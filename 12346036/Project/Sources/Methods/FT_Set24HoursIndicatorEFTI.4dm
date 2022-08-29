//%attributes = {}
// FT_Set24HoursIndicatorEFTI ($dateref;->$invoicesPtr;->$invoices24hIndPtr)
// Set the 24Hours insidcator for the transactions according to the FINTRAC Specifications

C_DATE:C307($1; $refDate)
C_POINTER:C301($2; $arrRecordsPtr; $3; $records24hIndPtr)
C_TEXT:C284($4; $branch)

Case of 
		
		
	: (Count parameters:C259=3)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:="ALL"
		
	: (Count parameters:C259=4)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($records; 0)
ARRAY REAL:C219($acum; 0)
ARRAY TEXT:C222($acumCustID; 0)
ARRAY TEXT:C222($acumxCust; 0)

READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])
C_DATE:C307($fromDate)

C_LONGINT:C283($i; $p)

$fromDate:=Add to date:C393($refDate; 0; 0; -1)

FT_queryEFT($fromDate; $refDate; False:C215)
USE SET:C118("eft")

READ ONLY:C145([Invoices:5])

FIRST RECORD:C50([eWires:13])

While (Not:C34(End selection:C36([eWires:13])))
	
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[eWires:13]InvoiceNumber:29)
	If (Not:C34([Invoices:5]isAMLReported:45))
		
		// Tx's over the limit will be reported
		If ((FT_SumUsingMarketRate_EFT([eWires:13]RegisterID:24)>=[ServerPrefs:27]twoIDsLimit:15) & ([Invoices:5]invoiceDate:44=$refDate))
			
			APPEND TO ARRAY:C911($arrRecordsPtr->; [eWires:13]eWireID:1)
			APPEND TO ARRAY:C911($records24hIndPtr->; False:C215)
			
		Else 
			// Always include transactions related to IRAN Curencies and countries
			
			If (([eWires:13]Currency:12="TOM") | ([eWires:13]Currency:12="IRR") | ([eWires:13]fromCountry:9="IR") | ([eWires:13]toCountry:10="IR") | ([Customers:3]CountryCode:113="IR") | ([Links:17]countryCode:50="IR"))
				
				If ([Invoices:5]invoiceDate:44=$refDate)
					APPEND TO ARRAY:C911($arrRecordsPtr->; [eWires:13]eWireID:1)
					APPEND TO ARRAY:C911($records24hIndPtr->; False:C215)
				End if 
				
			Else 
				$p:=Find in array:C230($acumCustId; [eWires:13]CustomerID:15)
				
				If ($p>0)
					$acum{$p}:=$acum{$p}+FT_SumUsingMarketRate_EFT([eWires:13]RegisterID:24)
					$acumxCust{$p}:=$acumxCust{$p}+","+[eWires:13]eWireID:1
					
					If ($acum{$p}>[ServerPrefs:27]twoIDsLimit:15)
						
						CLEAR VARIABLE:C89($records)
						tokenizePhraseIntoWords($acumxCust{$p}; ->$records; ",")
						
						For ($i; 1; Size of array:C274($records))
							
							If ([Invoices:5]invoiceDate:44=$refDate)
								APPEND TO ARRAY:C911($arrRecordsPtr->; $records{$i})
								APPEND TO ARRAY:C911($records24hIndPtr->; True:C214)
							End if 
							
						End for 
						$acum{$p}:=0
						$acumxCust{$p}:=""
					End if 
					
					
				Else 
					APPEND TO ARRAY:C911($acumCustID; [eWires:13]CustomerID:15)
					APPEND TO ARRAY:C911($acum; FT_SumUsingMarketRate_EFT([eWires:13]RegisterID:24))
					APPEND TO ARRAY:C911($acumxCust; [eWires:13]eWireID:1)
				End if 
				
			End if 
			
		End if 
		
	End if 
	
	NEXT RECORD:C51([eWires:13])
	
End while 

SORT ARRAY:C229($arrRecordsPtr->; $records24hIndPtr->)
QUERY SELECTION WITH ARRAY:C1050([eWires:13]eWireID:1; $arrRecordsPtr->)
ORDER BY:C49([eWires:13]; [eWires:13]SendDate:2; >)

