//%attributes = {}
// isFieldEmpty
// isFieldNotFilled
// use this method to check whether a field is left blank

C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($0; $isEmpty)

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=$1
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($type)

GET FIELD PROPERTIES:C258($1; $type)
Case of 
	: (($type=Is alpha field:K8:1) | ($type=Is text:K8:3))  // string
		$isEmpty:=($fieldPtr->="")
		
	: ($type=Is date:K8:7)
		$isEmpty:=($fieldPtr->=!00-00-00!)
		
	: ($type=Is time:K8:8)  //time
		$isEmpty:=($fieldPtr->=?00:00:00?)
		
	: ($type=Is boolean:K8:9)  // boolean
		$isEmpty:=($fieldPtr->=False:C215)
		
	: ($type=Is picture:K8:10)
		$isEmpty:=(Picture size:C356($fieldPtr->)=0)
		
	: ($type=Is BLOB:K8:12)
		$isEmpty:=(BLOB size:C605($fieldPtr->)=0)
		
	: ($type=Is pointer:K8:14)
		$isEmpty:=Is nil pointer:C315($fieldPtr)
		
	: (isFieldTypeNumeric($fieldPtr))
		$isEmpty:=($fieldPtr->=0)
		
	: ($type=Is undefined:K8:13)  // if undefined, then return true... not sure if that's okay or not
		$isEmpty:=True:C214
	Else 
		ASSERT:C1129(False:C215; "type not handled in this method isFieldEmpty "+String:C10($type))
End case 

$0:=$isEmpty