//%attributes = {}
// getUpdateSourceString(int) -> {1= Reuters, 2= Yahoo}

C_LONGINT:C283($1)
C_TEXT:C284($0)
Case of 
	: ($1=1)
		$0:="Reuters"
	: ($1=2)
		$0:="Yahoo"
End case 