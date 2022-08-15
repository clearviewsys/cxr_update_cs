//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/21/18, 16:34:28
// ----------------------------------------------------
// Method: webSelectCustomer
// Description
// 
//
// Parameters
// ----------------------------------------------------

//TRACE

READ ONLY:C145([Agents:22])

Case of 
	: (WEBUSERNAME="")
		REDUCE SELECTION:C351([Agents:22]; 0)
		
	: (webContext#"agents")
		REDUCE SELECTION:C351([Agents:22]; 0)
		
	Else 
		
		QUERY:C277([Agents:22]; [Agents:22]AgentID:1=WEBUSERNAME)
		
		If (Records in selection:C76([Agents:22])=1)  //good
		Else 
			REDUCE SELECTION:C351([Agents:22]; 0)
		End if 
End case 

webSetSyncSiteId([Agents:22]CountryCode:21)
