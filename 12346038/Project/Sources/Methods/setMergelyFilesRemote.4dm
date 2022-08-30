//%attributes = {}
// SetMegelyFilesRemote
//setMergely files to show in the browser.

C_BOOLEAN:C305($1)
C_POINTER:C301($2; $3; $4)
C_BOOLEAN:C305($5; $isRemote)

$isRemote:=False:C215

Case of 
		
	: (Count parameters:C259=4)
		$isRemote:=False:C215
		
	: (Count parameters:C259=5)
		$isRemote:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 


C_TEXT:C284(url; $lfile; $rfile; $fileName; $htmlFileName)
C_BOOLEAN:C305($continue)

C_TEXT:C284($filePath; $htmlContent; $folderPath; $remoteCode; $localCode; $methodName)
C_BLOB:C604($blobFileContent; $newFileContent; $lBlob)
C_BLOB:C604($lBlob; $rBlob; $htmlTemplateBlob; $newHtmlTemplateBlob)
C_TEXT:C284($lCodeFileName; $rCodeFileName; $htmlFileName; $htmlFileNameTemplate; $htmlTemplateContent; $htmlFileName)

$htmlFileNameTemplate:=getFilePathByID("CodeRevisions_TemplatePath")
$methodName:=arrMethodPath{arrMethodPath}
$remoteCode:=vSourceCode
TEXT TO BLOB:C554($remoteCode; $rBlob)
$rCodeFileName:=String:C10(Random:C100)+"_rhs.txt"
$rfile:=[FilePaths:83]FolderPath:3+$rCodeFileName
BLOB TO DOCUMENT:C526($rfile; $rBlob)
$continue:=True:C214

// If the method exists get the code else create an empty method
If (UTIL_isMethodExists($methodName))
	METHOD GET CODE:C1190($methodName; $localCode)
Else 
	
	myConfirm("Method "+$methodName+" Doesn´t exist. Do you want to create it?"; "Create Method"; "Cancel")
	If (Ok=1)
		$localCode:=$remoteCode
		UTIL_Method_CreateShared($methodName; $localCode)
	Else 
		
		myAlert("Method must be created to continue")
		$continue:=False:C215
		
	End if 
	
End if 

If ($continue)
	
	TEXT TO BLOB:C554($localCode; $lBlob)
	$lCodeFileName:=String:C10(Random:C100)+"_lhs.txt"
	$lfile:=[FilePaths:83]FolderPath:3+$lCodeFileName
	BLOB TO DOCUMENT:C526($lfile; $lBlob)
	
	
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
		FORM GOTO PAGE:C247(2)
	Else 
		WA OPEN URL:C1020(MergelyArea; url)
	End if 
	
	// Return file names to delete
	
	$2->:=$lfile
	$3->:=$rfile
	$4->:=$htmlFileName
	
End if 

