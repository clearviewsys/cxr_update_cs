//%attributes = {}
// 8/2/21 for MoneyWay clean up branch prefixes that were set incorrectly
// ibb
// need to update to request old/new prefixes


// bunch of var declarations added by TB

var $oldPrefix; $newPrefix; $fieldName; $prefixTable : Text
var $tablePtr; $syncPtr; $IDfieldPtr; $fieldPtr : Pointer
var $i; $ii : Integer

$oldPrefix:="PR"
$newPrefix:="NV"



For ($i; 1; Get last table number:C254)
	
	If (Is table number valid:C999($i))
		$tablePtr:=Table:C252($i)
		
		$IDfieldPtr:=UTIL_getFieldPointer("["+Table name:C256($i)+"]"+Substring:C12(Table name:C256($i); 1; Length:C16(Table name:C256($i))-1)+"ID")
		
		If (Is nil pointer:C315($IDfieldPtr))
		Else 
			READ WRITE:C146($tablePtr->)
			
			$syncPtr:=UTIL_getFieldPointer("["+Table name:C256($i)+"]"+"_Sync_ID")
			
			If (Is nil pointer:C315($syncPtr))
			Else 
				QUERY:C277($tablePtr->; $IDfieldPtr->=$oldPrefix+"@"; *)
				QUERY:C277($tablePtr->;  & ; $syncPtr->="MWNV@")
				If (Records in selection:C76($tablePtr->)>0)
					
					$prefixTable:=Substring:C12(Table name:C256($tablePtr); 1; 3)
					APPLY TO SELECTION:C70($tablePtr->; $IDfieldPtr->:=Replace string:C233($IDfieldPtr->; $oldPrefix+$prefixTable; $newPrefix+$prefixTable))
					
					FIRST RECORD:C50($tablePtr->)
					
					//loop thru other fields to see if the are ID fields for related tables
					For ($ii; 1; Get last field number:C255($i))
						If (Is field number valid:C1000($i; $ii))
							
							$fieldPtr:=Field:C253($i; $ii)
							$fieldName:=Field name:C257($i; $ii)
							
							Case of 
								: ($IDfieldPtr=$fieldPtr)
									//skip
								: ($fieldName="InternalRecordID")
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"CAS"; $newPrefix+"CAS"))
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"WIR"; $newPrefix+"WIR"))
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"INV"; $newPrefix+"INV"))
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"EWI"; $newPrefix+"EWI"))
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"CHE"; $newPrefix+"CHE"))
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"ACC"; $newPrefix+"ACC"))
									
									
								: ($fieldName="@ID") & ($fieldName#"@paid") & ($fieldName#"_Sync_ID") & ($fieldName#"UUID")
									$prefixTable:=Substring:C12($fieldName; 1; 3)
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+$prefixTable; $newPrefix+$prefixTable))
									
								: ($fieldName="InvoiceNumber")
									APPLY TO SELECTION:C70($tablePtr->; $fieldPtr->:=Replace string:C233($fieldPtr->; $oldPrefix+"INV"; $newPrefix+"INV"))
									
							End case 
							
							FIRST RECORD:C50($tablePtr->)
							
						End if 
					End for 
					
					UNLOAD RECORD:C212($tablePtr->)
					READ ONLY:C145($tablePtr->)
					REDUCE SELECTION:C351($tablePtr->; 0)
					
				End if 
				
			End if 
		End if 
		
	End if 
End for 

ALERT:C41("DONE")