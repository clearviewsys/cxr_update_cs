//%attributes = {"shared":true,"publishedWeb":true}
C_TEXT:C284($1; $statusText)

C_TEXT:C284($gateway)
C_OBJECT:C1216($status)
C_BOOLEAN:C305($readonly)

$statusText:="UNKNOWN"

C_OBJECT:C1216($we; $payment)

$we:=New object:C1471
$we:=Create entity selection:C1512([WebEWires:149])  //assume we have the record



Case of 
		//what if $we is emmpty
	: ($we.length=0)  //new record
		$statusText:="NEW"
		
	: (OB Get type:C1230($we.first(); "paymentInfo")=Is null:K8:31)
		$statusText:=getWebEWireStatusText
		
	: ($we.first().status>=30)  //invoiced and sent so assume payment completed
		$statusText:="completed"
		
	Else 
		If (OB Is defined:C1231($we.first().paymentInfo))
			$payment:=$we.first().paymentInfo
			$statusText:=$we.first().paymentInfo.status
			$gateway:=$we.first().paymentInfo.gateway
			
			If ($statusText="") | ($statusText="2")
				Case of 
					: ($gateway="polipaylink")
						// status options: completed, unused, activated, partpaid, future
						
					: ($gateway="polipayapi")
						//final status options = completed, cancelled, failed, receiptUnverified, timedOut
						//in process options = initiated, financialInstitution selected eulaAccepted, inProcess, Unknown
						
						If ($payment.poliLink#Null:C1517)
							//should recheck status right now
							$statusText:="NEW"  //give user option to pay now
						Else   //errro getting a poliLink
							// retry to get a link
							$readonly:=Read only state:C362([WebEWires:149])
							If ($readonly)
								UNLOAD RECORD:C212([WebEWires:149])
								READ WRITE:C146([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
							$status:=POLI_InitiateForWebEwire
							If ($status.success)
								SAVE RECORD:C53([WebEWires:149])
								$statusText:="NEW"
							Else 
								$statusText:="ERROR"
							End if 
							
							If ($readonly)
								UNLOAD RECORD:C212([WebEWires:149])
								READ ONLY:C145([WebEWires:149])
								LOAD RECORD:C52([WebEWires:149])
							End if 
							
						End if 
						
						
					: ($gateway="paymark")
						//0=UNKNOWN, 1=SUCCESSFUL, 2=DECLINED, 3=BLOCKED, 4=FAILED, 5=INPROGRESS, 6=CANCELLED.
						
						Case of 
							: ($payment.url=Null:C1517)  // retry to get a link
								$readonly:=Read only state:C362([WebEWires:149])
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ WRITE:C146([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								$status:=PMARK_initiateForWebEwire
								
								If ($status.success)
									$statusText:="NEW"
								Else 
									$statusText:="ERROR"
								End if 
								
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ ONLY:C145([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								
							: ($payment.url="")
								$readonly:=Read only state:C362([WebEWires:149])
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ WRITE:C146([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								$status:=PMARK_initiateForWebEwire
								
								If ($status.success)
									$statusText:="NEW"
								Else 
									$statusText:="ERROR"
								End if 
								
								If ($readonly)
									UNLOAD RECORD:C212([WebEWires:149])
									READ ONLY:C145([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
								End if 
								
								
							Else   //should recheck status right now
								
								$status:=PMARK_getForWebEwire($we.first().WebEwireID)
								If ($status.success)
									$statusText:=$status.statusText
								Else 
									$statusText:="NEW"  //give user option to pay now
								End if 
						End case 
						
						
					Else 
						$statusText:="UNDEFINED-Gateway Unknown"
				End case 
				
			End if 
		End if 
End case 


$0:=$statusText