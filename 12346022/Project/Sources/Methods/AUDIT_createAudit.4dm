//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/20/18, 10:31:48
// ----------------------------------------------------
// Method: AUDIT_CreateAudit
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $iEvent)
C_LONGINT:C283($2; $iTable)
C_LONGINT:C283($3; $iField)


C_POINTER:C301($ptrField; $ptrPK; $ptrTable)
C_PICTURE:C286($pPict)
C_LONGINT:C283($iClmNo; $iID; $iType)
C_BOOLEAN:C305($bLog; $bCreate)
C_BLOB:C604($xBlob)
C_TEXT:C284($tUser)
C_TEXT:C284($sID)
C_TEXT:C284($sTableField)

$iEvent:=$1
$iTable:=$2
$iField:=$3

$bLog:=False:C215
$bCreate:=False:C215

//setApplicationUser

$tUser:=getApplicationUser  // now uses current user

//If (getApplicationUser ="")
//$tUser:=Current system user+"||"+Current machine
//Else 
//$tUser:=getApplicationUser 
//End if 

If ($iField>0)  //log the field modification if any
	
	
	$ptrField:=Field:C253($iTable; $iField)
	$iType:=Type:C295($ptrField->)
	
	Case of 
		: ($iType=Is picture:K8:10)
			$pPict:=Old:C35($ptrField->)
			If (Picture size:C356($pPict)=Picture size:C356($ptrField->))
			Else 
				$bLog:=True:C214
				$bCreate:=True:C214
			End if 
			
		: ($iType=Is BLOB:K8:12)
			$xBlob:=Old:C35($ptrField->)
			If (BLOB size:C605($xBlob)=BLOB size:C605($ptrField->))
			Else 
				$bLog:=True:C214
				$bCreate:=True:C214
			End if 
			
		: (Field name:C257($ptrField)="ModificationDate")
			$bLog:=False:C215
			
		: (Field name:C257($ptrField)="ModificationTime")
			$bLog:=False:C215
			
		: (Field name:C257($ptrField)="ModifiedByUserID")
			$bLog:=False:C215
			
		: (Field name:C257($ptrField)="CreationDate")
			$bLog:=False:C215
			
		: (Field name:C257($ptrField)="CreationTime")
			$bLog:=False:C215
			
		: (Field name:C257($ptrField)="CreatedByUserID")
			$bLog:=False:C215
			
		: ($ptrField->=Old:C35($ptrField->))  //no change
			$bLog:=False:C215
		Else 
			$bLog:=True:C214
			$bCreate:=True:C214
	End case 
	
	If ($bCreate)
		
		CREATE RECORD:C68([Audit:118])
		[Audit:118]changeDate:5:=Current date:C33(*)
		[Audit:118]changeTime:6:=Current time:C178(*)
		[Audit:118]changeUser:7:=$tUser
		[Audit:118]eventNum:2:=$iEvent
		[Audit:118]fieldNum:4:=$iField
		[Audit:118]tableNum:3:=$iTable
		
		$ptrPK:=AUDIT_getPointerTableID(Table:C252($iTable))
		
		If (Not:C34(Is nil pointer:C315($ptrPK)))
			If (Type:C295($ptrPK->)=Is longint:K8:6)
				[Audit:118]recordID:10:=String:C10($ptrPK->)
			Else 
				[Audit:118]recordID:10:=$ptrPK->
			End if 
		End if 
		
		//[Audit]Claim_No:=AUDIT_Get_RelatedClmNo([Audit]Table_Num)  //2/11/16
		//End if 
		
		Case of 
			: ($iType=Is string var:K8:2) | ($iType=Is alpha field:K8:1) | ($iType=Is text:K8:3)
				[Audit:118]oldValue:8:=Old:C35($ptrField->)
				[Audit:118]newValue:9:=$ptrField->
				
			: ($iType=Is picture:K8:10)
				$pPict:=Old:C35($ptrField->)
				[Audit:118]oldValue:8:="Size: "+String:C10(Picture size:C356($pPict))
				[Audit:118]newValue:9:="Size: "+String:C10(Picture size:C356($ptrField->))
				
			: ($iType=Is BLOB:K8:12)
				$xBlob:=Old:C35($ptrField->)
				[Audit:118]oldValue:8:="Size: "+String:C10(BLOB size:C605($xBlob))
				[Audit:118]newValue:9:="Size: "+String:C10(BLOB size:C605($ptrField->))
				
			Else 
				[Audit:118]oldValue:8:=String:C10(Old:C35($ptrField->))
				[Audit:118]newValue:9:=String:C10($ptrField->)
		End case 
		
		SAVE RECORD:C53([Audit:118])
		
	End if 
	
