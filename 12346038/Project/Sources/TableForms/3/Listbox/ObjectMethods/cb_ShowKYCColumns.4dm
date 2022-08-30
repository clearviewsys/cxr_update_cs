C_LONGINT:C283($showKYC)
$showKYC:=Num:C11(Self:C308->=1)

If (Form event code:C388=On Clicked:K2:4)
	LISTBOX SET COLUMN WIDTH:C833(*; "colDOB"; 80*$showKYC)
	LISTBOX SET COLUMN WIDTH:C833(*; "colPictureID"; 100*$showKYC)
	LISTBOX SET COLUMN WIDTH:C833(*; "colOccupation"; 100*$showKYC)
	LISTBOX SET COLUMN WIDTH:C833(*; "col_BR_Started"; 100*$showKYC)
	LISTBOX SET COLUMN WIDTH:C833(*; "col_tags"; 100*$showKYC)
End if 