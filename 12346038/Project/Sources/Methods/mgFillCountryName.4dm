//%attributes = {}
C_TEXT:C284($1; $formObjectName)
C_TEXT:C284($2; $countryCode)
C_COLLECTION:C1488($3; $countries; $found)
C_TEXT:C284($4; $entryObject)
C_POINTER:C301($formObj)
C_LONGINT:C283($len)

$formObjectName:=$1
$countryCode:=$2
$formObj:=OBJECT Get pointer:C1124(Object named:K67:5; $formObjectName)
$entryObject:=""

If (Count parameters:C259<3)
	$countries:=mgGetCountryCodes
Else 
	$countries:=$3
	If (Count parameters:C259>3)
		$entryObject:=$4
	End if 
End if 

If ($countries=Null:C1517)
	$countries:=mgGetCountryCodes
End if 

$len:=Length:C16($countryCode)

If ($len=3)
	$found:=$countries.query("alpha3 = :1"; Lowercase:C14($countryCode))
Else 
	If ($len=2)
		$found:=$countries.query("alpha2 = :1"; Lowercase:C14($countryCode))
	End if 
End if 

If ($found.length>0)
	
	$formObj->:=Uppercase:C13($found[0].name)
	If ($entryObject#"")
		
		// small hack to allow to use this method in other forms that have different Form object definition
		// than one we use in mgSend and mgReceivee forms
		// rewrite later without this dependancy
		
		If ($entryObject[[1]]#"#")
			Form:C1466.object[$entryObject]:=Uppercase:C13($found[0].alpha3)
		Else 
			Form:C1466[Substring:C12($entryObject; 2)]:=Uppercase:C13($found[0].alpha3)
		End if 
		
	End if 
End if 
