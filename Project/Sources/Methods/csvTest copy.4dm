//%attributes = {}
var $inFilePath; $outFilePath; $json : Text
var $obj : Collection


$inFilePath:=System folder:C487(Desktop:K41:16)+"ExportCSV_100.csv"
$outFilePath:=csvConvert2JSON($inFilePath)

$json:=Document to text:C1236($outFilePath)

$obj:=JSON Parse:C1218($json)
