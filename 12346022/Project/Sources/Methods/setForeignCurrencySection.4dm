//%attributes = {}
// setForeignCurrencySection ($nodeRef; {$isEwire=false} false: Wires)


C_TEXT:C284($1; $nodeRef)
C_BOOLEAN:C305($2; $isEwire)

Case of 
	: (Count parameters:C259=1)
		$nodeRef:=$1
		$isEwire:=False:C215  // true: EWIRES, Default is WIRES
		
	: (Count parameters:C259=2)
		$nodeRef:=$1
		$isEwire:=$2  // true: EWIRES
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($toForeignCurrency; $tmp; $element; $to_party)

// Foreign Currency


If ($isEwire)  // Section for e-WIRES
	
	
	If ([eWires:13]isPaymentSent:20)  // Only for Outgoing eWires
		$toForeignCurrency:=GAML_CreateXMLNode($nodeRef; "to_foreign_currency")
		
		$element:=GAML_CreateXMLNode($toForeignCurrency; "foreign_currency_code"; ->[eWires:13]Currency:12; True:C214)
		$tmp:=String:C10([eWires:13]ToAmount:14; "###########0.00")
		$element:=GAML_CreateXMLNode($toForeignCurrency; "foreign_amount"; ->$tmp; True:C214)
		
		READ ONLY:C145([Registers:10])
		QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[eWires:13]RegisterID:24)
		
		C_REAL:C285($exchangeR)
		
		$exchangeR:=Trunc:C95(calcSafeDivide(1; [Registers:10]OurRate:25); 4)
		//$element:=GAML_CreateXMLNode ($toForeignCurrency;"foreign_exchange_rate";->[Registers]OurRate;True)
		$element:=GAML_CreateXMLNode($toForeignCurrency; "foreign_exchange_rate"; ->$exchangeR; True:C214)
	End if 
	
	
Else   // Section for WIRES
	
	If ([Wires:8]isOutgoingWire:16)
		$to_party:=GAML_CreateXMLNode($nodeRef; "to_foreign_currency")
		$element:=GAML_CreateXMLNode($to_party; "foreign_currency_code"; ->[Wires:8]Currency:15; True:C214)  // modified by TB : invoices must 
		
		$tmp:=String:C10([Wires:8]Amount:14; "###########0")
		$element:=GAML_CreateXMLNode($to_party; "foreign_amount"; ->$tmp; True:C214)
		
		READ ONLY:C145([Registers:10])
		QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[Wires:8]CXR_RegisterID:13)
		
		C_REAL:C285($rateInverse)
		RELATE ONE:C42([Registers:10]Currency:19)
		
		$rateInverse:=Trunc:C95(calcSafeDivide(1; [Registers:10]OurRate:25); 4)
		$element:=GAML_CreateXMLNode($to_party; "foreign_exchange_rate"; ->$rateInverse; True:C214)
		
	End if 
	
End if 

