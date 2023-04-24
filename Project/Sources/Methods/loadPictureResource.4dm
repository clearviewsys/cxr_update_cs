//%attributes = {}
// loadPictureResource
#DECLARE($picNameParam : Text; $picPtrParam : Pointer; $subFolderParam : 4D:C1709.Folder)->$pass : Boolean

var $subFolder : 4D:C1709.Folder
var $picName : Text
var $picPtr : Pointer
$subFolder:=Folder:C1567("Images/library")
Case of 
		
	: (Count parameters:C259=0)
		
		$picName:="AlertOk"
		var $pic : Picture
		$picPtr:=->$pic
		
	: (Count parameters:C259=2)
		$picName:=$picNameParam
		$picPtr:=$picPtrParam
		
	: (Count parameters:C259=3)
		$picName:=$picNameParam
		$picPtr:=$picPtrParam
		$subFolder:=$subFolderParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($picName#"@.@")
	$picName:=$picName+".png"
End if 

var $folder; $mainfolder : 4D:C1709.Folder
var $file : 4D:C1709.File
$folder:=Folder:C1567(Get 4D folder:C485(Current resources folder:K5:16); fk platform path:K87:2)
$mainfolder:=Folder:C1567($folder.path+Substring:C12($subFolder.path; 2))


$file:=File:C1566($mainfolder.path+$picName)

// TODO: validate why sometimes the $picPtr variable  is not pointing to a picture field: JA
If (Value type:C1509($picPtr->)=Is picture:K8:10)
	READ PICTURE FILE:C678($file.platformPath; $picPtr->; *)
End if 

If (OK=1)
	$pass:=True:C214
Else 
	$pass:=False:C215
End if 
