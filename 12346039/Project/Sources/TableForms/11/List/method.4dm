handleListForm
If (Form event code:C388=On Display Detail:K2:22)
	colourizeAlternateRows([MESSAGES:11]isFlagged:17)
	If ([MESSAGES:11]Priority:10=2)
		// _O_OBJECT SET COLOR([MESSAGES]Subject;calcColour(Red;Light grey))
		OBJECT SET RGB COLORS:C628([MESSAGES:11]Subject:7; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(Light grey:K11:13))
		
	Else 
		// _O_OBJECT SET COLOR([MESSAGES]Subject;calcColour(Dark grey;White))
		OBJECT SET RGB COLORS:C628([MESSAGES:11]Subject:7; convPalleteColourToRGB(Dark grey:K11:12); convPalleteColourToRGB(White:K11:1))
		
	End if 
	
	If ([MESSAGES:11]MessageID:1#"")
		hideObjectsOnTrue([MESSAGES:11]ReplyBody:9=""; "hasReply")
		hideObjectsOnTrue(([MESSAGES:11]isMessageSent:14 | [MESSAGES:11]isRead:12); "isNew")
	End if 
End if 
