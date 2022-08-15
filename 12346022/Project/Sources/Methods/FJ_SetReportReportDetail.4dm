//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FJ_SetReportReportDetail ($blobPtr; $reportCode;$fileName)
// Generate the FIJI FIU Report Header
// ------------------------------------------------------------------------------




C_TEXT:C284($1; $fileName; $2; $format; $rptInfo)

Case of 
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$format:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$rptInfo:=""
$rptInfo:=$rptInfo+"=B01:"+$format+CRLF
$rptInfo:=$rptInfo+":B02:"+fiReportRef+CRLF
//$rptInfo:=$rptInfo+":B03:N"+CRLF 
$rptInfo:=$rptInfo+"="

appendToFile($fileName; ->$rptInfo; False:C215)
