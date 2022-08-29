HandleEntryFormMethod

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	C_BOOLEAN:C305($isApproved)
	$isApproved:=[ExceptionsLog:75]isReviewed:10 & ([ExceptionsLog:75]Remarks:11#"")
	stampText("stamp_OK"; "Reviewed ✔"; "green"; $isApproved)
	
End if 