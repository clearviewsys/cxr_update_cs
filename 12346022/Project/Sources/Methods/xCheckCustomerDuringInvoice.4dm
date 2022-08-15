//%attributes = {}


C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)

C_BOOLEAN:C305($ready; $isReadOnly)

$ready:=<>doCheckSanctionLists & Is new record:C668([Invoices:5])

var $option : Object
$option:=New object:C1471("pointers"; New object:C1471("resultTextPtr"; ->$sanctionCheckResult))
If ($ready)
	
	$isReadOnly:=Read only state:C362([Customers:3])  //1/11/21 IBB
	sl_handleInvoiceScreening(sl_ForAutoCall; $option)
	
	//If ([Customers]isInsider=False)  // only check non-self companies
	//If (getKeyValue ("sanctionlist.version";"v2")="v1")
	//$sanctionCheckResult:=checkNameAgainstAllLists ([Customers]CompanyName;->$match;True;Table(->[Customers]);[Customers]CustomerID)
	//Else
	
	//C_OBJECT($inputs)
	//$inputs:=New object
	//$inputs.name:=[Customers]CompanyName
	//$inputs.isEntity:=True
	//$inputs.internalTableId:=Table(->[Customers])
	//$inputs.internalRecordId:=[Customers]CustomerID
	//$list:=ds.SanctionLists.query("IsEnabled = True").ShortName
	//$sanctionCheckResult:=checkInputToSanctionLists ($inputs;$list;->$match;False)
	//End if
	
	//C_TEXT($name; $query)
	//$name:=[Customers]CompanyName
	//$query:=""
	//C_POINTER($null)
	////handleCustomerEntityCompliance(False;$name;->[Customers]CustomerID;$null;$query;$null;->$sanctionCheckResult)
	//sl_handleCompanyNameCompliance(False; $name; ->[Customers]CustomerID; $data)
	//End if
	
	//Else   // else customer is not a company
	
	//If (Not(isCustomerSelfOrWalkIn([Customers]CustomerID)))
	
	//If (getKeyValue ("sanctionlist.version";"v2")="v1")
	//$name:=[Customers]FirstName+" "+[Customers]LastName
	//$sanctionCheckResult:=checkNameAgainstAllLists ($name;->$match;False;Table(->[Customers]);[Customers]CustomerID)
	//Else
	//C_OBJECT($inputs)
	//$inputs:=New object
	//$inputs.name:=makeFullName ([Customers]FirstName;[Customers]LastName)
	//$inputs.isEntity:=False
	//$inputs.internalTableId:=Table(->[Customers])
	//$inputs.internalRecordId:=[Customers]CustomerID
	//$list:=ds.SanctionLists.query("IsEnabled = True").ShortName
	//$sanctionCheckResult:=checkInputToSanctionLists ($inputs;$list;->$match;True)
	
	//End if
	//C_TEXT($name; $query)
	//$name:=makeFullName([Customers]FirstName; [Customers]LastName)
	//$query:=""
	//C_POINTER($null)
	//handleCustomerNameCompliance(False;$name;->[Customers]CustomerID;$null;$query;$null;\
								->$sanctionCheckResult)
	
	//sl_handlePersonNameCompliance(False; $name; ->[Customers]CustomerID; $data)
	//End if
	
	
	//End if
	//$sanctionCheckResult:=$output.matches
	
	
	[Invoices:5]didCheckSanctionList:69:=True:C214
	
	If ($sanctionCheckResult#"")
		READ WRITE:C146([Customers:3])
		LOAD RECORD:C52([Customers:3])
		
		setSanctionCheckFields($sanctionCheckResult)
		
		SAVE RECORD:C53([Customers:3])
		//READ ONLY([Customers])
		[Invoices:5]isCustomerSanctioned:70:=True:C214
		[Invoices:5]sanctionCheckResultString:72:=$sanctionCheckResult
	Else 
		// this else statement was added to make sure the date stamp for the customer last
		// check on the sanction list gets updated
		// by Tiran on August 13, 2014; Version 4.080
		
		READ WRITE:C146([Customers:3])
		LOAD RECORD:C52([Customers:3])
		[Customers:3]AML_LastSanctionListCheckDate:99:=Current date:C33
		SAVE RECORD:C53([Customers:3])
		//READ ONLY([Customers])
		
	End if 
	
	
	If ($isReadOnly) & (Read only state:C362([Customers:3])=False:C215)
		UNLOAD RECORD:C212([Customers:3])
		READ ONLY:C145([Customers:3])
		LOAD RECORD:C52([Customers:3])
	End if 
	
	
Else 
	[Invoices:5]didCheckSanctionList:69:=False:C215
	
End if 
