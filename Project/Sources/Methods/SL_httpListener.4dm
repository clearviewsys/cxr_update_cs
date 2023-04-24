//%attributes = {}
C_OBJECT:C1216($paymentInfo)
C_TEXT:C284($endpoint; $1)



C_TEXT:C284($token; $source; $input; $recordId; $sanctionCheckResult)
C_OBJECT:C1216($status; $entity; $record)
C_LONGINT:C283($i; $tableNum; $nameType)

If (Count parameters:C259>=1)
	$endpoint:=$1
End if 


$status:=New object:C1471
$status.success:=False:C215

ARRAY TEXT:C222($WEB_aNames; 0)
ARRAY TEXT:C222($WEB_aValues; 0)
WEB GET VARIABLES:C683($WEB_aNames; $WEB_aValues)


//Case of 
//: ($endpoint="@object@")

$source:=WAPI_getParameter("source")

Case of 
	: ($source="sanction-oracle-id-search-input")
		
		C_OBJECT:C1216($entity)
		$entity:=New object:C1471
		
		$input:=WAPI_getParameter("sanction-oracle-id-search-input")
		
		$entity:=ds:C1482.Customers.query("LastName == :1"; Substring:C12($input; 1; 1)+"@")
		
		If ($entity.length=0)
			WAPI_pushDOMHTML("sanction-oracle-id-data"; $input+": No customer record found.")
			WAPI_pushDOMValue("sanction-oracle-id-input"; "")
		Else 
			C_COLLECTION:C1488($filter)
			$filter:=New collection:C1472(Field name:C257(->[Customers:3]LastName:4); Field name:C257(->[Customers:3]FirstName:3); Field name:C257(->[Customers:3]DOB:5))
			C_COLLECTION:C1488($col)
			$col:=New collection:C1472
			$col:=$entity.toCollection($filter; 0; 0; 1)
			
			WAPI_pushDOMHTML("sanction-oracle-id-data"; "Oracle ID: "+$input+"<hr>"+JSON Stringify:C1217($col; *))
			WAPI_pushDOMValue("sanction-oracle-id-input"; $entity.first().CustomerID)
			WAPI_pushDOMAttribute("sanction-screen-btn"; "disabled"; "")
		End if 
		
		WAPI_pushDOMHTML("sanction-oracle-id-results"; "")
		
		
	: ($source="sanction-screen-btn")
		$sanctionCheckResult:="this is the result of a sanction query"
		$recordId:=WAPI_getParameter("sanction-oracle-id-input")
		
		$entity:=ds:C1482.Customers.query("CustomerID == :1"; $recordId)
		
		C_TEXT:C284($name; $query)
		$name:=makeFullName($entity.first().FirstName; $entity.first().LastName)
		$nameType:=1
		$tableNum:=Table:C252(->[Customers:3])
		//$query:=""
		//C_POINTER($null)
		//handleCustomerNameCompliance (False;$name;->[Customers]CustomerID;$null;$query;$null;\
																		->$sanctionCheckResult)
		C_OBJECT:C1216($o)
		$o:=ds:C1482.SanctionLists.query("ShortName = :1 and IsEnabled = true"; "OFAC")
		
		//$sanctionCheckResult:=runAndViewSanctionChecks ($name;1;$col;Table(->[Customers]);$input;$_6;->$_7;$_8)
		$status:=requestAndLogSanctionListCheck($name; $nameType; $o.first(); $tableNum; $recordId)  //;->$result)
		
		WAPI_pushDOMHTML("sanction-oracle-id-results"; "<hr> "+$status.SanctionList+"<br>"+JSON Stringify:C1217($status.ResponseJSON; *))
		WAPI_pushDOMAttribute("sanction-screen-btn"; "disabled"; "disabled")
	Else 
		
End case 


WAPI_pushJs("wapiShowProcessing(false)")
WEB SEND TEXT:C677(WAPI_pullJsStack)

//Else 
//WAPI_sendFile("home.shtml"; "sanction")

//End case 