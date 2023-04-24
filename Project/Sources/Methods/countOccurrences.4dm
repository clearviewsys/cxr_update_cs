//%attributes = {}
// countOccurrences
C_TEXT:C284($1; $fileName; $2; $pattern; $fileContent)
C_BOOLEAN:C305($found)
C_LONGINT:C283($0)

Case of 
	: (Count parameters:C259=2)
		
		$fileName:=$1
		$pattern:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($p; $start; $lengthfound; $numOcc)

$fileName:=$1
$fileContent:=Document to text:C1236($fileName)
$fileContent:=Replace string:C233($fileContent; Char:C90(CR ASCII code:K15:14); "")
$fileContent:=Replace string:C233($fileContent; Char:C90(LF ASCII code:K15:11); "")

$numOcc:=0
$start:=1
Repeat 
	$p:=Position:C15($pattern; $fileContent; $start; $lengthfound; *)
	
	If ($p>0)
		$start:=$p+$lengthfound
		$numOcc:=$numOcc+1
	End if 
	
Until ($p<=0)

$0:=$numOcc
