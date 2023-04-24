Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($width; $height)
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
		OBJECT SET COORDINATES:C1248(*; "Input_box"; 1; 1; $width-1; 16)
		OBJECT SET COORDINATES:C1248(*; "AutoList"; 1; 16; $width-1; $height-1)
	: (Form event code:C388=On Bound Variable Change:K2:52)
		OBJECT SET PLACEHOLDER:C1295(*; "Input_box"; Form:C1466.placeholder)
		OBJECT Get pointer:C1124(Object named:K67:5; "Input_box")->:=Form:C1466.value
	: (Form event code:C388=On Getting Focus:K2:7)
		OBJECT SET VISIBLE:C603(*; "AutoList"; True:C214)
	: (Form event code:C388=On Losing Focus:K2:8)
		OBJECT SET VISIBLE:C603(*; "AutoList"; False:C215)
End case 