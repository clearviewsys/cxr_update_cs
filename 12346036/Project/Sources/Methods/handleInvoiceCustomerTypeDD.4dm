//%attributes = {}
// handleInvoiceCustomerTypeDD (self; ->[invoices]CustomerType;{form event})
// this dropdown menu is used in the invoice module

C_POINTER:C301($self; $fieldPtr; $1; $2)
C_LONGINT:C283($formEvent; $3)
C_LONGINT:C283($index)
C_TEXT:C284($selection)

Case of 
	: (Count parameters:C259=2)
		$self:=$1
		$fieldPtr:=$2
		$formEvent:=Form event code:C388
	: (Count parameters:C259=3)
		$self:=$1
		$fieldPtr:=$2
		$formEvent:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: ($formEvent=On Load:K2:1)  // load the combo box array with transaction types
		If (isUserManager)
			ALL RECORDS:C47([CustomerTypes:94])
		Else 
			QUERY:C277([CustomerTypes:94]; [CustomerTypes:94]isRestrictedToManagers:5=False:C215)
		End if 
		ORDER BY:C49([CustomerTypes:94]; [CustomerTypes:94]CustomerTypeID:1)  // order by Trans Type
		SELECTION TO ARRAY:C260([CustomerTypes:94]CustomerTypeID:1; $self->)
		// once the form is loaded, assign the default value of the box to the field
		$index:=Find in array:C230($self->; [Invoices:5]CustomerTypeID:92)
		If ($index>0)
			$self->:=$index
			$self->{$index}:=[Invoices:5]CustomerTypeID:92
		End if 
		
	: (($formEvent=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Validate:K2:3))
		// after the combo box has been selected, assign the field to the new value    
		$index:=$self->
		$selection:=$self->{$index}
		$fieldPtr->:=$selection
		
End case 

RELATE ONE:C42([Invoices:5]CustomerTypeID:92)