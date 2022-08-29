//%attributes = {}

C_TEXT:C284($1; $table)
C_TEXT:C284($2; $recordID)
C_POINTER:C301($3; $ptrNameArray)
C_POINTER:C301($4; $ptrValueArray)

C_TEXT:C284($0)

C_OBJECT:C1216($entity; $status; $record)
C_TEXT:C284($result; $context)

$table:=$1
$recordID:=$2
$ptrNameArray:=$3
$ptrValueArray:=$4

$result:=""

If ($table=Table name:C256(->[Bookings:50]))
	
	$context:=WAPI_getSession("context")
	
	Case of 
		: ($context="customers")
			webSelectCustomerRecord
			
			$entity:=ds:C1482.Bookings.query("BookingID == :1 AND CustomerID == :2"; $recordID; [Customers:3]CustomerID:1)
			
			If ($entity.length=1)
				$record:=$entity.first()
				
				If ($record.isConfirmed=False:C215) & ($record.isHonored=False:C215)
					
					$record.ourRemarks:="Customer cancelled booking request"
					$record.expiryDate:=Current date:C33
					$record.expiryTime:=Current time:C178
					$record.isCancelled:=True:C214
					$status:=$record.save()
					
					If ($status.success=True:C214)
						$result:=WAPI_displayMessage("Cancelled"; "The Booking has been cancelled.")
						$result:=$result+"pq.grid('#grid-bookings').refreshDataAndView();"
					Else 
						$result:=WAPI_displayMessage("ERROR"; "The Booking could NOT be cancelled.")
					End if 
					
				Else 
					$result:=WAPI_displayMessage("ERROR"; "The Booking has already been processed. Can NOT be cancelled.")
				End if 
				
			Else 
				$result:=WAPI_displayMessage("ERROR"; "The Booking could NOT be cancelled.")
			End if 
			
		: ($context="agents")
			
			
		Else 
			
			
	End case 
	
End if 

$0:=$result