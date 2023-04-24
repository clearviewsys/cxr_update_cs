//%attributes = {"publishedWeb":true}
// Project Method: NumToText (real ; {Boolean}) -> text

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft
// From a code snippet posted to the 4D NUG by Kirk Brooks.

// Modified to also return the cents.
// $1 is a real value
// $2 is a boolean which determines if a negatrive value is returned
// if $2 is true or omitted-> return negative value
// if $2 is FALSE-> return error text

C_REAL:C285($1)
C_TEXT:C284($0; $Text)
C_LONGINT:C283($dollars; $cents)
C_BOOLEAN:C305($2; $OkToProceed; $negative)
//
$Text:=""
$dollars:=Int:C8($1)  //need to strip out any decimals
$cents:=($1*100)-($dollars*100)
$OkToProceed:=True:C214  //be optimistic
//
If ($dollars<0)  //it is a negative nubmer
	$dollars:=Abs:C99($dollars)  //in case a negative number is sent
	$negative:=True:C214
	//
	If (Count parameters:C259=2)
		$OkToProceed:=$2
	End if 
	//  
Else 
	$negative:=False:C215
End if 
//
If ($OkToProceed)  //go ahead and parse the value
	If ($dollars>=1000000000)
		$Text:=$Text+(Num:C11($Text#"")*" ")+NumToText($dollars\1000000000)+" Billion"
		$dollars:=$dollars%1000000000
	End if 
	//
	If ($dollars>=1000000)
		$Text:=$Text+(Num:C11($Text#"")*" ")+NumToText($dollars\1000000)+" Million"
		$dollars:=$dollars%1000000
	End if 
	//
	If ($dollars>=1000)
		$Text:=$Text+(Num:C11($Text#"")*" ")+NumToText($dollars\1000)+" Thousand"
		$dollars:=$dollars%1000
	End if 
	//
	If ($dollars>=100)
		$Text:=$Text+(Num:C11($Text#"")*" ")+NumToText($dollars\100)+" Hundred"
		$dollars:=$dollars%100
	End if 
	//
	If ($dollars>19)
		Case of 
			: (($dollars\10)=9)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Ninety"
			: (($dollars\10)=8)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Eighty"
			: (($dollars\10)=7)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Seventy"
			: (($dollars\10)=6)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Sixty"
			: (($dollars\10)=5)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Fifty"
			: (($dollars\10)=4)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Forty"
			: (($dollars\10)=3)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Thirty"
			: (($dollars\10)=2)
				$Text:=$Text+(Num:C11($Text#"")*" ")+"Twenty"
		End case 
		$dollars:=$dollars-(($dollars\10)*10)
	End if 
	//
	Case of 
		: ($dollars=19)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Nineteen"
		: ($dollars=18)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Eighteen"
		: ($dollars=17)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Seventeen"
		: ($dollars=16)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Sixteen"
		: ($dollars=15)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Fifteen"
		: ($dollars=14)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Fourteen"
		: ($dollars=13)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Thirteen"
		: ($dollars=12)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Twelve"
		: ($dollars=11)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Eleven"
		: ($dollars=10)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Ten"
		: ($dollars=9)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Nine"
		: ($dollars=8)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Eight"
		: ($dollars=7)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Seven"
		: ($dollars=6)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Six"
		: ($dollars=5)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Five"
		: ($dollars=4)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Four"
		: ($dollars=3)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Three"
		: ($dollars=2)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"Two"
		: ($dollars=1)
			$Text:=$Text+(Num:C11($Text#"")*" ")+"One"
		: ($dollars=0)
			//If ($Text="")
			//$Text:=$Text+(Num($Text#"")*" ")+"Zero"
			//End if 
	End case 
	
	If ($cents>0)
		$Text:=$Text+" and "+String:C10($cents)+"/100"
	End if 
	
	$0:=("Negative "*Num:C11($negative))+$Text
	
Else 
	$0:="!ERROR! "  //could be any other error message you like
End if 