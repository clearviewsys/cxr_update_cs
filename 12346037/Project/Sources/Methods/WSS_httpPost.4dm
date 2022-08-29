//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/03/21, 16:10:30
// ----------------------------------------------------
// Method: Sync_httpPost
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($1; $request)

C_OBJECT:C1216($0; $status)

C_LONGINT:C283($iStatus; $iCompressed)
C_BLOB:C604($xRequest; $xResponse)
C_TEXT:C284($tURL; $encodedText)
C_TEXT:C284($currOnErr)
C_LONGINT:C283($iTries)


$request:=$1
$status:=New object:C1471


$tURL:=Replace string:C233($request.url; "4dsoap"; "4DREMOTE")


$currOnErr:=Method called on error:C704
ON ERR CALL:C155("errorIgnore")  //make sure nothing pops up on server

If ($request.compression#"None")
	HTTP SET OPTION:C1160(HTTP compression:K71:15; 1)
End if 

HTTP SET OPTION:C1160(HTTP timeout:K71:10; $request.timeOut)

$encodedText:=$request.request
BASE64 DECODE:C896($encodedText; $xRequest)

COMPRESS BLOB:C534($xRequest; GZIP best compression mode:K22:18)

$iTries:=0
Repeat 
	$iTries:=$iTries+1
	$iStatus:=HTTP Request:C1158(HTTP POST method:K71:2; $tURL; $xRequest; $xResponse)
	
	If ($iStatus=200) & (BLOB size:C605($xResponse)>0)
	Else 
		DELAY PROCESS:C323(Current process:C322; 10)
		$iStatus:=0
	End if 
Until (($iStatus=200) | ($iTries>=5))

If ($iStatus=200)  // | ($iStatus=500)  //4D IS SENDING 500 WITH THE BLOB
	$status.success:=True:C214
	$status.statusText:="200"
	
	BLOB PROPERTIES:C536($xResponse; $iCompressed)
	If ($iCompressed=Is not compressed:K22:11)
	Else 
		EXPAND BLOB:C535($xResponse)
	End if 
	
	BASE64 ENCODE:C895($xResponse; $encodedText)
	$status.response:=$encodedText
Else 
	$status.success:=False:C215
	
	BLOB PROPERTIES:C536($xResponse; $iCompressed)
	If ($iCompressed=Is not compressed:K22:11)
	Else 
		EXPAND BLOB:C535($xResponse)
	End if 
	
	$status.statusText:=BLOB to text:C555($xResponse; UTF8 text without length:K22:17)
	BASE64 ENCODE:C895($xResponse; $encodedText)
	$status.response:=$encodedText
End if 

ON ERR CALL:C155($currOnErr)

$0:=$status