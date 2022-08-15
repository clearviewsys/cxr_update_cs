//%attributes = {}
#DECLARE($textvar : Text; $filename : Text)

var $path : Text

build_checkForArtifactsFolder

$path:=System folder:C487(Documents folder:K41:18)+"artifacts"+Folder separator:K24:12+$filename

TEXT TO DOCUMENT:C1237($path; $textvar; "UTF-8")

