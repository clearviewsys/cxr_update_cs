//%attributes = {}
C_POINTER:C301($tablePtr; $fieldPtr; $tableArrayPtr)

Case of 
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$tableArrayPtr:=$3
	Else 
		$tablePtr:=->[Currencies:6]
		$fieldPtr:=->[Currencies:6]CurrencyCode:1
		$tableArrayPtr:=->ARRCODES
End case 


C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row equals 5
	QUERY:C277($tablePtr->; $fieldPtr->=$tableArrayPtr->{$row})
	handledoubleclickevent($tablePtr)
End if 

//LISTBOX GET CELL POSITION