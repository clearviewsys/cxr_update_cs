//%attributes = {"shared":true}
// sets a path HTTP Client commands will find certificates to use when connecting to secure sites (https://mysite.com)

C_TEXT:C284($1; $folderPath)  // path to a folder containing certificates

$folderPath:=$1

If (Test path name:C476($folderPath)=Is a folder:K24:2)
	HTTP SET CERTIFICATES FOLDER:C1306($folderPath)
End if 
