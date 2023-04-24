//%attributes = {}
// designed to be run by calendar events
// self contained - no parameters needed
// checks  a watch folder for files that need to be imported
// 11/29/22


C_OBJECT:C1216($status; $batch; $obj; $es)
C_COLLECTION:C1488($col)
C_TEXT:C284($inFilePath; $outFilePath; $json; $folderPath; $archivePath; $ext; $dupPath)
C_LONGINT:C283($i)

$folderPath:=getFilePathByID("CAB-CSV"; "SERVER")
$ext:=getKeyValue("CAB.extension"; "txt")

If (Test path name:C476($folderPath)=Is a folder:K24:2)
	
	$archivePath:=$folderPath+"archive"+Folder separator:K24:12
	If (Test path name:C476($archivePath)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($archivePath)
	End if 
	
	$dupPath:=$folderPath+"duplicates"+Folder separator:K24:12
	If (Test path name:C476($dupPath)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($dupPath)
	End if 
	
	
	ARRAY TEXT:C222($aDocuments; 0)
	DOCUMENT LIST:C474($folderPath; $aDocuments)
	
	If (Size of array:C274($aDocuments)>0)
		//disableTriggers
		
		For ($i; 1; Size of array:C274($aDocuments))
			
			If ($aDocuments{$i}=("@."+$ext))
				$inFilePath:=$folderPath+$aDocuments{$i}
				
				$es:=ds:C1482.CAB_Batch_Logs.query("BatchID == :1"; $aDocuments{$i})
				
				If ($es.length=0)  // has not been processed yet
					$outFilePath:=csvConvert2JSON($inFilePath; True:C214)
					$json:=Document to text:C1236($outFilePath)
					DELETE DOCUMENT:C159($outFilePath)
					
					$col:=JSON Parse:C1218($json)
					If ($col.length>0)
						// create [CAB_Batch_Logs] record here
						$batch:=ds:C1482.CAB_Batch_Logs.new()
						$batch.DateStamp:=DATE_getCurrentDTS
						$batch.BatchID:=$aDocuments{$i}  //$batch.DateStamp
						$batch.Source:=$inFilePath
						$batch.NumOfRecords:=$col.length
						$status:=$batch.save()
						
						If ($status.success)
							START TRANSACTION:C239
							
							$status:=CXR_createTransactions($batch.BatchID; $col)
							
							
							If ($status.success)
								VALIDATE TRANSACTION:C240
								// udpate 
								//[CAB_Batch_Logs]Imported:=True
								//[CAB_Batch_Logs]isInvoicesCreated:=True
								//[CAB_Batch_Logs]isRegistersCreated:=True
								
								$batch.Imported:=1
								$batch.isInvoicesCreated:=1
								$batch.isRegistersCreated:=1
								If (Num:C11(getKeyValue("cab.customer.new.approvalstatus"; "0"))=-9999)
									$batch.isCustomersPulled:=0
								Else 
									$batch.isCustomersPulled:=1  // @ibb added b/c we create with registers now
								End if 
								$batch.isValidated:=1
								$status:=$batch.save()
								
								If ($status.success)  // --- NEED TO ARCHIVE THE CSV FILE HERE ----
									MOVE DOCUMENT:C540($inFilePath; $archivePath+"PROCESSED_"+$aDocuments{$i})
								Else 
									//error handling here
									CAB_log("Failed to save [CAB_Batch_Logs] record.")
								End if 
							Else 
								CANCEL TRANSACTION:C241
								// error handling here
								CAB_log("Error creating transactions (registers).")
							End if 
							
						Else 
							// error handling here
							CAB_log("Error creating on [CAB_Batch_Logs] record.")
						End if 
						
					Else 
						MOVE DOCUMENT:C540($inFilePath; $archivePath+"EMPTY_"+DATE_getCurrentDTS+"_"+$aDocuments{$i})
					End if 
					
				Else   // seems to have been processed
					MOVE DOCUMENT:C540($inFilePath; $dupPath+"DUP_"+DATE_getCurrentDTS+"_"+$aDocuments{$i})
				End if 
			End if 
			
		End for 
		
		//enableTriggers
	End if 
	
Else   // folder path does NOT exist
	// error handling here
	CAB_log("CSV folder path does not exist.")
End if 