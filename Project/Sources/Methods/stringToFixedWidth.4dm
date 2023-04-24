//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/29/18, 15:30:12
// ----------------------------------------------------
// Method: stringToFixedWidth
// Description
// 
//
// Parameters
// ----------------------------------------------------


//
//This pads a string with characters, either before or after
//
//$1 is pointer to string to pad
//$2 is preferred length of string
//   NOTE: no truncation is ever done
//$3 is ASCII value of padding character
//$4 is q for padding goes after string
//.   (otherwise the padding goes before string)
//

//============================================================
If (False:C215)  //methods and variables used indirectly herein (for Insider compatibility)
	//indirect_variables
	//indirect_method_calls
End if   //false  
//============================================================
C_TEXT:C284($1; $tString)
C_LONGINT:C283($2; $iFullLength)
C_LONGINT:C283($3; $iPadASCII)
C_BOOLEAN:C305($4; $bPadRight)


C_TEXT:C284($0)


//------------------------------------------------------------
//method_wide_constants_declarations
//------------------------------------------------------------
C_LONGINT:C283($iLength)  //actual length of parameter string
//============================================================


$tString:=$1
$iFullLength:=$2

If (Count parameters:C259>=3)
	$iPadASCII:=$3
Else 
	$iPadASCII:=Character code:C91(" ")
End if 

If (Count parameters:C259>=4)
	$bPadRight:=$4
Else 
	$bPadRight:=True:C214
End if 

$iLength:=Length:C16($tString)


If (Length:C16($tString)>$iFullLength)
	$tString:=Substring:C12($tString; 1; $iFullLength)
End if 


//
If ($iLength<$iFullLength)  //is there padding to be put in?
	If ($bPadRight)  //padding goes on right side
		$tString:=$tString+(Char:C90($iPadASCII)*($iFullLength-$iLength))
	Else   //pading goes on left side
		$tString:=(Char:C90($iPadASCII)*($iFullLength-$iLength))+$tString
	End if 
End if 


$0:=$tString
//eom