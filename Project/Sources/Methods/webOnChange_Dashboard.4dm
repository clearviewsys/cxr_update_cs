//%attributes = {}


C_TEXT:C284($1; $tFormName)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)


C_TEXT:C284($0)

C_TEXT:C284($mop; $tGroup; $tContext; $tCustomerID; $tToCCY; $tToCountry; $tFromCCY; $tFromCountry)
C_REAL:C285($rBase; $rDirectRate; $rFromAmount; $rFromFee; $rMargin; $rToAmount; $rInverseRate; $rSqAmount)
C_REAL:C285($rAmountDue; $sqFee)
C_OBJECT:C1216($o; $quote; $status)
C_COLLECTION:C1488($col)
C_BOOLEAN:C305($bRefresh; $doGetRates; $isComplete; $useMg; $showMG)
C_OBJECT:C1216($entity; $record)
C_TEXT:C284($code; $tRateNotes; $mgDelivery; $toCcyID; $option; $cxrCode; $groupName; $help)
C_TEXT:C284($TransferCalcMode; $transferMode)
C_LONGINT:C283($iPos)

ARRAY TEXT:C222($atSelectName; 0)
ARRAY TEXT:C222($atSelectValue; 0)



$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

ON ERR CALL:C155("onErrCallIgnore")

$tContext:=WAPI_getSession("context")

READ ONLY:C145(*)


$doGetRates:=False:C215
$bRefresh:=False:C215

$rFromAmount:=100
$rToAmount:=0
$rDirectRate:=0



