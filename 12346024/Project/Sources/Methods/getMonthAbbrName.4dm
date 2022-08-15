//%attributes = {}
// getMonthAbbrName (int) : string
// returns the name of the months

C_LONGINT:C283($1)
C_TEXT:C284($0)

Case of 
	: ($1=1)
		$0:="Jan"
	: ($1=2)
		$0:="Feb"
	: ($1=3)
		$0:="Mar"
	: ($1=4)
		$0:="Apr"
	: ($1=5)
		$0:="May"
	: ($1=6)
		$0:="Jun"
	: ($1=7)
		$0:="Jul"
	: ($1=8)
		$0:="Aug"
	: ($1=9)
		$0:="Sep"
	: ($1=10)
		$0:="Oct"
	: ($1=11)
		$0:="Nov"
	: ($1=12)
		$0:="Dec"
	Else 
		$0:=""
End case 