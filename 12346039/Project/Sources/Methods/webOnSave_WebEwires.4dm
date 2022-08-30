//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/18/18, 18:23:43
// ----------------------------------------------------
// Method: webDefaultValues_Ewires
// Description
// 
//    fill in any extra data prior to saving the new record

// Parameters
// ----------------------------------------------------




C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0; $OK)

C_TEXT:C284($baseURL; $context; $webewireid; $tPayMethod; $tInputControl; $errText; $particular)
C_OBJECT:C1216($status; $error)
C_BOOLEAN:C305($doGetToken)
C_LONGINT:C283($i)

//TRACE

$ptrNameArray:=$1
$ptrValueArray:=$2

$OK:=1  //assume all good

// TEST TO MAKE SURE HASN'T BEEN CREATED BEFORE - REFRESH ISSUE
$status:=WAPI_sessionGet("webewire")
If ($status.success)
	$webewireid:=$status.value
Else 
	$webewireid:=""
End if 

If ($webewireid="")  //hasn't been created -no refresh
	
	C_OBJECT:C1216($request)
	$status:=WAPI_sessionGet("request")  // have we started a request yet
	If ($status.success)
		$request:=$status.value
		WAPI_UT_objectToRecord($request; ->[WebEWires:149])  // init based on the request
	Else 
		$request:=New object:C1471
	End if 
	
	If ([WebEWires:149]WebEwireID:1="")
		Case of 
			: ([WebEWires:149]paymentInfo:35.deliveryMethod="MG")  // moneygram
				[WebEWires:149]WebEwireID:1:=Replace string:C233(makeWebEwireID; "WEB"; "MGS")
			: ([WebEWires:149]paymentInfo:35.bookingType="wire")
				[WebEWires:149]WebEwireID:1:=Replace string:C233(makeWebEwireID; Substring:C12(Table name:C256(->[WebEWires:149]); 1; 3); "WIR")
			: ([WebEWires:149]paymentInfo:35.bookingType="ewire")
				[WebEWires:149]WebEwireID:1:=Replace string:C233(makeWebEwireID; Substring:C12(Table name:C256(->[WebEWires:149]); 1; 3); "EWI")
			Else 
				[WebEWires:149]WebEwireID:1:=makeWebEwireID
		End case 
	End if 
	
	$status.success:=True:C214  // init
	
	
	Case of 
		: (webContext="agents")
			webSelectAgentRecord
			
			If ([WebEWires:149]agentID:29="")
				[WebEWires:149]agentID:29:=[Agents:22]AgentID:1
			End if 
			
			If ([WebEWires:149]author:34="")
				[WebEWires:149]author:34:=[Agents:22]AgentID:1
			End if 
			
			If ([WebEWires:149]status:16=0)
				[WebEWires:149]status:16:=0  //draft
			End if 
			
			If ([WebEWires:149]creationDate:15=!00-00-00!)
				[WebEWires:149]creationDate:15:=Current date:C33
			End if 
			
			If ([WebEWires:149]status:16=20)  //confirmed
				If ([WebEWires:149]confirmedDate:30=!00-00-00!)
					[WebEWires:149]confirmedDate:30:=Current date:C33
				End if 
			Else 
				[WebEWires:149]confirmedDate:30:=!00-00-00!  //make sure reset
			End if 
			
			//------ LINK IS THE FROM PARTY -------
			//------ CUSTOMER IS THE TO PARTY ------
			
			Case of 
				: ([eWires:13]CustomerID:15="NEW@")  //add the info to the existing link if nothing there else create new LINK 
					[WebEWires:149]CustomerID:21:=""
					
					If ([Links:17]CustomerName:15="")  //current link doesnt have a customer yet (new client setup)
						[Links:17]CustomerName:15:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
						[Links:17]CustomerPhone:16:=OB Get:C1224([WebEWires:149]toParty:8; Info_CellPhone)
						[Links:17]UnconfirmedCustomerName:18:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
						[Links:17]CustomerBankInfo:17:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Details)
						
					Else 
						//CREATE A NEW LINKS RECORD
						CREATE RECORD:C68([Links:17])
						createLinkID
						[Links:17]sameAsLinkID:52:=[WebEWires:149]LinkID:25
						[Links:17]countryCode:50:=[WebEWires:149]fromCountryCode:4
						[Links:17]Country:12:=getCountryNameByCode([WebEWires:149]fromCountryCode:4)
						
						[Links:17]CustomerID:14:=""
						[Links:17]CustomerName:15:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
						[Links:17]CustomerPhone:16:=OB Get:C1224([WebEWires:149]toParty:8; Info_CellPhone)
						[Links:17]UnconfirmedCustomerName:18:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
						[Links:17]CustomerBankInfo:17:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Details)
						[Links:17]Relationship:26:=OB Get:C1224([WebEWires:149]toParty:8; Info_Relationship)
						
						[Links:17]createdByUser:39:=[Agents:22]AgentID:1
						[Links:17]modifiedByUser:40:=""
						[Links:17]CreationDate:20:=Current date:C33
						[Links:17]CreationTime:21:=Current time:C178
						[Links:17]ModificationDate:22:=!00-00-00!
						[Links:17]ModificationTime:23:=?00:00:00?
						
					End if 
					
					SAVE RECORD:C53([Links:17])
					
					[WebEWires:149]LinkID:25:=[Links:17]LinkID:1  //update for new link
					
				: ([WebEWires:149]CustomerID:21="")
					// THIS SHOULDN'T HAPPEN - TRAP ERROR HERE <>TODO
					
				: ([WebEWires:149]CustomerID:21="|@")  //unestablished link
					//USE WHAT WAS ENTERED
					
				Else 
					QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[WebEWires:149]CustomerID:21)
					If (Records in selection:C76([Customers:3])=1)
						
						OB SET:C1220([WebEWires:149]toParty:8; Info_Address; [Customers:3]Address:7)
						OB SET:C1220([WebEWires:149]toParty:8; Info_FullName; [Customers:3]FullName:40)
						OB SET:C1220([WebEWires:149]toParty:8; Info_CellPhone; [Customers:3]CellPhone:13)
						OB SET:C1220([WebEWires:149]toParty:8; Info_City; [Customers:3]City:8)
						OB SET:C1220([WebEWires:149]toParty:8; Info_CompanyName; [Customers:3]CompanyName:42)
						OB SET:C1220([WebEWires:149]toParty:8; Info_DateOfBirth; [Customers:3]DOB:5)
						OB SET:C1220([WebEWires:149]toParty:8; Info_Email; [Customers:3]Email:17)
						OB SET:C1220([WebEWires:149]toParty:8; Info_Gender; [Customers:3]Gender:120)
						OB SET:C1220([WebEWires:149]toParty:8; Info_Relationship; [Customers:3]Relationship1:32)
						OB SET:C1220([WebEWires:149]toParty:8; Info_Salutation; [Customers:3]Salutation:2)
						
						
						//NOW CHECK FOR EXISTING LINK AND IF NONE CREATE ONE
						QUERY:C277([Links:17]; [Links:17]LinkID:1=[WebEWires:149]LinkID:25; *)
						QUERY:C277([Links:17];  | ; [Links:17]sameAsLinkID:52=[WebEWires:149]LinkID:25)
						QUERY SELECTION:C341([Links:17]; [Links:17]CustomerID:14=[WebEWires:149]CustomerID:21)
						
						If (Records in selection:C76([Links:17])=1)  //all good 
						Else 
							//create new link for this sender
							//CREATE A NEW LINKS RECORD
							CREATE RECORD:C68([Links:17])
							createLinkID
							[Links:17]sameAsLinkID:52:=[WebEWires:149]LinkID:25
							[Links:17]countryCode:50:=[WebEWires:149]fromCountryCode:4
							[Links:17]Country:12:=getCountryNameByCode([WebEWires:149]fromCountryCode:4)
							
							[Links:17]CustomerID:14:=[WebEWires:149]CustomerID:21  //new link to this customer record
							[Links:17]CustomerName:15:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
							[Links:17]CustomerPhone:16:=OB Get:C1224([WebEWires:149]toParty:8; Info_CellPhone)
							[Links:17]UnconfirmedCustomerName:18:=OB Get:C1224([WebEWires:149]toParty:8; Info_FullName)
							[Links:17]CustomerBankInfo:17:=OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_Details)
							[Links:17]Relationship:26:=OB Get:C1224([WebEWires:149]toParty:8; Info_Relationship)
							
							
							[Links:17]createdByUser:39:=[Agents:22]AgentID:1
							[Links:17]modifiedByUser:40:=""
							[Links:17]CreationDate:20:=Current date:C33
							[Links:17]CreationTime:21:=Current time:C178
							[Links:17]ModificationDate:22:=!00-00-00!
							[Links:17]ModificationTime:23:=?00:00:00?
							
							SAVE RECORD:C53([Links:17])
						End if 
					Else 
						//TRAP FOR ERROR HERE <>TODO
					End if 
			End case 
			
			
			UNLOAD RECORD:C212([Links:17])
			READ ONLY:C145([Links:17])
			REDUCE SELECTION:C351([Links:17]; 0)
			
			
		: (webContext="customers")
			webSelectCustomerRecord
			
			
			
			
			[WebEWires:149]UUID:2:=Generate UUID:C1066
			[WebEWires:149]isSent:22:=True:C214  //from web default - meaning outgoing not incoming
			[WebEWires:149]status:16:=5  //pending payment for customers
			[WebEWires:149]CustomerID:21:=[Customers:3]CustomerID:1  //fromParty
			
			If ([WebEWires:149]author:34="")
				[WebEWires:149]author:34:=[WebEWires:149]CustomerID:21
			End if 
			
			If ([WebEWires:149]creationDate:15=!00-00-00!)
				[WebEWires:149]creationDate:15:=Current date:C33
			End if 
			
			If ([WebEWires:149]creationTime:31=?00:00:00?)
				[WebEWires:149]creationTime:31:=Current time:C178
			End if 
			
			If (True:C214)  // customer
				OB SET:C1220([WebEWires:149]fromParty:7; Info_FullName; [Customers:3]FullName:40)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_FirstName; [Customers:3]FirstName:3)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_LastName; [Customers:3]LastName:4)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_Address; [Customers:3]Address:7)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_City; [Customers:3]City:8)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_State; [Customers:3]Province:9)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_PostalCode; [Customers:3]PostalCode:10)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_CountryCodeOfResidence; [Customers:3]CountryOfResidenceCode:114)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_CellPhone; [Customers:3]CellPhone:13)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_DateOfBirth; [Customers:3]DOB:5)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_GovernmentIDType; [Customers:3]PictureID_Type:70)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_GovernmentID; [Customers:3]PictureID_Number:69)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_Email; [Customers:3]Email:17)
				OB SET:C1220([WebEWires:149]fromParty:7; Info_Occupation; [Customers:3]Occupation:21)
			End if 
			
			If ([WebEWires:149]LinkID:25="")
			Else   //toParty
				QUERY:C277([Links:17]; [Links:17]LinkID:1=[WebEWires:149]LinkID:25; *)  //s
				QUERY:C277([Links:17];  & ; [Links:17]CustomerID:14=[WebEWires:149]CustomerID:21)
				
				OB SET:C1220([WebEWires:149]toParty:8; "salutation"; [Links:17]Salutation:25)
				OB SET:C1220([WebEWires:149]toParty:8; Info_FullName; [Links:17]FullName:4)
				OB SET:C1220([WebEWires:149]toParty:8; "firstName"; [Links:17]FirstName:2)
				OB SET:C1220([WebEWires:149]toParty:8; "lastName"; [Links:17]LastName:3)
				OB SET:C1220([WebEWires:149]toParty:8; "address"; [Links:17]Address:19)
				OB SET:C1220([WebEWires:149]toParty:8; "city"; [Links:17]City:11)
				OB SET:C1220([WebEWires:149]toParty:8; "state"; [Links:17]Province:60)
				OB SET:C1220([WebEWires:149]toParty:8; "postalCode"; [Links:17]PostalCode:61)
				
				OB SET:C1220([WebEWires:149]toParty:8; "dob"; [Links:17]DOB:49)
				OB SET:C1220([WebEWires:149]toParty:8; "governmentIdType"; [Links:17]PictureIDType:34)
				OB SET:C1220([WebEWires:149]toParty:8; "governmentId"; [Links:17]PictureID:53)
				OB SET:C1220([WebEWires:149]toParty:8; "countryCode"; [Links:17]countryCode:50)
				OB SET:C1220([WebEWires:149]toParty:8; "email"; [Links:17]email:5)
				OB SET:C1220([WebEWires:149]toParty:8; "gender"; [Links:17]Gender:47)
				OB SET:C1220([WebEWires:149]toParty:8; "relationship"; [Links:17]Relationship:26)
				OB SET:C1220([WebEWires:149]toParty:8; Info_isCompany; Choose:C955([Links:17]isCompany:43; "true"; "false"))
				OB SET:C1220([WebEWires:149]toParty:8; Info_CompanyName; Choose:C955([Links:17]isCompany:43; [Links:17]CompanyName:42; ""))
				
				If (OB Get:C1224([WebEWires:149]toParty:8; "cellPhone")="")
					OB SET:C1220([WebEWires:149]toParty:8; "cellPhone"; [Links:17]MainPhone:8)
				End if 
			End if 
			
			[WebEWires:149]toCountryCode:12:=[Links:17]countryCode:50
			
			Case of 
				: (OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_doTransferToBank)="on") & (OB Get:C1224([WebEWires:149]AML_Info:9; AML_toMOPCode)="")
					OB SET:C1220([WebEWires:149]AML_Info:9; AML_toMOPCode; getKeyValue("web.customers.webewires.tomop.bank"))
				: (OB Get:C1224([WebEWires:149]toBankingInfo:24; Bank_doTransferToBank)="") & (OB Get:C1224([WebEWires:149]AML_Info:9; AML_toMOPCode)="")
					OB SET:C1220([WebEWires:149]AML_Info:9; AML_toMOPCode; getKeyValue("web.customers.webewires.tomop.cash"))
				: (OB Get:C1224([WebEWires:149]AML_Info:9; AML_toMOPCode)="")
					OB SET:C1220([WebEWires:149]AML_Info:9; AML_toMOPCode; getKeyValue("web.customers.webewires.tomop.cash"))
				Else 
					//leave it alone
			End case 
			
			If ([WebEWires:149]paymentInfo:35.deliveryMethod="")
				[WebEWires:149]paymentInfo:35.deliveryMethod:=[WebEWires:149]AML_Info:9[AML_toMOPCode]
			End if 
			
			If ([WebEWires:149]paymentInfo:35.deliveryMethod="MG") & ([WebEWires:149]paymentInfo:35.deliveryMethod2="")
				[WebEWires:149]paymentInfo:35.deliveryMethod2:=[WebEWires:149]AML_Info:9[AML_toMOPCode]
			End if 
			
			[WebEWires:149]paymentInfo:35.amountPaid:=[WebEWires:149]fromAmount:3
			
		Else 
			
	End case 
	
	
	//--- MONEYGRAM ----
	If ([WebEWires:149]paymentInfo:35.deliveryMethod="MG")  // moneygram
		//$status:=WAPI_sessionGet ("request")  // have we started a request yet
		If (OB Is empty:C1297($request))  // ($status.success)
			//send back an error
			WAPI_setAlertMessage("Error retreiving MG send request from session."; 4)
			$OK:=0
			$status.success:=False:C215
		Else 
			//C_OBJECT($request)
			//$request:=$status.value
			
			//make sure the required fields are updated in .mgTransaction
			For ($i; 1; Size of array:C274($ptrNameArray->))
				$tInputControl:=$ptrNameArray->{$i}
				If ($tInputControl="mg-required-@")
					$request.mgTransaction[Replace string:C233($tInputControl; "mg-required-"; "")]:=$ptrValueArray->{$i}
				End if 
			End for 
			
			C_COLLECTION:C1488($mgOption)
			$mgOption:=$request.paymentInfo.mgQuoteOptions.query("DeliveryOptionDisplayName == :1"; [WebEWires:149]paymentInfo:35.deliveryMethod2)
			
			If ($mgOption.length=1)
				$request.mgTransaction.DeliveryOptionCode:=$mgOption[0].DeliveryOptionCode
				If ($mgOption.TransferToPointId=Null:C1517)
				Else 
					$request.mgTransaction.TransferToPointId:=$mgOption[0].TransferToPointId
				End if 
			End if 
			//$status:=mgValidateTransaction ($request.mgTransaction)  // move this to webOnChange_Ewires method befora a call to mgBuildSendRequestTransaction method @milan
			
			If (True:C214)  // ($status.success)
				C_OBJECT:C1216($mgResult)
				
				$mgResult:=mgSendRequest($request.mgTransaction)  //transaction was filled in webOnChange_WebEwires
				
				If ($mgResult.success)
					$status:=WAPI_UT_recordToObject(->[WebEWires:149]; False:C215)
					If ($status.success)
						C_OBJECT:C1216($webewire)
						$webewire:=$status.value  // entity with filled in values from webewires record
						$webewireID:=mgSendRequestCreateWebewire2($webewire; $request.mgTransaction; $mgResult; $request.CustomerID)
						$webewire.paymentInfo.mgQuoteOptions:=$request.paymentInfo.mgQuoteOptions
						
						WAPI_UT_objectToRecord($webewire; ->[WebEWires:149])  // copy values to the unsaved [webewries] record
					End if 
					
				Else   //$mgResult.success=false = send back an error
					$status.success:=False:C215
					WAPI_setAlertMessage("Error creating MoneyGram send request.<br>"+\
						Replace string:C233(mgGetSOAPErrorDetails($mgResult.mgerrormsg); Char:C90(Carriage return:K15:38); "<br>"); 4)
					$OK:=0
				End if 
				
			Else 
				//  //send back an error
				//C_OBJECT($error)
				//For each ($error;$status.errors)
				//$errText:=JSON Stringify($error)+"\n"
				//End for each 
				
				//WAPI_setAlertMessage ("Error validating MG transaction.\n\n"+$errText;4)
				
			End if 
			
		End if 
		
	End if 
	
	
	If ($status.success)
		//-- NEED KEYVALUE TO TURN ON/OFF ------- <>TODO
		// ---- WHAT ARE THE PAYMENT OPTIONS ---
		
		$tPayMethod:=[WebEWires:149]paymentInfo:35.paymentMethod
		
		Case of 
			: ($tPayMethod="paypal@")
				[WebEWires:149]paymentInfo:35.gateway:="paypal"
				[WebEWires:149]AML_Info:9[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.paypal"; "N")
				$status.success:=True:C214
				
			: ($tPayMethod="poli@")  //. --- POLIPAYMENTS
				[WebEWires:149]AML_Info:9[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.poli"; "N")
				$status:=POLI_InitiateForWebEwire
				
			: ($tPayMethod="eft@")  // --- ONLINE EFTPOS - PAYMARK/WORLDLINE
				[WebEWires:149]AML_Info:9[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.paymark"; "N")
				$status:=PMARK_initiateForWebEwire
				
			: ($tPayMethod="square@")  // --- SQUARE
				[WebEWires:149]AML_Info:9[AML_fromMOPCode]:=getKeyValue("web.customers.webewires.frommop.square"; "N")
				
				$particular:=Substring:C12([WebEWires:149]fromParty:7[Info_LastName]+" sends "+String:C10([WebEWires:149]toAmount:10)+" "+[WebEWires:149]toCCY:11+" to "+[WebEWires:149]toParty:8[Info_LastName]\
					+" Via: "+getPaymentTypeFromCode([WebEWires:149]paymentInfo:35.deliveryMethod); 1; 50)
				
				$status:=SQ_getPaymentLink(New object:C1471("idempotency_key"; [WebEWires:149]WebEwireID:1+"-"+DATE_getCurrentDTS; \
					"name"; $particular; "amount"; SQ_utilGetAmount([WebEWires:149]fromAmount:3); "currency"; [WebEWires:149]fromCCY:5))
				
				Case of 
					: ($status.success)
						[WebEWires:149]paymentInfo:35.url:=$status.url
						[WebEWires:149]paymentInfo:35.payment_link:=$status.payment_link
						[WebEWires:149]paymentInfo:35.transactionRefNo:=$status.payment_link.order_id
						[WebEWires:149]paymentInfo:35.gateway:="square"
						
					: ($status=Null:C1517)
						[WebEWires:149]paymentInfo:35.status:="Failure"
						[WebEWires:149]paymentInfo:35.statusText:="SQUARE transaction failed."
						
						$status:=New object:C1471
						$status.success:=False:C215
						$status.status:="Failure"
						$status.statusText:=[WebEWires:149]paymentInfo:35.statusText
					Else 
						[WebEWires:149]paymentInfo:35.status:=$status.status
						[WebEWires:149]paymentInfo:35.statusText:=$status.statusText
				End case 
				
				
				
				
			: ($tPayMethod="account@")
				[WebEWires:149]paymentInfo:35.gateway:="account"
				$status.success:=True:C214
				
			Else 
				[WebEWires:149]paymentInfo:35.gateway:=$tPayMethod
				$status.statusText:="NONE SET"
				$status.success:=True:C214
		End case 
		
		If ($status.success)
			[WebEWires:149]fromParty:7.geo:=UTIL_getLocationFromIp(WebClientIP).data
			[WebEWires:149]fromParty:7.userAgent:=WAPI_getParameter("userAgent")
			WAPI_sessionSet("webewire"; New object:C1471("value"; [WebEWires:149]WebEwireID:1))  //keep track that we just created
		Else   //send back an error
			WAPI_setAlertMessage("Error with payment gateway: "+$tPayMethod+" || "+$status.statusText; 4)
			$OK:=0
		End if 
		
	Else 
		$OK:=0
	End if 
	
Else   //existing already
	READ ONLY:C145([WebEWires:149])
	QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=$webewireid)
	WAPI_setAlertMessage($webewireid+" has been submitted for processing."; 1)
	$OK:=0
End if 

$0:=$OK