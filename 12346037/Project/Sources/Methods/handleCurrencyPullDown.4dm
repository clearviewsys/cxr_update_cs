//%attributes = {}
// handleCurrencyPullDown(self; ->table;->currencyField)
// call this method from a pull down object in list forms to filter the currency

C_POINTER:C301($1; $2; $3; $self; $tablePtr; $fieldPtr)
$self:=$1
$tablePtr:=$2
$fieldPtr:=$3
C_REAL:C285(vDefaultRate)

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($self->; 0)
	DISTINCT VALUES:C339($fieldPtr->; $self->)
	INSERT IN ARRAY:C227($self->; 1)
	$self->{1}:="All"
	$self->:=1
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($selection)
	$selection:=$self->{$self->}
	If ($self->=1)
		ALL RECORDS:C47($tablePtr->)
	Else 
		QUERY:C277($tablePtr->; $fieldPtr->=$selection)
		
	End if 
	QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=$selection)
	vDefaultRate:=[Currencies:6]SpotRateLocal:17
	
	orderByTable($tablePtr)
End if 

POST OUTSIDE CALL:C329(Current process:C322)

