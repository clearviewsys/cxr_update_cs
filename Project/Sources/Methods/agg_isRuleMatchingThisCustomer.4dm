//%attributes = {}
// agg_isRuleMatchingThisCustomer
// formerly called: matchCustomer_vs_AMLRule (customerObj;statsObj;ruleObj) : boolean
// returns true if customer transactions matches against the rule
// this evaluation method disregards the invoice
// see also: agg_getStatsObject ; newAML_AggrRule


#DECLARE($thisCustomer : Object; $statsObj : Object; $ruleObj : Object)->$match : Boolean

var $ruleObj; $thisCustomer; $statsObj : Object
var $match : Boolean
var $lowerBound; $upperBound; $buyV; $sellV; $rate; $rateInv : Real


If (Count parameters:C259#3)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 


$match:=($ruleObj.isActive | (Position:C15("group"; $ruleObj.ruleName)>0))  // always start with a assuming the match is true; if match is not active then there's no match

//If (($thisInvoiceID="") & (Num($ruleObj.isByInvoice)=1))  // if the rule is by invoice and no invoiceID is provided then fail
//$match:=False
//End if 
If ($match=False:C215)  // don't bother with the rest of the code if the match is false or the rule is inactive
	return ($match)
End if 

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
	$match:=($thisCustomer.CountryOfBirthCode=$ruleObj.ifNationality)  // this may cause a bug? #bug as the Nationality is not a code? 
End if 


// if RelationType is missing



// first check all Customer preconditions or scope (isWalking, isInsider, isCompany, etc)
$match:=matchBooleanToTristateRule($match; $thisCustomer.isWalkin; $ruleObj.ifIsWalkin)
$match:=matchBooleanToTristateRule($match; $thisCustomer.isInsider; $ruleObj.ifIsInsider)
$match:=matchBooleanToTristateRule($match; $thisCustomer.isCompany; $ruleObj.ifIsCompany)
$match:=matchBooleanToTristateRule($match; $thisCustomer.AML_isSuspicious; $ruleObj.ifIsSuspicious)
$match:=matchTrisateToTristateRule($match; $thisCustomer.AML_HighRisk; $ruleObj.ifIsHighRisk)
$match:=matchTrisateToTristateRule($match; $thisCustomer.AML_isPEP; $ruleObj.ifObj.isPEP)  // this is New for checking PEP or non-PEP[[

// total number of registers
If ($match & ($ruleObj.ifQtyGTOE#0))
	$match:=($statsObj.registersCount>=$ruleObj.ifQtyGTOE)
End if 

// total number of invoices
If ($match & ($ruleObj.ifObj.invoiceCountGTOE#0))
	$match:=($statsObj.invoicesCount>=$ruleObj.ifObj.invoiceCountGTOE)
End if 

// total number of branches
If ($match & ($ruleObj.ifBranchCountGTOE#0))
	$match:=($statsObj.branchesCount>=$ruleObj.ifBranchCountGTOE)
End if 

// total number of currencies
If ($match & ($ruleObj.ifCurrencyCountGTOE#0))
	$match:=($statsObj.currenciesCount>=$ruleObj.ifCurrencyCountGTOE)
End if 

// total number of high risk countries is GTOE
If ($match & ($ruleObj.ifObj.highRiskCountriesCountGTOE#0))
	$match:=($statsObj.highRiskCountriesCount>=$ruleObj.ifObj.highRiskCountriesCountGTOE)
End if 

// total number of high risk SOFs
If ($match & ($ruleObj.ifObj.highRiskSOFsCountGTOE#0))
	$match:=($statsObj.highRiskSOFsCount>=$ruleObj.ifObj.highRiskSOFsCountGTOE)
End if 


// total number of high risk POTs
If ($match & ($ruleObj.ifObj.highRiskPOTsCountGTOE#0))
	$match:=($statsObj.highRiskPOTsCount>=$ruleObj.ifObj.highRiskPOTsCountGTOE)
End if 

//getCollectionIntersection()

// if there's a match on the currencies that we are looking for in the rule
If ($match & ($ruleObj.ifObj.currencies.length>0))  // if the collection is not empty (there's a currency to search for
	// ifObj.currencies : is a collection of all currencies that we are looking for e.g. {"USD", "EUR", "CAD", "TOM"}
	// stats.currencies : is a collection of currencies that the customer has used during that period {"EUR", "GBP"}
	// if stats.currencies intersection with ruleObj.ifObj.currencies has a entry
	// note that the logis is OR ; meaning if the collection contains any of the elements in the rule it is accepted
	
	var $ccy : Text
	var $found : Boolean
	$found:=False:C215
	For each ($ccy; $ruleObj.ifObj.currencies) Until ($found)
		If ($statsObj.currencies.indexOf($ccy)>-1)  // if we found $ccy in the stats.currencies collection
			$found:=True:C214
		End if 
	End for each 
	$match:=$found  // if found it means the match is still true and if not found, it means match should be false
	
End if 


If ($match & ($ruleObj.ifObj.sourceOfFunds.length>0))  // if there's a rule for SOF
	var $col : Collection
	If ($statsObj.SOFs.length>0)
		$col:=getCollectionIntersection($statsObj.SOFs; $ruleObj.ifObj.sourceOfFunds)
		$match:=($col.length>0)  // there's a match if there's an intersection between the rule and the stats
	Else 
		$match:=False:C215
	End if 
End if 


If ($match & ($ruleObj.ifObj.purposeOfTransactions.length>0))  // if there's a rule for POT
	var $col : Collection
	If ($statsObj.POTs.length>0)
		$col:=getCollectionIntersection($statsObj.POTs; $ruleObj.ifObj.purposeOfTransactions)
		$match:=($col.length>0)  // there's a match if there's an intersection between the rule and the stats
	Else 
		$match:=False:C215
	End if 
End if 


If ($match & ($ruleObj.ifObj.typeOfTransactions.length>0))  // if there's a rule for ToT
	var $col : Collection
	If ($statsObj.TOTs.length>0)
		$col:=getCollectionIntersection($statsObj.TOTs; $ruleObj.ifObj.typeOfTransactions)
		$match:=($col.length>0)  // there's a match if there's an intersection between the rule and the stats
	Else 
		$match:=False:C215
	End if 
End if 


If ($match & ($ruleObj.ifObj.destinationCountries.length>0))  // if there's a rule for destination countries
	var $col : Collection
	If ($statsObj.destinationCountries.length>0)
		$col:=getCollectionIntersection($statsObj.destionationCountries; $ruleObj.ifObj.destionationCountries)
		$match:=($col.length>0)  // there's a match if there's an intersection between the rule and the stats
	Else 
		$match:=False:C215
	End if 
End if 


If (Not:C34($match))
	return ($match)
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
	
	$es:=ds:C1482.Currencies.query("ISO4217 = :1"; $ruleObj.toCurrency)  // this can by #optimized
	
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

//$0:=$match