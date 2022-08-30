//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: webGetChoiceListCountries
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option - pointer to array to fill
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label

C_TEXT:C284($context)
C_LONGINT:C283($i)

$context:=WAPI_getSession("context")

Case of 
	: ($context="customer")
		
	Else 
		ALL RECORDS:C47([FeeStructures:38])
End case 

//matchFeeRules(
ORDER BY:C49([FeeStructures:38]; [FeeStructures:38]FlatLocalFee:4; >)

For ($i; 1; Records in selection:C76([FeeStructures:38]))
	APPEND TO ARRAY:C911($1->; [FeeStructures:38]FeeStructureID:1)
	APPEND TO ARRAY:C911($2->; String:C10([FeeStructures:38]FlatLocalFee:4))
	NEXT RECORD:C51([FeeStructures:38])
End for 

//SELECTION TO ARRAY([FeeStructures]FeeStructureID;$1->)
//SELECTION TO ARRAY([FeeStructures]FlatLocalFee;$2->)  //<--- need to update web for MOPCode instead of MOP