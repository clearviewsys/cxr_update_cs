//%attributes = {}

//this is called from client and executes on the server
// so the paths are all relative to the server hardware


C_BLOB:C604($1; $xDocument)
C_TEXT:C284($2; $filename)
C_TEXT:C284($0; $relativePath)

C_TEXT:C284($posixMonthFolder; $path)
C_BOOLEAN:C305($folderExists)



$xDocument:=$1
$filename:=$2

$relativePath:=String:C10(Year of:C25(Current date:C33); "0000")+Folder separator:K24:12+String:C10(Month of:C24(Current date:C33); "00")+Folder separator:K24:12

//need to test the relative path and create folders as necssary
$posixMonthFolder:=Convert path system to POSIX:C1106(WAPI_uploadsFolder+$relativePath)
$folderExists:=Folder:C1567($posixMonthFolder).exists
If (Not:C34($folderExists))
	Folder:C1567($posixMonthFolder).create()
End if 


$filename:=Generate UUID:C1066+"_"+$filename

$path:=WAPI_uploadsFolder+$relativePath+$filename

BLOB TO DOCUMENT:C526($path; $xDocument)

$0:=$relativePath+$filename  //convert to posix path