//%attributes = {"shared":true}
C_TEXT:C284($0)


Case of 
	: ([WebEWires:149]WebEwireID:1="@WIR@")
		$0:="wire"
	: ([WebEWires:149]WebEwireID:1="@EWI@")
		$0:="eWire"
	: ([WebEWires:149]WebEwireID:1="@MG@")
		$0:="MG"
	Else 
		$0:="eWire"
End case 