//%attributes = {}

// updateCurrSpotRate ($dailyRateDate (text); $CurrencyCode (text); $rate (text) 
// Update the spotRate fields of [Currencies] table.
//

C_TEXT:C284($1; $dailyRateDate; $2; $code; $3; $rate)
C_BOOLEAN:C305($0; $status)
C_REAL:C285($rateRef)


Case of 
	: (Count parameters:C259=3)
		$dailyRateDate:=$1
		$code:=$2
		$rate:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// The xml date is in "yyyy-mm-dd" format
C_LONGINT:C283($yy; $mm; $dd)
C_DATE:C307($dateRef)
C_REAL:C285($rateRef)

$yy:=Num:C11(Substring:C12($dailyRateDate; 1; 4))
$mm:=Num:C11(Substring:C12($dailyRateDate; 6; 2))
$dd:=Num:C11(Substring:C12($dailyRateDate; 9; 2))

$status:=False:C215
$rateRef:=realToSystemNumFormat($rate)
$dateRef:=dateToSystemDateFormat($dd; $mm; $yy)

If ($rateRef#0)  // Ignore incorrect rates
	
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$code)
	
	If (Records in selection:C76([Currencies:6])=1)
		
		// update rate
		[Currencies:6]SpotRateLocal:17:=Trunc:C95(calcSafeDivide(1/$rateRef)*100; 12)
		SAVE RECORD:C53([Currencies:6])
		
		$status:=True:C214
	Else 
		// Ignore this new Rate, Currency doesn't exist
		$status:=True:C214
	End if 
End if 

$0:=$status

