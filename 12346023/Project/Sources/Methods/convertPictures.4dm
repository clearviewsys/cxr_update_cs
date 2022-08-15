//%attributes = {}
// convertPictures
// This method is throwing a runtime error due to a 4D_Pack command license issue
//Deprecated due to not having 4D_Pack
C_LONGINT:C283($iProgress; $iPercent; $i)

If (True:C214)
	C_LONGINT:C283($isObs; $numTables; $numFields; $tableNum; $fieldNum; $totalConverted)
	C_POINTER:C301($pPic; $pTable; $pField)
	ARRAY INTEGER:C220($picFields; 0)
	C_PICTURE:C286($pic)
	C_TEXT:C284($name)
	//Check List of plugins to ensure 4D_Pack
	If (True:C214)  //(is4DPack )
		//Don't run this code on 4d Server
		If (Application type:C494=4D Server:K5:6)
		Else 
			//Only Run once
			If (getKeyValue("pictures.convertDeprecated")#"False")
				
				myConfirm("Would you like to convert all pictures in the database to a modern format?"; "Yes"; "No"; "Picture Conversion")
				If (OK=1)
					
					//myAlert ("Converting Deprecated Pictures")
					
					$iProgress:=Progress New
					
					//Get total number of tables
					$numTables:=Get last table number:C254
					$totalConverted:=0
					For ($tableNum; 1; $numTables)
						If (Is table number valid:C999($tableNum))
							$pTable:=Table:C252($tableNum)
							
							$iPercent:=$tableNum/$numTables
							Progress SET PROGRESS($iProgress; $iPercent; "Converting pictures in "+Table name:C256($pTable))
							
							
							READ WRITE:C146($pTable->)
							ALL RECORDS:C47($pTable->)
							
							//get number of fields in table
							$numFields:=Get last field number:C255($tableNum)
							
							//Loop through all fields, add field number to array if picture
							For ($fieldNum; 1; $numFields)
								If (Is field number valid:C1000($tableNum; $fieldNum))
									$pField:=Field:C253($tableNum; $fieldNum)
									If (Type:C295($pField->)=Is picture:K8:10)
										APPEND TO ARRAY:C911($picFields; $fieldNum)
									End if 
								End if 
							End for 
							
							//Loop though all records, check fields in array for each record,
							//if deprecated, convert
							FIRST RECORD:C50($pTable->)
							If (Size of array:C274($picFields)>0)
								While (Not:C34(End selection:C36($pTable->)))
									For ($i; 1; Size of array:C274($picFields))
										$pField:=Field:C253($tableNum; $picFields{$i})
										
										If (Picture size:C356($pField->)>0)
											ARRAY TEXT:C222($atCodecs; 0)
											GET PICTURE FORMATS:C1406($pField->; $atCodecs)
											
											If (Find in array:C230($atCodecs; "@pict@")>0)
												
												CONVERT PICTURE:C1002($pField->; ".jpg")  //;0.6)  // WILL NOT WORK IN 64 BIT
												
												If (OK=1)
													SAVE RECORD:C53($pTable->)
												End if 
												
											End if 
											
										End if 
										//If (AP Is Picture Deprecated ($pField)=1)
										//CONVERT PICTURE($pField->;".jpg")
										//$totalConverted:=$totalConverted+1
										//SAVE RECORD($pTable->)
										//End if 
									End for 
									NEXT RECORD:C51($pTable->)
								End while 
							End if 
							
							//Clear array
							DELETE FROM ARRAY:C228($picFields; 1; Size of array:C274($picFields))
							
							REDUCE SELECTION:C351($pTable->; 0)
							
							
						End if 
						
						
					End for 
					
					Progress QUIT($iProgress)
					
					setKeyValue("pictures.convertDeprecated"; "False")
				End if 
				
				myAlert("Total Pictures Converted: "+String:C10($totalConverted))
			End if 
		End if 
	End if 
End if 