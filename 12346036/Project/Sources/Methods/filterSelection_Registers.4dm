//%attributes = {}

C_TEXT:C284(wapi_filter)

C_LONGINT:C283($iElem)
C_TEXT:C284($Filter)
$iElem:=Find in array:C230(WEB_aNames; "wapi_filter")
If ($iElem>0)
	$Filter:=WEB_aValues{$iElem}
Else 
	$Filter:=""
End if 

// convert from ewires to registers <>TODO

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
		
		
		If (Records in selection:C76([Agents:22])=1)
			//QUERY SELECTION([eWires];[eWires]AgentID=[Agents]AgentID;*)
			//
			//Case of 
			//: ($Filter="received-pending")
			//QUERY SELECTION([eWires]; & ;[eWires]isSettled=False;*)
			//
			//: ($Filter="received-settled")
			//QUERY SELECTION([eWires]; & ;[eWires]isSettled=True;*)
			//
			//: ($Filter="sent-pending")
			//QUERY SELECTION([eWires]; & ;[eWires]isSettled=False;*)
			//
			//: ($Filter="sent-settled")
			//QUERY SELECTION([eWires]; & ;[eWires]isSettled=True;*)
			//
			//Else 
			//  //QUERY SELECTION([eWires]; & ;[eWires]UUID="X";*)  //return nothing
			//End case 
			
			//QUERY([eWires])
			//QUERY([Registers];[Registers]CreationDate>!01/01/2013!)
			ALL RECORDS:C47([Registers:10])
			REDUCE SELECTION:C351([Registers:10]; 10000)  //testing
		Else 
			REDUCE SELECTION:C351([Registers:10]; 0)
		End if 
		
		
	Else 
		REDUCE SELECTION:C351([Registers:10]; 0)
End case 