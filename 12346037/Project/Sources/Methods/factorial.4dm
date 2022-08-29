//%attributes = {}
// factorial (n: longint) : longint
// returns the factorial of n

// Unit test is written @Nora


C_LONGINT:C283($1; $0; $n; $i; $val)

$n:=$1

//****** Recursive Factorial Function ******

//If ($n<=1)
//$0:=1
//Else 
//$0:=$n*factorial ($n-1)
//End if 

// ***** Factorial Function with For Loop *****
//$i:=0
//$val:=1

//For ($i;1;$n;)
//If ($n<=1)
//$0:=1
//Else 
//$val:=$val*$i
//End if 
//End for 
//$0:=$val

// ***** Factorial Function with While Loop ****

$i:=1
$val:=1
While ($i<=$n)
	If ($n<=1)
		$0:=1
	Else 
		$val:=$val*$i
	End if 
	$i:=$i+1
End while 
$0:=$val

//**** Factorial Function with Repeat...Until ****
//$i:=1
//$val:=1
//Repeat 
//If ($n<=1)
//$0:=1
//Else 
//$val:=$val*$i
//End if 
//$i:=$i+1
//Until ($i<=$n)
//$0:=$val





