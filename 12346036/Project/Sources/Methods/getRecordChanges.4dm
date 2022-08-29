//%attributes = {}

// getRecordChanges($arrFieldNameMainPtr;$arrTimeStampsMainPtr;$arrFieldNameDupPtr;$arrTimeStampsDupPtr)

C_POINTER:C301($1; $tablePtr; $2; $arrFieldNameMainPtr; $3; $arrTimeStampsMainPtr; $4; $arrFieldValMainPtr; $5; $arrFieldNameDupPtr; $6; $arrTimeStampsDupPtr; $7; $arrFieldValDupPtr; $8; $arrFields2UpdatePtr)

Case of 
		
	: (Count parameters:C259=8)
		$tablePtr:=$1
		$arrFieldNameMainPtr:=$2
		$arrTimeStampsMainPtr:=$3
		$arrFieldValMainPtr:=$4
		
		$arrFieldNameDupPtr:=$5
		$arrTimeStampsDupPtr:=$6
		$arrFieldValDupPtr:=$7
		$arrFields2UpdatePtr:=$8
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($i; $j; $fieldNumber; $p)
C_TEXT:C284($msg; $fieldName; $fieldValue; $dupTS; $dupFieldName; $mainTS)
C_POINTER:C301($ptr)

UTIL_Log("Duplicates"; "------------------------------------------------")
UTIL_Log("Duplicates"; "Customer ID: "+[Customers:3]CustomerID:1)

If ([Customers:3]isCompany:41)
	UTIL_Log("Duplicates"; "Customer FullName: "+[Customers:3]FullName:40)
	UTIL_Log("Duplicates"; "Customer First/last Name: "+[Customers:3]FirstName:3+" "+[Customers:3]LastName:4)
Else 
	UTIL_Log("Duplicates"; "Customer First/last Name:"+[Customers:3]FirstName:3+" "+[Customers:3]LastName:4)
End if 

UTIL_Log("Duplicates"; "Sync ID:     "+[Customers:3]_Sync_ID:94)
//UTIL_Log ("Duplicates";"------------------------------------------------")

For ($j; 1; Size of array:C274($arrFieldNameDupPtr->))
	$msg:=""
	$dupTS:=$arrTimeStampsDupPtr->{$j}
	$dupFieldName:=$arrFieldNameDupPtr->{$j}
	$fieldName:=Replace string:C233($dupFieldName; "field_timestamp."; "")
	$fieldNumber:=getFieldNumber($tablePtr; $fieldName)
	$p:=Find in array:C230($arrFieldNameMainPtr->; $arrFieldNameDupPtr->{$j})
	C_OBJECT:C1216($obj; $obj1; $obj2)
	
	If ($p>0)
		$mainTS:=$arrTimeStampsMainPtr->{$p}
		
		If (compareTimeStamps($dupTS; $mainTS))  //Field in Duplicated Record is more recent than in the  Main record
			
			$msg:=""
			$msg:=$msg+"UPD "+FT_StringFormat($dupFieldName; 35)
			$msg:=$msg+"Parent Date: "+$mainTS
			
			C_TEXT:C284($val)
			
			$val:=$arrFieldValMainPtr->{$p}
			$obj1:=convert2Object(->$val)
			$msg:=$msg+" Old: "+convert2String($obj1)
			
			$msg:=$msg+" Date: "+$dupTS
			$ptr:=getFieldPointer($tablePtr; $fieldName)
			
			$obj2:=convert2Object($ptr)
			$msg:=$msg+" New: "+convert2String($obj2)
			
			If ((convert2String($obj2)#"") & ($obj1.value#convert2String($obj2)))
				
				UTIL_Log("Duplicates"; $msg)
				APPEND TO ARRAY:C911($arrFields2UpdatePtr->; $fieldName)
				
				If (Shift down:C543)
					myAlert($msg)
				End if 
				
			End if 
			
		End if 
		
	Else 
		
		// A new field was updated or created after the main record was created
		$msg:=""
		$msg:=$msg+"NEW "+FT_StringFormat($dupFieldName; 35)
		$msg:=$msg+"Parent Date: N/A "
		$msg:=$msg+"Old: N/A "
		$val:="NA"
		
		$msg:=$msg+"New: "+$dupTS
		$ptr:=getFieldPointer($tablePtr; $fieldName)
		//$val:=$ptr->
		$obj:=convert2Object($ptr)
		$msg:=$msg+" New: "+convert2String($obj)
		
		UTIL_Log("Duplicates"; $msg)
		APPEND TO ARRAY:C911($arrFields2UpdatePtr->; $fieldName)
		If (Shift down:C543)
			myAlert($msg)
		End if 
		
	End if 
	
End for 
