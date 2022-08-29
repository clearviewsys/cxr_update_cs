//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/13/20, 19:21:14
// ----------------------------------------------------
// Method: UTIL_recordChangeToText
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptrTable)
C_LONGINT:C283($2; $iFormat)
C_BOOLEAN:C305($3; $hideMeta)

C_TEXT:C284($0; $record)

C_LONGINT:C283($i; $iFormat; $iTable; $iType)
C_POINTER:C301($ptrField)
C_PICTURE:C286($pPict)
C_TEXT:C284($old; $new)
C_BLOB:C604($xBlob)

$ptrTable:=$1

If (Count parameters:C259>=2)
	$iFormat:=$2
Else 
	$iFormat:=0
End if 

If (Count parameters:C259>=3)
	$hideMeta:=$3
Else 
	$hideMeta:=True:C214
End if 

$record:=""

If (Is nil pointer:C315($ptrTable))
	$record:="<p>Table Pointer is Nil - Please contact the developer.</p>"
	
Else 
	
	$iTable:=Table:C252($ptrTable)
	
	If (Is new record:C668($ptrTable->))
		
		Case of 
			: ($iFormat=0)  //tab delimited
				
			: ($iFormat=1)  //html table
				$record:="<table class='table table-condensed'>\r"
				$record:=$record+"<thead><tr><th>Field Name</th><th>Value</th></tr></thead>\r"
				$record:=$record+"<tbody>\r"
			Else 
				
		End case 
		
		//assume current record is about to be saved and after modification
		
		For ($i; 1; Get last field number:C255($ptrTable))
			
			If (Is field number valid:C1000($ptrTable; $i))
				
				$ptrField:=Field:C253(Table:C252($ptrTable); $i)
				
				If (UTIL_isFieldSystemInfo($ptrField))  //don't include this field
				Else 
					$iType:=Type:C295($ptrField->)
					
					Case of 
						: ($iType=Is string var:K8:2) | ($iType=Is alpha field:K8:1) | ($iType=Is text:K8:3)
							$new:=$ptrField->
							
						: ($iType=Is object:K8:27)
							$new:=JSON Stringify:C1217($ptrField->)
							
						: ($iType=Is picture:K8:10)
							$new:="Size: "+String:C10(Picture size:C356($ptrField->))
							
						: ($iType=Is BLOB:K8:12)
							$new:="Size: "+String:C10(BLOB size:C605($ptrField->))
							
						Else 
							$new:=String:C10($ptrField->)
					End case 
					
					
					If ($new="")  //don't display
					Else 
						
						Case of 
							: ($iFormat=0)
								$record:=$record+Char:C90(Carriage return:K15:38)+Field name:C257($iTable; $i)+Char:C90(Tab:K15:37)+$old+Char:C90(Tab:K15:37)+$new
								
							Else 
								$record:=$record+"<tr>\r"
								$record:=$record+"<td>"+Field name:C257($iTable; $i)+"</td><td>"+$new+"</td>\r"
								$record:=$record+"</tr>\r"
						End case 
						
					End if 
					
				End if 
				
			End if 
			
		End for 
		
		
		
		
	Else   //existing so show the changes
		
		Case of 
			: ($iFormat=0)  //tab delimited
				
			: ($iFormat=1)  //html table
				$record:="<table class='table table-condensed'>\r"
				$record:=$record+"<thead><tr><th>Field Name</th><th>Old Value</th><th>New Value</th></tr></thead>\r"
				$record:=$record+"<tbody>\r"
			Else 
				
		End case 
		
		//assume current record is about to be saved and after modification
		
		For ($i; 1; Get last field number:C255($ptrTable))
			
			If (Is field number valid:C1000($ptrTable; $i))
				
				$ptrField:=Field:C253(Table:C252($ptrTable); $i)
				
				If (UTIL_isFieldSystemInfo($ptrField))  //don't include this field
				Else 
					$iType:=Type:C295($ptrField->)
					
					Case of 
						: ($iType=Is string var:K8:2) | ($iType=Is alpha field:K8:1) | ($iType=Is text:K8:3)
							$old:=Old:C35($ptrField->)
							$new:=$ptrField->
							
						: ($iType=Is object:K8:27)
							$old:=JSON Stringify:C1217(Old:C35($ptrField->))
							$new:=JSON Stringify:C1217($ptrField->)
							
						: ($iType=Is picture:K8:10)
							$pPict:=Old:C35($ptrField->)
							$old:="Size: "+String:C10(Picture size:C356($pPict))
							$new:="Size: "+String:C10(Picture size:C356($ptrField->))
							
						: ($iType=Is BLOB:K8:12)
							$xBlob:=Old:C35($ptrField->)
							$old:="Size: "+String:C10(BLOB size:C605($xBlob))
							$new:="Size: "+String:C10(BLOB size:C605($ptrField->))
							
						Else 
							$old:=String:C10(Old:C35($ptrField->))
							$new:=String:C10($ptrField->)
					End case 
					
					
					If ($old=$new)
					Else 
						
						Case of 
							: ($iFormat=0)
								$record:=$record+Char:C90(Carriage return:K15:38)+Field name:C257($iTable; $i)+Char:C90(Tab:K15:37)+$old+Char:C90(Tab:K15:37)+$new
								
							Else 
								$record:=$record+"<tr>\r"
								$record:=$record+"<td>"+Field name:C257($iTable; $i)+"</td><td>"+$old+"</td><td>"+$new+"</td>\r"
								$record:=$record+"</tr>\r"
						End case 
						
					End if 
				End if 
			End if 
			
		End for 
		
	End if 
	
	
	Case of 
		: ($iFormat=0)
			
		: ($iFormat=1)  //html table
			$record:=$record+"</tbody>\r</table>\r"
		Else 
			
	End case 
End if 


$0:=$record