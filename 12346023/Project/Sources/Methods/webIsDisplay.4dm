//%attributes = {"shared":true,"publishedWeb":true}

C_TEXT:C284($1)
C_TEXT:C284($0; $display)

C_POINTER:C301($ptrField)
C_LONGINT:C283($iType)
C_TEXT:C284($tKey; $value)



$ptrField:=WAPI_txt2Field($1; ->$tKey)

If (Is nil pointer:C315($ptrField))
	$display:="NONE"
Else 
	
	$value:=WAPI_getValueAsString($ptrField; $tKey)
	
	Case of 
		: ($value="")
			$display:="none"
		: ($value="on") | ($value="true") | ($value="checked") | ($value="1")
			$display:="block"
		Else 
			$display:="none"
	End case 
End if 



$0:=$display