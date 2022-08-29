C_TEXT:C284($tUpdate)
C_LONGINT:C283($iError)


Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		C_TEXT:C284(veWireID; vSecurityCode)
		C_DATE:C307(vDate)
		C_TEXT:C284(vSenderName)
		C_TEXT:C284(vBeneficiaryName)
		C_REAL:C285(vFromAmount)
		C_REAL:C285(vToAmount)
		C_TEXT:C284(vFromCountryCode)
		C_TEXT:C284(vToCountryCode)
		
		C_TEXT:C284(vCurrency)
		C_BOOLEAN:C305(vIsSettled)
		C_TEXT:C284(vComments)
		C_BOOLEAN:C305(vIsFetched)
		C_DATE:C307(vFetchDate)
		C_TEXT:C284(vFetchLocation)
		
		
		
		C_LONGINT:C283($i)
		$i:=listbox_getSelectedRowNumber(->lb_eWire)
		
		If ($i>0)
			//handleGeteWireStatusButton 
			vEwireID:=arrEwireID{$i}
			vSecurityCode:=arrSecurityCode{$i}
			
			geteWireStatusRemotely(veWireID; vSecurityCode; ->vDate; ->vSenderName; ->vBeneficiaryName; ->vFromAmount; ->vToAmount; ->vCurrency; ->vFromCountryCode; ->vToCountryCode; ->vIsSettled; ->vComments; ->vIsFetched; ->vFetchDate; ->vFetchLocation; ->vBeneficiaryAmendedName)
			openFormWindow(->[eWires:13]; "eWireStatus")
		End if 
		
	: (Form event code:C388=On Clicked:K2:4) & (Right click:C712)
		
		C_LONGINT:C283($i)
		$i:=listbox_getSelectedRowNumber(->lb_eWire)
		
		If ($i>0)
			C_TEXT:C284($menu; $item)
			
			$menu:=Create menu:C408
			APPEND MENU ITEM:C411($menu; "Mark as Settled")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "Settle")
			
			$item:=Dynamic pop up menu:C1006($menu)
			
			
			Case of 
				: ($item="Settle")
					C_TEXT:C284($id; $code; $status)
					
					$id:=arrEwireID{$i}
					$code:=arrSecurityCode{$i}
					$status:=arrStatus{$i}
					
					Case of 
						: ($status="Invoiced")  //only allow invoiced
							
							myConfirm("Are you sure you want to MARK AS SETTLED: "+$id)
							If (OK=1)
								//  [{"LastName":"Anderson","City":"Cincinnati"}]
								
								$tUpdate:="[{\""+Field name:C257(->[eWires:13]isSettled:23)+"\":\"True\",\""+Field name:C257(->[eWires:13]modifiedByUser:52)+"\":\""+getSystemUserName+"\"}]"
								$iError:=WS_Remote_Record_Update(Table:C252(->[eWires:13]); Field:C253(->[eWires:13]eWireID:1); $id; $tUpdate; ""; $code; <>eWireServerURL)
								
								If ($iError=0)
									getRemoteEwireList
									DELAY PROCESS:C323(Current process:C322; 60)
									iH_Notify("SETTLED"; $id+" eWire has been Marked as Settled.")
									
								Else 
									iH_Notify("ERROR"; $id+" eWire has NOT been Marked as Settled. ["+String:C10($iError)+"]")
								End if 
								
							End if 
							
						Else 
							myAlert("This "+$status+" eWire can NOT be settled. "+$id)
					End case 
					
				Else 
					
			End case 
			
			
		End if 
		
	Else 
End case 