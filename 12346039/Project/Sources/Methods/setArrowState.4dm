//%attributes = {}
// setArrowState (->variableArrow; fieldValue)
// the field value is a percentage value (0-100)

C_POINTER:C301($1)
C_REAL:C285($2; $value)
$value:=$2
Case of 
	: ($value>3)
		$1->:=0
		
	: (($value>1) & ($value<3))
		$1->:=1
		
	: (($value>0) & ($value<=1))
		$1->:=2
		
	: ($value=0)
		$1->:=3
		
	: (($value<0) & ($value>=-1))
		$1->:=4
		
	: (($value<-1) & ($value>=-3))
		$1->:=5
		
	: ($value<-3)
		$1->:=6
		
End case 
