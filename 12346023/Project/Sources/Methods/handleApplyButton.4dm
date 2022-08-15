//%attributes = {}

Case of 
	: (Form event code:C388=On Load:K2:1)  //11/30/17 IBB disabled to test transaction issues with edit registers in invoice
		//If (Transaction level>1)
		If (Is new record:C668(Current form table:C627->))
			//_O_DISABLE BUTTON(Self->)
			OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
		End if 
		
		//OBJECT SET ENABLED(bUpdate;False)
		
		//End if 
		
		//apply button mainly for customers and currency
		//track that user has "applied" state or 
		//after clicking apply disable the cancel button -- can we tell if record has changed then enable apply 
		//otherwise disable apply
		//store record in memory xml... on load ... and allow and undo
		
		
	: (Form event code:C388=On Data Change:K2:15)
		
		
	Else 
		
		If (Is new record:C668(Current form table:C627->))
			// Modified by: Tiran Behrouz (2012-11-25)
			myAlert("Please use the save button instead.")
		Else 
			// Modified by: Tiran Behrouz (5/30/13)
			//handleSaveButton 
			If (validateTable(Current form table:C627))
				//ALERT(String(Transaction level))
				//If (Transaction level>1)
				//myAlert ("Please use the Save button.")
				//DISABLE BUTTON(Self->)
				//Else 
				SAVE RECORD:C53(Current form table:C627->)
				
				OBJECT SET ENABLED:C1123(BCANCEL; False:C215)  //disable the cancel button per Tiran 12/8/17
				
				If (False:C215)  //12/8/17 disabled per Tiran conversation - no transaction code in buttons
					If (Transaction level:C961=1)
						VALIDATE TRANSACTION:C240  //<----- I think this is problematic... the next record button does not start a new transaction
						// so at best only the first record is in a transaction
						
						TM_RemoveFromStack  //9/15/16
						
						
						//If (True)
						//$tResult:=" handleApplyButton method run: [100]: "+Table name(Current form table)
						//If (False)
						//$iError:=sendEmail ("barclay@mac.com";"Branch:"+<>BRANCHID+" User:"+<>USERID+" Date:"+String(Current date)+" "+"handleApplyButton";$tResult)
						//End if 
						//Sync_Log (Current method name;$tResult)
						//End if 
						
					End if 
				End if 
				//End if 
				//If (isApplyButtonClicked=False) & (Transaction level>0)
				//validatetransaction
				//End if 
				//
				//isApplyButtonClicked:=True
				//message("Record saved")
			Else 
				BEEP:C151
			End if 
			
		End if 
		
		
End case 