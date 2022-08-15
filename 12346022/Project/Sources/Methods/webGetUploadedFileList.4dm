//%attributes = {"publishedWeb":true}
C_TEXT:C284($vDestinationFolder)
ARRAY TEXT:C222(uploadedFileList; 0)
C_LONGINT:C283($i)
$vDestinationFolder:=Get 4D folder:C485(HTML Root folder:K5:20)+"uploads"+Folder separator:K24:12  //"WebFolder/uploads" folder
DOCUMENT LIST:C474($vDestinationFolder; uploadedFileList)