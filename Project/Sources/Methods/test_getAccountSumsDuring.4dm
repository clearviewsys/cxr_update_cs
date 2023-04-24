//%attributes = {}
// #unit-testing for getAccountSumsDuring


var $accountID : Text
var $from; $to : Date
var $sums : Object
var $a1; $a2; $a3; $b1; $b2; $b3 : Real

$accountID:="Cash-USD"

$sums:=getAccountSumsDuring($accountID)
$a1:=$sums.sumDebits
$b1:=$sums.subCredits

$from:=!00-00-00!
$sums:=getAccountSumsDuring($accountID; $from)
$a2:=$sums.sumDebits
$b2:=$sums.subCredits

ASSERT:C1129($a1=$a2)
ASSERT:C1129($b1=$b2)

$to:=!00-00-00!
$sums:=getAccountSumsDuring($accountID; $from; $to)
$a1:=$sums.sumDebits
$b1:=$sums.subCredits

ASSERT:C1129($a1=$a2)
ASSERT:C1129($b1=$b2)


$sums:=getAccountSumsDuring("Cash-EUR"; Current date:C33; Current date:C33)
$sums:=getAccountSumsDuring("Cash-USD"; Current date:C33; Current date:C33)

var $obj : Object
$obj:=New object:C1471
$obj.branchID:=""
$sums:=getAccountSumsDuring("Cash-USD"; Add to date:C393(Current date:C33; 0; 0; -2); Current date:C33; $obj)

$obj.subAccountID:="ME**"
$sums:=getAccountSumsDuring("Cash-USD"; Current date:C33; Current date:C33; $obj)
ASSERT:C1129($sums.balance=0)

// assuming Designer did some USD transactions in the past
$obj.subAccountID:=""
$obj.branchID:=""
$obj.userID:="Designer"
$sums:=getAccountSumsDuring("Cash-USD"; !00-00-00!; Current date:C33; $obj)
ASSERT:C1129($sums.balance>0)



