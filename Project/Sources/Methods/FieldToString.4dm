//%attributes = {}
//FieldtoString(»field)->string

// gets a field pointer and returns a string

C_POINTER:C301($1)
C_TEXT:C284($0)
C_LONGINT:C283($type)

GET FIELD PROPERTIES:C258($1; $type)
Case of 
	: ($type=Is alpha field:K8:1)  // string
		$0:=$1->
		
	: ($type=Is text:K8:3)  // text 
		$0:=$1->
		
	: ($type=Is time:K8:8)  //time
		$0:=Time string:C180($1->)
		
	: ($type=Is boolean:K8:9)  // boolean
		$0:=booleanToString($1->)
		
	: ($type=Is picture:K8:10)
		$0:=""
		
	: ($type=Is subtable:K8:11)
		$0:=""
	Else 
		$0:=String:C10($1->)
End case 