Else   //this is a table level event not field - create/delete -- Field = 0
	
	//***** NEED TO TRACK THE RECORD THAT WAS CHANGED ********
	
	CREATE RECORD:C68([Audit:118])
	[Audit:118]changeDate:5:=Current date:C33(*)
	[Audit:118]changeTime:6:=Current time:C178(*)
	[Audit:118]changeUser:7:=$tUser
	[Audit:118]eventNum:2:=$iEvent
	[Audit:118]fieldNum:4:=0
	[Audit:118]tableNum:3:=$iTable
	[Audit:118]oldValue:8:=""
	[Audit:118]newValue:9:=""
	
	$ptrPK:=AUDIT_getPointerTableID(Table:C252($iTable))
	
	If (Not:C34(Is nil pointer:C315($ptrPK)))
		If (Type:C295($ptrPK->)=Is longint:K8:6)
			[Audit:118]recordID:10:=String:C10($ptrPK->)
		Else 
			[Audit:118]recordID:10:=$ptrPK->
		End if 
	End if 
	
	[Audit:118]newValue:9:=UTIL_recordToText($iTable)
	// 
	//C_LONGINT($j)
	
	//For ($j;1;Get last field number($iTable))
	
	//If (Is field number valid($iTable;$j))
	//$ptrField:=Field($iTable;$j)
	//$iType:=Type($ptrField->)
	
	//Case of 
	//: ($iType=Is string var) | ($iType=Is alpha field) | ($iType=Is text)
	//[Audit]newValue:=[Audit]newValue+Char(Carriage return)+Field name($iTable;$j)+":"+Substring($ptrField->;1;80)
	//: ($iType=Is picture)
	//[Audit]newValue:=[Audit]newValue+Char(Carriage return)+Field name($iTable;$j)+":"+"Size: "+String(Picture size($ptrField->))
	//: ($iType=Is BLOB)
	//[Audit]newValue:=[Audit]newValue+Char(Carriage return)+Field name($iTable;$j)+":"+"Size: "+String(BLOB size($ptrField->))
	//Else 
	//[Audit]newValue:=[Audit]newValue+Char(Carriage return)+Field name($iTable;$j)+":"+String($ptrField->)
	//End case 
	
	//End if 
	
	//End for 
	
	SAVE RECORD:C53([Audit:118])
	
	If ([AuditControls:117]isArchive:7) & ([Audit:118]eventNum:2=On Deleting Record Event:K3:3)
		//$ptrTable:=Table([Audit]Table)
		$ptrField:=AUDIT_getPointerTableID(Table:C252($iTable))
		
		If (Is nil pointer:C315($ptrField))
			$ptrField:=Field:C253($iTable; 1)
		End if 
		
		$iType:=Type:C295($ptrField->)
		
		Case of 
			: ($iType=Is string var:K8:2) | ($iType=Is alpha field:K8:1) | ($iType=Is text:K8:3)
				$sID:=$ptrField->
			: ($iType=Is picture:K8:10)
				$sID:="PICTURE"
			: ($iType=Is BLOB:K8:12)
				$sID:="BLOB"
			Else 
				$sID:=String:C10($ptrField->)
		End case 
		
		//<>TODO need to finish the record export here
		
		//UTIL_exportRecord($ptrTable;UTIL_deletedFolderPath($ptrTable)+[Audit]ID+"_"+$sID+"_"+DTS_Get_Current)
		
	End if 
	
	
End if 
//
//TRACE

If (False:C215)
	Case of 
		: ($iTable>0) & ($iField>0)
			$sTableField:="["+Table name:C256($iTable)+"]"+Field name:C257($iTable; $iField)
		: ($iTable>0)
			$sTableField:=Table name:C256($iTable)
		Else 
			$sTableField:="UNKNOWN ["+String:C10($iTable)+":"+String:C10($iField)+"]"
	End case 
	UTIL_Log("AUDIT"; AUDIT_getEventName([Audit:118]eventNum:2)+Char:C90(Tab:K15:37)+$sTableField+Char:C90(Tab:K15:37)+[Audit:118]oldValue:8+Char:C90(Tab:K15:37)+[Audit:118]newValue:9)
End if 

