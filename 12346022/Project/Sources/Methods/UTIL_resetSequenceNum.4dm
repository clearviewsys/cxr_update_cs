//%attributes = {}
C_POINTER:C301($1; $ptrTable)
C_LONGINT:C283($0)

C_POINTER:C301($ptrField)
C_LONGINT:C283($iMax; $iProg)
C_REAL:C285($r)
C_TEXT:C284($branchID)


If (Count parameters:C259>=1)
	$ptrTable:=$1
Else 
	$ptrTable:=->[Customers:3]
End if 



$ptrField:=UTIL_getFieldPointer("["+Table name:C256($ptrTable)+"]"+Substring:C12(Table name:C256($ptrTable); 1; Length:C16(Table name:C256($ptrTable))-1)+"ID")

If (Is nil pointer:C315($ptrField))
Else 
	
	$branchID:=getBranchID
	$iMax:=0
	
	If (True:C214)  //<>TODO need parameter
		If (True:C214)
			
			$iProg:=Progress New
			Progress SET TITLE($iProg; "Calculating Sequence Number: "+$branchID+": "+Table name:C256($ptrTable))
			$ii:=0
			
			C_OBJECT:C1216($entity; $record)
			
			$entity:=ds:C1482[Table name:C256($ptrTable)].query(Field name:C257($ptrField)+" == :1"; $branchID+"@")
			For each ($record; $entity)
				$ii:=$ii+1
				
				If ($iMax<Num:C11($record[Field name:C257($ptrField)]))
					$iMax:=Num:C11($record[Field name:C257($ptrField)])
				End if 
				
				If (Mod:C98($ii; 100)=0)
					Progress SET MESSAGE($iProg; String:C10($ii))
					
					$r:=$ii/$entity.length
					Progress SET PROGRESS($iProg; $r)
					
				End if 
			End for each 
			
			
			
			Progress QUIT($iProg)
			
		Else 
			QUERY:C277($ptrTable->; $ptrField->=$branchID+"@")
			ORDER BY:C49($ptrTable->; $ptrField->; <)  //largest at top
			$iMax:=Num:C11($ptrField->)
		End if 
		
	Else 
		ALL RECORDS:C47($ptrTable->)
		C_LONGINT:C283($ii)
		For ($ii; 1; Records in selection:C76($ptrTable->))
			C_REAL:C285($iCurr)
			$iCurr:=Num:C11($ptrField->)
			If ($iCurr>$iMax)
				$iMax:=$iCurr
			End if 
			
			NEXT RECORD:C51($ptrTable->)
			
			If (Mod:C98($ii; 100)=0)
				Progress SET MESSAGE($iProg; String:C10($ii))
			End if 
		End for 
	End if 
	
	C_REAL:C285($iSeqNo)
	
	
	If (True:C214)
		Case of 
			: ($entity.length=0)
				
				
				
				//: ($ptrTable=(->[Invoices]))
				//  //$iSeqNo:=$iSeqNo-<>STARTINVOICENUMBER
				//$iMax:=$iMax-<>STARTINVOICENUMBER
				//: ($ptrTable=(->[eWires]))
				//  //$iSeqNo:=$iSeqNo-<>STARTEWIRENUMBER
				//$iMax:=$iMax-<>STARTEWIRENUMBER
				//: ($ptrTable=(->[Registers]))
				//  //$iSeqNo:=$iSeqNo-<>STARTREGISTERNUMBER
				//$iMax:=$iMax-<>STARTREGISTERNUMBER
				
				//: ($ptrTable=(->[Users]))
				//$iMax:=$iMax-100
				
				//: ($ptrTable=(->[AML_AggrRules])) | ($ptrTable=(->[Agents])) | ($ptrTable=(->[MainAccounts]))\
					 | ($ptrTable=(->[MESSAGES]))
				//$iMax:=$iMax-1000
				
				//: ($ptrTable=(->[AML_Reports])) | ($ptrTable=(->[CalendarEvents])) | ($ptrTable=(->[Relations]))\
					 | ($ptrTable=(->[WebEWires]))
				//$iMax:=$iMax-10000
				
				//: ($ptrTable=(->[CashInOuts])) | ($ptrTable=(->[Branches])) | ($ptrTable=(->[Bookings]))\
					 | ($ptrTable=(->[ReconciledRows])) | ($ptrTable=(->[Branches])) | ($ptrTable=(->[AgentAccounts]))\
					 | ($ptrTable=(->[AccountInOuts])) | ($ptrTable=(->[CallLogs])) | ($ptrTable=(->[CashInOuts]))\
					 | ($ptrTable=(->[CashTransactions])) | ($ptrTable=(->[Cheques])) | ($ptrTable=(->[Cities]))\
					 | ($ptrTable=(->[Confirmations])) | ($ptrTable=(->[ControlBox])) | ($ptrTable=(->[Countries]))\
					 | ($ptrTable=(->[CSMRelations])) | ($ptrTable=(->[Reports])) | ($ptrTable=(->[CashTransactions]))\
					 | ($ptrTable=(->[IntegrityChecks])) | ($ptrTable=(->[ItemCategories])) | ($ptrTable=(->[Items]))\
					 | ($ptrTable=(->[Letters])) | ($ptrTable=(->[LinkedDocs])) | ($ptrTable=(->[CommonLists]))\
					 | ($ptrTable=(->[Mailboxes])) | ($ptrTable=(->[Notifications])) | ($ptrTable=(->[Orders]))\
					 | ($ptrTable=(->[Shipments])) | ($ptrTable=(->[ShipmentLines])) | ($ptrTable=(->[FieldConstraints]))\
					 | ($ptrTable=(->[TellerProof])) | ($ptrTable=(->[LetterTemplates])) | ($ptrTable=(->[TransferTemplates]))\
					 | ($ptrTable=(->[IM_TransferLog])) | ($ptrTable=(->[ZipCodes]))
				//$iMax:=$iMax-100000
				
				//: ($ptrTable=(->[ThirdParties]))
				//$iMax:=$iMax-200000
				
				//: ($ptrTable=(->[Customers])) | ($ptrTable=(->[AML_Alerts])) | ($ptrTable=(->[ExceptionsLog]))\
					 | ($ptrTable=(->[ImportedRows])) | ($ptrTable=(->[ItemInOuts])) | ($ptrTable=(->[OrderLines]))
				//$iMax:=$iMax-1000000
				
				//: ($ptrTable=(->[RegistersAuditTrail])) | ($ptrTable=(->[ReconciledRows])) | ($ptrTable=(->[TellerProofLines]))
				//$iMax:=$iMax-10000000
				
				//: ($ptrTable=(->[WireTemplates]))
				//$iMax:=$iMax-30000
			Else 
				$iMax:=$iMax-UTIL_getSequencePadding($ptrTable)  //assume 
		End case 
	End if 
	
	//If ($iSeqNo>$iMax)
	If ($iMax<0)
		$iMax:=Abs:C99($iMax)
	End if 
	
	SET DATABASE PARAMETER:C642($ptrTable->; Table sequence number:K37:31; $iMax+1)
	//$tResult:=$tResult+Char(Carriage return)+Table name($ptrTable)
	//End if 
	$iSeqNo:=Get database parameter:C643($ptrTable->; Table sequence number:K37:31)
	
End if 

$0:=$iSeqNo