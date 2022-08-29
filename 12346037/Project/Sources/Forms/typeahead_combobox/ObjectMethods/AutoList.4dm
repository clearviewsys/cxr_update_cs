Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($index)
		C_POINTER:C301($input)
		$index:=Selected list items:C379(Form:C1466.autoList)
		$input:=OBJECT Get pointer:C1124(Object named:K67:5; "Input_box")
		$input->:=Form:C1466.matches[$index-1]
		Form:C1466.value:=$input->
		OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
End case 