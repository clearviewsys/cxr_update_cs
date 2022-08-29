//%attributes = {}
// FT_Set24HoursIndicatorEFT_NS ($dateref;->$invoicesPtr;->$invoices24hIndPtr;{$reportBranchId})
// Set the 24Hours insidcator for the transactions according to the FINTRAC Specifications

C_DATE:C307($1; $refDate)
C_POINTER:C301($2; $arrRecordsPtr; $3; $records24hIndPtr)
C_TEXT:C284($4; $branch)
C_BOOLEAN:C305($5; $isOutgoing)  // true: Outgoing, false: Incoming

Case of 
		
		
	: (Count parameters:C259=3)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:="ALL"
		$isOutgoing:=True:C214
		
	: (Count parameters:C259=4)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:=$4
		$isOutgoing:=True:C214
		
	: (Count parameters:C259=5)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:=$4
		$isOutgoing:=$5
		
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
FT_queryEFTO_NS($fromDate; $refDate; $isOutgoing)  // True: Is Outgoing
USE SET:C118("eft")
ORDER BY:C49([Wires:8]; [Wires:8]WireTransferDate:17; >)

FIRST RECORD:C50([Wires:8])

While (Not:C34(End selection:C36([Wires:8])))
	
	
	QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
	
	If ([WireTemplates:42]BankCountryCode:35#"CA")  // Don't process domestic Wires
		
		QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Wires:8]CXR_InvoiceID:12)
		If (Not:C34([Invoices:5]isAMLReported:45))
			// Tx's over the limit will be reported
			If ((FT_SumUsingMarketRate_EFT([Wires:8]CXR_RegisterID:13)>=[ServerPrefs:27]twoIDsLimit:15) & ([Invoices:5]invoiceDate:44=$refDate))
				
				APPEND TO ARRAY:C911($arrRecordsPtr->; [Wires:8]CXR_WireID:1)
				APPEND TO ARRAY:C911($records24hIndPtr->; False:C215)
				
			Else 
				// Always include transactions realted to IRAN Curencies
				
				If (([Wires:8]Currency:15="TOM") | ([Wires:8]Currency:15="IRR"))
					If ([Invoices:5]invoiceDate:44=$refDate)
						APPEND TO ARRAY:C911($arrRecordsPtr->; [Wires:8]CXR_WireID:1)
						APPEND TO ARRAY:C911($records24hIndPtr->; False:C215)
					End if 
					
				Else 
					$p:=Find in array:C230($acumCustId; [Wires:8]CustomerID:2)
					
					If ($p>0)
						$acum{$p}:=$acum{$p}+FT_SumUsingMarketRate_EFT([Wires:8]CXR_RegisterID:13)
						$acumxCust{$p}:=$acumxCust{$p}+","+[Wires:8]CXR_WireID:1
						
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
						APPEND TO ARRAY:C911($acumCustID; [Wires:8]CustomerID:2)
						APPEND TO ARRAY:C911($acum; FT_SumUsingMarketRate_EFT([Wires:8]CXR_RegisterID:13))
						APPEND TO ARRAY:C911($acumxCust; [Wires:8]CXR_WireID:1)
					End if 
					
				End if 
				
			End if 
		End if 
	End if 
	
	NEXT RECORD:C51([Wires:8])
	
End while 

SORT ARRAY:C229($arrRecordsPtr->; $records24hIndPtr->)
QUERY WITH ARRAY:C644([Wires:8]CXR_WireID:1; $arrRecordsPtr->)

ORDER BY:C49([Wires:8]; [Wires:8]WireTransferDate:17; >)
