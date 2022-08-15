//%attributes = {}


C_LONGINT:C283($1; $iTable)

C_TEXT:C284($0)


C_TEXT:C284($record)
C_POINTER:C301($ptrField)
C_LONGINT:C283($j; $iType)

$iTable:=$1



For ($j; 1; Get last field number:C255($iTable))
	
	If (Is field number valid:C1000($iTable; $j))
		$ptrField:=Field:C253($iTable; $j)
		$iType:=Type:C295($ptrField->)
		
		Case of 
			: ($iType=Is string var:K8:2) | ($iType=Is alpha field:K8:1) | ($iType=Is text:K8:3)
				$record:=$record+Char:C90(Carriage return:K15:38)+Field name:C257($iTable; $j)+":"+Substring:C12($ptrField->; 1; 80)
			: ($iType=Is picture:K8:10)
				$record:=$record+Char:C90(Carriage return:K15:38)+Field name:C257($iTable; $j)+":"+"Size: "+String:C10(Picture size:C356($ptrField->))
			: ($iType=Is BLOB:K8:12)
				$record:=$record+Char:C90(Carriage return:K15:38)+Field name:C257($iTable; $j)+":"+"Size: "+String:C10(BLOB size:C605($ptrField->))
			: ($iType=Is object:K8:27)
				$record:=$record+Char:C90(Carriage return:K15:38)+Get_Object_Info($ptrField)
			Else 
				$record:=$record+Char:C90(Carriage return:K15:38)+Field name:C257($iTable; $j)+":"+String:C10($ptrField->)
		End case 
		
	End if 
	
End for 


$0:=$record