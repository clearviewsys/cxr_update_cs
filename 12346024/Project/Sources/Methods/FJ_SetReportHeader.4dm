//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FJ_SetReportHeader ($blobPtr; $fileName)
// Generate the FIJI FIU Report Header
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $fileName)
C_TEXT:C284($rptHeader)
C_LONGINT:C283($p)

Case of 
		
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$rptHeader:=""
$rptHeader:=$rptHeader+"A01:HR"+CRLF
$rptHeader:=$rptHeader+":A02:"+fiReportRef+CRLF

$fileName:=Replace string:C233($fileName; ".txt"; "")
$p:=Length:C16($fileName)-9
$rptHeader:=$rptHeader+":A03:"+Substring:C12($fileName; $p)+CRLF

//$rptHeader:=$rptHeader+"="

appendToFile($fileName; ->$rptHeader; True:C214)
