//%attributes = {}


C_TEXT:C284($1; $fromCurrency)
C_TEXT:C284($2; $toCurrency)
C_REAL:C285($3; $amount)
C_BOOLEAN:C305($4; $isBuy)
C_TEXT:C284($5; $customerType)
C_TEXT:C284($6; $customerID)
C_TEXT:C284($7; $mop)

C_OBJECT:C1216($0; $currencyRules)


If (Count parameters:C259>=4)
	$fromCurrency:=$1
	$toCurrency:=$2
	$amount:=$3
	$isBuy:=$4
End if 

Case of 
	: (Count parameters:C259=4)
		$customerID:=[Customers:3]CustomerID:1  //assume current customer
		$customerType:=[Customers:3]GroupName:90
		$mop:=""
		
	: (Count parameters:C259=5)
		$customerType:=$5
		$customerID:=""
		$mop:=""
		
	: (Count parameters:C259=6)
		$customerType:=$5
		$customerID:=$6
		$mop:=""
		
	: (Count parameters:C259=7)
		$customerType:=$5
		$customerID:=$6
		$mop:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (True:C214)  //----  GET BASE RULES FOR CURRENCY PAIR ------ 
	If ($customerID#"") & ($mop#"")
		$currencyRules:=ds:C1482.RateRules.query("(toCurrency == :1 AND fromCurrency == :2  AND CustomerID == :3 AND  methodOfPayment == :4) AND ((upperLimit >= :5 AND lowerLimit <= :5) OR (upperLimit == 0))"; $toCurrency; $fromCurrency; $customerID; $mop; $amount)
	End if 
	
	If ($currencyRules.length=0) & ($customerID#"")
		$currencyRules:=ds:C1482.RateRules.query("(toCurrency == :1 AND fromCurrency == :2  AND CustomerID == :3 ) AND ((upperLimit >= :4 AND lowerLimit <= :4) OR (upperLimit == 0))"; $toCurrency; $fromCurrency; $customerID; $amount)
	End if 
	
	If ($currencyRules.length=0) & ($customerType#"") & ($mop#"")  //check for group
		$currencyRules:=ds:C1482.RateRules.query("(toCurrency == :1 AND fromCurrency == :2  AND CustomerTypeID == :3  AND methodOfPayment == :4) AND ((upperLimit >= :5 AND lowerLimit <= :5) OR (upperLimit == 0))"; $toCurrency; $fromCurrency; $customerType; $mop; $amount)
	End if 
	
	If ($currencyRules.length=0) & ($customerType#"")  //check for group
		$currencyRules:=ds:C1482.RateRules.query("(toCurrency == :1 AND fromCurrency == :2  AND CustomerTypeID == :3 ) AND ((upperLimit >= :4 AND lowerLimit <= :4) OR (upperLimit == 0))"; $toCurrency; $fromCurrency; $customerType; $amount)
	End if 
	
	If ($currencyRules.length=0) & ($mop#"")  //check for rateRules with MOP and without cust id and cust type
		$currencyRules:=ds:C1482.RateRules.query("(toCurrency == :1 AND fromCurrency == :2  AND methodOfPayment == :3 AND CustomerID == '' AND CustomerTypeID == '' ) AND ((upperLimit >= :4 AND lowerLimit <= :4) OR (upperLimit == 0))"; $toCurrency; $fromCurrency; $mop; $amount)
	End if 
	
	If ($currencyRules.length=0)  //check for rateRules without cust id and cust type and mop
		$currencyRules:=ds:C1482.RateRules.query("(toCurrency == :1 AND fromCurrency == :2  AND methodOfPayment == '' AND CustomerID == '' AND CustomerTypeID == '' ) AND ((upperLimit >= :3 AND lowerLimit <= :3) OR (upperLimit == 0))"; $toCurrency; $fromCurrency; $amount)
	End if 
End if 

If (True:C214)  //----  FALL BACK FOR ALL CURRENCY COMBINATIONS --- uses * as wildcard - need to store that in [RateRules]
	If ($currencyRules.length=0)
		
		If ($currencyRules.length=0) & ($customerID#"") & ($mop#"")  //check for rateRules fallback - mop and customer id
			$currencyRules:=ds:C1482.RateRules.query("(toCurrency === '*' AND fromCurrency === '*'  AND methodOfPayment == :1 AND CustomerID == :2 AND CustomerTypeID == '' ) AND ((upperLimit >= :3 AND lowerLimit <= :3) OR (upperLimit == 0))"; $mop; $customerID; $amount)
		End if 
		
		If ($currencyRules.length=0) & ($customerID#"")  //check for rateRules fallback - mop and customer id
			$currencyRules:=ds:C1482.RateRules.query("(toCurrency === '*' AND fromCurrency === '*'  AND methodOfPayment == '' AND CustomerID == :1 AND CustomerTypeID == '' ) AND ((upperLimit >= :2 AND lowerLimit <= :2) OR (upperLimit == 0))"; $customerID; $amount)
		End if 
		
		If ($currencyRules.length=0) & ($customerType#"") & ($mop#"")  //check for rateRules fallback - mop and customer id
			$currencyRules:=ds:C1482.RateRules.query("(toCurrency === '*' AND fromCurrency === '*'  AND methodOfPayment == :1 AND CustomerID == '' AND CustomerTypeID == :2 ) AND ((upperLimit >= :3 AND lowerLimit <= :3) OR (upperLimit == 0))"; $mop; $customerType; $amount)
		End if 
		
		If ($currencyRules.length=0) & ($customerType#"")  //check for rateRules fallback - mop and customer id
			$currencyRules:=ds:C1482.RateRules.query("(toCurrency === '*' AND fromCurrency === '*'  AND methodOfPayment == '' AND CustomerID == '' AND CustomerTypeID == :1 ) AND ((upperLimit >= :2 AND lowerLimit <= :2) OR (upperLimit == 0))"; $customerType; $amount)
		End if 
		
		If ($currencyRules.length=0) & ($mop#"")  //check for rateRules fallback - mop 
			$currencyRules:=ds:C1482.RateRules.query("(toCurrency === '*' AND fromCurrency === '*'  AND methodOfPayment == :1 AND CustomerID == '' AND CustomerTypeID == '') AND ((upperLimit >= :2 AND lowerLimit <= :2) OR (upperLimit == 0))"; $mop; $amount)
		End if 
		
		// -- DO WE NEED TO ADD $ RANGES ?? ----
		
		If ($currencyRules.length=0)  //check for rateRules fallback
			$currencyRules:=ds:C1482.RateRules.query("(toCurrency === '*' AND fromCurrency === '*'  AND methodOfPayment == '' AND CustomerID == '' AND CustomerTypeID == '' ) AND ((upperLimit >= :1 AND lowerLimit <= :1) OR (upperLimit == 0))"; $amount)
		End if 
	End if 
End if 


$0:=$currencyRules