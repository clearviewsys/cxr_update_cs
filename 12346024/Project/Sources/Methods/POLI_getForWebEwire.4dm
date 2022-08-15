//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/24/21, 08:43:40
// ----------------------------------------------------
// Method: POLI_getForWebEwire
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $token)

$token:=$1

//now use GETTransacction API to get state of that transaction
C_OBJECT:C1216($response; $entity; $record; $status)
C_LONGINT:C283($i)


$status:=New object:C1471
$status.success:=False:C215


$response:=POLI_getTransaction($token)
If ($response.success)
	$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; $response.response.MerchantReference)
	If ($entity.length=1)
		$record:=$entity.first()
		
		Case of 
			: ($record.status>=10)  //already paid
			: ($record.status<0)  //denied / cancelled
			Else 
				$record.paymentInfo.status:=$response.response.TransactionStatusCode
				$record.paymentInfo.transactionId:=$response.response.TransactionID
				$record.paymentInfo.transactionDateTime:=$response.response.EstablishedDateTime
				$record.paymentInfo.paymentMethod:="POLI"
				
				
				//If ($response.response.BankReceiptNo="")
				//$record.paymentInfo.confirmationID:=$response.response.TransactionRefNo
				//Else 
				//$record.paymentInfo.confirmationID:=$response.response.BankReceiptNo
				//End if 
				
				If ($record.paymentInfo.paymentData=Null:C1517)
					$record.paymentInfo.paymentData:=New object:C1471
				End if 
				
				ARRAY TEXT:C222($atProperties; 0)
				OB GET PROPERTY NAMES:C1232($response.response; $atProperties)
				For ($i; 1; Size of array:C274($atProperties))
					OB SET:C1220($record.paymentInfo.paymentData; $atProperties{$i}; $response.response[$atProperties{$i}])
				End for 
				
				If ($record.status<10) & ($record.status>=0)
					$record.status:=10
				End if 
				
				$record.AML_Info[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.poli")
				
				Case of 
					: ($record.paymentInfo.status="Completed")
						$record.status:=10
					: ($record.paymentInfo.status="Cancelled")
						$record.status:=-10
						$record.isCancelled:=True:C214
					: ($record.paymentInfo.status="Failed")
						$record.status:=-10  //cancelled due to bank specific failure
						$record.isCancelled:=True:C214
					: ($record.paymentInfo.status="ReceiptUnverified")
						$record.status:=-20  //denied
						$record.isCancelled:=True:C214
					: ($record.paymentInfo.status="TimeOut")
						$record.status:=-10  //cancel - customer didn't finish in time
						$record.isCancelled:=True:C214
				End case 
				
				$status:=$record.save()
				If ($status.success)
				Else 
					
				End if 
		End case 
		
	End if 
	
End if 

$0:=$status