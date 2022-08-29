//%attributes = {}
// roundthiscurrencyrateFields

// PLEASE DO NOT CHANGE THE ORDER OF THE FOLLOWING TWO PARAGRAPH
// IT IS IMPORTANT TO ROUND THE INVERSE VALUES FIRST BEFORE ROUND THE MAIN VALUES
C_REAL:C285($spotRate; $ourBuy; $ourSell)
$spotRate:=[Currencies:6]SpotRateLocal:17
$ourBuy:=[Currencies:6]OurBuyRateLocal:7
$ourSell:=[Currencies:6]OurSellRateLocal:8

[Currencies:6]OurBuyRateInverse:25:=Round:C94(calcSafeDivide(1; $ourBuy); [Currencies:6]RoundDigitInverse:28)
[Currencies:6]spotRateInverse:41:=Round:C94(calcSafeDivide(1; $spotRate); [Currencies:6]RoundDigitInverse:28)
[Currencies:6]OurSellRateInverse:26:=Round:C94(calcSafeDivide(1; $ourSell); [Currencies:6]RoundDigitInverse:28)

[Currencies:6]OurBuyRateLocal:7:=Round:C94($ourBuy; [Currencies:6]RoundDigit:27)
[Currencies:6]SpotRateLocal:17:=Round:C94($spotRate; [Currencies:6]RoundDigit:27)
[Currencies:6]OurSellRateLocal:8:=Round:C94($ourSell; [Currencies:6]RoundDigit:27)
