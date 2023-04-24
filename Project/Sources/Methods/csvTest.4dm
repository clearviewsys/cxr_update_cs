//%attributes = {}
var $inFilePath; $outFilePath; $json : Text
var $obj : Collection


//$inFilePath:=System folder(Desktop)+"ExportCSV_100.csv"

$inFilePath:=Select document:C905(System folder:C487(Desktop:K41:16); ""; "pick"; 0)
$inFilePath:=document

$outFilePath:=csvConvert2JSON($inFilePath; True:C214)

$json:=Document to text:C1236($outFilePath)

$obj:=JSON Parse:C1218($json)

C_OBJECT:C1216($status)

$status:=CXR_createTransactions("batchid"; $obj)


If ($status.success)
	
Else 
	
End if 