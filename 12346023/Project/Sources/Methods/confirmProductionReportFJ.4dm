//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($msg)
$0:=False:C215

$msg:="TESTING Mode allows to generate the same report several times."+Char:C90(CR ASCII code:K15:14)
$msg:=$msg+"You are trying to generate the report in PRODUCTION MODE, "+Char:C90(CR ASCII code:K15:14)
$msg:=$msg+"this means a real environment, in order to submit the report using the FIJI FIU Platform."+Char:C90(CR ASCII code:K15:14)+Char:C90(CR ASCII code:K15:14)
$msg:=$msg+"Are you sure you want continue in production environment?. Answer NO will continue in TESTING Environment"

If (operationMode=0)
	
	myConfirm($msg; "Yes"; "No")
	
	If (ok=0)
		operationMode:=1  // Set checkbox as TESTING MODE
		
	End if 
	
End if 

