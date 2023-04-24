//%attributes = {}
// returns application key required to access our backup bucket at BackBlaze B2 cloud

// returns all information needed to access B2 bucket

C_OBJECT:C1216($0)
C_TEXT:C284($keyID; $keyName; $key)

//$0:=New object
//$0.keyID:="004bd5f82a8c5e60000000001"
//$0.keyName:="integration4D"
//$0.key:="K004A8HSJhCTL/G5akU0J7kJoJUp0EU"

$keyID:=getKeyValue("b2.keyID")
$keyName:=getKeyValue("b2.keyName")
$key:=getKeyValue("b2.key")

If ($key#"")
	If ($keyID#"")
		If ($key#"")
			$0:=New object:C1471
			$0.keyID:=$keyID
			$0.keyName:=$keyname
			$0.key:=$key
		End if 
	End if 
End if 
