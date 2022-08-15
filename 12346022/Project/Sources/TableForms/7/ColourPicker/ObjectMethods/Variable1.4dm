// vsColorValue non-enterable Object Method
Case of 
	: (Form event code:C388=On Load:K2:1)
		vsColorValue:="0x00000000"
End case   // vsColor non-enterable variable Object Method

Case of 
	: (Form event code:C388=On Load:K2:1)
		vsColor:=""
		OBJECT SET RGB COLORS:C628(vsColor; 0x00FFFFFF; 0x0000)
End case 