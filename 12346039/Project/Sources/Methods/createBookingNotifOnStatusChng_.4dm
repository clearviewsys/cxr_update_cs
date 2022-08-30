//%attributes = {}
//createEmailBookingOnStatusChng

//---NOT USED ANY MORE--

C_BOOLEAN:C305($1; $isNew)

C_TEXT:C284($email; $body; $subject)
C_LONGINT:C283($0; $error)

C_BOOLEAN:C305($honorChange; $confirmChange)
C_OBJECT:C1216($entity)
C_TEXT:C284($currErrMethod)


$error:=0

If (Count parameters:C259=1)
	$isNew:=$1
Else 
	$isNew:=False:C215
End if 



If (Sync_IsSyncProcess)
	//don't run if this is a sync record
Else 
	$confirmChange:=Old:C35([Bookings:50]isConfirmed:15)#[Bookings:50]isConfirmed:15
	$honorChange:=Old:C35([Bookings:50]isHonored:18)#[Bookings:50]isHonored:18
	
	If ($confirmChange) | ($honorChange) | ($isNew)  //status change
		
		$currErrMethod:=Method called on error:C704
		ON ERR CALL:C155("onErrCallIgnore")
		
		$entity:=ds:C1482.Customers.query("CustomerID == :1"; [Bookings:50]CustomerID:2)
		
		If ($entity.length=1)
			$error:=sendNotificationEmailForBooking($entity.first().Email)
			
			$error:=createSMSForBooking($entity.first().CellPhone)
		End if 
		
		ON ERR CALL:C155($currErrMethod)
		
	End if 
	
End if 

$0:=$error

