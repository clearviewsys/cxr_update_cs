//%attributes = {}


// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/19/15, 18:04:08
// ----------------------------------------------------
// Method: eWireRemoteList.bt_Sync_Receive
// Description
//      

//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($0; $errorNum)

C_POINTER:C301($NilPtr; $tablePtr)
C_BLOB:C604($blob)
C_BLOB:C604($listBlob)
C_LONGINT:C283($i; $count; $errorNum; $fieldNum; $tableNum)
C_TEXT:C284($sqlQuery; $tStatus; $tXML; $json)
C_BOOLEAN:C305($useJSON)

C_TEXT:C284(vToCountry)
C_TEXT:C284(vFromCountry)
C_DATE:C307(vToDate)
C_DATE:C307(vFromDate)
C_REAL:C285(vFromAmount; vToAmount)
C_TEXT:C284(vCurrency)
C_LONGINT:C283(vIsCancelled)

$errorNum:=0


$tableNum:=Table:C252(->[eWires:13])
$tablePtr:=->[eWires:13]


// CLEAR ARRAYS

ARRAY TEXT:C222(arreWireID; 0)
ARRAY DATE:C224(arrCreationDate; 0)
ARRAY TEXT:C222(arrBeneficiaryName; 0)
ARRAY TEXT:C222(arrFromCountry; 0)
ARRAY TEXT:C222(arrToCountry; 0)
ARRAY REAL:C219(arrFromAmount; 0)
ARRAY REAL:C219(arrToAmount; 0)
ARRAY TEXT:C222(arrCurr; 0)
ARRAY TEXT:C222(arrSecurityCode; 0)
ARRAY TEXT:C222(arrMOP; 0)
ARRAY TEXT:C222(arrInvoiceNum; 0)
ARRAY TEXT:C222(arrStatus; 0)
ARRAY BOOLEAN:C223(arrIsSettled; 0)
ARRAY BOOLEAN:C223(arrIsBankDeposit; 0)
ARRAY BOOLEAN:C223(arrIsDirectDeposit; 0)

ARRAY TEXT:C222(arrMOP; 0)
ARRAY TEXT:C222(arrStatus; 0)
ARRAY TEXT:C222(arrBeneficiaryAccount; 0)
ARRAY TEXT:C222(arrBeneficiaryBank; 0)
ARRAY TEXT:C222(arrBeneficiaryCell; 0)
ARRAY TEXT:C222(arrSenderName; 0)
ARRAY TEXT:C222(arrComments; 0)

ARRAY TEXT:C222(arrPD_BankDeposit; 3)  // pull down menus (states: 0: both; 1: True; 2: False
ARRAY TEXT:C222(arrPD_IsSettled; 3)

// ************ BUILD AN SQL QUERY IN TEXT *************
$sqlQuery:=""
//$sqlQuery:=$sqlQuery+makeSQLQuery (->[eWires];->[eWires]isCancelled;"FALSE";"=";"AND")  // should not be cancelled
$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]fromCountry:9; vFromCountry; "="; "AND")  // 
$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]toCountry:10; vToCountry; "="; "AND")
$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]creationDate:53; String:C10(vFromDate); ">="; "AND")
$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]creationDate:53; String:C10(vToDate); "<="; "AND")

// 0: either state of true or false; 1: TRUE ; 2: FALSE
// there are 9 cases to be considered (3^2) ; 00, 01, 02, 10, 11, 12, 20, 21, 22
C_LONGINT:C283($settled; $deposit)
$settled:=arrPD_IsSettled-1  // settled is 1 less than the index of the array selection
$deposit:=arrPD_BankDeposit-1  // deposit is 1 less than the selected row in the pulldown menu


