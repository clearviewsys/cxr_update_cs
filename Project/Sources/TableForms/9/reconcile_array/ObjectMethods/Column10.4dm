C_BOOLEAN:C305($isChecked; $isOldChecked)
C_LONGINT:C283($row)
C_TEXT:C284($validation)

$row:=getListBoxRowNumber(Focus object:C278)
$isChecked:=arrChecked{$row}
$isOldChecked:=arrOldChecked{$row}
$validation:=arrValidation{$row}

If ((cbAutoValidate=1) & ($isChecked=True:C214) & ($validation=""))  // if auto-validation is on and the row gets validated
	C_TEXT:C284(validationCode)
	validationCode:=getNextValidationStamp
	setListBoxFocusedRow(->arrValidation; ->validationCode)
	incrementValidation
	setListBoxFocusedRow(->arrValidator; -><>applicationUser)
	
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	If ($isChecked=False:C215)
		CONFIRM:C162("Are you sure you want to uncheck a reconciled row?"; "Uncheck"; "Undo")
		If (Ok=0)  // undo
			arrChecked{$row}:=True:C214
		Else 
		End if 
	End if 
End if 

If ((arrChecked{$row}=False:C215) & ($validation#""))
	arrValidation{$row}:=""
	arrValidator{$row}:=""
	decrementValidation
End if 

