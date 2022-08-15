//%attributes = {}

C_TEXT:C284($1; $tEvent)
C_POINTER:C301($2; $ptrNameArray)
C_POINTER:C301($3; $ptrValueArray)

$tEvent:=$1

If (Count parameters:C259>=2)
	$ptrNameArray:=$2
Else 
	
End if 

If (Count parameters:C259>=3)
	$ptrValueArray:=$3
Else 
	
End if 


C_TEXT:C284(wapi_filter)
C_LONGINT:C283($iElem)
C_TEXT:C284($Filter)

$iElem:=Find in array:C230($ptrNameArray->; "wapi_filter")
If ($iElem>0)
	$Filter:=$ptrValueArray->{$iElem}
Else 
	$Filter:=""
End if 
C_TEXT:C284($tTable; $tPrimKey; $tLinkID)
C_TEXT:C284($pqFilter)
$pqFilter:=WAPI_getParameter("pq_filter"; $ptrNameArray; $ptrValueArray)  //->WEB_aNames;->WEB_aValues)

//get session id and determine user-

//query selection... as needed

Case of 
	: (webContext="customers")
		//problay need to verify we have the correct customer
		webSelectCustomerRecord
		
		If (Records in selection:C76([Customers:3])=1)
			QUERY SELECTION:C341([eWires:13]; [eWires:13]CustomerID:15=[Customers:3]CustomerID:1; *)
			
			Case of 
				: ($Filter="received-pending")
					QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)
					
				: ($Filter="received-settled")
					QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isSettled:23=True:C214; *)
					
				: ($Filter="sent-pending")
					QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isSettled:23=False:C215; *)
					
				: ($Filter="sent-settled")
					QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]isSettled:23=True:C214; *)
					
				Else 
					//QUERY SELECTION([eWires]; & ;[eWires]UUID="X";*)  //return nothing
			End case 
			
			QUERY:C277([eWires:13])
			
		Else 
			REDUCE SELECTION:C351([eWires:13]; 0)
		End if 
		
	: (webContext="agents")
		webSelectAgentRecord
		
		C_TEXT:C284($tAgentCountryCode; $tAgentID)
		$tAgentID:=[Agents:22]AgentID:1
		$tAgentCountryCode:=[Agents:22]CountryCode:21
		
		If (Records in selection:C76([Agents:22])=1)
			
			$tTable:=WAPI_getParameter("table")  //;$ptrNameArray;$ptrValueArray)
			If ($tTable="")
				$tTable:=WAPI_getParameter("pq_table")  //;$ptrNameArray;$ptrValueArray)
			End if 
			
			$tPrimKey:=WAPI_getParameter("primarykey")  //;$ptrNameArray;$ptrValueArray)
			
			Case of 
				: ($tTable=Table name:C256(->[eWires:13])) & ($tEvent="getlist")  //12/26/19
					//use filter that is passed in
					
				: ($tTable=Table name:C256(->[eWires:13]))
					//QUERY SELECTION([eWires];[eWires]AgentID="";*)
					//QUERY SELECTION([eWires]; | ;[eWires]AgentID=$tAgentID)
					
					
				: ($tTable=Table name:C256(->[Links:17])) & ($tPrimKey=WAPI_getInputControlID(->[Links:17]LinkID:1))  //in a link detail 
					$tLinkID:=WAPI_getParameter($tPrimKey; $ptrNameArray; $ptrValueArray)
					QUERY:C277([eWires:13]; [eWires:13]LinkID:8=$tLinkID)  //get ewires related to this link
					
				: ($pqFilter="")  //no query has been speciifed
					REDUCE SELECTION:C351([eWires:13]; 0)
					
				Else 
					QUERY SELECTION:C341([eWires:13]; [eWires:13]AgentID:26=$tAgentID)
			End case 
			
			//QUERY SELECTION([eWires])
			
		Else 
			REDUCE SELECTION:C351([eWires:13]; 0)
		End if 
		
		
	Else 
		REDUCE SELECTION:C351([eWires:13]; 0)
End case 