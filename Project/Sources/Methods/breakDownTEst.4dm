//%attributes = {}
//C_REAL($number; $remainder)

//C_LONGINT($n)
//C_BOOLEAN($considerAvailability)

//$n:=10
//$number:=1334.34
//$considerAvailability:=False

//ARRAY REAL(denomArr; 10)
//ARRAY REAL(availabilityArr; 10)
//ARRAY REAL(resultArr; 10)

//denomArr{1}:=1000
//denomArr{2}:=100
//denomArr{3}:=50
//denomArr{4}:=20
//denomArr{5}:=10
//denomArr{6}:=5
//denomArr{7}:=2
//denomArr{8}:=1
//denomArr{9}:=0.25
//denomArr{10}:=0.01

//availabilityArr{1}:=0
//availabilityArr{2}:=8
//availabilityArr{3}:=3
//availabilityArr{4}:=20
//availabilityArr{5}:=20
//availabilityArr{6}:=4
//availabilityArr{7}:=3
//availabilityArr{8}:=2
//availabilityArr{9}:=100
//availabilityArr{10}:=1000

//
//C_REAL($result;$remainder)
//For ($i;1;$n)
//If ($considerAvailability)
//$result:=calcMin (Int($number/denomArr{$i});availabilityArr{$i})
//Else 
//$result:=Int($number/denomArr{$i})
//End if 
//$remainder:=$number-($result*denomArr{$i})
//resultArr{$i}:=$result
//$number:=$remainder
//End for 
//$remainder:=breakAmountIntoDenoms(5320.28; ->denomArr; ->resultArr)
//$remainder:=breakAmountIntoDenoms(1400.03; ->denomArr; ->resultArr)
//$remainder:=breakAmountIntoDenoms(278.01; ->denomArr; ->resultArr)
