Case of 
	: (Form event code:C388=On Drop:K2:12)
		
		C_LONGINT:C283($p)
		C_POINTER:C301($objPtr)
		C_POINTER:C301($srcObjPtr; $dstObjPtr)
		C_LONGINT:C283($srcRow; $processId)
		
		//_O_DRAG AND DROP PROPERTIES($srcObjPtr; $srcRow; $processId)
		
		C_LONGINT:C283($rownum; $colnum)
		$rownum:=Drop position:C608($colnum)
		
		If ($colnum=2)
			arrValuesOCR{$rownum}:=arrTextsOCR{$srcRow}
			//LISTBOX SET ROW COLOR(*;"lbScanned";$rownum;0x00FFFF00;‘k53;25‘)
			
		End if 
		
End case 
