C_TEXT:C284($self)
If (Form event code:C388=On Clicked:K2:4)
	pickTransferTemplates(->$self)
	vAmount:=[TransferTemplates:54]Amount:6
	vCurrency:=[TransferTemplates:54]currency:5
	vFromAccount:=[TransferTemplates:54]fromAccount:3
	vToAccount:=[TransferTemplates:54]toAccount:4
	vComments:=[TransferTemplates:54]Description:2
	POST OUTSIDE CALL:C329(Current process:C322)
End if 