//%attributes = {}
// getTieredRate (fromCurrency; toCurrency; amount; isBuy:bool; customerType; customerID): object
// #ORDA ; #rule  ; #booking 
// return object: 
// $o.rate
// $o.base
// $o.fee
// $o.margin
// $o.group
// $o.customer
//$o.mop

// 
// 1 - Rules that match with to same customerID, the same currency pair
// 2 - If not found, then look for Rules that match with the same customerType(Group), same currency pair
// 3 - If not found, then look for Rules that match with same currency pair
// if not found, use the same rate as in the Currencies table as a last resort. This is the current default behavior! 

// In each stage, when more multiple rules are found, look for the rule that matches the same amount limit (correct tier) 
// as the customer requested booking amount. If the amount is greater than all available tiers, the booking cannot be applied! 


C_TEXT:C284($1; $fromCurrency)
C_TEXT:C284($2; $toCurrency)
C_REAL:C285($3; $amount)
C_BOOLEAN:C305($4; $isBuy)
C_TEXT:C284($5; $customerType)
C_TEXT:C284($6; $customerID)
C_TEXT:C284($7; $mop)

C_OBJECT:C1216($0; $o)

C_OBJECT:C1216($currencyRules; $segmentRules; $obj)
C_BOOLEAN:C305($isValid; $isUseCurrencyTable)
C_REAL:C285($margin; $spotRate; $rate; $fee)
C_LONGINT:C283($error)
C_TEXT:C284($rateRuleID)


$margin:=0
$rate:=0
$isValid:=False:C215
$o:=New object:C1471

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

If (True:C214)
	$error:=ws_getCurrencyRate($fromCurrency; $toCurrency; ->$spotRate)
Else 
	// error handling
	setErrorTrap(Current method name:C684; "Couldn't connect to Rate Server")
	
	$error:=ws_getConversionRate_S2($fromCurrency; $toCurrency; ->$spotRate)
	endErrorTrap
End if 

