//%attributes = {}
// webViewCID(->table;->customerIDPtr;->agentFieldPtr; URLstring;{->relateOneField})
// this method must be called when the view form needs a context Id 

C_TEXT:C284($4; $urlString)
C_POINTER:C301($1; $2; $3; $5; $6; $tablePtr; $customerIDPtr; $agentFieldPtr; $relateOneFieldPtr; $relateOneFieldLevel2Ptr)

$tablePtr:=$1
$customerIDPtr:=$2
$agentFieldPtr:=$3
$urlString:=$4


C_TEXT:C284(searchKey; webContextID)
web_ParseURL($urlString; ->webContextID; ->searchKey)
If (webisContextAlive(webContextID))
	QUERY:C277($tablePtr->; Field:C253(Table:C252($tablePtr); 1)->=searchKey)
	//QUERY SELECTION($tablePtr->;$customerIDPtr->=webLoginID)  ` filter only the register for the right customer
	If (($customerIDPtr->#webLoginID) & ($agentFieldPtr->#webLoginID))  // ******SECURITY CHECK VERY IMPORTANT
		
		selectNone($tablePtr)
	End if 
	
	Case of 
		: (Count parameters:C259=5)
			$relateOneFieldPtr:=$5
			
			RELATE ONE:C42($relateOneFieldPtr->)
		: (Count parameters:C259=6)
			$relateOneFieldPtr:=$5
			$relateOneFieldLevel2Ptr:=$6
			
			RELATE ONE:C42($relateOneFieldPtr->)
			RELATE ONE:C42($relateOneFieldLevel2Ptr->)
	End case 
	
	If (Records in selection:C76($tablePtr->)=0)
		web_SendErrorMsg("Sorry, no record to display.")
	Else 
		SetVariablesToFields($tablePtr)
		web_SendHTMLPage($tablePtr; "View"; "CID")
	End if 
	
Else 
	web_SendContextExpiredPage
End if 

