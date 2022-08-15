//%attributes = {}
C_TEXT:C284($0)
C_LONGINT:C283($selector; <>workstationDetectionMethod)
C_TEXT:C284(<>clientCode)

$selector:=<>workstationDetectionMethod

Case of 
	: ($selector=0)  // Workstation name
		$0:=Current machine:C483
	: ($selector=1)  // Username
		$0:=Current system user:C484
	: ($selector=2)  // Mac Address
		$0:=UTIL_getMacAddress
	: ($selector=3)  // Serial Number 
		$0:=getApplicationUser
	: ($selector=4)  // static
		$0:=<>clientCode
		
	Else 
		$0:=Current machine:C483
End case 
