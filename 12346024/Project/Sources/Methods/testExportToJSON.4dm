//%attributes = {}
C_POINTER:C301($tablePtr)
C_TEXT:C284($json)
C_TEXT:C284($path)
C_LONGINT:C283($i)

$path:=System folder:C487(Documents folder:K41:18)+"milanexport"+Folder separator:K24:12

If (Test path name:C476($path)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($path)
End if 

For ($i; 1; Get last table number:C254)
	
	If (Is table number valid:C999($i))
		
		MESSAGE:C88(Table name:C256($i))
		
		$tablePtr:=Table:C252($i)
		
		$json:=recordsToJSON($tablePtr; "ALL")
		
		TEXT TO DOCUMENT:C1237($path+Table name:C256($i); $json; "UTF-8")
		
	End if 
	
End for 
