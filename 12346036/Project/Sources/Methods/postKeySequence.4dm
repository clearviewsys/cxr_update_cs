//%attributes = {}
// postKeySequence (string:keysequence; boolean:tab)
// this method simulates a series of keyboard entries
// this can be used for testing the speed of data entry in forms

C_TEXT:C284($1; $str; $char)
C_BOOLEAN:C305($2; $tab)
C_LONGINT:C283($n; $i)

Case of 
	: (Count parameters:C259=0)
		$str:="ABC"
		$tab:=False:C215
		
	: (Count parameters:C259=1)
		$str:=$1
		$tab:=False:C215
	: (Count parameters:C259=2)
		$str:=$1
		$tab:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$n:=Length:C16($str)

For ($i; 1; $n)
	$char:=Substring:C12($str; $i; 1)
	
	If (($char="\\") & ($i<$n))
		
		If (Substring:C12($str; $i+1; 1)="t")  // the next char is a tab
			
			postTabKey
			$i:=$i+2  // advance two chars assuming there will be more
			
			If ($i<$n)
				$char:=Substring:C12($str; $i; 1)  // read the next char after tab
			End if 
			
		End if 
	End if 
	If ($i<=$n)
		POST KEY:C465(Character code:C91($char))
	End if 
	//DELAY PROCESS(Current process;60)
End for 

If ($tab)
	postTabKey
End if 