Case of 
	: ($tContext="agents")
		webSelectAgentRecord
		
	: ($tContext="customers")
		webSelectCustomerRecord
		
		$tCustomerID:=[Customers:3]CustomerID:1
		
		If (Choose:C955(getKeyValue("web.customers.module.quotes.useCustomerCountry"; "false")="true"; True:C214; False:C215))
			$tFromCountry:=[Customers:3]CountryOfResidenceCode:114
			$tFromCCY:=getCurrencyCodeByCountryCode($tFromCountry)  //"CAD"
		Else 
			$tFromCountry:=<>CountryCode
			$tFromCCY:=<>baseCurrency
		End if 
		
		If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))
			$status:=WAPI_sessionGet("quote")
			If ($status.success) & ($status.value#Null:C1517)
				$quote:=$status.value
				
				If ($quote["dash-quote-from-ccy"]="")
					$quote["dash-quote-from-ccy"]:=$tFromCCY
				End if 
				
				If ($quote["dash-quote-from-country"]="")
					$quote["dash-quote-from-country"]:=$tFromCountry
				End if 
				
				$tToCountry:=$quote["dash-quote-to-country"]
				$tToCCY:=$quote["dash-quote-to-ccy"]
				$rToAmount:=$quote["dash-quote-to-amount"]
				$tFromCCY:=$quote["dash-quote-from-ccy"]
				$tFromCountry:=$quote["dash-quote-from-country"]
				$rFromAmount:=$quote["dash-quote-from-amount"]
				$rAmountDue:=$quote["dash-quote-amount-due"]
				$rDirectRate:=$quote["dash-quote-direct-rate"]
				$rInverseRate:=$quote["dash-quote-inverse-rate"]
				$rFromFee:=$quote["dash-quote-from-fee"]
				//$tPromoCode:=$quote["dash-quote-promo-code"]
				$TransferCalcMode:=$quote["dash-quote-transfer-calc-mode"]
				If ($TransferCalcMode="")
					$TransferCalcMode:="QEX_FEE"  // default for MG - based on send amount and fee added to the send amt
				End if 
				
			Else 
				$quote:=New object:C1471
				
				$quote["dash-quote-from-ccy"]:=$tFromCCY
				$quote["dash-quote-from-country"]:=$tFromCountry
				$quote["dash-quote-to-ccy"]:=""
				$quote["dash-quote-to-country"]:=""
				$quote.customerID:=[Customers:3]CustomerID:1
				
				$quote["dash-quote-direct-rate"]:=0
				$quote["dash-quote-inverse-rate"]:=0
				$quote["dash-quote-rate"]:=0
				$quote["dash-quote-from-fee"]:=0
				$quote["dash-quote-base"]:=0
				
				$quote["dash-quote-to-amount"]:=0
				$quote["dash-quote-from-amount"]:=0
				$quote["dash-quote-amount-due"]:=0
				$quote["dash-quote-pay"]:=""
				$quote["dash-quote-delivery"]:=""
				$quote["dash-quote-delivery-mg"]:=""
				$quote["dash-quote-delivery-mg-code"]:=""
				$quote["dash-quote-promo-code"]:=""
				$quote["dash-quote-transfer-to-point-id"]:=""
				
				$TransferCalcMode:="QEX_FEE"  // default for MG - based on send amount and fee added to the send amt
				$quote["dash-quote-transfer-calc-mode"]:=$TransferCalcMode
			End if 
			
			
		End if 
		
		
		Case of 
			: ($tEvent="DOMContentLoaded") | ($tEvent="readystatechange") | ($tEvent="onload")
				
				If (Choose:C955(getKeyValue("web.customers.module.rates.show")="true"; True:C214; False:C215))
					
					If (Choose:C955(getKeyValue("web.customers.module.rates.useCurrencies")="true"; True:C214; False:C215))
						webGetChoiceListCurrency(->$atSelectValue)
						$tToCCY:=$atSelectValue{1}
					Else 
						$entity:=New object:C1471
						$entity:=ds:C1482.Links.query("CustomerID == :1"; $tCustomerID)
						If ($entity.length>0)
							
							$col:=New collection:C1472
							$col:=$entity.distinct("countryCode")
							
							For each ($code; $col)
								If ($code="")
								Else 
									APPEND TO ARRAY:C911($atSelectValue; getCurrencyCodeByCountryCode($code))
								End if 
							End for each 
							
							If (Size of array:C274($atSelectValue)>0)
								$tToCCY:=$atSelectValue{1}
							End if 
							
						Else 
							$tToCCY:=<>baseCurrency
						End if 
					End if 
					// currenty options for live rates
					WAPI_pushDOMSelectOptions("dash-to-ccy"; ->$atSelectValue; ->$atSelectValue; ->$atSelectValue)
					
					$doGetRates:=True:C214
					$bRefresh:=True:C214
				End if 
				
				If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))
					//$groupName:=getKeyValue ("web.customers.module.quotes.show.groups")
					
					webGetChoiceListCountries(->$atSelectName; ->$atSelectValue)  //do we need to differentiate for MG?
					
					WAPI_pushDOMSelectOptions("dash-quote-to-country"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; $quote["dash-quote-to-country"])
					
					$tToCountry:=$quote["dash-quote-to-country"]
					
					ARRAY TEXT:C222($atSelectName; 0)
					ARRAY TEXT:C222($atSelectValue; 0)
					webLoadToMopArrays($tToCountry; ->$atSelectName; ->$atSelectValue)
					
					WAPI_pushDOMSelectOptions("dash-quote-delivery"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; $quote["dash-quote-delivery"])
					
					// -- GET PICKUP LOCATIONS - NON-MG TRANS
					$help:=getKeyValue("web.customers.module.quotes.help."+$tToCountry)
					WAPI_pushDOMHelp("dash-quote-to-country"; $help; "form-control-label small")
					
					If (False:C215)
						ARRAY TEXT:C222($atSelectName; 0)
						ARRAY TEXT:C222($atSelectValue; 0)
						WAPI_pushDOMSelectOptions("dash-quote-delivery-mg"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; $quote["dash-quote-delivery-mg"])
					End if 
					
					$bRefresh:=True:C214
					
				End if 
				
				
				
			: ($tEvent="change") & ($tSource="dash-quote-to-country")  // -- SELECT COUNTRY MENU
				$tToCountry:=WAPI_getParameter("dash-quote-to-country")
				
				ARRAY TEXT:C222($atSelectName; 0)
				ARRAY TEXT:C222($atSelectValue; 0)
				webLoadToMopArrays($tToCountry; ->$atSelectName; ->$atSelectValue)
				
				WAPI_pushDOMSelectOptions("dash-quote-delivery"; ->$atSelectName; ->$atSelectValue; ->$atSelectName)
				$quote["dash-quote-delivery"]:=$atSelectValue{1}
				$quote["dash-quote-to-country"]:=$tToCountry
				
				//--------- RESET DELIVERY OPTIONS FOR MG
				WAPI_pushDOMClass("dash-quote-delivery-hidden"; "hidden"; "add")
				$quote["dash-quote-delivery-mg"]:=""
				$quote["dash-quote-delivery-mg-code"]:=""
				WAPI_pushDOMClass("dash-quote-rate-exchange-group"; "hidden"; "add")
				WAPI_pushDOMClass("dash-quote-to-ccy-mg-group"; "hidden"; "add")
				
				// ---- RESET WIRE OPTIONS ---
				WAPI_pushDOMClass("dash-quote-wire-hidden"; "hidden"; "add")
				
				// ----------- GET PICKUP LOCATIONS - NON-MG TRANS
				$help:=getKeyValue("web.customers.module.quotes.help."+$tToCountry)
				WAPI_pushDOMHelp("dash-quote-to-country"; $help; "form-control-label small")
				
				
				
				Case of 
					: ($quote["dash-quote-delivery"]="N")  //is wire/bank transfer
						// for wire transfer need to know ccy options for countries per keyvalue
						C_COLLECTION:C1488($col)
						//$col:=New collection
						//$col:=Storage.wiresMap.query("alpha2 == :1";$tToCountry)
						
						$col:=webGetCountrySettings($tToCountry).result
						
						If ($col.length>0)
							Case of 
								: ($col[0].ccy.length=1)
									$tToCCY:=$col[0].ccy[0]
								: ($col[0].ccy.length>1)
									$tToCCY:=$col[0].ccy[0]
									//show other currencies
									WAPI_pushDOMClass("dash-quote-wire-hidden"; "hidden"; "remove")
									
									ARRAY TEXT:C222($atSelectName; 0)
									COLLECTION TO ARRAY:C1562($col[0].ccy; $atSelectName)
									WAPI_pushDOMSelectOptions("dash-quote-wire-options"; ->$atSelectName; ->$atSelectName; ->$atSelectName; $tToCCY)
									
							End case 
						Else   //not found
							$tToCCY:="N/A"
						End if 
						
					Else 
						$tToCCY:=getCurrencyCodeByCountryCode($tToCountry)
						WAPI_pushDOMHelp("dash-quote-delivery"; "")
						
						WAPI_pushDOMReadOnly("dash-quote-from-amount"; False:C215)
						WAPI_pushDOMReadOnly("dash-quote-to-amount"; False:C215)
				End case 
				
				// ----- SET TO CURRENCY AND FLAG ICON 
				$quote["dash-quote-to-ccy"]:=$tToCCY
				WAPI_pushDOMValue("dash-quote-to-ccy"; $tToCCY)
				WAPI_pushDOMImgSrc("dash-quote-to-amount-post"; webGetFlag_Currency($tToCCY))
				
				$bRefresh:=True:C214
				
				
			: (($tEvent="change") | ($tEvent="click")) & ($tSource="dash-quote-wire-options@")  // WIRE OPTIONS - change in ccy
				$tToCCY:=WAPI_getParameter($tSource)
				$quote["dash-quote-to-ccy"]:=$tToCCY
				$bRefresh:=True:C214
				
				
				
			: (($tEvent="change") | ($tEvent="click")) & ($tSource="dash-quote-delivery-mg@")  // -- MONEYGRAM DELIVERY METHODS
				$quote["dash-quote-delivery-mg"]:=WAPI_getParameter($tSource)
				$bRefresh:=True:C214
				
			: (($tEvent="change") | ($tEvent="click")) & ($tSource="dash-quote-delivery@")  // -- DELIVERY METHODS
				
				$quote["dash-quote-delivery"]:=WAPI_getParameter($tSource)
				
				
				Case of 
					: ($quote["dash-quote-delivery"]="mg")  // show additional MG delivery options
						WAPI_pushDOMClass("dash-quote-wire-hidden"; "hidden"; "add")
						WAPI_pushDOMClass("dash-quote-delivery-hidden"; "hidden"; "remove")
						$quote["dash-quote-delivery-mg"]:=""  //"D"  //set default - cash
						$quote["dash-quote-delivery-mg-code"]:=""
						
					: ($quote["dash-quote-delivery"]="N")  // bank/wire transfer
						WAPI_pushDOMClass("dash-quote-delivery-hidden"; "hidden"; "add")
						WAPI_pushDOMClass("dash-quote-wire-hidden"; "hidden"; "add")
						
						If (Storage:C1525.wiresMap.query("alpha2 == :1"; $tToCountry).length>0)
							If (Storage:C1525.wiresMap.query("alpha2 == :1"; $tToCountry)[0].ccy.length>1)
								WAPI_pushDOMClass("dash-quote-wire-hidden"; "hidden"; "remove")
							Else 
								$tToCCY:=""
								WAPI_pushDOMHTML("dash-quote-to-amount-pre"; $tToCCY)
								WAPI_pushDOMImgSrc("dash-quote-to-amount-post"; webGetFlag_Currency($tToCCY))
							End if 
						End if 
						
					Else 
						WAPI_pushDOMClass("dash-quote-wire-hidden"; "hidden"; "add")
						WAPI_pushDOMClass("dash-quote-delivery-hidden"; "hidden"; "add")
						$quote["dash-quote-delivery-mg"]:=""
						$quote["dash-quote-delivery-mg-code"]:=""
				End case 
				
				$doGetRates:=True:C214
				
				
				
			: ($tEvent="click") & ($tSource="dash-quote-pay-@")  // -- PAMENT METHODS - POLI/PAYMARK/SQUARE
				WAPI_pushDOMClass("dash-quote-pay-*"; "btn-primary"; "remove")
				WAPI_pushDOMClass($tSource; "btn-primary"; "add")
				$quote["dash-quote-pay"]:=Replace string:C233($tSource; "dash-quote-pay-method-"; "")
				
				
				
			: ($tEvent="change") & ($tSource="dash-quote-from-amount")  // -- FROM AMOUNT
				$rFromAmount:=Num:C11(WAPI_getParameter($tSource))
				$quote["dash-quote-from-amount"]:=$rFromAmount
				$TransferCalcMode:="QEX_FEE"
				$quote["dash-quote-transfer-calc-mode"]:=$TransferCalcMode
				$bRefresh:=True:C214
				
			: ($tEvent="change") & ($tSource="dash-quote-to-amount")  // -- TO AMOUNT
				$rToAmount:=Num:C11(WAPI_getParameter($tSource))
				$quote["dash-quote-to-amount"]:=$rToAmount
				$TransferCalcMode:="QRECEIVE_FEE"
				$quote["dash-quote-transfer-calc-mode"]:=$TransferCalcMode
				$bRefresh:=True:C214
				
			: (($tEvent="change") | ($tEvent="click")) & ($tSource="dash-quote-to-ccy-mg@")
				$tToCCY:=WAPI_getParameter($tSource)
				$quote["dash-quote-to-ccy"]:=$tToCCY
				$bRefresh:=True:C214
				
			: ($tEvent="change") & ($tSource="dash-to-ccy")
				$rFromAmount:=100  //Num(WAPI_getParameter ("dash-from-amount"))
				$tToCCY:=WAPI_getParameter("dash-to-ccy")
				$doGetRates:=True:C214
				$bRefresh:=True:C214
				
			: ($tEvent="change") & ($tSource="dash-quote-promo-code")
				$quote["dash-quote-promo-code"]:=WAPI_getParameter($tSource)
				$bRefresh:=True:C214
				
			: ($tEvent="click")
				WAPI_pushDOMClass("live-rate-*"; "btn-primary"; "remove")
				WAPI_pushDOMClass($tSource; "btn-primary"; "add")
			Else 
				$bRefresh:=False:C215
		End case 
		
	Else 
		
