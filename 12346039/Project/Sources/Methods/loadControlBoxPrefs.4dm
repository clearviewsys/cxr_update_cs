//%attributes = {}

ALL RECORDS:C47([ControlBox:66])
FIRST RECORD:C50([ControlBox:66])

If (Records in selection:C76([ControlBox:66])=0)
	READ WRITE:C146([ControlBox:66])
	
	CREATE RECORD:C68([ControlBox:66])
	
	[ControlBox:66]commandPath:7:="C:\\SendReceiptCommand.exe"
	[ControlBox:66]ControlBoxID:1:="_"
	[ControlBox:66]portName:2:="COM1"
	[ControlBox:66]posID:6:="POS #1"
	[ControlBox:66]cashier:5:="C1"
	[ControlBox:66]baudRate:3:="19200"
	[ControlBox:66]controlFlow:4:="DSR"
	assignControlBoxVarsToFields
	SAVE RECORD:C53([ControlBox:66])
	UNLOAD RECORD:C212([ControlBox:66])
Else 
	LOAD RECORD:C52([ControlBox:66])
	assignControlBoxVarsToFields
	
	UNLOAD RECORD:C212([ControlBox:66])
End if 
