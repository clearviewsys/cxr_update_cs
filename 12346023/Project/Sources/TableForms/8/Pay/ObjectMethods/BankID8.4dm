C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)
C_BOOLEAN:C305($ok1)

C_POINTER:C301($fieldPtr)
$fieldPtr:=Self:C308

If (Form event code:C388=On Data Change:K2:15)
	
	$fieldPtr->:=removeEnclosingSpaces(toTitleCase($fieldPtr))
	
	clearPictureField(->latestListCheckBeneficiary1)
	If (stringHasMinimumLength($fieldPtr->; 4))
		
		$match:=sl_handleEWiresScreening(sl_ForInputBox)
		//$match:=sl_handlePersonNameCompliance(False; $fieldPtr->; ->[Wires]CXR_WireID; New object(\
									"pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary1)\
									))
		//$sanctionCheckResult:=checkNameAgainstAllLists ($fieldPtr->;->$match;False;Table(->[Wires]);[Wires]WireNo)  // check for a person
		
		Case of 
			: (($match=2) | ($match=1))  // Exact/partial Match?
				
				[Wires:8]AML_isSanctionListChecked:54:=True:C214
				[Wires:8]AML_didMatchOnWatchList:55:=True:C214
				[Wires:8]AML_WatchListResult:58:=$sanctionCheckResult
				
			: ($match=0)
				
				[Wires:8]AML_isSanctionListChecked:54:=True:C214
				[Wires:8]AML_didMatchOnWatchList:55:=False:C215
				
			: ($match=-1)  // ws Error
				
				[Wires:8]AML_isSanctionListChecked:54:=False:C215
				
		End case 
		
		//showSanctionCheckAlert ($match;$sanctionCheckResult)
		//SetSanctionListCheckIcon ($match;->latestListCheckBeneficiary1)
		
	End if 
	
End if 
