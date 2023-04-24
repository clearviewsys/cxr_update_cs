//%attributes = {}
// isThisComputerAuthorized
// this method returns true or false depending on whether this workstation is authorized to run
// there must be a record of MAC address in the MACs table

C_BOOLEAN:C305($0)

READ ONLY:C145([MACs:18])
C_TEXT:C284($mac)
$mac:=UTIL_getMacAddress
QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=$mac)
LOAD RECORD:C52([MACs:18])
If (Records in selection:C76([MACs:18])=0)
	$0:=False:C215
Else 
	$0:=True:C214
End if 
