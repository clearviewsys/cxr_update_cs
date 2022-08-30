//%attributes = {}
//JSONToCSV ($parameters; $returnpointer)
//This was part of the component for CSV

C_OBJECT:C1216($1; $params)
C_POINTER:C301($2)

ASSERT:C1129(Count parameters:C259>1)
ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
ASSERT:C1129(Type:C295($2->)=Object array:K8:28)

ARRAY OBJECT:C1221($records; 0)
COPY ARRAY:C226($2->; $records)

$params:=$1

C_BOOLEAN:C305($with_column_title; $no_last_line_delimiter; $with_bom; $with_line_number)
$with_column_title:=OB Get:C1224($params; "with_column_title"; Is boolean:K8:9)
$with_line_number:=OB Get:C1224($params; "with_line_number"; Is boolean:K8:9)
$no_last_line_delimiter:=OB Get:C1224($params; "no_last_line_delimiter"; Is boolean:K8:9)
$with_bom:=OB Get:C1224($params; "with_bom"; Is boolean:K8:9)

C_TEXT:C284($delimiter_record; $delimiter_field)
//fixed
$delimiter_record:="\r\n"
$delimiter_field:=","

C_TEXT:C284($encoding)
$encoding:=OB Get:C1224($params; "encoding"; Is text:K8:3)

If ($encoding="")
	$encoding:="utf-8"
End if 

ARRAY LONGINT:C221($path_pos; 0)
ARRAY LONGINT:C221($path_len; 0)
C_TEXT:C284($folderPathMotif; $out)

Case of 
	: (Is macOS:C1572)  // replaced by @tiran 
		$folderPathMotif:="(.*:)"
	Else 
		$folderPathMotif:="(.*\\\\)"
End case 

$out:=OB Get:C1224($params; "out"; Is text:K8:3)
C_TEXT:C284($outFolderPath)
If (Match regex:C1019($folderPathMotif; $out; 1; $path_pos; $path_len))
	$outFolderPath:=Substring:C12($out; $path_pos{1}; $path_len{1})
	CREATE FOLDER:C475($outFolderPath; *)
End if 
C_TIME:C306($docRef)
USE CHARACTER SET:C205($encoding; 0)
$docRef:=Create document:C266($out)

If ($with_bom)
	C_BLOB:C604($BOM)
	Case of 
		: ($encoding="utf-8")
			SET BLOB SIZE:C606($BOM; 3)
			$BOM{0}:=0x00EF
			$BOM{1}:=0x00BB
			$BOM{2}:=0x00BF
			SEND PACKET:C103($docRef; $BOM)
		: ($encoding="utf-16le")
			SET BLOB SIZE:C606($BOM; 2)
			$BOM{0}:=0x00FF
			$BOM{1}:=0x00FE
			SEND PACKET:C103($docRef; $BOM)
		: ($encoding="utf-16be")
			SET BLOB SIZE:C606($BOM; 2)
			$BOM{0}:=0x00FE
			$BOM{1}:=0x00FF
			SEND PACKET:C103($docRef; $BOM)
	End case 
End if 

C_LONGINT:C283($pos; $len; $count)
C_OBJECT:C1216($record)
C_TEXT:C284($delimiter_field)
C_TIME:C306($docRef)
$count:=Size of array:C274($records)
C_LONGINT:C283($i; $j)
For ($i; 1; $count)
	
	$record:=$records{$i}
	
	ARRAY TEXT:C222($names; 0)
	OB GET PROPERTY NAMES:C1232($record; $names)
	
	If ($i=1) & ($with_column_title)
		For ($j; 1; Size of array:C274($names))
			If ($j#1)
				SEND PACKET:C103($docRef; $delimiter_field)
			End if 
			SEND PACKET:C103($docRef; $names{$j})
		End for 
		SEND PACKET:C103($docRef; $delimiter_record)
	End if 
	
	If ($with_line_number)
		SEND PACKET:C103($docRef; String:C10($i))
	End if 
	C_TEXT:C284($field)
	C_TEXT:C284($value)
	For ($j; 1; Size of array:C274($names))
		If ($j#1)
			SEND PACKET:C103($docRef; $delimiter_field)
		Else 
			If ($with_line_number)
				SEND PACKET:C103($docRef; $delimiter_field)
			End if 
		End if 
		$field:=$names{$j}
		$value:=OB Get:C1224($record; $field; Is text:K8:3)
		If (Match regex:C1019("[,\r\n\"]"; $value; 1; $pos; $len))
			$value:="\""+Replace string:C233($value; "\""; "\"\""; *)+"\""
		End if 
		SEND PACKET:C103($docRef; $value)
	End for 
	
	If (Not:C34(($no_last_line_delimiter) & ($i=$count)))
		SEND PACKET:C103($docRef; $delimiter_record)
	End if 
	
End for 

CLOSE DOCUMENT:C267($docRef)
USE CHARACTER SET:C205(*; 0)