//%attributes = {}
C_TEXT:C284($1; $batchID)
C_COLLECTION:C1488($2; $col)

C_OBJECT:C1216($0; $status)

C_OBJECT:C1216($trans)
C_BOOLEAN:C305($doShowProg)
C_LONGINT:C283($i; $iProg)
C_REAL:C285($r)

// pass in a transaction object

$status:=New object:C1471("success"; True:C214; "status"; 0; "statusText"; "")  // init to success for loop

$batchID:=$1
$col:=$2

$doShowProg:=Choose:C955(getKeyValue("CAB.transaction.progress.show"; "true")="true"; True:C214; False:C215)

// validate json

If (False:C215)
	//$schemaPath:=Get 4D folder(Current resources folder)+"jq"+Folder separator+"cabSchema.json"
	
	//If (Test path name($schemaPath)=Is a document)
	//$schema:=JSON Parse(Document to text($schemaPath))
	
	//$status:=JSON Validate($col; $schema)  // fails when using a collection
	//End if 
End if 

If ($doShowProg)
	$iProg:=Progress New
	$i:=0
End if 

For each ($trans; $col) While ($status.success)
	$status:=CXR_createTransaction($batchID; $trans)
	
	
	If ($status.success)
	Else 
		CAB_log("Error creating transaction: "+$status.statusText)
	End if 
	
	
	If ($doShowProg)
		$i:=$i+1
		If (Mod:C98($i; 100)=0)
			Progress SET TITLE($iProg; "Creating "+String:C10($col.length)+" transactions")
			$r:=$i/$col.length
			Progress SET PROGRESS($iProg; $r)
		End if 
	End if 
	
End for each 

If ($doShowProg)
	Progress QUIT($iProg)
End if 

$0:=$status