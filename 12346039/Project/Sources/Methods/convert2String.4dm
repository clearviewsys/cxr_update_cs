//%attributes = {}
// convert2String ($ptr)
C_OBJECT:C1216($1; $obj)
C_TEXT:C284($0; $txt)
C_LONGINT:C283($type)

$obj:=$1

$type:=OB Get type:C1230($obj; "value")

Case of 
		
	: ($type=Is picture:K8:10)
		$txt:=OB Get:C1224($obj; "value")
		
	: ($type=Is text:K8:3)
		$txt:=OB Get:C1224($obj; "value")
		
	: ($type=Is object:K8:27)
		
	Else 
		$txt:=String:C10(OB Get:C1224($obj; "value"))
		
End case 


$0:=$txt



//Case of 
//: ($type=Is date)
//$txt:=String(OB Get type($obj;"value"))

//: ($type=Is longint)
//$txt:=String(OB Get type($obj;"value"))

//: ($type=Is picture)
//$txt:=String(OB Get type($obj;"value"))

//: ($type=Is real)
//$txt:=String(OB Get type($obj;"value"))

//: ($type=Is text)
//$txt:=String(OB Get type($obj;"value"))

//Else 

//End case 




//: (Type($ptr->)=Is text)
//$0:=$ptr->

//: (Type($ptr->)=Is picture)
//$0:="Is Picture"

//Else 
//$0:=String($ptr->)
//End case 


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