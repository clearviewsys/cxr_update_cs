//%attributes = {}
// prepares collection of paths to 4D Developer Professional license files

#DECLARE($licensesPath : Text)->$licenses : Collection

var $licensesPath : Text
var $i : Integer

If (Count parameters:C259=0)
	$licensesPath:=System folder:C487(Documents folder:K41:18)+"Licenses"+Folder separator:K24:12
End if 

ARRAY TEXT:C222($files; 0)

DOCUMENT LIST:C474($licensesPath; $files)

$licenses:=New collection:C1472

If (True:C214)
	
	For ($i; 1; Size of array:C274($files))
		If ($files{$i}[[1]]#".")
			$licenses.push($licensesPath+$files{$i})
		End if 
	End for 
	
Else 
	
	// OLD CODE
	
	var $idx : Integer
	
	$idx:=1
	
	For ($i; 1; Size of array:C274($files))
		If ($files{$i}[[1]]#".")
			$licenses.push(New object:C1471("elementName"; "Item"+String:C10($idx); "path"; $licensesPath+$files{$i}))
			$idx:=$idx+1
		End if 
	End for 
	
End if 
