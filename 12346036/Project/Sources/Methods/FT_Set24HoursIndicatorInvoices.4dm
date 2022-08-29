//%attributes = {}
// FT_Set24HoursIndicatorInvoices ($dateref;->$invoicesPtr;->$invoices24hIndPtr)
// Set the 24Hours insidcator for the transactions according to the FINTRAC Specifications

C_DATE:C307($1; $refDate)
C_POINTER:C301($2; $invoicesPtr; $3; $invoices24hIndPtr)
C_TEXT:C284($4; $branch)
C_REAL:C285($totMarketRate)
C_DATE:C307($dayBefore)
C_LONGINT:C283($p; $i)

Case of 
		
		
	: (Count parameters:C259=3)
		$refDate:=$1
		$invoicesPtr:=$2
		$invoices24hIndPtr:=$3
		$branch:="ALL"
		
	: (Count parameters:C259=4)
		$refDate:=$1
		$invoicesPtr:=$2
		$invoices24hIndPtr:=$3
		$branch:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($inv; 0)
ARRAY REAL:C219($acum; 0)
ARRAY TEXT:C222($acumCustID; 0)
ARRAY TEXT:C222($acumInvxCust; 0)
ARRAY TEXT:C222($arrCustomersInv; 0)
ARRAY TEXT:C222($arrCustomersInvNoRep; 0)


READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])

READ ONLY:C145([Customers:3])


$dayBefore:=Add to date:C393($refDate; 0; 0; -1)
QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=$dayBefore; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=$refDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isCancelled:84=False:C215; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isAMLReported:45=False:C215)



If ($branch#"ALL")
	QUERY SELECTION:C341([Invoices:5]; [Invoices:5]BranchID:53=reportBranchId)
End if 

ORDER BY:C49([Invoices:5]; [Invoices:5]invoiceDate:44; >)

While (Not:C34(End selection:C36([Invoices:5])))
	
	
	If (isACashInvoice([Invoices:5]InvoiceID:1))
		
		If ((FT_SumUsingMarketRate([Invoices:5]InvoiceID:1)>[ServerPrefs:27]twoIDsLimit:15) & ([Invoices:5]invoiceDate:44=$refDate))
			APPEND TO ARRAY:C911($invoicesPtr->; [Invoices:5]InvoiceID:1)
			APPEND TO ARRAY:C911($invoices24hIndPtr->; False:C215)
			
		Else 
			
			If ((invoiceRelatedIran([Invoices:5]InvoiceID:1; $refDate)) & ([Invoices:5]invoiceDate:44=$refDate))
				APPEND TO ARRAY:C911($invoicesPtr->; [Invoices:5]InvoiceID:1)
				APPEND TO ARRAY:C911($invoices24hIndPtr->; False:C215)
				
			Else 
				
				If (Not:C34(invoiceRelatedIran([Invoices:5]InvoiceID:1; $refDate)))
					
					$p:=Find in array:C230($acumCustId; [Invoices:5]CustomerID:2)
					
					If ($p>0)
						//$acum{$p}:=$acum{$p}+[Invoices]fromAmountLC
						$acum{$p}:=$acum{$p}+FT_SumUsingMarketRate([Invoices:5]InvoiceID:1)
						$acumInvxCust{$p}:=$acumInvxCust{$p}+","+[Invoices:5]InvoiceID:1
						
						If (($acum{$p}>=[ServerPrefs:27]twoIDsLimit:15) & ([Invoices:5]invoiceDate:44=$refDate))
							
							CLEAR VARIABLE:C89($inv)
							tokenizePhraseIntoWords($acumInvxCust{$p}; ->$inv; ",")
							
							For ($i; 1; Size of array:C274($inv))
								APPEND TO ARRAY:C911($invoicesPtr->; $inv{$i})
								APPEND TO ARRAY:C911($invoices24hIndPtr->; True:C214)
							End for 
							$acum{$p}:=0
							$acumInvxCust{$p}:=""
						End if 
						
						
					Else 
						APPEND TO ARRAY:C911($acumCustID; [Invoices:5]CustomerID:2)
						APPEND TO ARRAY:C911($acum; FT_SumUsingMarketRate([Invoices:5]InvoiceID:1))
						APPEND TO ARRAY:C911($acumInvxCust; [Invoices:5]InvoiceID:1)
					End if 
					
				End if 
				
			End if 
			
			
		End if 
		
	End if 
	
	
	NEXT RECORD:C51([Invoices:5])
	
End while 

SORT ARRAY:C229($invoicesPtr->; $invoices24hIndPtr->)