End case 

//-- DO WE NEED TO GET RATES ---
If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))
	$doGetRates:=False:C215
	
	Case of 
		: ($tEvent="onload")
		: ($tSource="dash-quote-delivery-mg@")  // change in mg delivery method
		: ($tSource="dash-quote-pay-method@")  //  change in payment method
			If ($quote["dash-quote-pay"]="SQ@")
				$doGetRates:=True:C214  // need to get the fee
			End if 
		: ($tSource="dash-quote-to-ccy-mg@")
		: ($quote["dash-quote-from-ccy"]="")
		: ($quote["dash-quote-from-country"]="")
		: ($quote["dash-quote-from-amount"]=0) & ($TransferCalcMode="QEX_FEE")
		: ($quote["dash-quote-to-amount"]=0) & ($TransferCalcMode="QRECEIVE_FEE")
			//: ($quote["dash-quote-pay"]="") // currently ok to be blank
		: ($quote["dash-quote-delivery"]="")
		Else 
			$doGetRates:=True:C214
	End case 
	
End if 



If ($doGetRates)  //get rates
	
	If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))
		If ($quote["dash-quote-delivery"]="mg")  // get MG quote here
			$doGetRates:=False:C215  // use MG for rates not our tieredRates
			
			C_OBJECT:C1216($mgQuotes)
			// we get the following back - 1 per delivery type
			// Country. -- destination/TOCOUNTRY
			// TransferAmount. -- destination/TOAMOUNT
			// TransferCurrency --  destination/TOCCY
			// TransferExchangeRate. -- 
			
			// DeliveryOptionCode
			// DeliveryOptionName
			
			// TransferSendCurrency. -- fromCCY
			// TransferSendAmount. -- from amount after fee
			// TransferTotalFeeAmount. -- from fee
			// TransferTotalSendAmount -- from amount
			
			//TransferTotalSendAmount=TransferSendAmount+TransferTotalFeeAmount. // local ccy
			Case of 
				: ($TransferCalcMode="QEX_FEE")
					$mgQuotes:=mgGetQuote($quote["dash-quote-from-amount"]; $quote["dash-quote-from-ccy"]; $quote["dash-quote-to-country"]; "QEX_FEE"; $quote["dash-quote-promo-code"])
					
				: ($TransferCalcMode="QRECEIVE_FEE")
					$mgQuotes:=mgGetQuote($quote["dash-quote-to-amount"]; $quote["dash-quote-from-ccy"]; $quote["dash-quote-to-country"]; "QRECEIVE_FEE"; $quote["dash-quote-promo-code"])
					
				: ($TransferCalcMode="QINC_FEE")
					$mgQuotes:=mgGetQuote($quote["dash-quote-from-amount"]; $quote["dash-quote-from-ccy"]; $quote["dash-quote-to-country"]; "QINC_FEE"; $quote["dash-quote-promo-code"])
					
				Else 
					$mgQuotes:=mgGetQuote($quote["dash-quote-from-amount"]; $quote["dash-quote-from-ccy"]; $quote["dash-quote-to-country"]; "QEX_FEE"; $quote["dash-quote-promo-code"])
			End case 
			// TODO - FOR DELIVERY OPTIONS - REMOVE OPTIONS NOT AVAILABLE
			
			If ($mgQuotes.success)  // we get the following back - 1 per delivery type
				$quote["dash-quote-mg-options"]:=$mgQuotes.result  // store all results
				$quote["dash-quote-mg-refresh-dts"]:=DATE_getCurrentDTS  //store when the refresh happened
			Else 
				$quote["dash-quote-mg-options"]:=New collection:C1472
				WAPI_pushDisplayMessage("ERROR"; "MG Server unreachable. Please try again later.<br>"+OB Get:C1224($mgQuotes; "err"; Is text:K8:3)+": "+$mgQuotes.mgerrormsg.message)
			End if 
			
		Else 
			$doGetRates:=True:C214
		End if 
		
	Else 
	End if 
	
	
	If ($doGetRates)  // tieredRates
		
		Case of 
			: ($quote["dash-quote-delivery"]="N")  // wire/bank transfer
				$transferMode:="wire"
				$rFromAmount:=roundToBase($rFromAmount)
				
			: ($quote["dash-quote-delivery"]="N-M")  // mobile wallet
				$transferMode:="wallet"
			: ($quote["dash-quote-delivery"]="D")  // cash
				$transferMode:="cash"
			Else 
				$transferMode:="ewire"
		End case 
		
		Case of 
			: ($TransferCalcMode="QEX_FEE")  // send amt plus fee
				$o:=getTieredRate($tToCCY; $tFromCCY; $rFromAmount; False:C215; [Customers:3]GroupName:90; [Customers:3]CustomerID:1; $transferMode)
				
			: ($TransferCalcMode="QRECEIVE_FEE")  // recieve amt plus fee
				$o:=getTieredRate($tToCCY; $tFromCCY; $rToAmount; False:C215; [Customers:3]GroupName:90; [Customers:3]CustomerID:1; $transferMode)
				
			: ($TransferCalcMode="QINC_FEE")  // send amt minus fee
				$o:=getTieredRate($tToCCY; $tFromCCY; $rFromAmount+$rFromFee; False:C215; [Customers:3]GroupName:90; [Customers:3]CustomerID:1; $transferMode)
				
			Else 
				$o:=getTieredRate($tToCCY; $tFromCCY; $rFromAmount; False:C215; [Customers:3]GroupName:90; [Customers:3]CustomerID:1; $transferMode)
		End case 
		
		//customer ccy is the base/denomonitor - always calc in the local currency
		// direct rate is the price of the product
		$rDirectRate:=$o.rate
		$rInverseRate:=$o.inverse
		$rBase:=$o.base
		$rFromFee:=$o.fee
		$rMargin:=$o.margin
		$tGroup:=$o.group
		$tCustomerID:=$o.customer
		$mop:=$o.mop
		
		If ($rDirectRate>0)
			
			If ($rInverseRate=0)
				$rInverseRate:=1/$rDirectRate
				$rInverseRate:=Round:C94($rInverseRate; 6)
			End if 
			
			Case of 
				: ($TransferCalcMode="QEX_FEE")  // get the TO AMT plus fee
					$rToAmount:=Round:C94(($rFromAmount)*$rInverseRate; 2)
					$rAmountDue:=$rFromAmount+$rFromFee
					
				: ($TransferCalcMode="QINC_FEE")  // get the TO AMT includes the fee -- NEEDS TESTING??
					$rToAmount:=Round:C94(($rFromAmount-$rFromFee)*$rInverseRate; 2)
					$rFromAmount:=$rFromAmount-$rFromFee  // updated from amount
					$rAmountDue:=$rFromAmount+$rFromFee
					
				: ($TransferCalcMode="QRECEIVE_FEE")  // get the FROM AMT 
					$rFromAmount:=roundToBase($rToAmount*$rDirectRate)
					$rAmountDue:=$rFromAmount+$rFromFee
					
				Else 
					$rToAmount:=Round:C94(($rFromAmount)*$rInverseRate; 2)
					$rAmountDue:=$rFromAmount+$rFromFee
			End case 
			
		Else 
			$rToAmount:=0
		End if 
		
		If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))
			If ($quote["dash-quote-pay"]="SQ@")
				$sqFee:=Num:C11(getKeyValue("web.configuration.payments.square.fee.percentage"))
				If ($sqFee>0)
					$rSqAmount:=Round:C94(($rAmountDue*$sqFee); 2)
					$rFromFee:=$rFromFee+$rSqAmount
					$rAmountDue:=$rAmountDue+$rSqAmount  // $rAmountDue already has base fee included
				End if 
			End if 
			
			$quote["dash-quote-direct-rate"]:=$rDirectRate
			$quote["dash-quote-inverse-rate"]:=$rInverseRate
			$quote["dash-quote-from-fee"]:=$rFromFee
			$quote["dash-quote-from-amount"]:=$rFromAmount
			$quote["dash-quote-amount-due"]:=$rFromAmount+$rFromFee
			
			$quote["dash-quote-base"]:=$rBase
			$quote["dash-quote-to-amount"]:=$rToAmount
		End if 
		
	End if 
	
	$bRefresh:=True:C214  //if we update rates we need to refresh
