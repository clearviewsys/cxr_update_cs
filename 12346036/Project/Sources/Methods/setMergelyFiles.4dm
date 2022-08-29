//%attributes = {}
// setMergely files to show in the browser.

C_BOOLEAN:C305($1)
C_POINTER:C301($2; $3; $4)
C_TEXT:C284(url; $lfile; $rfile; $fileName; $htmlFileName)

C_TEXT:C284($filePath; $htmlContent; $folderPath)
C_BLOB:C604($blobFileContent; $newFileContent; $lBlob)
C_BLOB:C604($lBlob; $rBlob; $htmlTemplateBlob; $newHtmlTemplateBlob)
C_TEXT:C284($lCodeFileName; $rCodeFileName; $htmlFileName; $htmlFileNameTemplate; $htmlTemplateContent; $htmlFileName)

$htmlFileNameTemplate:=getFilePathByID("CodeRevisions_TemplatePath")

TEXT TO BLOB:C554(vSourceCode; $lBlob)
$lCodeFileName:=String:C10(Random:C100)+"_lhs.txt"
$lfile:=[FilePaths:83]FolderPath:3+$lCodeFileName
BLOB TO DOCUMENT:C526($lfile; $lBlob)

TEXT TO BLOB:C554([DB_CodeRevisions:103]SourceCode:5; $rBlob)
$rCodeFileName:=String:C10(Random:C100)+"_rhs.txt"
$rfile:=[FilePaths:83]FolderPath:3+$rCodeFileName
BLOB TO DOCUMENT:C526($rfile; $rBlob)

DOCUMENT TO BLOB:C525($htmlFileNameTemplate; $htmlTemplateBlob)
$htmlTemplateContent:=BLOB to text:C555($htmlTemplateBlob; UTF8 text without length:K22:17)
$htmlTemplateContent:=Replace string:C233($htmlTemplateContent; "<LFILE>"; $lCodeFileName)
$htmlTemplateContent:=Replace string:C233($htmlTemplateContent; "<RFILE>"; $rCodeFileName)
TEXT TO BLOB:C554($htmlTemplateContent; $newHtmlTemplateBlob)

$fileName:=String:C10(Random:C100)+"_"+[FilePaths:83]FileName:2
$htmlFileName:=[FilePaths:83]FolderPath:3+$fileName
BLOB TO DOCUMENT:C526($htmlFileName; $newHtmlTemplateBlob)

url:=getFilePathByID("CodeRevisions_URL")+$fileName

// Show in a browser or in a web area
If ($1)
	WA OPEN URL:C1020(MergelyArea; url)
	FORM GOTO PAGE:C247(3)
Else 
	WA OPEN URL:C1020(MergelyArea; url)
End if 

// Return file names to delete

$2->:=$lfile
$3->:=$rfile
$4->:=$htmlFileName



