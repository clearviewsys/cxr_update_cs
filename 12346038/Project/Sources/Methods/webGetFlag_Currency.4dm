//%attributes = {"shared":true}
// GETLibraryGIF (libraryPictureName)

// this method must be called from a URL 

// <IMG SRC="4DACTION/GETLibraryGIF/USD">


C_TEXT:C284($1; $code)
C_TEXT:C284($0; $tBase64)

C_PICTURE:C286($pict)
//C_BLOB($blob)
//GET PICTURE FROM LIBRARY("flag_CAD";$pict)

$code:=$1

$code:=Replace string:C233($code; "/"; "")

//$code:=Substring($1;2)
READ ONLY:C145([Currencies:6])
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$code)

If (Records in selection:C76([Currencies:6])>0)
	$pict:=[Currencies:6]Flag:3
Else 
	//maybe send back a "broken" image????
End if 

$tBase64:=WAPI_pict2Base64(->$pict)

$0:=$tBase64