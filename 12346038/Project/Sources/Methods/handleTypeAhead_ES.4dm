//%attributes = {}
C_TEXT:C284($head; $tail; $field; $entered)
C_LONGINT:C283($i; $n; $formEvent)

C_OBJECT:C1216($obj)

C_POINTER:C301($self)
$self:=Self:C308



If ((Form event code:C388=On Before Keystroke:K2:6) | (Form event code:C388=$formEvent))
	If (Keystroke:C390=Char:C90(DEL ASCII code:K15:34))
		$formEvent:=On Before Keystroke:K2:6
	End if 
	
End if 

If ((Form event code:C388=On After Edit:K2:43) | (Form event code:C388=$formEvent))
	$entered:=Get edited text:C655
	$i:=Length:C16($entered)
	
	$obj:=ds:C1482.Customers.query("FullName= :1"; $entered+"@")  // find all customers staring with the entered text
	If ($obj.length>0)  // found
		$self->:=$obj[0].FullName
		$n:=Length:C16($obj[0].FullName)
		HIGHLIGHT TEXT:C210($self->; $i+1; $n+1)
	Else   // not found
		$self->:=""
		//handleTypeAhead_ES
	End if 
	
	
End if 