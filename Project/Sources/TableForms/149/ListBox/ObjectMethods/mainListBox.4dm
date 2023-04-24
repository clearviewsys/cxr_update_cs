handleListBoxObjectMethod(Self:C308; Current form table:C627; ->[WebEWires:149]CustomerID:21)

If (Form event code:C388=On After Sort:K2:28)
	C_TEXT:C284($formula)
	
	If (Self:C308->>0)  //already sorted
		
	Else 
		//$iDirection:=Choose($iColumn>0;1;2)
		//LISTBOX GET CELL POSITION(*;"mainListBox";$col;$row)
		$formula:=LISTBOX Get column formula:C1202(Self:C308->)
		
		EXECUTE FORMULA:C63("Order by formula([WebEWires];"+$formula+";>)")
		
		Self:C308->:=1  // currently only handles one direction
	End if 
End if 