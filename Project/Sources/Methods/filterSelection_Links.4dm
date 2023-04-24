//%attributes = {}

C_TEXT:C284($1; $tEvent)
C_POINTER:C301($2; $ptrNameArray)
C_POINTER:C301($3; $ptrValueArray)
C_TEXT:C284($tTable; $tPrimKey; $tLinkID)

$tEvent:=$1

If (Count parameters:C259>=2)
	$ptrNameArray:=$2
Else 
	
End if 

If (Count parameters:C259>=3)
	$ptrValueArray:=$3
Else 
	
End if 


//get session id and determine user

//query selection... as needed

C_TEXT:C284($tContext)
$tContext:=webContext



Case of 
	: ($tContext="customer@")
		//problay need to verify we have the correct customer
		webSelectCustomerRecord
		
		
		If (Records in selection:C76([Customers:3])=1)
			QUERY SELECTION:C341([Links:17]; [Links:17]CustomerID:14=[Customers:3]CustomerID:1)
		Else 
			REDUCE SELECTION:C351([Links:17]; 0)
		End if 
		
		
	: ($tContext="agent@")
		webSelectAgentRecord
		
		If (Records in selection:C76([Agents:22])=1)
			
			If ($tEvent="@getList@")
				
				$tTable:=WAPI_getParameter("table")  //;$ptrNameArray;$ptrValueArray)
				$tPrimKey:=WAPI_getParameter("primarykey")  //;$ptrNameArray;$ptrValueArray)
				
				Case of 
					: ($tTable=Table name:C256(->[Links:17])) & ($tPrimKey=WAPI_getInputControlID(->[Links:17]LinkID:1))  //in a link detail 
						$tLinkID:=WAPI_getParameter($tPrimKey)  //;$ptrNameArray;$ptrValueArray)
						QUERY:C277([Links:17]; [Links:17]sameAsLinkID:52=$tLinkID)
						QUERY SELECTION:C341([Links:17]; [Links:17]CustomerID:14#"")
						
					Else 
						QUERY SELECTION:C341([Links:17]; [Links:17]countryCode:50=[Agents:22]CountryCode:21)
						QUERY SELECTION BY FORMULA:C207([Links:17]; [Links:17]sameAsLinkID:52=[Links:17]LinkID:1)  //only the primary links
				End case 
				
				
			Else 
				
			End if 
			
		Else 
			REDUCE SELECTION:C351([Links:17]; 0)
		End if 
		
		
	Else 
		REDUCE SELECTION:C351([Links:17]; 0)
		
End case 