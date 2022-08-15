//%attributes = {}
// revertRecord (->table)
// this method should revert all values of a record to its old values
// this can be used when changes are not allowed and old values should be restored
// this is like a 'CANCEL' function but it happens after user saves the record instead (e.g. changes to reconciled rows)

C_POINTER:C301($1; $tablePtr; $fieldPtr)
C_LONGINT:C283($n; $i)

$tablePtr:=$1
$n:=Get last field number:C255($tablePtr)

For ($i; 1; $n)
	If (Is field number valid:C1000($tablePtr; $i))
		$fieldPtr:=Field:C253(Table:C252($tablePtr); $i)
		Case of 
			: (Field name:C257($fieldPtr)="_Sync_ID")  //do nothing
			: (Field name:C257($fieldPtr)="_Sync_Data")  //8/23/18 IBB
			: (Field name:C257($fieldPtr)="UUID")  //do nothing
				//TRACE
			Else 
				$fieldPtr->:=Old:C35($fieldPtr->)  // restore old values
		End case 
	End if 
End for 
