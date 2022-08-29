Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On After Keystroke:K2:26)
		If (Form:C1466.collection#Null:C1517)
			Form:C1466.matches:=handleTypeAheadCollectVariable(Self:C308; Form:C1466.collection)
		Else 
			Form:C1466.matches:=handleTypeAheadSelectVariable(Self:C308; Form:C1466.entity)
		End if 
		ARRAY TEXT:C222($array; 0)
		C_LONGINT:C283($list)
		Form:C1466.autoList:=New list:C375
		COLLECTION TO ARRAY:C1562(Form:C1466.matches; $array)
		ARRAY TO LIST:C287($array; Form:C1466.autoList)
		OBJECT SET LIST BY REFERENCE:C1266(*; "AutoList"; Form:C1466.autoList)
		C_LONGINT:C283($index)
		$index:=Find in list:C952(*; "AutoList"; Self:C308->; 0)
		SELECT LIST ITEMS BY POSITION:C381(*; "AutoList"; $index)
		OBJECT SET SCROLL POSITION:C906(*; "AutoList")
		Form:C1466.value:=Self:C308->
End case 