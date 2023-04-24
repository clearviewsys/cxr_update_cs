veWireID:=""
//GOTO AREA(*;"eWireID")


pickeWireForCustomer(->veWireID; vCustomerID)
//pickeWire (->veWireID;
//selectpendingeWire
//veWireID:=Request("eWire")
//pickeWire (->veWireID)

//QUERY([eWires];[eWires]eWireID=veWireID)  // search for eWire
//QUERY SELECTION([eWires];[eWires]isSettled=False)  // not paid yet
//


If (Records in selection:C76([eWires:13])=1)
	RELATE ONE:C42([eWires:13]LinkID:8)
	READ WRITE:C146([eWires:13])
	LOAD RECORD:C52([eWires:13])  // lock the record for modification
	handleReceiveeWireGetRateButton
	
	If ([eWires:13]isSettled:23)
		vbIsSettled:=[eWires:13]isSettled:23
	Else 
		If ([eWires:13]toMOP_Code:114=getKeyValue("ewire.tomop.cash"; "D"))  //"D@")
			vbIsSettled:=True:C214
		Else 
			vbIsSettled:=False:C215
		End if   //6/3/21
	End if 
	
	
Else 
	BEEP:C151
	myAlert("eWire not found")
	UNLOAD RECORD:C212([eWires:13])
	UNLOAD RECORD:C212([Links:17])
	vbIsSettled:=False:C215  //6/3/21
End if 