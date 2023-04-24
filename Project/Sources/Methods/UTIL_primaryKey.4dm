//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/12/18, 15:16:47
// ----------------------------------------------------
// Method: UTIL_primaryKey
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $ii; $iElem)
C_POINTER:C301($ptr)
C_TEXT:C284(VTABLENAME)
C_TEXT:C284($tPKName; $tTablename)
C_TEXT:C284($tResult)
C_POINTER:C301($ptrTable)

$tResult:=""


ARRAY TEXT:C222($atPKTableNames; 0)
ARRAY LONGINT:C221($aiPKTableIDs; 0)

Begin SQL
	SELECT TABLE_NAME, TABLE_ID
	FROM _USER_CONSTRAINTS
	WHERE CONSTRAINT_TYPE = 'P'
	INTO :$atPKTableNames, :$aiPKTableIDs;
End SQL


For ($i; 1; Get last table number:C254)
	
	$iElem:=Find in array:C230($aiPKTableIDs; $i)
	If ($iElem>0)
		//we have a PK so all shoudl be good
	Else 
		$tResult:=$tResult+Table name:C256($i)+Char:C90(Carriage return:K15:38)
		
		
		$ptr:=UTIL_getFieldPointer("["+Table name:C256($i)+"]UUID")
		
		$ptrTable:=Table:C252($i)
		
		If (Not:C34(Is nil pointer:C315($ptr)))  //there is a field called UUID
			//lets make sure that there are valid values in the UUID field
			
			READ WRITE:C146($ptrTable->)
			ALL RECORDS:C47($ptrTable->)
			ORDER BY:C49($ptrTable->; $ptr->)
			FIRST RECORD:C50($ptrTable->)
			
			
			For ($ii; 1; Records in selection:C76($ptrTable->))
				//If (UTIL_UUID_is_Null ($ptr->))
				$ptr->:=Generate UUID:C1066  //assign a valid UUID
				SAVE RECORD:C53($ptrTable->)
				//End if 
				
				NEXT RECORD:C51($ptrTable->)
			End for 
			
			
			$tTablename:=Table name:C256($i)
			$tPKName:="pk_"+$tTablename
			
			//force index to be rebuilt
			ARRAY POINTER:C280($aptrFields; 0)
			APPEND TO ARRAY:C911($aptrFields; $ptr)
			
			DELETE INDEX:C967($ptr)
			CREATE INDEX:C966($ptrTable->; $aptrFields; Standard BTree index:K58:3; $tPKName)
			
			//now set the UUID field to be the unique
			If (False:C215)  //CAN'T FIGURE OUT HOW TO SET UNIQUE
				vtStatement:="ALTER TABLE "+$tTablename+" MODIFY [UUID] UNIQUE;"
				Begin SQL
					EXECUTE IMMEDIATE :vtStatement
				End SQL
			End if 
			
			//now set the UUID field to be the primary key
			vtStatement:="ALTER TABLE "+$tTablename+" ADD CONSTRAINT "+$tPKName+" PRIMARY KEY ([UUID]);"
			Begin SQL
				EXECUTE IMMEDIATE :vtStatement
			End SQL
			
		End if 
	End if 
	
End for 

SET TEXT TO PASTEBOARD:C523($tResult)
