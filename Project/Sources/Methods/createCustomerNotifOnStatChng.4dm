//%attributes = {}
//createEmailBookingStatusChange

C_TEXT:C284($email; $body; $subject)
C_LONGINT:C283($0; $error)

C_BOOLEAN:C305($honorChange; $confirmChange)
C_OBJECT:C1216($entity)
C_TEXT:C284($currErrMethod)


$error:=0

If (Sync_IsSyncProcess)
	//con't run in a sync process
Else 
	$confirmChange:=Old:C35([Bookings:50]isConfirmed:15)#[Bookings:50]isConfirmed:15
	$honorChange:=Old:C35([Bookings:50]isHonored:18)#[Bookings:50]isHonored:18
	
	If ($confirmChange) | ($honorChange)  //status change
		
		$currErrMethod:=Method called on error:C704
		ON ERR CALL:C155("onErrCallIgnore")
		
		$error:=createEmailBookingOnStatusChng
		
		ON ERR CALL:C155($currErrMethod)
		
	End if 
	
End if 

$0:=$error