handleListBoxObjectMethod(Self:C308; Current form table:C627)


If (Form event code:C388=On After Sort:K2:28)
	C_TEXT:C284($formula)
	
	If (Self:C308->>0)  //already sorted
		
	Else 
		C_TEXT:C284($tField; $tAttribute)
		C_LONGINT:C283($iPosition)
		//$iDirection:=Choose($iColumn>0;1;2)
		//LISTBOX GET CELL POSITION(*;"mainListBox";$col;$row)
		$formula:=LISTBOX Get column formula:C1202(Self:C308->)
		If ($formula="@.@")  // for object
			$iPosition:=Position:C15("."; $formula)
			$tField:=Substring:C12($formula; 1; $iPosition-1)
			$tAttribute:=Substring:C12($formula; $iPosition+1)
			EXECUTE FORMULA:C63("Order by attribute([Notifications];"+$tField+";\""+$tAttribute+"\";>)")
		Else 
			EXECUTE FORMULA:C63("Order by formula([Notifications];"+$formula+";>)")
		End if 
		
		Self:C308->:=1  // currently only handles one direction
	End if 
End if 