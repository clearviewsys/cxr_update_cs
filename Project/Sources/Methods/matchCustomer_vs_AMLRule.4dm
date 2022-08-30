//%attributes = {}
// matchCustomer_vs_AMLRule (customerObj;statsObj;ruleObj)
// returns true if customer transactions matches against the rule
// this evaluation method disregards the invoice

C_OBJECT:C1216($ruleObj; $thisCustomer; $statsObj; $1; $2)
C_BOOLEAN:C305($match; $0)
C_REAL:C285($lowerBound; $upperBound; $buyV; $sellV; $rate; $rateInv)

Case of 
	: (Count parameters:C259=3)
		$thisCustomer:=$1
		$statsObj:=$2
		$ruleObj:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$match:=($ruleObj.isActive | (Position:C15("group"; $ruleObj.ruleName)>0))  // always start with a assuming the match is true; if match is not active then there's no match

//If (($thisInvoiceID="") & (Num($ruleObj.isByInvoice)=1))  // if the rule is by invoice and no invoiceID is provided then fail
//$match:=False
//End if 

If ($match & ($ruleObj.ifCustomerID#""))  // if the condition only applies to a certain customer ID then make sure the ID is matching 
	$match:=($thisCustomer.CustomerID=$ruleObj.ifCustomerID)
End if 

If ($match & ($ruleObj.ifGroup#""))  // if the condition only applied to a special group, make sure the group is matching
	//[Customers]GroupName
	$match:=($thisCustomer.GroupName=$ruleObj.ifGroup)
End if 

If ($match & ($ruleObj.ifOccupation#""))  // if the condition only applied to a special group, make sure the group is matching
	//[Customers]Occupation
	$match:=($thisCustomer.Occupation=$ruleObj.ifOccupation)
End if 

If ($match & ($ruleObj.ifIndustryCode#""))  // if the condition only applied to a special group, make sure the group is matching
	//[Customers]IndustryCode
	$match:=($thisCustomer.IndustryCode=$ruleObj.ifIndustryCode)
End if 

If ($match & ($ruleObj.ifNationality#""))  // if the condition only applied to a special group, make sure the group is matching
	//[Customers]CountryOfBirthCode
	$match:=($thisCustomer.CountryOfBirthCode=$ruleObj.ifNationality)
End if 


// if RelationType is missing



// first check all Customer preconditions or scope (isWalking, isInsider, isCompany, etc)
$match:=matchBooleanToTristateRule($match; $thisCustomer.isWalkin; $ruleObj.ifIsWalkin)
$match:=matchBooleanToTristateRule($match; $thisCustomer.isInsider; $ruleObj.ifIsInsider)
$match:=matchBooleanToTristateRule($match; $thisCustomer.isCompany; $ruleObj.ifIsCompany)
$match:=matchBooleanToTristateRule($match; $thisCustomer.AML_isSuspicious; $ruleObj.ifIsSuspicious)
$match:=matchTrisateToTristateRule($match; $thisCustomer.AML_HighRisk; $ruleObj.ifIsHighRisk)

// total number of transactions
If ($match & ($ruleObj.ifQtyGTOE#0))
	$match:=($statsObj.totalCount>=$ruleObj.ifQtyGTOE)
End if 


// volume of transaction (debitLocal or creditLocal)
$upperBound:=$ruleObj.ifUpperBound

$lowerBound:=$ruleObj.ifVolumeGTOE
$buyV:=$statsObj.volumeBuy
$sellV:=$statsObj.volumeSell

If ($match & ($lowerBound#0))
	If ($upperBound=0)
		$match:=(($buyV>=$lowerBound) | ($sellV>=$lowerBound))  // 
	Else 
		$match:=((($buyV>=$lowerBound) & ($buyV<$upperBound)) | (($sellV>=$lowerBound) & ($sellV<$upperBound)))
	End if 
End if 

// amount of transaction (debit or credit)
$lowerBound:=$ruleObj.ifAmountGTOE
$buyV:=$statsObj.sumDebit
$sellV:=$statsObj.sumCredit

If ($match & ($lowerBound#0))
	If ($upperBound=0)
		$match:=(($buyV>=$lowerBound) | ($sellV>=$lowerBound))  // 
	Else 
		$match:=((($buyV>=$lowerBound) & ($buyV<$upperBound)) | (($sellV>=$lowerBound) & ($sellV<$upperBound)))
	End if 
End if 

// match based on the value of transaction (e.g. if the transaction value is more than 10K USD when the base currency is CAD)
// this can also be used to match against the base currency value without considering the gain of the transaction so basically
// the value will be evaluated based on the market value only. This rule will only exectue if both the transaction value and
// the currency for it have been assigned. 
If ($match & ($ruleObj.ifValueGTOE#0) & ($ruleObj.toCurrency#""))  // both value should be non-zero
	C_REAL:C285($valueBuy; $valueSell; $rateInv)
	// find the currency and get the rate, if not found return 0
	C_OBJECT:C1216($es)
	$es:=ds:C1482.Currencies.query("ISO4217 = :1"; $ruleObj.toCurrency)
	If ($es.length>0)  // found a rate
		//[Currencies]SpotRateLocal
		//[Currencies]spotRateInverse
		$rateInv:=$es.first().spotRateInverse  // the reason we use the inverse rate is  
		$rate:=$es.first().SpotRateLocal
		
		If ($ruleObj.toCurrency=<>baseCurrency)  // base Currency
			$valueBuy:=$statsObj.volumeBuy+$statsObj.sumGains  // add the gains of the transaction during buy
			$valueSell:=$statsObj.volumeSell  // do not add the gains 
		Else 
			$valueBuy:=($statsObj.volumeBuy+$statsObj.sumGains)*$rateInv  // there are gains from buying at a discounted rate that reduces the value of the transaction; we should add those gains back
			// the reason that we multiply by $rateInv is that we have to convert the local amount into the value of the currency we are comparing it against (e.g. 1200 NZD is about 900 CAD)
			// the gains in this transaction (during purchase) lower the value of the transaction so we convert the gains back into the foreign currency amount and then add them to the value
			// so a gain of $100 CAD may be equivalent to $70 USD so we add that $70 USD to the value and then compary with the rule 
			
			$valueSell:=$statsObj.volumeSell*$rateInv
		End if 
		
		$lowerBound:=$ruleObj.ifValueGTOE
		$buyV:=$valueBuy
		$sellV:=$valueSell
		
		If ($match & ($lowerBound#0))
			If ($upperBound=0)
				$match:=(($buyV>=$lowerBound) | ($sellV>=$lowerBound))  // 
			Else 
				$match:=((($buyV>=$lowerBound) & ($buyV<$upperBound)) | (($sellV>=$lowerBound) & ($sellV<$upperBound)))
			End if 
		End if 
		
	Else   // didn't find a matching currency therefore the match is false
		$match:=False:C215
	End if 
End if 

$0:=$match