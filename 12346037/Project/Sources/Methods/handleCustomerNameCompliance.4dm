//%attributes = {}
// [AccountInOuts]  // handleCustomerNameCompliance
// $isForce    check no matter what or check only as server prefs
// $fullname   name of customer
// $logIdPtr   the id field ie. [Customer]CustomerId
// $resultIcon result icon
// $query      if not for all (not usuable for Version 1)
// $resultPtr  the pointer to store result string

// Edited by: Wai-Kin Chau

C_TEXT:C284($sanctionCheckResult; $fullName; $tip)
C_LONGINT:C283($match)
C_BOOLEAN:C305($1; $isForced)
C_TEXT:C284($2; $fullName)
C_POINTER:C301($3; $logIdPtr)
C_POINTER:C301($4; $resultIcon)
C_TEXT:C284($5; $query)
C_POINTER:C301($6; $resultPtr)
C_LONGINT:C283($0; $match)
C_POINTER:C301($7; $resultWithoutPEP)
$logIdPtr:=->[Customers:3]CustomerID:1
$resultIcon:=->latestCheckStatus1
$query:=""

$fullName:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
		
	: (Count parameters:C259=1)
		$isForced:=$1
		
	: (Count parameters:C259=2)
		$isForced:=$1
		$fullName:=$2
		
	: (Count parameters:C259=3)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		
	: (Count parameters:C259=4)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		
	: (Count parameters:C259=5)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		$query:=$5
		
	: (Count parameters:C259=6)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		$query:=$5
		$resultPtr:=$6
		
	: (Count parameters:C259=7)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		$query:=$5
		$resultPtr:=$6
		$resultWithoutPEP:=$7
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//$tip:=""
//clearPictureField ($resultIcon)
//OBJECT SET HELP TIP(*;"latestCheckStatus1";$tip)

If (stringHasMinimumLength($fullName; 3))
	
	// We must make sure that sanction List checks don't apply for customers that are on Whitelist unless the Whitelisting is expired.
	If (applyForSanctionListCheck)
		
		If ($logIdPtr=Null:C1517)
			$0:=CheckSanctionCheckListSetIcon($isForced; $fullName; False:C215; 0; ""; $resultIcon; $query; $resultPtr; $resultWithoutPEP)
		Else 
			$0:=CheckSanctionCheckListSetIcon($isForced; $fullName; False:C215; Table:C252($logIdPtr); $logIdPtr->; $resultIcon; $query; $resultPtr; $resultWithoutPEP)
			
			QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
			QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
			
		End if 
	End if 
	
End if 