Case of 
	: (($settled=0) & ($deposit=0))
		If (vIsCancelled=1)
			$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isCancelled:34; "TRUE"; "=")  // end the query with a trivial query
		Else 
			$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isCancelled:34; "FALSE"; "=")  // end the query with a trivial query
		End if 
		
	: (($settled=0) & ($deposit=1))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]doTransferToBank:33; "TRUE"; "=")
		
	: (($settled=0) & ($deposit=2))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]doTransferToBank:33; "FALSE"; "=")
		
	: (($settled=1) & ($deposit=0))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isSettled:23; "TRUE"; "=")
		
	: (($settled=1) & ($deposit=1))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isSettled:23; "TRUE"; "="; "AND")
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]doTransferToBank:33; "TRUE"; "=")
		
	: (($settled=1) & ($deposit=2))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isSettled:23; "TRUE"; "="; "AND")
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]doTransferToBank:33; "FALSE"; "=")
		
	: (($settled=2) & ($deposit=0))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isSettled:23; "FALSE"; "=")
		
	: (($settled=2) & ($deposit=1))
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isSettled:23; "FALSE"; "="; "AND")
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]doTransferToBank:33; "TRUE"; "=")
		
	: (($settled=2) & ($deposit=2))
		
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]isSettled:23; "FALSE"; "="; "AND")
		$sqlQuery:=$sqlQuery+makeSQLQuery(->[eWires:13]; ->[eWires:13]doTransferToBank:33; "FALSE"; "=")
		
	Else 
		myAlert("THIS STATE SHOULD NOT EXIST")
		
End case 

// **********  END BUILD SQL QUERY ****************




//call web service here
$listBlob:=WS_Remote_List_Load($tableNum; $sqlQuery; <>eWireServerURL; ""; ->[eWires:13]eWireID:1; ->[eWires:13]creationDate:53; \
->[eWires:13]BeneficiaryFullName:5; ->[eWires:13]fromCountry:9; ->[eWires:13]toCountry:10; ->[eWires:13]FromAmount:13; ->[eWires:13]ToAmount:14; \
->[eWires:13]Currency:12; ->[eWires:13]isSettled:23; ->[eWires:13]doTransferToBank:33; ->[eWires:13]securityChallengeCode:75; ->[eWires:13]toMOP:116; \
->[eWires:13]Status:22; ->[eWires:13]BeneficiaryBankName:76; ->[eWires:13]BeneficiaryBankAccountNo:66; ->[eWires:13]SenderName:7; \
->[eWires:13]BeneficiaryCellPhone:61; ->[eWires:13]comments_Visible:48)

//$listBlob:=WS_Remote_List_Load ($tableNum;$sqlQuery;"http://127.0.0.1:8080";"";->[eWires]eWireID;->[eWires]creationDate;->[eWires]BeneficiaryFullName;->[eWires]fromCountry;->[eWires]toCountry;->[eWires]FromAmount;->[eWires]ToAmount;->[eWires]Currency;->[eWires]isSettled)

//$listBlob:=WS_Remote_List_Load ($tableNum;$sqlQuery;"http://209.208.78.30:8080";"";->[eWires]eWireID;->[eWires]creationDate;->[eWires]BeneficiaryFullName;->[eWires]fromCountry;->[eWires]toCountry;->[eWires]FromAmount;->[eWires]ToAmount;->[eWires]Currency;->[eWires]isSettled)



