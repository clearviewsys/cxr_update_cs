handleShowCustomerNamesButton(Self:C308; ->[Registers:10]CustomerID:5)
C_POINTER:C301($viewListBoxPtr)
$viewListBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "viewListBox")
REDRAW:C174($viewListBoxPtr->)



//C_LONGINT($self)
//$self:=Self->
//If (Form event=On Clicked)
//
//Case of 
//: ($self=1)
//SET FIELD RELATION([Registers]CustomerID;Automatic;Manual)
//LISTBOX SET COLUMN WIDTH(*;"col_CustomerName";170)
//REDRAW(mainlistbox)
//
//: ($self=0)
//SET FIELD RELATION([Registers]CustomerID;Manual;Manual)
//LISTBOX SET COLUMN WIDTH(*;"col_CustomerName";0)
//
//Else 
//End case 
//
//End if 