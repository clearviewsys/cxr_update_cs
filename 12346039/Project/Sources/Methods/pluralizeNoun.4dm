//%attributes = {}
// pluralizeNoun (noun ; number) -> string
// example: pluralize ("Customer";$n) 

C_TEXT:C284($0; $1)
C_LONGINT:C283($2)

Case of 
	: ($2=0)
		$0:="No "+$1+" "
		
	: ($2=1)
		$0:="One "+$1+" "
		
	: ($2>1)
		$0:=String:C10($2)+" "+$1+"s "
		
End case 