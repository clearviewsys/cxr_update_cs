//%attributes = {}
// getupdateSourceMainURL -> mainURL (eg : reuters.com)


C_TEXT:C284($0)

Case of 
	: (<>updateSource="reuters")
		$0:="reuters.com"
		
	: (<>updateSource="yahoo")
		$0:="finance.yahoo.com"
		
End case 