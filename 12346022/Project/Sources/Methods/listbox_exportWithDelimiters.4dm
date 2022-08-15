//%attributes = {}
// saveToTextFile (->listbox;path;fieldDelimiter;rowDelimiter)
// WARNING: all numeric columns should have an object name with the prefix num_

C_POINTER:C301($listBoxPtr; $1)
C_TEXT:C284($fileName; $2)
C_TEXT:C284($fieldDelimiter; $3)
C_TEXT:C284($rowDelimiter; $4)
C_TEXT:C284($fileExtension; $5)


$listBoxPtr:=$1
$fileName:=$2
$fieldDelimiter:=$3
$rowDelimiter:=$4

If (Count parameters:C259=5)
	$fileExtension:=$5
Else 
	$fileExtension:="TEXT"
End if 

C_LONGINT:C283($row; $col; $n; $m)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
$m:=LISTBOX Get number of columns:C831($listBoxPtr->)

If ($n>0)
	C_TEXT:C284($headerName)
	
	ARRAY TEXT:C222($arrHeaderNames; 0)
	ARRAY TEXT:C222($arrColNames; 0)
	ARRAY POINTER:C280($arrColVars; 0)
	ARRAY POINTER:C280($arrHeaderVars; 0)
	ARRAY BOOLEAN:C223($arrVisible; 0)
	ARRAY POINTER:C280($arrStyles; 0)
	
	LISTBOX GET ARRAYS:C832($listBoxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrVisible; $arrStyles)
	
	
	C_TIME:C306(vhDoc)
	vhDoc:=Create document:C266($fileName; $fileExtension)  // Create a text document 
	
	If (OK=1)
		For ($row; 0; $n)
			For ($col; 1; $m)
				If ($row=0)
					$headerName:=$arrHeaderNames{$col}
					If (Substring:C12($headerName; 4; 1)="_")
						$headerName:=Substring:C12($headerName; 5)
					End if 
					
					SEND PACKET:C103(vhDoc; $headerName+$fieldDelimiter)
				Else 
					C_POINTER:C301($colPtr)
					C_TEXT:C284($cell)
					C_REAL:C285($numCell)
					C_BOOLEAN:C305($isNum)
					C_TEXT:C284($prefix)
					C_LONGINT:C283($type)
					$prefix:=Substring:C12($arrHeaderNames{$col}; 1; 4)
					$colPtr:=$arrColVars{$col}
					
					Case of 
						: ($prefix="pic_") | (Type:C295($colPtr->{$row})=Is picture:K8:10)
							$cell:="_"
						: ($prefix="cur_")
							$cell:=enDoubleQuote(String:C10($colPtr->{$row}; "|Currency"))
						: ($prefix="num_") | (Type:C295($colPtr->{$row})=Is longint:K8:6) | (Type:C295($colPtr->{$row})=Is real:K8:4)
							$cell:=String:C10($colPtr->{$row})
						: (($prefix="bool") | ($prefix="bln_")) | (Type:C295($colPtr->{$row})=Is boolean:K8:9)
							$cell:=booleanToString($colPtr->{$row})
						: ($prefix="dat_") | (Type:C295($colPtr->{$row})=Is date:K8:7) | (Type:C295($colPtr->{$row})=Is time:K8:8)
							$cell:=String:C10($colPtr->{$row})
						Else 
							$cell:=enDoubleQuote($colPtr->{$row})
					End case 
					
					
					SEND PACKET:C103(vhDoc; $cell+$fieldDelimiter)
				End if 
			End for 
			SEND PACKET:C103(vhDoc; $rowDelimiter)  // Write one word into the document 
			
		End for 
		CLOSE DOCUMENT:C267(vhDoc)  // Close the document 
	End if 
Else 
	myAlert("There are no rows to export")
End if 
