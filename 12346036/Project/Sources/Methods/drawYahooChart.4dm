//%attributes = {}
C_PICTURE:C286($0)
C_LONGINT:C283($months; $1)
C_TEXT:C284($subURL)
//http://www.refcofx.com/images/refco-company-profile2.jpg


Case of 
	: (Count parameters:C259=1)
		$months:=$1
End case 

If ($months=0)
	$months:=1
End if 

$subURL:="z?s="+[Currencies:6]ISO4217:31+[Currencies:6]toISO4217:32+"=X&z=m&t="+String:C10($months)+"m"
$0:=fetchPNGImagefromURL("ichart.yahoo.com"; $subUrl)
