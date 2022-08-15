//%attributes = {}

//get template info to be used for the "customer" or "agent"
//these are templates for primarily web portal users
//could create an "internal" context too - this is currently "" unspecified and assumes customer

C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $context)

C_OBJECT:C1216($0; $templateInfo)

C_OBJECT:C1216($entity)
C_BOOLEAN:C305($isNewRecord; $statusChange; $confirmChange; $honorChange)

$ptrTable:=$1

$templateInfo:=New object:C1471
$templateInfo.subject:=""
$templateInfo.template:=""
$templateInfo.success:=False:C215

If (webIsLicensed)
	
	If (Count parameters:C259>=2)
		$context:=$2
	Else 
		$context:="customers"
	End if 
	
	If (Is new record:C668($ptrTable->)) | (Trigger event:C369=On Saving New Record Event:K3:1)
		$isNewRecord:=True:C214
	Else 
		$isNewRecord:=False:C215
	End if 
	
	Case of 
		: ($context="customers") | ($context="")
			
			Case of 
				: ($ptrTable=(->[Customers:3]))
					If ($isNewRecord)
						If ($context="customers")  //only web new recs
							$templateInfo.subject:="Thank you for creating your profile."
							$templateInfo.template:="customers-new-welcome.html"
							$templateInfo.message:="Thank you for joining us. "
							$templateInfo.message:=$templateInfo.message+"We will review your profile and will recieve another email when your account is ready for you to access."
							$templateInfo.sourceTable:=Table:C252(->[Customers:3])
							$templateInfo.sourceId:=[Customers:3]CustomerID:1
							$templateInfo.sourceType:="new"
							$templateInfo.success:=True:C214
						End if 
						
					Else 
						Case of 
							: (Old:C35([Customers:3]approvalStatus:146)#1) & ([Customers:3]approvalStatus:146=1)  //internet access is now allowed
								$templateInfo.subject:="Your profile is now approved for web access"
								$templateInfo.template:="customers-status-change.html"
								$templateInfo.message:="Your profile is now approved for web access."
								$templateInfo.sourceTable:=Table:C252(->[Customers:3])
								$templateInfo.sourceId:=[Customers:3]CustomerID:1
								$templateInfo.sourceType:="access"
								$templateInfo.success:=True:C214
								
							: (Old:C35([Customers:3]isAllowedInternetAccess:50)=False:C215) & ([Customers:3]isAllowedInternetAccess:50=True:C214)  //internet access is now allowed
								$templateInfo.subject:="Your profile is now approved for web access"
								$templateInfo.template:="customers-status-change.html"
								$templateInfo.message:="Your profile is now approved for web access."
								$templateInfo.sourceTable:=Table:C252(->[Customers:3])
								$templateInfo.sourceId:=[Customers:3]CustomerID:1
								$templateInfo.sourceType:="access"
								$templateInfo.success:=True:C214
								
							: (Old:C35([Customers:3]approvalStatus:146)#4) & ([Customers:3]approvalStatus:146=4)  //internet access is now denied
								$templateInfo.subject:="Your profile is now denied for web access"
								$templateInfo.template:="customers-status-change.html"
								$templateInfo.message:="Your profile has been denied for web access."
								$templateInfo.sourceTable:=Table:C252(->[Customers:3])
								$templateInfo.sourceId:=[Customers:3]CustomerID:1
								$templateInfo.sourceType:="access"
								$templateInfo.success:=True:C214
								
								//: (Old([Customers]isOnHold)=False) & ([Customers]isOnHold=True)  //put onHold
								//$templateInfo.subject:="Your profile has been placed on Hold."
								//$templateInfo.template:="customers-status-change.html"
								//$templateInfo.message:="Your profile has been placed on Hold."
								//$templateInfo.sourceTable:=Table(->[Customers])
								//$templateInfo.sourceId:=[Customers]CustomerID
								//$templateInfo.sourceType:="hold"
								//$templateInfo.success:=True
								//: (Old([Customers]isOnHold)=True) & ([Customers]isOnHold=False)  //taken off onHold
								//$templateInfo.subject:="Your profile has been taken off Hold."
								//$templateInfo.template:="customers-status-change.html"
								//$templateInfo.message:="Your profile has been taken off Hold."
								//$templateInfo.sourceTable:=Table(->[Customers])
								//$templateInfo.sourceId:=[Customers]CustomerID
								//$templateInfo.sourceType:="hold"
								//$templateInfo.success:=True
						End case 
						
					End if 
					
					
					
				: ($ptrTable=(->[Links:17]))
					
					If ($isNewRecord)
						$templateInfo.subject:="We have received your request to add a beneficiary."
						$templateInfo.template:="links-new-record.html"
						$templateInfo.sourceTable:=Table:C252(->[Links:17])
						$templateInfo.sourceId:=[Links:17]LinkID:1
						$templateInfo.sourceType:="new"
						$templateInfo.success:=True:C214
					Else 
						
						
					End if 
					
					
					
				: ($ptrTable=(->[WebEWires:149]))
					If ($isNewRecord)
						$templateInfo.subject:="We have received your Send Money request."
						$templateInfo.template:="webewires-new-record.html"
						$templateInfo.sourceTable:=Table:C252(->[WebEWires:149])
						$templateInfo.sourceId:=[WebEWires:149]WebEwireID:1
						$templateInfo.sourceType:="new"
						$templateInfo.success:=True:C214
					Else 
						$statusChange:=Old:C35([WebEWires:149]status:16)#[WebEWires:149]status:16
						
						If ($statusChange) & ([WebEWires:149]status:16<0)  //only send for denials/cancellings
							If ([WebEWires:149]paymentInfo:35.status="SUCCESS@") | ([WebEWires:149]paymentInfo:35.status="COMPLETE@")  // if it wasn't a successful payment don't bother to notify
								$templateInfo.subject:="There has been an Update to your  Send Money request."
								$templateInfo.template:="webewires-update-record.html"
								$templateInfo.sourceTable:=Table:C252(->[WebEWires:149])
								$templateInfo.sourceId:=[WebEWires:149]WebEwireID:1
								$templateInfo.sourceType:=getWebEWireStatusText
								$templateInfo.success:=True:C214
							End if 
						End if 
						
					End if 
					
					
				: ($ptrTable=(->[eWires:13]))
					If ($isNewRecord)
						$entity:=ds:C1482.WebEWires.query("eWireID == :1"; [eWires:13]eWireID:1)
						If ($entity.length=1)
							$templateInfo.subject:="Your eWire request has been processed. ["+[eWires:13]eWireID:1+"]"  //need to send code here
							$templateInfo.template:="ewires-new-record.html"
							$templateInfo.sourceTable:=Table:C252(->[eWires:13])
							$templateInfo.sourceId:=[eWires:13]eWireID:1
							$templateInfo.sourceType:="new"
							$templateInfo.success:=True:C214
						End if 
						
					Else 
						$statusChange:=Old:C35([eWires:13]Status:22)#[eWires:13]Status:22
						If ($statusChange)
							$templateInfo.subject:="There has been an Update to your  request to send an eWire."
							$templateInfo.template:="ewires-update-record.html"
							$templateInfo.sourceTable:=Table:C252(->[eWires:13])
							$templateInfo.sourceId:=[eWires:13]eWireID:1
							$templateInfo.sourceType:=[eWires:13]Status:22
							$templateInfo.success:=True:C214
						End if 
						
					End if 
					
					
					
				: ($ptrTable=(->[Bookings:50]))
					If ($isNewRecord)
						$templateInfo.subject:="We have received your request to book currency. "+[Bookings:50]BookingID:1
						$templateInfo.template:="bookings-new-record.html"
						$templateInfo.sourceTable:=Table:C252(->[Bookings:50])
						$templateInfo.sourceId:=[Bookings:50]BookingID:1
						$templateInfo.sourceType:="new"
						$templateInfo.success:=True:C214
					Else 
						$confirmChange:=Old:C35([Bookings:50]isConfirmed:15)#[Bookings:50]isConfirmed:15
						$honorChange:=Old:C35([Bookings:50]isHonored:18)#[Bookings:50]isHonored:18
						
						If ($confirmChange) | ($honorChange)  //status change
							$templateInfo.subject:="There has been an Update to your  booking request."
							$templateInfo.template:="bookings-update-record.html"
							$templateInfo.sourceTable:=Table:C252(->[Bookings:50])
							$templateInfo.sourceId:=[Bookings:50]BookingID:1
							If ($honorChange)
								$templateInfo.sourceType:="honored"
							Else 
								$templateInfo.sourceType:="confirmed"
							End if 
							$templateInfo.success:=True:C214
						End if 
						
					End if 
					
					
					
				Else 
					//no notification
			End case 
			
			
		: ($context="agents")
			
			
	End case 
	
End if 

$0:=$templateInfo
