C_TEXT:C284($formPath)
C_BLOB:C604($blobDocument)

If (Not:C34(Undefined:C82(Form:C1466.path)))
	$formPath:=Form:C1466.path
	DOCUMENT TO BLOB:C525($formPath; $blobDocument)
	[WebAttachments:86]FilePath:3:=putWebAttachmentToServer($blobDocument; [WebAttachments:86]FileName:5)
End if 


//handleSaveButton(->[ExceptionsLog];->[ExceptionsLog]BranchID;->[ExceptionsLog]Date;->[ExceptionsLog]Time;->[ExceptionsLog]ReviewerUserID)