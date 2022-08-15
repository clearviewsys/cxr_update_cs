//%attributes = {}
// fetchBankNoteBLOB ( $bankNoteFileName) -> HTML

C_BLOB:C604($0)
C_TEXT:C284($name; $1)

C_LONGINT:C283($tcp_id; $catNo; $2)
C_TEXT:C284($webpage; $buffer)
C_LONGINT:C283($vState; $error; $Err; $State)
$name:=$1

$error:=0
$tcp_id:=0
$vState:=0

$error:=TCP_Open("banknotes.com"; 80; $tcp_id)
If ($error=0)
	$error:=TCP_Send($tcp_ID; "GET /"+$name+Char:C90(10)+Char:C90(13))
	//$error:=TCP_Send ($tcp_ID;"GET /m5?a=1&s="+$2+"&t="+$1+Char(10)+Char(13))
	If ($error=0)
		$webpage:=""
		$vState:=0
		
		C_BLOB:C604($Blob_Received; $Blob_All)
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

