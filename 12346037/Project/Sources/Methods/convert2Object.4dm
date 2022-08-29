//%attributes = {}
// convert2String ($ptr)
C_POINTER:C301($1; $ptr)
C_OBJECT:C1216($0; $obj)
$ptr:=$1


$0:=$obj

Case of 
	: (Type:C295($ptr->)=Is picture:K8:10)
		OB SET:C1220($0; "value"; "Is Picture")
		
	Else 
		OB SET:C1220($0; "value"; $ptr->)
		
End case 


//Is BLOBLongint30
//Is BooleanLongint6
//Is collectionLongint42
//Is dateLongint4
//Is longintLongint9
//Is nullLongint255
//Is objectLongint38
//Is pictureLongint3
//Is pointerLongint23
//Is realLongint1
//Is textLongint2
//Is timeLongint11
//Is undefinedLongint5
//Is variantLongint12
//Object arrayLongint39