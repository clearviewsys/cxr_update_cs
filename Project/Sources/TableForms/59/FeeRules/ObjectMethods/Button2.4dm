ALL RECORDS:C47([FeeRules:59])
C_LONGINT:C283($n)
$n:=LISTBOX Get number of rows:C915(feeRulesListBox)-Records in selection:C76([FeeRules:59])
checkInit
Case of 
	: ($n>0)
		checkAddWarning("It seems like you forgot to save "+pluralizeNoun("new rule"; Abs:C99($n))+", without saving fist.")
	: ($n<0)
		checkAddWarning("it seems like you have deleted "+pluralizeNoun("old rule"; Abs:C99($n))+", without saving first.")
End case 

If (isValidationConfirmed)
	CANCEL:C270
	CLOSE WINDOW:C154
Else 
	REJECT:C38
End if 