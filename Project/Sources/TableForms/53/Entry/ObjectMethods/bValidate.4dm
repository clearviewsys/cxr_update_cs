C_LONGINT:C283(bodyRichText)
copy4DWriteTextIntoPlainText(bodyRichText; ->[LetterTemplates:53]Body:3)

If (validateTable(Current form table:C627))
	If (is4DWriteAvailable)
		//[LetterTemplates]BodyRichText_:=‘12000;140‘ (bodyRichText)
	End if 
	SAVE RECORD:C53(Current form table:C627->)
Else 
	REJECT:C38
End if 