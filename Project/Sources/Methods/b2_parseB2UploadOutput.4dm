//%attributes = {}
C_TEXT:C284($1; $output; $json; $nojson)
C_OBJECT:C1216($0)

C_LONGINT:C283($posJSON; $posSemicolon)
C_COLLECTION:C1488($col)

$output:=$1

$posJSON:=Position:C15("{"; $output)

If ($posJSON>0)
	
	$json:=Substring:C12($output; $posJSON)
	$nojson:=Substring:C12($output; 1; $posJSON-1)
	
	$0:=JSON Parse:C1218($json)
	
	$col:=Split string:C1554($nojson; "\n")
	
	If ($col.length>0)
		
		$posSemicolon:=Position:C15(":"; $col[0])
		
		If ($posSemicolon>0)
			$0.url_by_filename:=Substring:C12($col[0]; $posSemicolon+1)
		End if 
		
		If ($col.length>1)
			
			$posSemicolon:=Position:C15(":"; $col[1])
			
			If ($posSemicolon>0)
				$0.url_by_fileid:=Substring:C12($col[1]; $posSemicolon+1)
			End if 
			
		End if 
		
	End if 
	
End if 
