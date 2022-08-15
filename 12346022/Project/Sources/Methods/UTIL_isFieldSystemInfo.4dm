//%attributes = {}


C_POINTER:C301($1; $ptrField)

C_BOOLEAN:C305($0; $isMeta)

C_TEXT:C284($fieldName)

$ptrField:=$1

$fieldName:=Field name:C257($ptrField)

Case of 
	: ($fieldName="@UUID")
		$isMeta:=True:C214
		
	: ($fieldName="_sync_@")
		$isMeta:=True:C214
		
	: ($fieldName="ModificationDate")
		$isMeta:=True:C214
		
	: ($fieldName="ModificationTime")
		$isMeta:=True:C214
		
	: ($fieldName="ModifiedByUserID")
		$isMeta:=True:C214
		
	: ($fieldName="CreationDate")
		$isMeta:=True:C214
		
	: ($fieldName="CreationTime")
		$isMeta:=True:C214
		
	: ($fieldName="CreatedByUserID")
		$isMeta:=True:C214
		
		
	Else 
		$isMeta:=False:C215
End case 

$0:=$isMeta