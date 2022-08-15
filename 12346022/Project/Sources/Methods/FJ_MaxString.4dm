//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FJ_MaxString: 
// Check if string is greater than a max chars and split into lines.
// 
// Parameters: 
//   $1: String to format  (Input - String) 
//   $2: max length   (Input - Number) 
//   $3: Max Lines 
//    $4: Add CRLF?
//
// Return:
//   $0: Number formated  (Output - String)
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/07/2015
// ------------------------------------------------------------------------------
//Unit test written @Zoya 
C_TEXT:C284($1; $stringToFormat)
C_LONGINT:C283($2; $max)  // Max Length
C_LONGINT:C283($3; $maxLines)  // Max Lines

C_TEXT:C284($0; $tmp; $line)
C_BOOLEAN:C305($crlf)

$crlf:=True:C214

Case of 
		
	: (Count parameters:C259=2)
		
		$stringToFormat:=FJ_Trim($1)
		$max:=$2
		$maxLines:=1
		
	: (Count parameters:C259=3)
		
		$stringToFormat:=FJ_Trim($1)
		$max:=$2
		$maxLines:=$3
		
		
	: (Count parameters:C259=4)
		
		$stringToFormat:=FJ_Trim($1)
		$max:=$2
		$maxLines:=$3
		$crlf:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($result)
C_BOOLEAN:C305($ok)
C_LONGINT:C283($i; $ticks)
ARRAY TEXT:C222($arrResult; 0)


$ok:=PHP Execute:C1058(""; "wordwrap"; $result; $stringToFormat; $max)
//$ticks:=(Random%(3))+1
//DELAY PROCESS(Current process;$ticks)
$ok:=PHP Execute:C1058(""; "explode"; $arrResult; "\n"; $result)
//DELAY PROCESS(Current process;$ticks)
If (Size of array:C274($arrResult)>$maxLines)
	
	Repeat 
		DELETE FROM ARRAY:C228($arrResult; Size of array:C274($arrResult); 1)
	Until (Size of array:C274($arrResult)<=$maxLines)
	
End if 

$result:=""
For ($i; 1; Size of array:C274($arrResult))
	$result:=$result+$arrResult{$i}
	
	If ($i<Size of array:C274($arrResult))
		$result:=$result+"\n"
	End if 
	
End for 

$0:=$result


If (False:C215)
	
	
	ARRAY TEXT:C222($arrResult; 0)
	$ok:=PHP Execute:C1058(""; "str_split"; $arrResult; $stringToFormat; $max)
	
	
	$line:=""
	
	If ($maxLines>Size of array:C274($arrResult))
		$maxLines:=Size of array:C274($arrResult)
	End if 
	
	For ($i; 1; Size of array:C274($arrResult))
		
		//$arrResult{$i}:=Replace string($arrResult{$i};Char(LF ASCII code);"")
		//$arrResult{$i}:=Replace string($arrResult{$i};Char(CR ASCII code);"")
		
		If (FJ_Trim($arrResult{$i})#"")
			
			If ($i<$maxLines)
				
				If ($crlf)
					$line:=$line+FJ_Trim($arrResult{$i})+CRLF
				Else 
					$line:=$line+FJ_Trim($arrResult{$i})
				End if 
				
			Else 
				If ($i=$maxLines)
					$line:=$line+FJ_Trim($arrResult{$i})
				End if 
				
			End if 
			
		End if 
		
	End for 
	
	$0:=FJ_Trim($line)
	
End if 
