//%attributes = {}
// fetchBLOBfromURL ( domainURL ; subURL) -> BLOB
// ex : fetchBLOBfromURL ("banknotes.com"; "images/51.JPG")

C_BLOB:C604($0)
C_TEXT:C284($domainURL; $subURL; $2; $1)

C_LONGINT:C283($tcp_id)
C_TEXT:C284($webpage; $buffer; $httpRequest)
C_LONGINT:C283($vState; $error; $Err; $State)
C_BLOB:C604($Blob_Received; $Blob_All)

$domainURL:=$1
$subURL:=$2
$error:=0
$tcp_id:=0
$vState:=0

$error:=TCP_Open($domainURL; 80; $tcp_id)
If ($error=0)
	$httpRequest:="GET /"+$subURL+" HTTP/1.1"+Char:C90(13)+Char:C90(10)
	$httpRequest:=$httpRequest+"Host: "+$domainURL+Char:C90(13)+Char:C90(10)
	$httpRequest:=$httpRequest+"Connection: close"+Char:C90(13)+Char:C90(10)
	$httpRequest:=$httpRequest+"Accept: */*"+Char:C90(13)+Char:C90(10)
	$httpRequest:=$httpRequest+"User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en)"+Char:C90(13)+Char:C90(10)
	$httpRequest:=$httpRequest+"Referer: http://web-sniffer.net/"+Char:C90(13)+Char:C90(10)
	$httpRequest:=$httpRequest+Char:C90(13)+Char:C90(10)
	//saveTextToFile ($httpRequest;"HTTPRequest"+$domainURL+".html")
	
	$error:=TCP_Send($tcp_ID; $httpRequest)
	//$error:=TCP_Send ($tcp_ID;"GET /m5?a=1&s="+$2+"&t="+$1+Char(10)+Char(13))
	If ($error=0)
		$webpage:=""
		$vState:=0
		
		
		C_LONGINT:C283($srcpos; $dstpos)
		Repeat 
			$Err:=TCP_ReceiveBLOB($TCP_ID; $Blob_Received)
			$Err:=TCP_State($TCP_ID; $State)
			$srcpos:=0
			$dstpos:=BLOB size:C605($Blob_All)
			//Concatenating received Blobs
			COPY BLOB:C558($Blob_Received; $Blob_All; $srcpos; $dstpos; BLOB size:C605($Blob_Received))
		Until (($State=0) | ($Err#0))
		//webpage:=ISO to Mac($webpage)
	End if 
	$error:=TCP_Close($tcp_id)
End if 

$0:=$Blob_All

