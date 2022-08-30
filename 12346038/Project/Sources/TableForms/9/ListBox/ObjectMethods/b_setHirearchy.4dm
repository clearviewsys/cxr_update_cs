
C_BOOLEAN:C305($isH)
LISTBOX GET HIERARCHY:C1099(*; "acc_accountsListBox"; $isH)
If ($isH)
	LISTBOX SET HIERARCHY:C1098(*; "acc_accountsListBox"; False:C215)
	LISTBOX SET COLUMN WIDTH:C833(*; "accounts"; 200)
	LISTBOX SET COLUMN WIDTH:C833(*; "Mainaccounts"; 0)
	
Else 
	LISTBOX SET HIERARCHY:C1098(*; "acc_accountsListBox"; True:C214)
	LISTBOX SET COLUMN WIDTH:C833(*; "accounts"; 0)
	LISTBOX SET COLUMN WIDTH:C833(*; "Mainaccounts"; 200)
	
End if 