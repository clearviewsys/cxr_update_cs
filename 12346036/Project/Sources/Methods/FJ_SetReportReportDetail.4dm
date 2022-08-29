//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FJ_SetReportReportDetail ($blobPtr; $reportCode;$fileName)
// Generate the FIJI FIU Report Header
// ------------------------------------------------------------------------------




C_TEXT:C284($1; $fileName; $2; $format; $rptInfo)
C_LONGINT:C283($batchSeqId)
Case of 
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$format:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$rptInfo:=""
$rptInfo:=$rptInfo+"=B01:"+$format+CRLF
$batchSeqId:=FT_NextSequence("FJ_RPTS_BatchSeq")
//$rptInfo:=$rptInfo+":B02:LFJ"+FT_StringFormat (String($batchSeqId);10;"0";"RJ")+CRLF 
//$rptInfo:=$rptInfo+":B02:"+fiReportRef+CRLF 
//$rptInfo:=$rptInfo+":B03:N"+CRLF 
$rptInfo:=$rptInfo+"="

appendToFile($fileName; ->$rptInfo; False:C215)
