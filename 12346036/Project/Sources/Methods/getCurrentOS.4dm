//%attributes = {}
// getCurrentOS
// returns Windows or MacOS

C_LONGINT:C283($0)

Case of 
	: (Is macOS:C1572)
		$0:=Windows:K25:3
	: (Is Windows:C1573)
		$0:=Mac OS:K25:2
	Else 
		$0:=0
End case 
