//%attributes = {}
C_TEXT:C284($1; $ip)

C_OBJECT:C1216($0; $o)

C_LONGINT:C283($stat)


If (Count parameters:C259>=1)
	$ip:=$1
Else 
	$ip:="173.79.254.254"
End if 

//"User-Agent: keycdn-tools:https://www.example.com"

ARRAY TEXT:C222($atHeaderName; 0)
ARRAY TEXT:C222($atHeaderValue; 0)

APPEND TO ARRAY:C911($atHeaderName; "User-Agent")
APPEND TO ARRAY:C911($atHeaderValue; "keycdn-tools:https://dev.clearviewsys.com")

$stat:=HTTP Get:C1157("https://tools.keycdn.com/geo.json?host="+$ip; $o; $atHeaderName; $atHeaderValue)

If ($stat=200)
	$0:=New object:C1471("success"; True:C214; "data"; $o.data.geo)
Else 
	$0:=New object:C1471("success"; False:C215; "data"; New object:C1471)
End if 