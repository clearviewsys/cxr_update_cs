//%attributes = {}

// ------------------------------------------------------------------------------
// Method: getSystemDateFormat: 
//         Return the system date format
// Parameters: (none) 
// Return: System date format 
// ------------------------------------------------------------------------------
// Jaime Alvarez, March 18/2015
// ------------------------------------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($dateSep; $dayPos; $monthPos; $yearPos; $dateFormat)
C_LONGINT:C283($y; $m; $d)

GET SYSTEM FORMAT:C994(Date separator:K60:10; $dateSep)
GET SYSTEM FORMAT:C994(Short date day position:K60:12; $dayPos)
GET SYSTEM FORMAT:C994(Short date month position:K60:13; $monthPos)
GET SYSTEM FORMAT:C994(Short date year position:K60:14; $yearPos)

$y:=Num:C11($yearPos)
$m:=Num:C11($monthPos)
$d:=Num:C11($dayPos)

Case of 
		
	: (($y=1) & ($m=2) & ($d=3))
		$dateFormat:="y"+$dateSep+"m"+$dateSep+"d"
		
	: (($y=3) & ($m=1) & ($d=2))
		$dateFormat:="m"+$dateSep+"d"+$dateSep+"y"
		
	: (($y=3) & ($m=2) & ($d=1))
		$dateFormat:="d"+$dateSep+"m"+$dateSep+"y"
End case 

$0:=$dateFormat