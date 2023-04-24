//%attributes = {}
//https://127.0.0.1/CXR/GET/v1/currency/quote?base=CAD&symbols=EUR,USD

C_LONGINT:C283($pos)
C_COLLECTION:C1488($symbols)
C_TEXT:C284($base)


ARRAY TEXT:C222($aNames; 0)
ARRAY TEXT:C222($aValues; 0)
WEB GET VARIABLES:C683($aNames; $aValues)


$pos:=Find in array:C230($aNames; "base")
If ($pos>0)
	$base:=$aValues{$pos}
End if 

$pos:=Find in array:C230($aNames; "symbols")
If ($pos>0)
	$symbols:=Split string:C1554($aValues{$pos}; ",")
End if 


Case of 
	: ($base="")
		API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Base currency not specified"))
		
	: ($symbols.length=0)
		API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Symbols not specified"))
		
	Else 
		
End case 