//%attributes = {}
C_TEXT:C284($1; $webEwireID)
C_OBJECT:C1216($2; $whattoUpdate; $webEwire; $status)
C_LONGINT:C283($i)
C_BOOLEAN:C305($0)

ARRAY TEXT:C222($properties; 0)

$webEwireID:=$1
$whattoUpdate:=$2
$0:=False:C215

$webEwire:=ds:C1482.WebEWires.query("WebEwireID = :1"; $webEwireID).first()

If ($webEwire#Null:C1517)
	
	OB GET PROPERTY NAMES:C1232($whattoUpdate; $properties)
	
	For ($i; 1; Size of array:C274($properties))
		$webEwire.paymentInfo[$properties{$i}]:=$whattoUpdate[$properties{$i}]
	End for 
	
	$status:=$webEwire.save()
	
	If ($status.success)
		$0:=True:C214
	End if 
	
End if 
