//%attributes = {}
// createRecordKYC_ReviewLog (customer; description)

C_TEXT:C284($customerID; $1)
C_TEXT:C284($description; $2)
C_LONGINT:C283($isPictureIDOK; $isGeneralInfoOK; $isAddressOK; $isOccupationOK; $3; $4; $5; $6)
C_LONGINT:C283($isAllOK; $7)


Case of 
	: (Count parameters:C259=0)
		pickCustomer(->$customerID)  // pick a customer
		$description:="test"
		
	: (Count parameters:C259=1)
		$customerID:=$1
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$description:=$2
		
	: (Count parameters:C259=7)
		$customerID:=$1
		$description:=$2
		$isOccupationOK:=$3
		$isGeneralInfoOK:=$4
		$isPictureIDOK:=$5
		$isAddressOK:=$6
		$isAllOK:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129($customerID#""; "Customer ID cannot be blank")

READ WRITE:C146([KYC_ReviewLog:124])
CREATE RECORD:C68([KYC_ReviewLog:124])
[KYC_ReviewLog:124]CustomerID:2:=$customerID
[KYC_ReviewLog:124]ReviewDate:3:=Current date:C33
[KYC_ReviewLog:124]ReviewerID:4:=getApplicationUser
[KYC_ReviewLog:124]Notes:5:=$description

[KYC_ReviewLog:124]isOccupationChecked:9:=$isOccupationOK
[KYC_ReviewLog:124]isGeneralInfoChecked:11:=$isGeneralInfoOK
[KYC_ReviewLog:124]isPictureIDChecked:8:=$isPictureIDOK
[KYC_ReviewLog:124]isAddressChecked:10:=$isAddressOK
[KYC_ReviewLog:124]isAllOkay:12:=numToBoolean($isAllOK)  // 


SAVE RECORD:C53([KYC_ReviewLog:124])
UNLOAD RECORD:C212([KYC_ReviewLog:124])
READ ONLY:C145([KYC_ReviewLog:124])