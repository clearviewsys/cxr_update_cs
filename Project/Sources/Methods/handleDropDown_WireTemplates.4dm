//%attributes = {}
// handleDropDown_wireTemplate (->boundVar/self; ->boundField; customerID; form Event)

C_POINTER:C301($self_DDArray; $boundFieldPtr; $originalTablePtr; $originalFieldPtr; $1; $2)
C_TEXT:C284($customerID; $3)
C_LONGINT:C283($index; $i)
C_TEXT:C284($selection; $delim)
C_LONGINT:C283($formEvent; $4)  // to relaod the values into the DropDown array (force refresh)
$originalTablePtr:=->[WireTemplates:42]
$originalFieldPtr:=->[WireTemplates:42]WireTemplateID:1
$delim:="  :  "
Case of 
		
	: (Count parameters:C259=3)
		$self_DDArray:=$1
		$boundFieldPtr:=$2
		$customerID:=$3
		$formEvent:=Form event code:C388
		
	: (Count parameters:C259=4)  // 
		$self_DDArray:=$1
		$boundFieldPtr:=$2
		$customerID:=$3
		$formEvent:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: ($formEvent=On Load:K2:1)  // load the combo box array with transaction types
		
		READ ONLY:C145($originalTablePtr->)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=$customerID; *)
		QUERY:C277([WireTemplates:42];  | ; [WireTemplates:42]CustomerID:2="")  // generic wire templates 
		ORDER BY:C49([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1)  // order by name
		
		C_LONGINT:C283($i; $n)
		$n:=Records in selection:C76([WireTemplates:42])
		FIRST RECORD:C50([WireTemplates:42])
		//APPEND TO ARRAY($self_DDArray->;"")
		For ($i; 1; $n)
			LOAD RECORD:C52([WireTemplates:42])
			APPEND TO ARRAY:C911($self_DDArray->; [WireTemplates:42]WireTemplateID:1+$delim+[WireTemplates:42]WireTemplateAlias:14)
			NEXT RECORD:C51([WireTemplates:42])
		End for 
		SET QUERY LIMIT:C395(0)
		
		INSERT IN ARRAY:C227($self_DDArray->; 1)  // the first item should be empty if empty is allowed
		$self_DDArray->{1}:=""
		$self_DDArray->:=1  // select the first item (empty row) 
		
	: (($formEvent=On Data Change:K2:15) | ($formEvent=On Clicked:K2:4) | ($formEvent=On Validate:K2:3))
		// after the combo box has been selected, assign the field to the new value    
		$index:=$self_DDArray->
		$selection:=$self_DDArray->{$index}
		$selection:=Substring:C12($selection; 1; Position:C15($delim; $selection)-1)
		$boundFieldPtr->:=$selection  // update the value of the bound variable
End case 