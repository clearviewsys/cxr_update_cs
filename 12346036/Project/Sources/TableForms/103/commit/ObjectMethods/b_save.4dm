checkInit
checkMandatoryField(->vSubject; True:C214; getLocalizedKeyword("subject"))

// we don't use isValidationConfirmed method because the validate method cannot be
// called since this form doesn't include fields (which are tested by the validate method)

If (checkErrorExist)
	REJECT:C38
Else 
	ACCEPT:C269
End if 