//%attributes = {}
#DECLARE($filesToUpload : Collection)

var $file : Text
var $obj; $fileObj; $compare : Object
var $skipAuthorization : Boolean

If (b2_authorize_account)
	
	$skipAuthorization:=True:C214
	
	For each ($file; $filesToUpload)
		
		If (Test path name:C476($file)=Is a document:K24:1)
			
			$fileObj:=File:C1566($file; fk platform path:K87:2)
			
			If ($fileObj.size>b2_getAsyncUploadLimit)
				$obj:=b2_uploadFileAsync($file; $skipAuthorization)
			Else 
				$obj:=b2_uploadFile($file; $skipAuthorization)
			End if 
			
		End if 
		
	End for each 
	
End if 
