//%attributes = {}

validateFieldsForTable(->[MainAccounts:28])
If (isValidationConfirmed)
	START TRANSACTION:C239
	
	TM_Add2Stack(->[MainAccounts:28]; Current method name:C684; Transaction level:C961)  //9/6/16
	C_LONGINT:C283($i)
	For ($i; 1; LISTBOX Get number of rows:C915(acc_SubledgerListBox))
		createAccount(acc_arrAccountIDs{$i}; [MainAccounts:28]MainAccountID:1; acc_arrCurrencies{$I}; True:C214; False:C215)
	End for 
	SAVE RECORD:C53([MainAccounts:28])
	VALIDATE TRANSACTION:C240
	
	TM_RemoveFromStack  //9/6/16
	
Else 
	REJECT:C38
End if 
