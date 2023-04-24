//%attributes = {}
// myRequest(subject): return value

C_TEXT:C284($1; $0; vRequestEntry; vRequestSubject)
Case of 
	: (Count parameters:C259=1)
		vRequestSubject:=$1
	Else 
		vRequestSubject:="Please enter a message:"
End case 

If (Application type:C494#4D Server:K5:6)
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675("RequestForm"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("RequestForm")
	CLOSE WINDOW:C154($winRef)
End if 

$0:=vRequestEntry