End if 



If ($bRefresh)
	
	If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))
		
		If ($quote["dash-quote-delivery"]="mg")  // ONLY FOR MG OPTIONS
			
			ARRAY TEXT:C222($atSelectName; 0)
			ARRAY TEXT:C222($atSelectValue; 0)
			
			//to ccy options
			$toCcyID:=String:C10(mgCurrencyCode2CurrencyID($quote["dash-quote-to-ccy"]))
			
			C_COLLECTION:C1488($mgCcyOptions)
			$mgCcyOptions:=$quote["dash-quote-mg-options"].distinct("TransferCurrency")
			If ($mgCcyOptions=Null:C1517)
			Else 
				$iPos:=$mgCcyOptions.indexOf($toCcyID)
				If ($iPos>0)  //all good
				Else 
					$toCcyID:=$mgCcyOptions[0]
					$quote["dash-quote-to-ccy"]:=mgCurrencyID2CurrencyCode(Num:C11($toCcyID))
				End if 
				
				If ($mgCcyOptions.length>1)
					ARRAY TEXT:C222($atSelectName; 0)
					For each ($code; $mgCcyOptions)
						APPEND TO ARRAY:C911($atSelectName; mgCurrencyID2CurrencyCode(Num:C11($code)))
					End for each 
					WAPI_pushDOMSelectOptions("dash-quote-to-ccy-mg"; ->$atSelectName; ->$atSelectName; ->$atSelectName; $quote["dash-quote-to-ccy"])
					WAPI_pushDOMClass("dash-quote-to-ccy-mg-group"; "hidden"; "remove")
				Else 
					WAPI_pushDOMClass("dash-quote-to-ccy-mg-group"; "hidden"; "add")
				End if 
				
			End if 
			
			// find the $mgQuote.result with DeliveryOptionCode = "dash-quote-delivery-mg"
			$mgDelivery:=$quote["dash-quote-delivery-mg"]
			
			C_COLLECTION:C1488($mgQuoteOptions)
			$mgQuoteOptions:=$quote["dash-quote-mg-options"].query("TransferCurrency == :1"; $toCcyID)
			
			If ($mgQuoteOptions=Null:C1517)
			Else 
				ARRAY TEXT:C222($atSelectName; 0)
				ARRAY TEXT:C222($atSelectValue; 0)
				COLLECTION TO ARRAY:C1562($mgQuoteOptions; $atSelectName; "DeliveryOptionDisplayName"; $atSelectValue; "DeliveryOptionDisplayName")
				
				$iPos:=Find in array:C230($atSelectValue; $mgDelivery)
				
				$rMargin:=0
				$tGroup:=""
				$tCustomerID:=""
				$mop:=""
				
				If ($iPos=-1)  // revert to default - should be cash
					
					$mgQuote:=$quote["dash-quote-mg-options"].query("TransferCurrency == :1"; $toCcyID)
					
					$rInverseRate:=Num:C11($mgQuote[0].TransferExchangeRate)
					$rDirectRate:=1/$rInverseRate
					$rBase:=Num:C11($mgQuote[0].TransferExchangeRate)
					$rFromFee:=Num:C11($mgQuote[0].TransferTotalFeeAmount)
					$rFromAmount:=Num:C11($mgQuote[0].TransferSendAmount)
					$rAmountDue:=Num:C11($mgQuote[0].TransferTotalSendAmount)
					$tFromCCY:=mgCurrencyID2CurrencyCode(Num:C11($mgQuote[0].TransferSendCurrency))
					$tToCCY:=mgCurrencyID2CurrencyCode(Num:C11($mgQuote[0].TransferCurrency))
					$rToAmount:=Num:C11($mgQuote[0].TransferAmount)
					//$mgDelivery:=$mgQuote[0].DeliveryOptionCode  // reset to first option
					$mgDelivery:=$mgQuote[0].DeliveryOptionDisplayName  // reset to first option
					//$quote["dash-quote-delivery-mg"]:=mgGetCxrCodeByDeliveryCode ($mgDelivery)  // set the delivery option per result
					$quote["dash-quote-delivery-mg"]:=$mgDelivery  // set the delivery option per result
					$quote["dash-quote-delivery-mg-code"]:=$mgQuote[0].DeliveryOptionCode
					$quote["dash-quote-transfer-to-point-id"]:=$mgQuote[0].TransferToPointId
					
				Else 
					C_COLLECTION:C1488($mgQuote)
					//$mgQuote:=$quote["dash-quote-mg-options"].query("DeliveryOptionCode == :1 AND TransferCurrency == :2";$mgDelivery;String(mgCurrencyCode2CurrencyID ($quote["dash-quote-to-ccy"])))
					$mgQuote:=$quote["dash-quote-mg-options"].query("DeliveryOptionDisplayName == :1 AND TransferCurrency == :2"; $mgDelivery; String:C10(mgCurrencyCode2CurrencyID($quote["dash-quote-to-ccy"])))
					
					If ($mgQuote.length>0)
						$rInverseRate:=Num:C11($mgQuote[0].TransferExchangeRate)  //1/$rDirectRate
						$rDirectRate:=1/$rInverseRate
						
						$rBase:=Num:C11($mgQuote[0].TransferExchangeRate)
						$rFromAmount:=Num:C11($mgQuote[0].TransferSendAmount)  // before fees
						$rFromFee:=Num:C11($mgQuote[0].TransferTotalFeeAmount)
						$rAmountDue:=Num:C11($mgQuote[0].TransferTotalSendAmount)  // includes fees
						
						$tFromCCY:=mgCurrencyID2CurrencyCode(Num:C11($mgQuote[0].TransferSendCurrency))
						$tToCCY:=mgCurrencyID2CurrencyCode(Num:C11($mgQuote[0].TransferCurrency))
						$rToAmount:=Num:C11($mgQuote[0].TransferAmount)
						
						$quote["dash-quote-delivery-mg-code"]:=$mgQuote[0].DeliveryOptionCode
						$quote["dash-quote-transfer-to-point-id"]:=$mgQuote[0].TransferToPointId
						
					Else   // try again without del option
						$mgQuote:=$quote["dash-quote-mg-options"].query("TransferCurrency == :1"; String:C10(mgCurrencyCode2CurrencyID($quote["dash-quote-to-ccy"])))
						
						If ($mgQuote.length>0)
							//$mgDelivery:=$mgQuote[0].DeliveryOptionCode
							$mgDelivery:=$mgQuote[0].DeliveryOptionDisplayName
							//$quote["dash-quote-delivery-mg"]:=mgGetCxrCodeByDeliveryCode ($mgDelivery)  // set the delivery option per result
							$quote["dash-quote-delivery-mg"]:=$mgQuote[0].DeliveryOptionDisplayName  //$mgDelivery  // set the delivery option per result
							$quote["dash-quote-delivery-mg-code"]:=$mgQuote[0].DeliveryOptionCode
							$quote["dash-quote-transfer-to-point-id"]:=$mgQuote[0].TransferToPointId
						End if 
					End if 
					
					If ($mgQuote.length>0)
						$rInverseRate:=Num:C11($mgQuote[0].TransferExchangeRate)
						$rDirectRate:=1/$rInverseRate
						
						$rBase:=Num:C11($mgQuote[0].TransferExchangeRate)
						$rFromAmount:=Num:C11($mgQuote[0].TransferSendAmount)  // before fees
						$rFromFee:=Num:C11($mgQuote[0].TransferTotalFeeAmount)
						$rAmountDue:=Num:C11($mgQuote[0].TransferTotalSendAmount)  // includes fees
						
						$tFromCCY:=mgCurrencyID2CurrencyCode(Num:C11($mgQuote[0].TransferSendCurrency))
						$tToCCY:=mgCurrencyID2CurrencyCode(Num:C11($mgQuote[0].TransferCurrency))
						$rToAmount:=Num:C11($mgQuote[0].TransferAmount)
						
					Else 
						$rInverseRate:=-1
						$rDirectRate:=-1
						$rBase:=0
						$rFromAmount:=0
						$rFromFee:=0
						$rAmountDue:=0
						$rToAmount:=0
					End if 
					
				End if 
				
				
				$quote["dash-quote-direct-rate"]:=$rDirectRate
				$quote["dash-quote-inverse-rate"]:=$rInverseRate
				$quote["dash-quote-from-fee"]:=$rFromFee
				$quote["dash-quote-from-amount"]:=$rFromAmount
				$quote["dash-quote-amount-due"]:=$rAmountDue  // includes fees
				$quote["dash-quote-base"]:=$rBase
				$quote["dash-quote-to-amount"]:=$rToAmount
				$quote["dash-quote-to-ccy"]:=$tToCCY
				$quote["dash-quote-from-ccy"]:=$tFromCCY
				
			End if 
			
			If (True:C214)  // REFRESH - UDPATE MG DELIVERY OPTIONS
				
				
				If (True:C214)  // check to see if we have stored a quote and push those values
					
					WAPI_pushDOMSelectOptions("dash-quote-delivery-mg"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; $quote["dash-quote-delivery-mg"])
					WAPI_pushDOMSelectedOption("dash-quote-delivery-mg"; $quote["dash-quote-delivery-mg"])
					
					If ($quote["dash-quote-delivery"]="MG") & (Size of array:C274($atSelectName)>0)
						WAPI_pushDOMClass("dash-quote-delivery-hidden"; "hidden"; "remove")
					Else 
						WAPI_pushDOMClass("dash-quote-delivery-hidden"; "hidden"; "add")
					End if 
					
				End if 
			End if 
			
		End if 
		
		
		If ($rDirectRate>0)
			WAPI_pushDOMHTML("dash-quote-rate"; String:C10($rInverseRate; "###,##0.0000"))
			WAPI_pushDOMHTML("rate-notes"; $tRateNotes)
			WAPI_pushDOMClass("dash-quote-rate-exchange-group"; "hidden"; "remove")
		Else 
			WAPI_pushDOMHTML("dash-quote-rate"; "---")
			WAPI_pushDOMClass("dash-quote-rate-exchange-group"; "hidden"; "add")
		End if 
		
		WAPI_pushDOMValue("dash-quote-promo-code"; $quote["dash-quote-promo-code"])
		
		WAPI_pushDOMValue("dash-quote-from-amount"; String:C10($rFromAmount; "###,###,###,##0.00"))
		WAPI_pushDOMImgSrc("dash-quote-from-amount-post"; webGetFlag_Currency($tFromCCY))
		WAPI_pushDOMHTML("dash-quote-from-amount-pre"; $tFromCCY)
		
		WAPI_pushDOMValue("dash-quote-to-amount"; String:C10($rToAmount; "###,###,###,##0.00"))
		WAPI_pushDOMImgSrc("dash-quote-to-amount-post"; webGetFlag_Currency($tToCCY))
		WAPI_pushDOMHTML("dash-quote-to-amount-pre"; $tToCCY)
		
		WAPI_pushDOMHTML("dash-quote-from-fee"; String:C10($rFromFee; "###,###,##0.00"))
		WAPI_pushDOMHTML("dash-quote-amount-due"; String:C10($rAmountDue; "###,###,###,##0.00"))
		
		If (Choose:C955(getKeyValue("web.customers.module.quotes.show.rateinfo")="true"; True:C214; False:C215))
			C_TEXT:C284($tRateNotes)
			$tRateNotes:=$tToCCY+"->"+$tFromCCY+"  Rate Rule: "+$tCustomerID+" | "+$tGroup+" | Base: "+String:C10($rBase)+" Margin: "+String:C10($rMargin)+" Fee: "+String:C10($rFromFee)
			WAPI_pushDOMHTML("dash-quote-rate-help"; $tRateNotes)
		End if 
		
		WAPI_pushDOMClass("dash-quote-pay-method-"+$quote["dash-quote-pay"]; "btn-primary"; "add")  // highlight the payment method/ POLI/EFTPOS/other
		
	End if 
	
	
	If (Choose:C955(getKeyValue("web.customers.module.rates.show")="true"; True:C214; False:C215))
		If (True:C214)
			WAPI_pushDOMValue("dash-from-ccy"; $tFromCCY)
			WAPI_pushJs("$('#dash-to-ccy option[value=\""+$tToCCY+"\"]').prop('selected', true);")
		Else 
			WAPI_pushDOMValue("dash-from-ccy"; getCountryNameByCode($tFromCountry))
			WAPI_pushDOMValue("dash-to-ccy"; getCountryNameByCode($tToCountry))
		End if 
		
		WAPI_pushDOMValue("dash-to-amount"; String:C10($rToAmount; "###,###,###,##0.00"))
		
		If ($rDirectRate>0)
			WAPI_pushDOMHTML("dash-rate"; String:C10($rInverseRate; "###,###,##0.0000"))
			WAPI_pushDOMHTML("rate-notes"; $tRateNotes)
		Else 
			WAPI_pushDOMHTML("dash-rate"; "Rates Unavailable")
		End if 
		
		WAPI_pushDOMImgSrc("dash-from-amount-post"; webGetFlag_Currency($tFromCCY))
		WAPI_pushDOMImgSrc("dash-to-amount-post"; webGetFlag_Currency($tToCCY))
	End if 
End if 



If (Choose:C955(getKeyValue("web.customers.module.quotes.show")="true"; True:C214; False:C215))  //-- IS COMPLETE -- ??
	$isComplete:=False:C215
	Case of 
		: ($quote["dash-quote-from-ccy"]="")
		: ($quote["dash-quote-from-country"]="")
		: ($quote["dash-quote-direct-rate"]=0)
		: ($quote["dash-quote-inverse-rate"]=0)
		: ($quote["dash-quote-to-amount"]=0)
		: ($quote["dash-quote-from-amount"]=0)
		: ($quote["dash-quote-pay"]="")
		: ($quote["dash-quote-delivery"]="")
		Else 
			$isComplete:=True:C214
	End case 
	
	WAPI_pushDOMProperty("wapi-create-quote-btn"; "disabled"; Choose:C955($isComplete; "false"; "true"))
	
	$status:=WAPI_sessionSet("quote"; New object:C1471("value"; $quote))
End if 


WAPI_pushJs("wapiShowProcessing(false)")
//ALERT("done "+Current method name)
$0:=WAPI_pullJsStack