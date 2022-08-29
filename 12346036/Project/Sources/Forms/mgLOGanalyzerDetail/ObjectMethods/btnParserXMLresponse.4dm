C_TEXT:C284($json; $request)
C_LONGINT:C283($pos)
C_OBJECT:C1216($obj; $res)

$request:="SendConfirm"

$pos:=Position:C15("{"; Form:C1466.message)

If ($pos>0)
	
	
	$json:=Substring:C12(Form:C1466.message; $pos)
	
	$obj:=JSON Parse:C1218($json)
	
	$request:=Request:C163("Which SOAP method?")
	
	If (OK=1)
		
		If ($request="SendConfirm")
			$res:=mgGetActionResult($obj.response; $request)
		Else 
			$res:=mgGetSendRequestResult($obj.response)
		End if 
		
		Form:C1466.message:=Form:C1466.message+"\n\n"+JSON Stringify:C1217($res; *)
		
	End if 
	
End if 

