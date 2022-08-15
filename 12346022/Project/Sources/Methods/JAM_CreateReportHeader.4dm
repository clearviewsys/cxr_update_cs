//%attributes = {}
// JAM_CreateReportHeader ($fileName)
// Create the Report Header


C_TEXT:C284($1; $fileName)
C_TEXT:C284($reportType)
C_TEXT:C284($2; $sep)

Case of 
		
	: (Count parameters:C259=1)
		$fileName:=$1
		$sep:=""
	: (Count parameters:C259=2)
		$fileName:=$1
		$sep:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($content; $batchname; $batchDescription; $createdBy)
C_TEXT:C284($authorizedBy; $processDate)
C_BLOB:C604($blob)
C_TEXT:C284($processDate; $processTime)

$reportType:="H"+$sep
$batchname:=getFileName($fileName)
$batchname:=Replace string:C233($batchname; ".TXT"; "")
$batchname:=FT_StringFormat($batchname; 10)+$sep

$batchDescription:=FT_StringFormat(getKeyValue("JAM.default.Report.description"; "Banking Currency Exchange"); 30)+$sep

$createdBy:=getApplicationUser+$sep
$createdBy:=FT_StringFormat($createdBy; 10)+$sep

$authorizedBy:=""+$sep
$authorizedBy:=FT_StringFormat($authorizedBy; 10)+$sep

$processDate:=FT_GetStringDate+$sep
$processTime:=FT_GetStringTime+$sep

// Create the ascii line for header

$content:=$reportType
$content:=$content+$batchname
$content:=$content+$batchDescription

$content:=$content+$createdBy
$content:=$content+$authorizedBy

$content:=$content+$processDate
$content:=$content+$processTime

// Save the line into a file
TEXT TO BLOB:C554($content; $blob; UTF8 text without length:K22:17; *)
AppendBlobToFile($fileName; $blob)








