//%attributes = {}
// pickAccounts(self; {"queryCommandName"};{request description string}; {forceDialog})
// ex : pickAccounts

C_POINTER:C301($1; $self)
C_TEXT:C284($2; vQueryAccountsCommand; $3)
C_BOOLEAN:C305($4; $forceDialog)
$forceDialog:=False:C215

Case of 
		
	: (Count parameters:C259=1)
		$self:=$1
		vQueryAccountsCommand:=""
		
	: (Count parameters:C259=2)
		$self:=$1
		vQueryAccountsCommand:=$2
		
	: (Count parameters:C259=3)
		$self:=$1
		vQueryAccountsCommand:=$2
		setRequestString($3)
		
	: (Count parameters:C259=4)
		$self:=$1
		vQueryAccountsCommand:=$2
		setRequestString($3)
		$forceDialog:=$4
	Else 
		
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

If (vQueryAccountsCommand="")
	allRecordsAccounts
Else 
	EXECUTE FORMULA:C63(vQueryAccountsCommand)  // not sure if this is the right thing -- 5/22/18 IBB changed from method
End if 

pickRecordForTable(->[Accounts:9]; ->[Accounts:9]AccountID:1; $self; True:C214; $forceDialog)
setRequestString("")
