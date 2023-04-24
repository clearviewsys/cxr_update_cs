C_COLLECTION:C1488($toUpload; $found)
C_OBJECT:C1216($currFile)
C_BOOLEAN:C305($add)
C_TEXT:C284($msg; $msg_skipped; $msg_added)
C_LONGINT:C283($progress)

If (Form:C1466.selectedLocalFiles#Null:C1517)
	
	$progress:=Progress New
	
	Progress SET TITLE($progress; "Uploading files to B2 Cloud")
	Progress SET MESSAGE($progress; "Getting remote listing ...")
	
	Form:C1466.remoteFiles:=b2_ls
	
	Progress SET MESSAGE($progress; "Comparing files ...")
	
	For each ($currFile; Form:C1466.selectedLocalFiles)
		
		$add:=True:C214
		
		$found:=Form:C1466.remoteFiles.query("fileName = :1"; $currFile.fileName)
		
		If ($found#Null:C1517)
			If ($found.length>0)
				$add:=False:C215
			End if 
		End if 
		
		If ($add)
			If ($toUpload=Null:C1517)
				$toUpload:=New collection:C1472
			End if 
			$toUpload.push($currFile)
			$msg_added:=$msg_added+$currFile.fileName+"\n"
		Else 
			$msg_skipped:=$msg_skipped+$currFile.fileName+"\n"
		End if 
		
	End for each 
	
	Progress QUIT($progress)
	
	If ($toUpload#Null:C1517)
		b2_uploadToCloud($toUpload)
		$msg:="Files queued for upload:\n\n"+$msg_added
		If ($msg_skipped#"")
			$msg:=$msg+"\n\nFiles skipped:\n\n"+$msg_skipped
		End if 
		myAlert($msg)
	Else 
		$msg:="Nothing to upload.\n\n"
		If ($msg_skipped#"")
			$msg:=$msg+"\n\nFiles skipped:\n\n"+$msg_skipped
		End if 
		myAlert($msg)
	End if 
	
	
End if 
