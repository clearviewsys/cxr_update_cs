//%attributes = {}
C_LONGINT:C283(Error; $i)
C_TEXT:C284(Error method; Error formula)
C_TEXT:C284($output; $errorMsg; $filename)
C_BOOLEAN:C305($inHeadless)

$output:="Build error: "+String:C10(Error)+"\nBuild error method: "+Error method+"\nBuild error formula: "+Error formula

$errorMsg:="Errors building, check build_errors.txt file(s) in artifacts folder"

$filename:="build_errors_"+String:C10(Tickcount:C458)+".txt"

ARRAY LONGINT:C221($codes; 0)
ARRAY TEXT:C222($internal; 0)
ARRAY TEXT:C222($textArr; 0)

GET LAST ERROR STACK:C1015($codes; $internal; $textArr)

For ($i; 1; Size of array:C274($codes))
	$output:=$output+"\nStack "+String:C10($i)+": "+String:C10($codes{$i})+Char:C90(Tab:K15:37)+$internal{$i}+Char:C90(Tab:K15:37)+$textArr{$i}
End for 

logLineInLogEvent($output)

TEXT TO DOCUMENT:C1237(System folder:C487(Documents folder:K41:18)+"artifacts"+Folder separator:K24:12+$filename; $output; "UTF-8")  // upload this via artifact upload github action

$inHeadless:=Get application info:C1599.headless

If ($inHeadless)
	logLineInLogEvent($errorMsg)
	QUIT 4D:C291
Else 
	myAlert($errorMsg)
End if 
