//%attributes = {}
// setSanctionCheckFields ($result)
// e.g. setSanctionCheckFields ($SanctionCheckResult)
// PRE: Customer records must be loaded and ready to be changed
// POST: The customer AML fields will be affected


C_TEXT:C284($SanctionCheckResult; $1)
C_LONGINT:C283($match)

Case of 
		
	: (Count parameters:C259=1)
		$SanctionCheckResult:=$1
		$match:=getMatchType($SanctionCheckResult)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


Case of 
	: ($match=2)  // Exact match
		
		$SanctionCheckResult:="CHECKING IN SANCTION LISTS FAILED."+CRLF+"Checked by "+getApplicationUser+" on "+String:C10(Current date:C33)+CRLF+$SanctionCheckResult
		[Customers:3]isOnHold:52:=True:C214
		[Customers:3]AML_RiskRating:75:=5
		[Customers:3]AML_isSuspicious:49:=True:C214
		[Customers:3]AML_hasPositiveMatchOnSL:92:=True:C214
		[Customers:3]AML_LastSanctionListCheckDate:99:=Current date:C33(*)
		myAlert($sanctionCheckResult; "AML WARNING: This name matches with a name on a sanction list.")
		
	: ($match=1)  // NO exact match
		
		$SanctionCheckResult:="CHECKING IN SANCTION LISTS FAILED."+CRLF+"Checked by "+getApplicationUser+" on "+String:C10(Current date:C33)+CRLF+$SanctionCheckResult
		[Customers:3]AML_hasPositiveMatchOnSL:92:=True:C214
		[Customers:3]AML_LastSanctionListCheckDate:99:=Current date:C33(*)
		myAlert($SanctionCheckResult; "AML WARNING: This name possible matches with a name on a sanction list.")
		
	: ($match=0)  // No in sanction Lists
		
		$SanctionCheckResult:="CHECKING IN SANCTION LISTS PASSED. Checked by "+getApplicationUser+" on "+String:C10(Current date:C33)
		[Customers:3]AML_hasPositiveMatchOnSL:92:=False:C215
		[Customers:3]AML_LastSanctionListCheckDate:99:=Current date:C33(*)
		
	: ($match=-1)  // The system could not check the sanction List
		$SanctionCheckResult:="CHECKING IN SANCTION LISTS FAILED. The system could not check on the sanction List. System error"
		myAlert($SanctionCheckResult; "System Error")
End case 



