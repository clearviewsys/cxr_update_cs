//%attributes = {}
// Method: RGB2Hex
// Parameters
// $0 - RGB value in Hex format
// $1 - R (red) value
// $2 - G (green) value
// $3 - B (blue) value
// ----------------------------------------------------

C_TEXT:C284($0; $hex_t; $rgbcolor_t)
C_LONGINT:C283($1; $2; $3)
C_LONGINT:C283($dec_l; $whole_l; $remainder_l; $i)
C_REAL:C285($result_r)
ARRAY LONGINT:C221($color_al; 3)

If (Count parameters:C259>=3)
	If ($1#255)
		$color_al{1}:=($1%255)  // R
	Else 
		$color_al{1}:=$1
	End if 
	If ($2#255)
		$color_al{2}:=($2%255)  // G
	Else 
		$color_al{2}:=$2
	End if 
	If ($3#255)
		$color_al{3}:=($3%255)  // B
	Else 
		$color_al{3}:=$3
	End if 
	
	For ($i; 1; 3)
		$hex_t:=""
		$dec_l:=$color_al{$i}
		If ($dec_l>15)
			While ($dec_l>0)
				$result_r:=$dec_l/16
				$whole_l:=Int:C8($result_r)
				$remainder_l:=$dec_l-($whole_l*16)
				Case of 
					: ($remainder_l=10)
						$hex_t:="A"+$hex_t
					: ($remainder_l=11)
						$hex_t:="B"+$hex_t
					: ($remainder_l=12)
						$hex_t:="C"+$hex_t
					: ($remainder_l=13)
						$hex_t:="D"+$hex_t
					: ($remainder_l=14)
						$hex_t:="E"+$hex_t
					: ($remainder_l=15)
						$hex_t:="F"+$hex_t
					Else 
						$hex_t:=String:C10($remainder_l)+$hex_t
				End case 
				$dec_l:=$whole_l
			End while 
		Else 
			Case of 
				: ($dec_l=10)
					$hex_t:="0A"
				: ($dec_l=11)
					$hex_t:="0B"
				: ($dec_l=12)
					$hex_t:="0C"
				: ($dec_l=13)
					$hex_t:="0D"
				: ($dec_l=14)
					$hex_t:="0E"
				: ($dec_l=15)
					$hex_t:="0F"
				Else 
					$hex_t:=String:C10($dec_l; "00")
			End case 
		End if 
		$rgbcolor_t:=$rgbcolor_t+$hex_t
	End for 
	$0:=$rgbcolor_t
Else 
	$0:="FFFFFF"
End if 
