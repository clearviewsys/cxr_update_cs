//%attributes = {}
// handleCustomerEntityCompliance
If (False:C215)
	C_PICTURE:C286(latestCheckStatus2)
End if 

C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)
C_BOOLEAN:C305($1; $isForced; $ok1)
C_TEXT:C284($2; $name)
C_POINTER:C301($3; $logIdPtr)
C_POINTER:C301($4; $resultIcon)
C_TEXT:C284($5; $query)
C_POINTER:C301($6; $resultPtr)
C_POINTER:C301($7; $resultWithoutPEPPtr)
C_LONGINT:C283($0; $result)
C_TEXT:C284($pattern)

$name:=removeEnclosingSpaces([Customers:3]CompanyName:42)
$logIdPtr:=->[Customers:3]CustomerID:1
$resultIcon:=->latestCheckStatus2
$resultPtr:=Null:C1517

Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
	: (Count parameters:C259=1)
		$isForced:=$1
	: (Count parameters:C259=2)
		$isForced:=$1
		$name:=$2
		
	: (Count parameters:C259=3)
		$isForced:=$1
		$name:=$2
		$logIdPtr:=$3
		
	: (Count parameters:C259=4)
		$isForced:=$1
		$name:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		
	: (Count parameters:C259=5)
		$isForced:=$1
		$name:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		$query:=$5
		
	: (Count parameters:C259=6)
		$isForced:=$1
		$name:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		$query:=$5
		$resultPtr:=$6
		
	: (Count parameters:C259=7)
		$isForced:=$1
		$name:=$2
		$logIdPtr:=$3
		$resultIcon:=$4
		$query:=$5
		$resultPtr:=$6
		$resultWithoutPEPPtr:=$7
	Else 
		
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

//clearPictureField (->latestCheckStatus2)

If (($name#"") & (stringHasMinimumLength($name; 4)))
	
	If (applyForSanctionListCheck)
		If ($logIdPtr=Null:C1517)
			$0:=CheckSanctionCheckListSetIcon($isForced; $name; True:C214; 0; ""; $resultIcon; $query; $resultPtr; $resultWithoutPEPPtr)
		Else 
			$0:=CheckSanctionCheckListSetIcon($isForced; $name; True:C214; Table:C252($logIdPtr); $logIdPtr->; $resultIcon; $query; $resultPtr; $resultWithoutPEPPtr)
			
			QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
			QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
		End if 
		//If ($isForced)
		//$sanctionCheckResult:=checkNameAgainstAllLists (removeEnclosingSpaces ([Customers]CompanyName);->$match;True;Table(->[Customers]);[Customers]CustomerID;True)  // Force Checking
		//Else 
		//$sanctionCheckResult:=checkNameAgainstAllLists (removeEnclosingSpaces ([Customers]CompanyName);->$match;True;Table(->[Customers]);[Customers]CustomerID)  // Use server preferences for checking 
		//End if 
		
		//  // We must make sure that sanction List checks don't apply for customers that are on Whitelist unless the Whitelisting is expired.
		
		//setSanctionCheckFields ($sanctionCheckResult)
		//SetSanctionListCheckIcon ($match;->latestCheckStatus2)
		
	End if 
	
	
	
End if 

