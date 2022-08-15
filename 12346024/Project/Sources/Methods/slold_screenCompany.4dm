//%attributes = {}
// handleCustomerEntityCompliance
// $isForce    check no matter what or check only as server prefs
// $fullname   name of customer
// $logIdPtr   the id field ie. [Customer]CustomerId
// $resultIcon result icon
// $options    list of options see sl_createDefaultOptionsObject
// $resultPtr  the pointer to store result string
// Author by: Wai-Kin Chau

C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)
C_BOOLEAN:C305($1; $isForced)
C_TEXT:C284($2; $name)
C_POINTER:C301($3; $logIdPtr; $resultIcon)
C_LONGINT:C283($0; $match)
C_OBJECT:C1216($4; $options)
$logIdPtr:=->[Customers:3]CustomerID:1
$resultIcon:=->latestCheckStatus1
C_TEXT:C284($resultText; $query)
$resultText:=""
$query:=""

$name:=removeEnclosingSpaces([Customers:3]CompanyName:42)
$logIdPtr:=->[Customers:3]CustomerID:1

$options:=sl_createDefaultOptionsObject($isForced)

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
		$options:=utils_setupObjectProperties($options; $4)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//clearPictureField (->latestCheckStatus2)

//C_TEXT($resultWithoutPEP)
//$resultWithoutPEP:=""


var $runCheck : Boolean

$runCheck:=($isForced | <>doCheckSanctionLists)
If ($runCheck)
	$runCheck:=stringHasMinimumLength($name; 4)
End if 


If ($runCheck)
	If ($logIdPtr#Null:C1517)
		$runCheck:=sl_isCustomerSubjectToScreening($logIdPtr->)
	End if 
End if 

If ($runCheck)
	
	//If ($logIdPtr=Null)
	//$0:=CheckSanctionCheckListSetIcon($isForced; $name; True; 0; ""; \
																								$options.pointers.resultIconPtr; \
																								$options.options.list; \
																								$options.pointers.resultTextPtr; ->$resultWithoutPEP; \
																								$options.options.autoList; \
																								$options.options.interface)
	//Else
	//$0:=CheckSanctionCheckListSetIcon($isForced; $name; True; Table($logIdPtr); $logIdPtr->; \
																								$options.pointers.resultIconPtr; \
																								$options.options.list; \
																								$options.pointers.resultTextPtr; ->$resultWithoutPEP; \
																								$options.options.autoList; \
																								$options.options.interface; \
																								$logIdPtr)
	//If ($options.options.ignorePEP)
	//$options.pointers.resultTextPtr->:=$resultWithoutPEP
	//End if
	
	var $data : Collection
	$data:=slold_pickSanctionCheckLists($name; True:C214; $logIdPtr; $options)
	$0:=slo_displaySanctionListResult(\
		ds:C1482.SanctionCheckLog.fromCollection($data); \
		$options.options.interface; $options.pointers.resultIconPtr; \
		$options.pointers.resultTextPtr; $logIdPtr)
	
	//$0:=sl_chooseSanctionCheckMethod($name; True; $logIdPtr; $options)
	
	If ($options.option.comfirmReject)
		If (($0#0) & ($0#-2))
			myConfirm("Sanction check produces a match. Do you want to fix the issue?"; "Ignore and continue"; "Return and Edit")
			If (OK#1)
				REJECT:C38
			End if 
		End if 
	End if 
	If ($logIdPtr#Null:C1517)
		QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
		QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
	End if 
	
End if 