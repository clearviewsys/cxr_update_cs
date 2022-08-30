//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $json)

C_LONGINT:C283($0; $count)

C_OBJECT:C1216($o; $entity)


If (Count parameters:C259>=1)
	$json:=$1
	If ($json="/@")
		$json:=Substring:C12($json; 2)
	End if 
	
	$o:=JSON Parse:C1218($json)
	
	Case of 
		: ($o.table="wiretemplates")
			$count:=ds:C1482.WireTemplates.query($o.filter).length
			//ALERT(String($count))
			$0:=$count
		Else 
			$0:=-1
	End case 
	
Else 
	$0:=0
End if 
//