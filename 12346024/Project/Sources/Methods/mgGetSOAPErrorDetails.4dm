//%attributes = {}
// returns details about an error in a text variable ready to display in alert

C_TEXT:C284($0)
C_OBJECT:C1216($1; $errorObj)

$errorObj:=$1
$0:=Char:C90(Carriage return:K15:38)

If ($errorObj#Null:C1517)
	If ($errorObj.message#Null:C1517)
		$0:=$0+Char:C90(Carriage return:K15:38)+"Error text: "+$errorObj.message
	End if 
	If ($errorObj.operationalID#Null:C1517)
		$0:=$0+Char:C90(Carriage return:K15:38)+"Operational ID: "+$errorObj.operationalID
	End if 
	If ($errorObj.httpcode#Null:C1517)
		$0:=$0+Char:C90(Carriage return:K15:38)+"HTTP error code: "+String:C10($errorObj.httpcode)
	End if 
End if 
