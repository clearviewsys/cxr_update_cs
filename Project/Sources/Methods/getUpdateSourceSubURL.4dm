//%attributes = {}
// getUpdateSourceSubURL(fromAmout;fromCurrency;toCurrency)


C_REAL:C285($fromAmount; $1)
C_TEXT:C284($2; $3; $fromCurrency; $toCurrency)
C_TEXT:C284($0; $subURL)

$fromAmount:=$1
$fromCurrency:=$2
$toCurrency:=$3

Case of 
	: (<>updateSource="reuters")
		// http://www.reuters.com/financeCurrencies.jhtml?amt=1000&fromCurrencies=USD&toCurrencies=IRR&result=

		$subURL:="financeCurrencies.jhtml?amt="+String:C10($fromAmount)+"&fromCurrencies="+$fromCurrency+"&toCurrencies="+$toCurrency+"&result="
		//http://www.reuters.com/financeCurrencies.jhtml?amt=1.00&fromCurrencies=USD&toCurrencies=AED&result=

	: (<>updateSource="yahoo")
		//http://finance.yahoo.com/currency/convert?amt=1000&from=USD&to=IRR&submit=Convert

		$subURL:="currency/convert?amt="+String:C10($fromAmount)+"&from="+$fromCurrency+"&to="+$toCurrency+"&submit=Convert"
		//

		
End case 

$0:=$subURL