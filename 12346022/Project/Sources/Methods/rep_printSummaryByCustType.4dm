//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/27/17, 14:44:33
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: rep_IBB_Report
// Description
// 
//
// Parameters
// ----------------------------------------------------


//All the fields are from the REGISTERS table except for the 'typeOfcustomer'(Saudi vs. non-Saudi)which is in the INVOICES table.
//
//FYI:
//Cost of Purchase=Sum([Registers]DebitLocal)
//Revenue from Sales=Sum([Registers]CreditLocal)
//Volume Bought=Sum([Registers]Debit)
//Volume Sold=Sum([Registers]Credit)

//@barclay the count for buy and sell are different. The buy is when we purchase a(non local#<>basecurrency)
//and the sell is when we sell a currency non local.
//
//The CustomerTypeID is the field I was referring to(from the top of my head)


C_DATE:C307($1; $dStart)
C_DATE:C307($2; $dEnd)


C_REAL:C285(vVolumeBought; vVolumeSold; vPurchaseCost; vRevenueSales)
C_LONGINT:C283(vSalesNum; vPurchaseNum; $iSelected; $i; $ii; $iSize; $iNationalityPos; $iElem; $iPageNum)
C_TEXT:C284($tNationality; $formname; $LastCurrency)

C_REAL:C285(vVolumeBoughtTotal; vVolumeSoldTotal; vPurchaseCostTotal; vRevenueSalesTotal)
C_LONGINT:C283(vSalesNumTotal; vPurchaseNumTotal)

vSalesNumTotal:=0
vVolumeBoughtTotal:=0
vPurchaseCostTotal:=0
vPurchaseNumTotal:=0
vVolumeSoldTotal:=0
vRevenueSalesTotal:=0



