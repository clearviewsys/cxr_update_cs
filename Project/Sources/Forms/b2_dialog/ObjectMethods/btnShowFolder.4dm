var $destinationFolder : Text


If (Form:C1466.currLocalFile#Null:C1517)
	
	If (Form:C1466.currLocalFile.localPath="backup_folder")
		
		$destinationFolder:=backup_getDestinationFolder
		
		If (Test path name:C476($destinationFolder)=Is a folder:K24:2)
			
			SHOW ON DISK:C922($destinationFolder; *)
			
		End if 
		
	Else 
		
		$destinationFolder:=b2_getLocalDownloadDestination
		
		If (Test path name:C476($destinationFolder)=Is a folder:K24:2)
			
			SHOW ON DISK:C922($destinationFolder; *)
			
		End if 
		
	End if 
	
	
End if 
