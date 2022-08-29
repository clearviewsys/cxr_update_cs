//%attributes = {}
C_TEXT:C284($fileName; $report2Delete; $fileContent)
C_LONGINT:C283($reportSeq; operationMode)
//$report2Delete:=Request("Enter the report Number to delete")
//If ($report2Delete#"")

//operationMode:=1  //Testing
operationMode:=0  //Production


// Create and define the LCTR Report File Name
$fileName:=FT_GetFileName
$reportSeq:=FT_NextSequence("FINTRAC_ReportSeq")
FT_DeleteLCTRReport($fileName; $reportSeq)

$fileContent:=Document to text:C1236($fileName)

$fileContent:=Replace string:C233($fileContent; "_RS??"; "00001")
$fileContent:=Replace string:C233($fileContent; "_SH??"; "00001")
$fileContent:=Replace string:C233($fileContent; "_RC??"; "00001")

C_BLOB:C604($blob)
TEXT TO BLOB:C554($fileContent; $blob; UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($fileName; $blob)



//End if 

C_TEXT:C284($fileName; $report2Delete; $fileContent)
C_LONGINT:C283($reportSeq; operationMode)
//$report2Delete:=Request("Enter the report Number to delete")
//If ($report2Delete#"")

//operationMode:=1  //Testing
operationMode:=0  //Production


// Create and define the LCTR Report File Name
$fileName:=FT_GetFileName
$reportSeq:=FT_NextSequence("FINTRAC_ReportSeq")
FT_DeleteLCTRReport($fileName; $reportSeq)

$fileContent:=Document to text:C1236($fileName)

$fileContent:=Replace string:C233($fileContent; "_RS??"; "00001")
$fileContent:=Replace string:C233($fileContent; "_SH??"; "00001")
$fileContent:=Replace string:C233($fileContent; "_RC??"; "00001")

C_BLOB:C604($blob)
TEXT TO BLOB:C554($fileContent; $blob; UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($fileName; $blob)



//End if 

C_TEXT:C284($fileName; $report2Delete; $fileContent)
C_LONGINT:C283($reportSeq; operationMode)
//$report2Delete:=Request("Enter the report Number to delete")
//If ($report2Delete#"")

//operationMode:=1  //Testing
operationMode:=0  //Production


// Create and define the LCTR Report File Name
$fileName:=FT_GetFileName
$reportSeq:=FT_NextSequence("FINTRAC_ReportSeq")
FT_DeleteLCTRReport($fileName; $reportSeq)

$fileContent:=Document to text:C1236($fileName)

$fileContent:=Replace string:C233($fileContent; "_RS??"; "00001")
$fileContent:=Replace string:C233($fileContent; "_SH??"; "00001")
$fileContent:=Replace string:C233($fileContent; "_RC??"; "00001")

C_BLOB:C604($blob)
TEXT TO BLOB:C554($fileContent; $blob; UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($fileName; $blob)



//End if 

