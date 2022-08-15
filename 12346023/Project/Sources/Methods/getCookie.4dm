//%attributes = {}
// returns one cookie value from header values array received after call to HTTP Request command
// cookie attributes are also returned as collection within cookie object

C_OBJECT:C1216($0; $atribute)
C_TEXT:C284($1; $cookie; $cookieName; $cookieValue; $currentAttribute)
C_LONGINT:C283($i)
C_BOOLEAN:C305($keepGoing)

$cookie:=$1
$i:=1
$keepGoing:=True:C214
$cookieName:=""
$cookieValue:=""

While (($i<=Length:C16($cookie)) & $keepGoing)
	If ($cookie[[$i]]#" ")
		$keepGoing:=($cookie[[$i]]#"=")
		If ($keepGoing)
			$cookieName:=$cookieName+$cookie[[$i]]
		End if 
	End if 
	$i:=$i+1
End while 

$keepGoing:=True:C214

While (($i<=Length:C16($cookie)) & $keepGoing)
	If ($cookie[[$i]]#" ")
		$keepGoing:=($cookie[[$i]]#";")
		If ($keepGoing)
			$cookieValue:=$cookieValue+$cookie[[$i]]
		End if 
	End if 
	$i:=$i+1
End while 

// now get the cookie attributes

ARRAY OBJECT:C1221($attributes; 0)

$currentAttribute:=""

While ($i<=Length:C16($cookie))
	
	If ($cookie[[$i]]#" ")
		
		If ($cookie[[$i]]#";")
			$currentAttribute:=$currentAttribute+$cookie[[$i]]
		Else 
			
			$atribute:=getCookieAttribute($currentAttribute)
			If ($atribute#Null:C1517)
				APPEND TO ARRAY:C911($attributes; $atribute)
			End if 
			$currentAttribute:=""
			
		End if 
		
	End if 
	
	$i:=$i+1
	
End while 

If ($currentAttribute#"")
	$atribute:=getCookieAttribute($currentAttribute)
	If ($atribute#Null:C1517)
		APPEND TO ARRAY:C911($attributes; $atribute)
	End if 
End if 

If ($cookieName#"")
	
	$0:=New object:C1471
	$0.cookie:=$cookieName
	$0.value:=$cookieValue
	
	If (Size of array:C274($attributes)>0)
		
		$0.attributes:=New collection:C1472
		
		For ($i; 1; Size of array:C274($attributes))
			$0.attributes.push($attributes{$i})
		End for 
		
	End if 
	
End if 
