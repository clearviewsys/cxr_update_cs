ARRAY TEXT:C222(arrDirections; 3)

Case of 
	: (Form event code:C388=On Load:K2:1)
		arrDirections:=1
	: (Form event code:C388=On Clicked:K2:4)
		
		handleeWiresPendingPullDown
		
End case 