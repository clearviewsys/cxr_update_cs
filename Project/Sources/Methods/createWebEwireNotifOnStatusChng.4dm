//%attributes = {}
//createEmailBookingOnStatusChng

//NOT USED

C_BOOLEAN:C305($1; $isNew)

C_TEXT:C284($email; $body; $subject)
C_LONGINT:C283($0; $error)

C_BOOLEAN:C305($honorChange; $confirmChange)
C_OBJECT:C1216($entity)
C_TEXT:C284($currErrMethod)
C_BOOLEAN:C305($statusChange)


$error:=0

If (Count parameters:C259=1)
	$isNew:=$1
Else 
	$isNew:=False:C215
End if 



If (Sync_IsSyncProcess)
	//don't run if this is a sync record
Else 
	$statusChange:=Old:C35([WebEWires:149]status:16)#[WebEWires:149]status:16
	
	If ($statusChange) | ($isNew)  //status change
		
		$currErrMethod:=Method called on error:C704
		ON ERR CALL:C155("onErrCallIgnore")
		
		$entity:=ds:C1482.Customers.query("CustomerID == :1"; [WebEWires:149]CustomerID:21)
		
		If ($entity.length=1)
			$error:=sendNotificationEmail4WebEwire($entity.first().Email)
			
			//$error:=createSMSForBooking ($entity.first().CellPhone)
		End if 
		
		ON ERR CALL:C155($currErrMethod)
		
	End if 
	
End if 

$0:=$error