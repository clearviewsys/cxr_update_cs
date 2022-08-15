//%attributes = {}


C_POINTER:C301($1; $ptrField)
C_LONGINT:C283($2; $isWebConstraint)
C_TEXT:C284($3; $constraint)

C_LONGINT:C283($tableNo; $fieldNo)
C_OBJECT:C1216($o; $status)

$ptrField:=$1

If (Count parameters:C259>=2)
	$isWebConstraint:=$2
Else 
	$isWebConstraint:=0  //both cxr and web
End if 

If (Count parameters:C259>=3)
	$constraint:=$3
Else 
	$constraint:=""
End if 

$tableNo:=Table:C252($ptrField)
$fieldNo:=Field:C253($ptrField)



If (True:C214)
	
	$o:=ds:C1482.FieldConstraints.query("TableNo == :1 AND FieldNo == :2"; $tableNo; $fieldNo)
	
	If ($o.length=0)  //only create if doesn't exist
		$o:=ds:C1482.FieldConstraints.new()
		
		$o.UUID:=Generate UUID:C1066
		$o.TableNo:=Table:C252($ptrField)
		$o.FieldNo:=Field:C253($ptrField)
		$o.FieldLabel:=Field name:C257($ptrField)
		$o.isMandatory:=True:C214
		$o.isWebConstraint:=$isWebConstraint
		$o.TableName:=Table name:C256($tableNo)
		$o.FieldName:=Field name:C257($tableNo; $fieldNo)
		$o.isConditional:=False:C215
		$o.GroupName:=""
		$o.condition:=$constraint
		$status:=$o.save()
		
		If ($status.success=True:C214)
		Else 
			
		End if 
	End if 
	
Else 
	CREATE RECORD:C68([FieldConstraints:69])
	
	[FieldConstraints:69]TableNo:1:=Table:C252($ptrField)
	[FieldConstraints:69]FieldNo:2:=Field:C253($ptrField)
	[FieldConstraints:69]FieldLabel:3:=Field name:C257($ptrField)
	[FieldConstraints:69]isMandatory:4:=True:C214
	[FieldConstraints:69]isWebConstraint:13:=$isWebConstraint
	[FieldConstraints:69]TableName:5:=Table name:C256([FieldConstraints:69]TableNo:1)
	[FieldConstraints:69]FieldName:6:=Field name:C257([FieldConstraints:69]TableNo:1; [FieldConstraints:69]FieldNo:2)
	[FieldConstraints:69]isConditional:7:=False:C215
	[FieldConstraints:69]GroupName:8:=""
	
	//[FieldConstraints]_Sync_ID:=
	//[FieldConstraints]_Sync_Data:=
	//[FieldConstraints]_Sync_Exception:=
	[FieldConstraints:69]UUID:12:=Generate UUID:C1066
	
	SAVE RECORD:C53([FieldConstraints:69])
	
	UNLOAD RECORD:C212([FieldConstraints:69])
End if 