If (BLOB size:C605($listBlob)>0)
	
	ARRAY TEXT:C222($atItemList; 0)
	
	$tXML:=XB_BlobToBag($listBlob)
	
	//XB_ViewBags ($tXML)` for debugging
	
	$tStatus:=XB_GetText($tXML; "requestStatus")
	
	Case of 
		: ($tStatus="SUCCESS")
			$useJSON:=XB_GetBoolean($tXML; "requestJSON")
			$count:=XB_ItemCount($tXML; "DataList")  //that number of fields that were requested
			
			XB_GetAllItems($tXML; ->$atItemList)  //for testing
			
			// ******** FILL THE LISTBOX ARRAYS WITH THE DATA RETURNED ***********
			// data is returned in the same order it was requested above in WS_Remote_List_Load
			
			If ($useJSON)
				$json:=XB_GetText($tXML; "DataList.List1")
				JSON PARSE ARRAY:C1219($json; arreWireID)
				$json:=XB_GetText($tXML; "DataList.List2")
				JSON PARSE ARRAY:C1219($json; arrCreationDate)
				$json:=XB_GetText($tXML; "DataList.List3")
				JSON PARSE ARRAY:C1219($json; arrBeneficiaryName)
				$json:=XB_GetText($tXML; "DataList.List4")
				JSON PARSE ARRAY:C1219($json; arrFromCountry)
				$json:=XB_GetText($tXML; "DataList.List5")
				JSON PARSE ARRAY:C1219($json; arrToCountry)
				$json:=XB_GetText($tXML; "DataList.List6")
				JSON PARSE ARRAY:C1219($json; arrFromAmount)
				$json:=XB_GetText($tXML; "DataList.List7")
				JSON PARSE ARRAY:C1219($json; arrToAmount)
				$json:=XB_GetText($tXML; "DataList.List8")
				JSON PARSE ARRAY:C1219($json; arrCurr)
				$json:=XB_GetText($tXML; "DataList.List9")
				JSON PARSE ARRAY:C1219($json; arrIsSettled)
				$json:=XB_GetText($tXML; "DataList.List10")
				JSON PARSE ARRAY:C1219($json; arrIsDirectDeposit)
				$json:=XB_GetText($tXML; "DataList.List11")
				JSON PARSE ARRAY:C1219($json; arrSecurityCode)
				
				If ($count>=12)
					$json:=XB_GetText($tXML; "DataList.List12")
					JSON PARSE ARRAY:C1219($json; arrMOP)
				End if 
				
				If ($count>=13)
					$json:=XB_GetText($tXML; "DataList.List13")
					JSON PARSE ARRAY:C1219($json; arrStatus)
				End if 
				
				If ($count>=14)
					$json:=XB_GetText($tXML; "DataList.List15")
					JSON PARSE ARRAY:C1219($json; arrBeneficiaryBank)
				End if 
				
				If ($count>=15)
					$json:=XB_GetText($tXML; "DataList.List15")
					JSON PARSE ARRAY:C1219($json; arrBeneficiaryAccount)
				End if 
				
				If ($count>=16)
					$json:=XB_GetText($tXML; "DataList.List16")
					JSON PARSE ARRAY:C1219($json; arrSenderName)
				End if 
				If ($count>=17)
					$json:=XB_GetText($tXML; "DataList.List17")
					JSON PARSE ARRAY:C1219($json; arrBeneficiaryCell)
				End if 
				If ($count>=18)
					$json:=XB_GetText($tXML; "DataList.List18")
					JSON PARSE ARRAY:C1219($json; arrComments)
				End if 
				
			Else 
				XB_GetVariable($tXML; "DataList.List1"; ->arreWireID)
				XB_GetVariable($tXML; "DataList.List2"; ->arrCreationDate)
				XB_GetVariable($tXML; "DataList.List3"; ->arrBeneficiaryName)
				XB_GetVariable($tXML; "DataList.List4"; ->arrFromCountry)
				XB_GetVariable($tXML; "DataList.List5"; ->arrToCountry)
				XB_GetVariable($tXML; "DataList.List6"; ->arrFromAmount)
				XB_GetVariable($tXML; "DataList.List7"; ->arrToAmount)
				XB_GetVariable($tXML; "DataList.List8"; ->arrCurr)
				XB_GetVariable($tXML; "DataList.List9"; ->arrIsSettled)
				XB_GetVariable($tXML; "DataList.List10"; ->arrIsDirectDeposit)
				XB_GetVariable($tXML; "DataList.List11"; ->arrSecurityCode)
				XB_GetVariable($tXML; "DataList.List12"; ->arrMOP)
				XB_GetVariable($tXML; "DataList.List13"; ->arrStatus)
				
				XB_GetVariable($tXML; "DataList.List14"; ->arrBeneficiaryBank)
				XB_GetVariable($tXML; "DataList.List15"; ->arrBeneficiaryAccount)
				
				XB_GetVariable($tXML; "DataList.List16"; ->arrSenderName)
				XB_GetVariable($tXML; "DataList.List17"; ->arrBeneficiaryCell)
				XB_GetVariable($tXML; "DataList.List18"; ->arrComments)
			End if 
			
			
			
		: ($tStatus="FAIL-SECURITY@")
			$errorNum:=-1
			myAlert("Fail - Security")
			//LOG HERE?
			
		: ($tStatus="FAIL-NO RECORDS FOUND@") | ($tStatus="FAIL-NOT FOUND@")
			$errorNum:=-2
			//LOG HERE?
			myAlert("Fail - No Records Found")
			
		Else 
			$errorNum:=-6
			//LOG HERE?
			myAlert("Fail - Unknown Error: "+$tStatus)
			
	End case 
	
	XB_Clear($tXML)
	
End if 

If ($errorNum=0)
	C_POINTER:C301($ptr)
	
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "eWire_UpdateNotes")
	
	If (Is nil pointer:C315($ptr))
	Else 
		$ptr->:="Updated: "+String:C10(Current date:C33)+" at "+String:C10(Current time:C178)
	End if 
Else 
	UTIL_Log(Table name:C256($tablePtr); "LIST ERROR: "+String:C10($errorNum)+" "+$tStatus+" "+Table name:C256($tablePtr)+" "+$sqlQuery)
End if 


$0:=$errorNum