//%attributes = {}
C_TEXT:C284($1; $countryCode)
C_BOOLEAN:C305($0)

$countryCode:=$1
$0:=True:C214

Case of 
		
	: ($countryCode="CAN")
	: ($countryCode="USA")
	: ($countryCode="MEX")
		
	Else 
		
		$0:=False:C215
		
End case 
