//%attributes = {}
C_TEXT:C284($1; $fileName)
C_COLLECTION:C1488($2; $unfinishedFiles; $lineElements)
C_BOOLEAN:C305($0)
C_LONGINT:C283($idx)

$fileName:=$1
$unfinishedFiles:=$2
$0:=False:C215

For ($idx; 1; $unfinishedFiles.length)
	
	$lineElements:=Split string:C1554($unfinishedFiles[$idx-1]; " ")
	
	If ($lineElements.length>0)
		
		If ($fileName=$lineElements[1])
			$0:=True:C214
			$idx:=$unfinishedFiles.length+1
		End if 
		
	End if 
	
End for 
