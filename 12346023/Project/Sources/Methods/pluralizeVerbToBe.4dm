//%attributes = {}
// pluralizeVerbToBe ( number) -> {was/were}
// example: pluralizeverbtobe (2) -> were


C_TEXT:C284($0)
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		$0:="was "
		
	: ($1=1)
		$0:="was "
		
	: ($1>1)
		$0:="were "
		
End case 