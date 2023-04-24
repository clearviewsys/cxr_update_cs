//%attributes = {}
C_LONGINT:C283($errorCode)
C_TEXT:C284(veWireID; vSecurityCode; vCustomerID)
C_DATE:C307(vDate)
C_TEXT:C284(vSenderName)
C_TEXT:C284(vBeneficiaryName)
C_REAL:C285(vFromAmount)
C_REAL:C285(vToAmount)
C_TEXT:C284(vFromCountry)
C_TEXT:C284(vToCountry)

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
checkAddWarningOnTrue(([Customers:3]FullName:40#vBeneficiaryName); "Beneficiary Name doesn't match Customer Name")
checkAddErrorIf((vToCountry#<>COMPANYCOUNTRY); "This eWire is sent to a different country")


If (isValidationConfirmed)
	
	$errorCode:=ewr_getEwireRecord(veWireID; vSecurityCode)
	
	Case of 
			
		: ($errorCode=0)
			If (queryReceivedEWireAndReassign(veWireID; vCustomerID))
				myAlert("eWire Fetched and reassigned to "+vCustomerID)
				
				veWireID:=""
				vSecurityCode:=""
				vCustomerID:=""
				
			Else 
				myAlert("eWire couldn't be reassigned to customer!")
			End if 
			
			
			
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
			myAlert("Fetch Failed. eWire is already fetched.")
			
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
