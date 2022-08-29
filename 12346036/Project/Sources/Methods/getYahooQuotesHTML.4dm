//%attributes = {"publishedWeb":true}
// getYahooQuotesHTML ( fromCurrency;toCurrecy;fromAmount) -> HTML

C_TEXT:C284($1; $2; $fromCurrency; $toCurrency)
C_TEXT:C284($0)

C_TEXT:C284($webpage; $URL; $subURL)
C_REAL:C285($fromAmount)
C_LONGINT:C283($vLength; $vOffset)

$fromCurrency:=$1
$toCurrency:=$2
If (Count parameters:C259=3)
	$fromAmount:=$3
Else 
	$fromAmount:=1
End if 

$URL:=getUpdateSourceMainURL
$subURL:=getUpdateSourceSubURL($fromAmount; $fromCurrency; $toCurrency)

C_BLOB:C604($blob)
$blob:=fetchBLOBfromURL($url; $subURL)
//saveBLOBtoFile ($blob;$fromCurrency+$toCurrency+".html")  ` writes the fetched html to file

Case of 
	: (<>updateSource="reuters")
		$vOffset:=34000
		$vLength:=6000
	: (<>updateSource="yahoo")
		$vOffset:=23000
		$vLength:=1000
End case 
//saveBLOBtoFile($blob;"testBlob.txt")
$webPage:=BLOB to text:C555($blob; Mac text without length:K22:10; $vOffset; $vLength)

//saveTextToFile ($webPage;$fromCurrency+$toCurrency+".txt")

$0:=$webpage