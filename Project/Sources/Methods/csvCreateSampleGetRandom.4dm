//%attributes = {}
#DECLARE($propertyName : Text; $additionalParameter : Variant)->$value : Variant

var $rndInteger; $seed; $baseRecordID : Integer
var $rndReal : Real
var $baseDate : Date

$seed:=Tickcount:C458+Milliseconds:C459+Random:C100
$baseDate:=Add to date:C393(!00-00-00!; 2022; 11; 1)
$baseRecordID:=139840650

Case of 
		
	: ($propertyName="transaction_type")
		
		$rndInteger:=$seed%2
		
		Case of 
				
			: ($rndInteger=0)
				
				$value:="Versement Espèces"
				
			: ($rndInteger=1)
				
				$value:="Pertes et Profits"
				
		End case 
		
	: ($propertyName="branch_code")
		
		$rndInteger:=$seed%5
		$value:=String:C10($rndInteger+1; "000")
		
		
	: ($propertyName="flex_module")
		
		$rndInteger:=$seed%3
		
		Case of 
				
			: ($rndInteger=0)
				
				$value:="RT"
				
			: ($rndInteger=1)
				
				$value:="ST"
				
			: ($rndInteger=2)
				
				$value:="DE"
				
		End case 
		
	: ($propertyName="transaction_code")
		
		$rndInteger:=$seed%2
		
		Case of 
				
			: ($rndInteger=0)
				
				$value:="352"
				
			: ($rndInteger=1)
				
				$value:="T22"
				
		End case 
		
	: ($propertyName="dr_br_ind")
		
		$rndInteger:=$seed%2
		
		Case of 
				
			: ($rndInteger=0)
				
				$value:="D"
				
			: ($rndInteger=1)
				
				$value:="C"
				
		End case 
		
	: ($propertyName="dr_br_ind")
		
		$rndInteger:=$seed%2
		
		Case of 
				
			: ($rndInteger=0)
				
				$value:="EUR"
				
			: ($rndInteger=1)
				
				$value:="USD"
				
		End case 
		
		
	: (($propertyName="creation_date_stamp") | ($propertyName="transaction_date_stamp") | ($propertyName="value_date"))
		
		$rndInteger:=$seed%30
		$value:=$rndInteger+1
		
		
End case 
