//%attributes = {}
// pickRiskFactors_ORDA ( ->textEntry ; RiskReducing:int )

// #orda

C_LONGINT:C283($win)
C_TEXT:C284($form)
C_OBJECT:C1216($es)
C_TEXT:C284($0; $result)
C_POINTER:C301($1; $self)
C_LONGINT:C283($2; $isRiskReducing)

Case of 
	: (Count parameters:C259=0)
		$self:=->$result
		$isRiskReducing:=2
		
	: (Count parameters:C259=1)
		$self:=$1
		$isRiskReducing:=2
		
	: (Count parameters:C259=2)
		$self:=$1
		$isRiskReducing:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$form:="Picker"

// for easy access to the form
// [List_RiskFactors];"Picker"
//[List_RiskFactors]

$es:=New object:C1471
$es.searchString:=""

Case of 
	: ($isRiskReducing=0)
		$es.initialList:=ds:C1482.List_RiskFactors.query("isRiskReducing = false").orderBy("RiskFactor")  // prepare the risk
		
	: ($isRiskReducing=1)
		$es.initialList:=ds:C1482.List_RiskFactors.query("isRiskReducing = true").orderBy("RiskFactor")  // prepare the risk
	Else 
		$es.initialList:=ds:C1482.List_RiskFactors.all().orderBy("isRiskReducing, RiskFactor")  // prepare the risk
End case 

$win:=Open form window:C675([List_RiskFactors:132]; $form)
DIALOG:C40([List_RiskFactors:132]; $form; $es)

If (OK=1)
	If ($es.selectedItems#Null:C1517)
		C_OBJECT:C1216($e)
		C_LONGINT:C283($i; $len)
		C_TEXT:C284($result)
		$len:=$es.selectedItems.length
		For each ($e; $es.selectedItems)
			If ($e.isRiskReducing)
				$result:=$result+"<span style=\"color:green;\">"+$e.RiskFactor+"</span>"
			Else 
				$result:=$result+"<span style=\"color:red;\">"+$e.RiskFactor+"</span>"
			End if 
			$i:=$i+1
			If ($i<$len)
				$result:=$result+",  "
			End if 
		End for each 
		$self->:=$result
		//$self->:=($es.selectedItems.RiskFactor.join(", ";ck ignore null or empty))
	End if 
End if 