If (isUserAllowedToPrintReports)
	
	If (Count parameters:C259=0)
		requestDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; True:C214)
	Else 
		QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$dStart; *)
		QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$dEnd)
	End if 
	
	If (OK=1)
		
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]isTransfer:3=False:C215)
		
		ARRAY TEXT:C222($atCustTypes; 0)
		RELATE ONE SELECTION:C349([Registers:10]; [Invoices:5])
		DISTINCT VALUES:C339([Invoices:5]CustomerTypeID:92; $atCustTypes)
		
		If (True:C214)
			//add option for user to select customer types to use in the report
			ARRAY LONGINT:C221($aiSelectedCustTypes; 0)
			If (Size of array:C274($atCustTypes)>1)
				$iSelected:=myChoiceList("Select the customer types to include."; ->$atCustTypes; ->$aiSelectedCustTypes)
				
				If ($iSelected>0)
					For ($i; Size of array:C274($atCustTypes); 1; -1)
						If (Find in array:C230($aiSelectedCustTypes; $i)>0)
						Else 
							DELETE FROM ARRAY:C228($atCustTypes; $i)
						End if 
					End for 
				End if 
				
			Else 
				APPEND TO ARRAY:C911($aiSelectedCustTypes; 1)
				$iSelected:=1  //default
			End if 
		End if 
		
		If ($iSelected>0)  //users still wants to print this report
			ARRAY TEXT:C222($atTemp; 0)
			ARRAY TEXT:C222($atCurrency; 0)
			ARRAY TEXT:C222($atNationality; 0)  //CustomerTypeID
			
			DISTINCT VALUES:C339([Registers:10]Currency:19; $atTemp)
			SORT ARRAY:C229($atTemp)
			
			For ($i; 1; Size of array:C274($atTemp))  //need to add the nationality array and adjust the currency array 
				
				For ($ii; 1; Size of array:C274($atCustTypes))
					//If (Find in array($aiSelectedCustTypes;$ii)>0)  //only add those the user selected above
					APPEND TO ARRAY:C911($atNationality; $atCustTypes{$ii})  //insert each customer type ie. Saudi and non-Saudi
					APPEND TO ARRAY:C911($atCurrency; $atTemp{$i})
					//End if 
				End for 
			End for 
			
			$iSize:=Size of array:C274($atCurrency)
			
			//SELL ARRAYS
			//ARRAY LONGINT($aiSalesCount;$iSize)
			ARRAY LONGINT:C221($aiPurchaseCount; $iSize)
			ARRAY REAL:C219($arVolumeBought; $iSize)  //Debit
			ARRAY REAL:C219($arPurchaseCost; $iSize)  //DebitLocal
			
			//BUY ARRAYS
			//ARRAY LONGINT($aiPurchaseCount;$iSize)
			ARRAY LONGINT:C221($aiSalesCount; $iSize)
			ARRAY REAL:C219($arVolumeSold; $iSize)  //Credit
			ARRAY REAL:C219($arSalesRevenue; $iSize)  //CreditLocal
			
			
			
			
			For ($i; 1; Records in selection:C76([Registers:10]))
				
				$iElem:=Find in array:C230($atCurrency; [Registers:10]Currency:19)  //first occurrence of the currency
				
				If ($iElem>0)
					QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Registers:10]InvoiceNumber:10)
					
					$tNationality:=[Invoices:5]CustomerTypeID:92
					$iNationalityPos:=Find in array:C230($atCustTypes; $tNationality)
					
					
					If ($iNationalityPos>0)  //5/23/17 IBB only if found they may not want all types on the report
						$iElem:=$iElem+$iNationalityPos-1  //this gets us the position of the nationality in the current currency
						
						Case of 
								//: ([Registers]baseCURR=[Registers]Currency)  //SELL
							: ([Registers:10]Credit:7>0)  //SELL
								$aiSalesCount{$iElem}:=$aiSalesCount{$iElem}+1
								$arVolumeSold{$iElem}:=$arVolumeSold{$iElem}+[Registers:10]Credit:7
								$arSalesRevenue{$iElem}:=$arSalesRevenue{$iElem}+[Registers:10]CreditLocal:24
								
								//: ([Registers]baseCURR#[Registers]Currency)  //BUY - PURCHASE
							: ([Registers:10]Debit:8>0)  //BUY - PURCHASE
								$aiPurchaseCount{$iElem}:=$aiPurchaseCount{$iElem}+1
								$arVolumeBought{$iElem}:=$arVolumeBought{$iElem}+[Registers:10]Debit:8
								$arPurchaseCost{$iElem}:=$arPurchaseCost{$iElem}+[Registers:10]DebitLocal:23
								
							Else 
								//TRACE
						End case 
					End if 
					
				Else 
					//TRACE
				End if 
				
				NEXT RECORD:C51([Registers:10])
			End for 
			
			ARRAY TEXT:C222($atHeaders; 0)
			APPEND TO ARRAY:C911($atHeaders; "Currency")
			APPEND TO ARRAY:C911($atHeaders; "Nationality")
			APPEND TO ARRAY:C911($atHeaders; "Number")
			APPEND TO ARRAY:C911($atHeaders; "Volume Bought")
			APPEND TO ARRAY:C911($atHeaders; "Cost of Purchase")
			APPEND TO ARRAY:C911($atHeaders; "Number")
			APPEND TO ARRAY:C911($atHeaders; "Volume Sold")
			APPEND TO ARRAY:C911($atHeaders; "Revenue from Sales")
			
			
			printSettings
			If (OK=1)
				$formname:="printSummaryByCustType"
				Print form:C5([Registers:10]; $formname; Form header:K43:3)
				Print form:C5([Registers:10]; $formname; Form header1:K43:4)
				Print form:C5([Registers:10]; $formname; Form header2:K43:5)
				
				$LastCurrency:=""
				$iPageNum:=1
				For ($i; 1; Size of array:C274($atCurrency))
					
					If ($LastCurrency=$atCurrency{$i})
						vCurrency:=""
					Else 
						vCurrency:=$atCurrency{$i}
						$LastCurrency:=vCurrency
					End if 
					
					vNationality:=$atNationality{$i}
					vSalesNum:=$aiSalesCount{$i}
					vVolumeBought:=$arVolumeBought{$i}
					vPurchaseCost:=$arPurchaseCost{$i}
					
					vPurchaseNum:=$aiPurchaseCount{$i}
					vVolumeSold:=$arVolumeSold{$i}
					vRevenueSales:=$arSalesRevenue{$i}
					
					vSalesNumTotal:=vSalesNumTotal+vSalesNum
					vVolumeBoughtTotal:=vVolumeBoughtTotal+vVolumeBought
					vPurchaseCostTotal:=vPurchaseCostTotal+vPurchaseCost
					vPurchaseNumTotal:=vPurchaseNumTotal+vPurchaseNum
					vVolumeSoldTotal:=vVolumeSoldTotal+vVolumeSold
					vRevenueSalesTotal:=vRevenueSalesTotal+vRevenueSales
					
					vNum:=$i
					
					If (False:C215)  //moved to form event
						If (Mod:C98($i; 2)=0)
							OBJECT SET VISIBLE:C603(*; "DetailBackground"; False:C215)
						Else 
							OBJECT SET VISIBLE:C603(*; "DetailBackground"; True:C214)
						End if 
					End if 
					
					If (Mod:C98($i; 49)=0)  //every 50 rows
						vPageNum:=String:C10($iPageNum; "- ####0 -")
						Print form:C5([Registers:10]; $formname; Form footer:K43:2)
						PAGE BREAK:C6
						//CANCEL
						Print form:C5([Registers:10]; $formname; Form header1:K43:4)
						Print form:C5([Registers:10]; $formname; Form header2:K43:5)
						
						$iPageNum:=$iPageNum+1
					End if 
					
					Print form:C5([Registers:10]; $formname; Form detail:K43:1)
				End for 
				
				
				
				Print form:C5([Registers:10]; $formname; Form break0:K43:14)
				
				vPageNum:=String:C10($iPageNum; "- ####0 -")
				Print form:C5([Registers:10]; $formname; Form footer:K43:2)
				PAGE BREAK:C6
			End if 
			
			If (False:C215)
				//iO_arraysToXML (System folder(Desktop)+"test.xls";->$atHeaders;->$atCurrency;->$atNationality;->$aiSalesCount;->$arVolumeBought;->$arPurchaseCost;->$aiPurchaseCount;->$arVolumeSold;->$arSalesRevenue)
				//iO_arraysToTXT (System folder(Desktop)+"test.txt";->$atHeaders;->$atCurrency;->$atNationality;->$aiSalesCount;->$arVolumeBought;->$arPurchaseCost;->$aiPurchaseCount;->$arVolumeSold;->$arSalesRevenue)
				//iO_arraysToCSV (System folder(Desktop)+"test.csv";->$atHeaders;->$atCurrency;->$atNationality;->$aiSalesCount;->$arVolumeBought;->$arPurchaseCost;->$aiPurchaseCount;->$arVolumeSold;->$arSalesRevenue)
			End if 
			
			
		End if 
	End if 
	
Else 
	myAlert("Please ask the administrator to grant you access to this menu.")
End if 