If ($error#0)  // --- FALLBACK TO THE CURRENCIES TABLE ----- if 
	//[Currencies]OurBuyRateLocal
	//[Currencies]OurSellRateLocal
	//[Currencies]SpotRateLocal
	//[Currencies]ISO4217
	//[Currencies]toISO4217
	
	//$obj:=ds.Currencies.query("ISO4217 ==:1 AND toISO4217 == :2";$fromCurrency;$toCurrency)
	
	//If ($obj.length>0)
	//$o.rate:=Choose($isBuy;$obj.OurBuyRateLocal;$obj.OurSellRateLocal)
	//$o.base:=$obj.SpotRateLocal
	//Else 
	//$o.rate:=0
	//$o.base:=0
	//End if 
	//$o.fee:=0
	//$o.margin:=0
	//$o.group:="N/A"
	//$o.customer:="Currency Table"
	//$o.mop:=""
	
Else 
	//$isUseCurrencyTable:=False
	
	C_OBJECT:C1216($currencyRules)
	$currencyRules:=New object:C1471
	$currencyRules.length:=0
	
	
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
				$currencyRules:=ds:C1482.RateRules.query("(toCurrency == '*' AND fromCurrency == '*'  AND methodOfPayment == :1 AND CustomerID == :2 AND CustomerTypeID == '' ) AND ((upperLimit >= :3 AND lowerLimit <= :3) OR (upperLimit == 0))"; $mop; $customerID; $amount)
			End if 
			
			If ($currencyRules.length=0) & ($customerID#"")  //check for rateRules fallback - mop and customer id
				$currencyRules:=ds:C1482.RateRules.query("(toCurrency == '*' AND fromCurrency == '*'  AND methodOfPayment == '' AND CustomerID == :1 AND CustomerTypeID == '' ) AND ((upperLimit >= :2 AND lowerLimit <= :2) OR (upperLimit == 0))"; $customerID; $amount)
			End if 
			
			If ($currencyRules.length=0) & ($customerType#"") & ($mop#"")  //check for rateRules fallback - mop and customer id
				$currencyRules:=ds:C1482.RateRules.query("(toCurrency == '*' AND fromCurrency == '*'  AND methodOfPayment == :1 AND CustomerID == '' AND CustomerTypeID == :2 ) AND ((upperLimit >= :3 AND lowerLimit <= :3) OR (upperLimit == 0))"; $mop; $customerType; $amount)
			End if 
			
			If ($currencyRules.length=0) & ($customerType#"")  //check for rateRules fallback - mop and customer id
				$currencyRules:=ds:C1482.RateRules.query("(toCurrency == '*' AND fromCurrency == '*'  AND methodOfPayment == '' AND CustomerID == '' AND CustomerTypeID == :1 ) AND ((upperLimit >= :2 AND lowerLimit <= :2) OR (upperLimit == 0))"; $customerType; $amount)
			End if 
			
			If ($currencyRules.length=0) & ($mop#"")  //check for rateRules fallback - mop 
				$currencyRules:=ds:C1482.RateRules.query("(toCurrency == '*' AND fromCurrency == '*'  AND methodOfPayment == :1 AND CustomerID == '' AND CustomerTypeID == '') AND ((upperLimit >= :2 AND lowerLimit <= :2) OR (upperLimit == 0))"; $mop; $amount)
			End if 
			
			If ($currencyRules.length=0)  //check for rateRules fallback
				$currencyRules:=ds:C1482.RateRules.query("(toCurrency == '*' AND fromCurrency == '*'  AND methodOfPayment == '' AND CustomerID == '' AND CustomerTypeID == '' ) AND ((upperLimit >= :1 AND lowerLimit <= :1) OR (upperLimit == 0))"; $amount)
			End if 
		End if 
	End if 
	
	If (False:C215)
		If ($currencyRules.length>0)
			$segmentRules:=New object:C1471  // why inside an if #TB? 
			$segmentRules.length:=0
			
			//-----  CUSTOMER RULES ------
			//NEED TO CONSIDER UPPER AND LOWER LIMITS AND IF NONE SPECIFIED
			If ($customerID#"")
				$segmentRules:=$currencyRules.query("CustomerID == :1"; $customerID)
			End if 
			
			//[RateRules]
			//----  GROUP RULES ----- 
			//NEED TO CONSIDER UPPER AND LOWER LIMITS AND IF NONE SPECIFIED
			If ($segmentRules.length=0) & ($customerType#"")  //didn't find any customer rules
				$segmentRules:=$currencyRules.query("CustomerTypeID == :1"; $customerType)
			End if 
			
			//---- RATE RULES NOT CUSTOMER AND NOT TYPE SPECIFIED ---
			// ---- DEFAULT RULES FOR CURRENCY PAIR ----
			If ($segmentRules.length=0)  //no rules by customer id or type
				$segmentRules:=$currencyRules.query("CustomerTypeID == '' AND CustomerID == ''")
			End if 
			
			If ($segmentRules.length>0)  //we have rules to review
				C_OBJECT:C1216($rule)
				$fee:=0
				
				For each ($rule; $segmentRules) While ($isValid=False:C215)
					$isValid:=isValidTieredRate($amount; $rule.lowerLimit; $rule.upperLimit)
					If ($isValid)
						If ($isBuy)
							$fee:=$rule.buyFee
							$margin:=$rule.buyMargin
						Else 
							$fee:=$rule.sellFee
							$margin:=$rule.sellMargin
						End if 
						$customerType:=$rule.CustomerTypeID
						$customerID:=$rule.CustomerID
					End if 
				End for each 
				
			Else 
				// what about if the rule was not found?  #TB
				$isUseCurrencyTable:=True:C214
			End if 
			
		End if 
	End if 
	
	
	
End if 


Case of 
	: ($fromCurrency=$toCurrency)
		$rate:=1
		$spotRate:=$rate
		$fee:=0
		$margin:=0
		$customerType:="Default"
		$customerID:="N/A"
		
	: ($currencyRules.length=0)  // ($isUseCurrencyTable)  //nothing found in [RateRules] so use the [Currencies] table
		If (True:C214)
			$obj:=ds:C1482.Currencies.query("ISO4217 ==:1 AND toISO4217 == :2"; $fromCurrency; $toCurrency)
			
			If ($obj.length>0)
				$rate:=Choose:C955($isBuy; $obj.first().OurBuyRateLocal; $obj.first().OurSellRateLocal)
				$spotRate:=$obj.first().SpotRateLocal
			Else 
				$rate:=0
				$spotRate:=0
			End if 
			$fee:=0
			$margin:=0
			$customerType:="N/A"
			$customerID:="Currency Table"
			$mop:=""
			$rateRuleID:=""
		Else 
			$rate:=Choose:C955($isBuy; getOurBuyRate($fromCurrency); getOurSellRate($fromCurrency))  //getCurrencyRate ($fromCurrency)  //keep the given rate -- always a sell right now
			$spotRate:=$rate
			$fee:=0
			$margin:=0
			$customerType:="Currency Table"
			$customerID:="N/A"
			$rateRuleID:=""
		End if 
		
	Else   //we found rule(s) that meet the criteria - use first one found
		
		If ($isBuy)
			$fee:=$currencyRules.first().buyFee
			$margin:=$currencyRules.first().buyMargin
			$rate:=$spotRate-$margin  //need to convert margin from PIP to $
		Else 
			$fee:=$currencyRules.first().sellFee
			$margin:=$currencyRules.first().sellMargin
			$rate:=$spotRate+$margin  // <--- TIRAN WE NEED TO CONFIRM ADD/SUBSTRACT???
		End if 
		
		$customerType:=$currencyRules.first().CustomerTypeID
		$customerID:=$currencyRules.first().CustomerID
		$rateRuleID:=$currencyRules.first().UUID
		
		
		//If ($isBuy)  //custoemr buys we add
		//$rate:=$spotRate+$margin  //need to convert margin from PIP to $
		//Else 
		//$rate:=$spotRate-$margin  //buy rate we subtracct
		//End if 
		
End case 

$o.rate:=$rate
$o.base:=$spotRate
$o.fee:=$fee
$o.margin:=$margin
$o.group:=$customerType
$o.customer:=$customerID
$o.id:=$rateRuleID
$o.mop:=$mop

$0:=$o  //$rRate