//%attributes = {}
// pickSubAccounts(self; accountID; {forceDialog})
// ex : pickAccounts

C_POINTER:C301($1; $self)
C_TEXT:C284($2; $accountID; vAccountID)
C_BOOLEAN:C305($3; $forceDialog)
C_TEXT:C284($subaccount; vAccountID_pick)

Case of 
		
	: (Count parameters:C259=0)
		$self:=->$subaccount
		$accountID:="Account-USD"
		$forceDialog:=True:C214  // open it for testing
		
	: (Count parameters:C259=1)
		$self:=$1
		$accountID:=""
		$forceDialog:=False:C215
		
	: (Count parameters:C259=2)
		$self:=$1
		$accountID:=$2
		$forceDialog:=False:C215
		
	: (Count parameters:C259=3)
		$self:=$1
		$accountID:=$2
		$forceDialog:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

vAccountID_pick:=$accountID
//selectSubAccountsByVAccountID 

pickRecordForTable(->[SubAccounts:112]; ->[SubAccounts:112]SubAccountID:2; $self; True:C214; $forceDialog)
setRequestString("")

