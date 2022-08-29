//%attributes = {}
C_LONGINT:C283($errorCode)
C_TEXT:C284(veWireID; vSecurityCode; vCustomerID)
C_DATE:C307(vDate)
C_TEXT:C284(vSenderName)
C_TEXT:C284(vBeneficiaryName)
C_REAL:C285(vFromAmount)
C_REAL:C285(vToAmount)
C_TEXT:C284(vFromCountryCode)
C_TEXT:C284(vToCountryCode)

C_TEXT:C284(vCurrency)
C_BOOLEAN:C305(vIsSettled)
C_TEXT:C284(vComments)
C_BOOLEAN:C305(vIsFetched)
C_DATE:C307(vFetchDate)
C_TEXT:C284(vFetchLocation)

checkInit
checkIfNullString(->veWireID; "eWire ID")
checkIfNullString(->vSecurityCode; "Security Code")
checkIfNullString(->vCustomerID; "Customer ID")
checkAddWarningOnTrue(([Customers:3]FullName:40#vBeneficiaryName); "Beneficiary Name doesn't match Customer Name. Please double check!")
checkAddErrorIf((vToCountryCode#<>countrycode); "This eWire is sent to "+getCountryNameByCode(vToCountryCode))
checkAddWarning("Once the eWire is fetched, it cannot be unfetched!")

If (isValidationConfirmed)
	
	$errorCode:=ewr_getEwireRecord(veWireID; vSecurityCode)
	
	Case of 
			
		: ($errorCode=0)
			READ WRITE:C146([eWires:13])  //5/12/21
			QUERY:C277([eWires:13]; [eWires:13]eWireID:1=veWireID)
			
			If (Records in selection:C76([eWires:13])=1)
				myAlert("eWire Fetched Successfuly!")
				
				[eWires:13]FromAmount:13:=[eWires:13]ToAmount:14  // switching fromAmount to ToAmount
				[eWires:13]FromCurrency:11:=[eWires:13]Currency:12  // we are not switching 
				[eWires:13]ToAmount:14:=0
				[eWires:13]isPaymentSent:20:=False:C215  // eWire Received
				[eWires:13]customerID_origin:84:=[eWires:13]CustomerID:15
				[eWires:13]invoiceID_origin:86:=[eWires:13]InvoiceNumber:29
				[eWires:13]linkID_origin:85:=[eWires:13]LinkID:8
				[eWires:13]registerID_origin:91:=[eWires:13]RegisterID:24
				
				[eWires:13]RegisterID:24:=""
				[eWires:13]LinkID:8:=""
				[eWires:13]InvoiceNumber:29:=""
				
				
				ASSERT:C1129(vCustomerID#""; "CustomerID didn't pick correctly")
				If (Find in field:C653([Customers:3]CustomerID:1; vCustomerID)<0)
					ASSERT:C1129(vCustomerID#""; "CustomerID didn't pick correctly")
				End if 
				[eWires:13]CustomerID:15:=vCustomerID
				
				// this is very important because the value of the amountLocal should change to the destnation country rate
				// for example if eWire is sent from Fiji to NZ, the original amountLocal is in FJD/NZD but in destination
				// the amount local should be calculated based on NZD/NZD which is 1
				C_REAL:C285($rate)
				$rate:=getCurrencyRate([eWires:13]Currency:12)
				[eWires:13]amountLocal:45:=[eWires:13]FromAmount:13*$rate  // recalculate the amountLocal based on the value of receiving country
				
				SAVE RECORD:C53([eWires:13])
				
				setNextCustomer(vCustomerID)
				newRecordInvoices
			Else 
				myAlert("Fetch failed. eWire not created locally.")
			End if 
			
			UNLOAD RECORD:C212([eWires:13])
			READ ONLY:C145([eWires:13])
			LOAD RECORD:C52([eWires:13])  //1/11/21
			
			veWireID:=""
			vSecurityCode:=""
			vCustomerID:=""
			
		: ($errorCode=-1)
			myAlert("Incorrect Security Code")
		: ($errorCode=-2)
			myAlert("eWire ID is not available on the server")
			
		: ($errorCode=-3)
			myAlert("Multiple eWires found with the same ID.")
			
		: ($errorCode=-4)
			myAlert("Could not retreive eWire")
			
		: ($errorCode=-5)
			myAlert("This eWire was previously fetched and cannot be fetched again.")
			
		: ($errorCode=-6)
			myAlert("Something went wrong during fetch.")
			
		: ($errorCode=-20)
			myAlert("Fetch Failed. eWire is already fetched")
			
		: ($errorCode=-21)
			myAlert("Fetch Failed. This eWire has been already settled!")
			
		: ($errorCode=-22)
			myAlert("Fetch Failed. This eWire has been Cancelled!")
			
			
		Else 
			myAlert("Unknown ERROR Code:"+String:C10($errorCode))
			
			
	End case 
	
Else 
	REJECT:C38
	
End if 
