C_REAL:C285($coef; $value)
C_TEXT:C284($str)
$str:=Self:C308->{Self:C308->}
$value:=100000

Case of 
	: ($str="Austrian Schilling")
		$coef:=Euro converter:C676($value; Austrian Schilling:K40:1; Euro:K40:12)
	: ($str="Belgian Franc")
		$coef:=Euro converter:C676($value; Belgian Franc:K40:11; Euro:K40:12)
	: ($str="Deutschemark")
		$coef:=Euro converter:C676($value; Deutsche Mark:K40:6; Euro:K40:12)
	: ($str="Finnish Markka")
		$coef:=Euro converter:C676($value; Finnish Markka:K40:2; Euro:K40:12)
	: ($str="French Franc")
		$coef:=Euro converter:C676($value; French Franc:K40:5; Euro:K40:12)
	: ($str="Greek drachma")
		$coef:=Euro converter:C676($value; Greek Drachma:K40:13; Euro:K40:12)
	: ($str="Irish Pound")
		$coef:=Euro converter:C676($value; Irish Pound:K40:3; Euro:K40:12)
	: ($str="Italian Lire")
		$coef:=Euro converter:C676($value; Italian Lira:K40:8; Euro:K40:12)
	: ($str="Luxembourg Franc")
		$coef:=Euro converter:C676($value; Luxembourg Franc:K40:10; Euro:K40:12)
	: ($str="Netherlands Guilder")
		$coef:=Euro converter:C676($value; Netherlands Guilder:K40:4; Euro:K40:12)
	: ($str="Portuguese Escudo")
		$coef:=Euro converter:C676($value; Portuguese Escudo:K40:7; Euro:K40:12)
	: ($str="Spanish Peseta")
		$coef:=Euro converter:C676($value; Spanish Peseta:K40:9; Euro:K40:12)
		
End case 

[Currencies:6]MarketAdjustCoef:39:=$coef/$value
[Currencies:6]MarketAdjusterValue:38:=0
