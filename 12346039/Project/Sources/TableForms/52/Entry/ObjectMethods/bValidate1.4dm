C_LONGINT:C283(bodyRichText)
handleSaveButton
copy4DWriteTextIntoPlainText(bodyRichText; ->[Letters:52]Body:4)

If (validateTable(Current form table:C627))
	If (is4DWriteAvailable)
		//[Letters]BodyRichText_:=‘12000;140‘ (bodyRichText)
	End if 
	SAVE RECORD:C53(Current form table:C627->)
Else 
	REJECT:C38
End if 