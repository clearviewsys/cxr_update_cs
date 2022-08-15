//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/24/21, 08:56:46
// ----------------------------------------------------
// Method: PMARK_getForWebEwire
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $reference)

C_OBJECT:C1216($0; $status)

C_OBJECT:C1216($response; $entity; $record)
C_LONGINT:C283($i)

If (Count parameters:C259>=1)
	$reference:=$1
Else 
	$reference:=[WebEWires:149]WebEwireID:1
End if 

$status:=New object:C1471
$status.success:=False:C215

//account_id - The Paymark Click Account ID used for processing the transaction.
//amount
// reference
//transaction_id
//transaction_status -- 
//response_text
//receipt_id
// verifier -- is this the token?

$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; $reference)

If ($entity.length=1)
	$record:=$entity.first()
Else 
	$record:=ds:C1482.WebEWires.new()  // more for debugging right now
	$record.WebEwireID:=makeWebEwireID
	$record.paymentInfo:=New object:C1471
End if 


Case of 
	: ($record.paymentInfo.paymentMethod=Null:C1517)
		$record.paymentInfo.paymentMethod:="PAYMARK"
	: ($record.paymentInfo.paymentMethod="")
		$record.paymentInfo.paymentMethod:="PAYMARK"
End case 

$response:=New object:C1471
$response.success:=False:C215

Case of 
	: ($record.status>=10)  //already paid
	: ($record.status<0)  //denied / cancelled
	Else 
		// NOW CALL  FOR THE TRANSACTION DETAILS
		$response:=PMARK_getTransaction($record.paymentInfo.transactionRefNo)
End case 

If ($response.success=False:C215)  // fall back now try with our reference
	$response:=PMARK_searchTransaction(New object:C1471("reference"; $record.WebEwireID; "startDate"; $record.creationDate; "endDate"; $record.creationDate+1))
End if 

If ($response.success)  // & ($response.response.length>0)
	C_OBJECT:C1216($o)
	$o:=New object:C1471
	
	If (False:C215)
		
		
		Case of 
			: (Value type:C1509($response.response)=Is collection:K8:32)
				If ($response.response.length>0)  // loop thru and see if there is a "successful" trans
					C_OBJECT:C1216($tran)
					C_BOOLEAN:C305($isFound)
					$isFound:=False:C215
					For each ($tran; $response.response) Until ($isFound)
						If ($tran.status="SUCCESSFUL")  // this is the one to use
							$isFound:=True:C214
							$o:=$tran
						End if 
					End for each 
					
					If ($o=Null:C1517)  // nothing successful
						$o:=$response.response[0]
					End if 
				End if 
				
			: (Value type:C1509($response.response)=Is object:K8:27)
				$o:=$response.response
		End case 
	Else 
		
		$o:=$response  //.response
		
	End if 
	
	If ($o.status=Null:C1517)
	Else 
		
		Case of 
			: ($o.response=Null:C1517)
				$record.paymentInfo.status:="NOT FOUND"
			: ($o.response.length=0)
				$record.paymentInfo.status:="NOT FOUND"
			Else 
				$record.paymentInfo.status:=$o.response.status
				$record.paymentInfo.transactionDateTime:=$o.response.transactionDate
				$record.paymentInfo.transactionType:=$o.response.type
				
				//$record.paymentInfo.transactionId:=$o.receiptNumber  // paymark receipt ID -- don't change the ID
				//$record.paymentInfo.transactionRefNo:=$o.receiptNumber // don't change the refNo ... this is most important for paymark
				
				If ($record.paymentInfo.paymentData=Null:C1517)
					$record.paymentInfo.paymentData:=New object:C1471
				End if 
				
				ARRAY TEXT:C222($atProperties; 0)
				OB GET PROPERTY NAMES:C1232($o.response; $atProperties)
				For ($i; 1; Size of array:C274($atProperties))
					OB SET:C1220($record.paymentInfo.paymentData; $atProperties{$i}; $o[$atProperties{$i}])
				End for 
				
		End case 
		
		//If ($record.status<10) & ($record.status>=0)
		//$record.status:=10
		//End if 
		
		If ($record.AML_Info[AML_fromMOPCode]="")
			$record.AML_Info[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.paymark"; "N")
		End if 
		
		Case of 
			: ($record.paymentInfo.status="SUCCESSFUL")
				$record.status:=10
			: ($record.paymentInfo.status="CANCELLED")
				$record.status:=-10
				$record.isCancelled:=True:C214
			: ($record.paymentInfo.status="FAILED")
				$record.status:=-10  //cancelled due to bank specific failure
				$record.isCancelled:=True:C214
			: ($record.paymentInfo.status="DECLINED")
				$record.status:=-20  //denied
				$record.isCancelled:=True:C214
			: ($record.paymentInfo.status="BLOCKED")
				$record.status:=-20  //denied
				$record.isCancelled:=True:C214
			: ($record.paymentInfo.status="INPROGRESS")
				
			: ($record.paymentInfo.status="UNKNOWN")
				
			: ($record.paymentInfo.status="NOT FOUND")
			Else 
				//TRACE
		End case 
		
		$status:=$record.save()
		If ($status.success)
			$status.status:=$record.paymentInfo.status
			$status.statusText:=$record.paymentInfo.status
		Else 
			
		End if 
	End if 
	
Else 
	
End if 


$0:=$status