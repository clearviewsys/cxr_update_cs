//%attributes = {}
// gets document from Resources forlder

C_TEXT:C284($1; $fileName)
C_TEXT:C284($0; $mypagepath)

$fileName:=$1

$mypagepath:=mgGetResourcesPath+$fileName

If (Test path name:C476($mypagepath)=Is a document:K24:1)
	$0:=Document to text:C1236($mypagepath; "UTF-8")
End if 
