
C_LONGINT:C283($count; $error)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Is new record:C668([Wires:8]))
			$count:=selectActiveWebeWires4Customer([Customers:3]CustomerID:1; "wire")
			
			If ($count>=1)
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		//$error:=createEwireFromWebeWire ([WebEWires]WebEwireID)
		C_TEXT:C284($WebEWireID; $currWebEWireID)
		
		$currWebEWireID:=[Wires:8]WireNo:48
		
		$WebEWireID:=pickWebEWireForInvoice("wire")
		If ($WebEWireID#"")
			$error:=createWireFromWebeWire($WebEWireID)
			
			If ($error=0) & ($currWebEWireID#"")
				//need to undo previous choice
				READ WRITE:C146([WebEWires:149])
				QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=$currWebEWireID)
				[WebEWires:149]eWireID:18:=""
				[WebEWires:149]status:16:=20
				[WebEWires:149]paymentInfo:35.invoiceID:=""
				SAVE RECORD:C53([WebEWires:149])
				UNLOAD RECORD:C212([WebEWires:149])
				READ ONLY:C145([WebEWires:149])
			End if 
		End if 
		
		If ($error=0)
			vAmountLocal_BF:=[Wires:8]AmountLocal:25-[Wires:8]FlatFeeLocal:24
			vTotalFees:=[Wires:8]FlatFeeLocal:24
			vInverseRate:=[WebEWires:149]inverseRate:14
			vBaseCurrency:=[WebEWires:149]fromCCY:5
			OBJECT SET ENTERABLE:C238(*; "toAmount"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "calcField11"; False:C215)
		End if 
		
End case 