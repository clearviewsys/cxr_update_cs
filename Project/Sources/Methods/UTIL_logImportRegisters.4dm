//%attributes = {}

// currently for REGISTERS
// need to add a header to the text file imported
//paste the following in text file as header
SET TEXT TO PASTEBOARD:C523("logDate\tlogTime\tlogType\t\tRegisterID\tRegisterDate\tisTransfer\tRegisterType\tCustomerID\tAccountID\tCredit\tDebit\tComments\tInvoiceNumber\tisFlagged\tAutoComments\tisReceived\tCreationDate\tCreationTime\tCreatedByUserID\tInternalTableNumber\tInternalRecordID\tCurrency"+"\tModificationDate\tModificationTime\tModifiedByUserID\tDebitLocal\tCreditLocal\tOurRate\tSpotRate\tAvgRate\tpercentFee\tfeeLocal\ttotalFees\ttax1_Received\ttax2_Received\ttax1_Paid\ttax2_Paid\tisValidated\tvalidationCode\tvalidatedByUserID\tisTrade\tBranchID\tisCash\tCurr"+"encyAlias\tPresetBuyRate\tPresetSellRate\tisExported\tisAML_Reportable\tisAML_LCT\tisAML_EFT\tisAML_STR\tAML_reportName\tAML_isReported\tAML_mustReportBefore\tAML_reportDate\tAML_reportReference\t_Sync_ID\t_Sync_Data\tUnrealizedGain\tReferenceNo\tSubAccountID\tisCancel"+"led\tbaseCURR\teWireID\tWireID\tmodBranchID\tUUID\t_Sync_Hash")

C_COLLECTION:C1488($col)
C_OBJECT:C1216($record; $entity; $es; $status)
C_LONGINT:C283($count; $i; $type)
C_TEXT:C284($logType; $registerId; $value)
C_BOOLEAN:C305($doUpdate)


$col:=IE4_importTabToCollection(""; False:C215)

ARRAY TEXT:C222($aNames; 0)
OB GET PROPERTY NAMES:C1232(ds:C1482.Registers; $aNames)

// 
$count:=0

For each ($record; $col)
	$count:=$count+1
	
	If ($count=1)  //header... skip
	Else 
		
		$logType:=$record.logType
		$registerId:=Replace string:C233($record.RegisterID; "RegisterID:"; "")
		$doUpdate:=False:C215
		
		$es:=ds:C1482.Registers.query("RegisterID == :1"; $registerId)  // test does it exist?
		
		
		Case of 
			: ($logType="NEW")
				If ($es.length=0)
					$entity:=ds:C1482.Registers.new()
					$doUpdate:=True:C214
				End if 
				
			: ($logType="EDIT")
				
				Case of 
					: ($es.length=0)
						$entity:=ds:C1482.Registers.new()
						$doUpdate:=True:C214
						
					: ($es.length=1)
						$entity:=$es.first()
						$doUpdate:=True:C214
					Else 
						$entity:=New object:C1471
						$doUpdate:=False:C215
				End case 
				
			: ($logType="DEL")
				$doUpdate:=False:C215
				
				If ($es.length=1)
					$entity:=$es.first()
					
					$status:=$entity.drop()
					If ($status.success=False:C215)
						TRACE:C157
					End if 
				End if 
				
		End case 
		
		If ($doUpdate)
			For ($i; 1; Size of array:C274($aNames))
				
				If (OB Is defined:C1231($record; $aNames{$i})=False:C215)
					//skip
				Else 
					
					$type:=OB Get type:C1230($entity; $aNames{$i})
					$value:=Replace string:C233($record[$aNames{$i}]; $aNames{$i}+":"; "")
					
					Case of 
						: ($type=Null:C1517)
							
						: ($type=Is object:K8:27)  // objects handled below
							
						: ($type=Is BLOB:K8:12)
							
						: ($type=Is date:K8:7)
							$entity[$aNames{$i}]:=Date:C102($value+"T00:00:00")
							
						: ($type=Is longint:K8:6) | ($type=Is real:K8:4) | ($type=Is integer:K8:5)
							$entity[$aNames{$i}]:=Num:C11($value)
							
						: ($type=Is time:K8:8)
							$entity[$aNames{$i}]:=Time:C179($value)
							
						: ($type=Is boolean:K8:9)
							$entity[$aNames{$i}]:=Choose:C955($value="True"; True:C214; False:C215)
							
						: ($type=5)  //UNDEFINED --  IS THIS A RELATION????
							
						Else 
							$entity[$aNames{$i}]:=$value
					End case 
				End if 
				
			End for 
			
			$status:=$entity.save()
			If ($status.success=False:C215)
				TRACE:C157
			End if 
			
		End if 
		
	End if 
	
	
End for each 