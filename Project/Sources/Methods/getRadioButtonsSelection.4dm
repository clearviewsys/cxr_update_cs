//%attributes = {}
// getRadioButtonSelection( ->rb1;->rb2;->rb3;->rb4;->rb5) : number
// this method returns a selection number based on which radio button is selected


C_LONGINT:C283($1; $2; $3; $4; $5)
C_LONGINT:C283($switch; $0)


Case of 
	: ($1=1)  //
		$switch:=1
	: ($2=1)  //
		$switch:=2
	: ($3=1)
		$switch:=3
	: ($4=1)
		$switch:=4
	: ($5=1)
		$switch:=5
	Else 
		$switch:=0
End case 

$0:=$switch