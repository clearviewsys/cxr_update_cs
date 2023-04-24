//%attributes = {}
#DECLARE($commandNameParam : Text)

var $commandName : Text
Case of 
	: (Count parameters:C259=1)
		$commandName:=$commandNameParam
End case 

C_TEXT:C284($result; $sanctionCheckResult)
C_LONGINT:C283($match)
$sanctionCheckResult:="Failed to connect to server"

setErrorTrap("CheckSanctionListButton"; "Something went wrong during this check")


If (stringHasMinimumLength([eWires:13]BeneficiaryFullName:5; 2))
	
	//$sanctionCheckResult:=checkNameAgainstAllLists ([eWires]BeneficiaryFullName;->$match;False;Table(->[eWires]);[eWires]eWireID)
	C_POINTER:C301($nullPtr)
	// This is in a older method
	slold_screenPerson(False:C215; [eWires:13]BeneficiaryFullName:5; ->[Wires:8]WireNo:48; New object:C1471(\
		"pointers"; New object:C1471("resultTextPtr"; ->$sanctionCheckResult)\
		))
	//handleCustomerNameCompliance(False; [eWires]BeneficiaryFullName; ->[eWires]eWireID; $nullPtr; ""; ->$sanctionCheckResult)
	//sl_checkeWiresCompliance($commandName)
	setSanctionCheckFields($sanctionCheckResult)
	[eWires:13]didCheckAgainstSanctionList:69:=True:C214
	
	appendToStringOnCondition($sanctionCheckResult#""; ->[eWires:13]sanctionCheckResultString:71; $sanctionCheckResult; True:C214)
	
	If (($match=2) | ($match=1))  // if a result is an exact match in any of the watchlist, mark it as match
		[eWires:13]didMatchWithSanctionList:70:=True:C214
		OBJECT SET ENTERABLE:C238([eWires:13]isFalsePositiveMatch:78; True:C214)
		OBJECT SET VISIBLE:C603([eWires:13]didMatchWithSanctionList:70; True:C214)
		OBJECT SET VISIBLE:C603(*; "NameisCleared"; False:C215)
	Else 
		[eWires:13]didMatchWithSanctionList:70:=False:C215
		OBJECT SET ENTERABLE:C238([eWires:13]isFalsePositiveMatch:78; False:C215)
		OBJECT SET VISIBLE:C603([eWires:13]didMatchWithSanctionList:70; False:C215)
		OBJECT SET VISIBLE:C603(*; "NameisCleared"; True:C214)  // name is cleared
		
	End if 
	
End if 

endErrorTrap
