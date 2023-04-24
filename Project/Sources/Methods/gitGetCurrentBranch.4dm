//%attributes = {}
// git branch --show-current

// or line 1 of file HEAD in .git folder:

// ref: refs/heads/develop
// ref: refs/heads/main

#DECLARE()->$branchName : Text

var $packageFolder; $gitFolder; $headFile : Object
var $headContent : Text
var $start : Integer
var $ok : Boolean

$branchName:=""
$packageFolder:=Folder:C1567(fk database folder:K87:14)

$gitFolder:=Folder:C1567($packageFolder.platformPath+".git"; fk platform path:K87:2)

$headFile:=File:C1566($gitFolder.platformPath+"HEAD"; fk platform path:K87:2)

If ($headFile.exists)
	
	$headContent:=$headFile.getText()
	
	$start:=1
	ARRAY LONGINT:C221($pos_found; 0)
	ARRAY LONGINT:C221($length_found; 0)
	
	$ok:=Match regex:C1019("(.+)(refs/heads/)(.+)"; $headContent; $start; $pos_found; $length_found)
	
	If ($ok)
		If (Size of array:C274($pos_found)>2)
			$branchName:=Substring:C12($headContent; $pos_found{3}; $length_found{3})
		End if 
	End if 
	
End if 
