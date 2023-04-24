C_OBJECT:C1216($oneFile)
C_TEXT:C284($path; $result; $msg; $msg_skipped; $msg_added)
C_COLLECTION:C1488($toDownload; $found)
C_LONGINT:C283($progress)
C_BOOLEAN:C305($add)

If (Form:C1466.selectedRemoteFiles#Null:C1517)
	
	For each ($oneFile; Form:C1466.selectedRemoteFiles)
		
		$add:=True:C214
		
		$found:=Form:C1466.localFiles.query("fileName = :1"; $oneFile.fileName)
		
		If ($found#Null:C1517)
			If ($found.length>0)
				$add:=False:C215
			End if 
		End if 
		
		If ($add)
			If ($toDownload=Null:C1517)
				$toDownload:=New collection:C1472
			End if 
			$toDownload.push($oneFile)
			$msg_added:=$msg_added+$oneFile.fileName+"\n"
		Else 
			$msg_skipped:=$msg_skipped+$oneFile.fileName+"\n"
		End if 
		
		
	End for each 
	
	If ($toDownload#Null:C1517)
		b2_downloadFromCloud($toDownload)
		b2_refreshLocalFileList
	End if 
	
	
End if 
