//%attributes = {}
C_TEXT:C284($1; $inXML; $ref; $msgelement)
C_OBJECT:C1216($0)

$inXML:=$1

C_LONGINT:C283($pos1; $pos2)
C_TEXT:C284($msg; $operationID)

$pos1:=Position:C15("<Message>"; $inXML)

If ($pos1>0)
	$pos2:=Position:C15("</Message>"; $inXML; $pos1)
	If ($pos2>0)
		$msg:=Substring:C12($inXML; $pos1+Length:C16("<Message>"); $pos2-$pos1-Length:C16("<Message>"))
	End if 
End if 

$pos1:=Position:C15("<OperationId>"; $inXML)

If ($pos1>0)
	$pos2:=Position:C15("</OperationId>"; $inXML; $pos1)
	If ($pos2>0)
		$operationID:=Substring:C12($inXML; $pos1+Length:C16("<OperationId>"); $pos2-$pos1-Length:C16("<OperationId>"))
	End if 
End if 

$0:=New object:C1471

$0.message:=$msg
$0.operationalID:=$operationID

