//%attributes = {}
// makeeWireActionMessage -> text

// PRE: ewire must be loaded


C_TEXT:C284($message; $0)
$message:=""
If ([eWires:13]doNotifyBySMS:31)
	$message:="* Please call recepient at :"+[eWires:13]phoneNumber:39+Char:C90(Carriage return:K15:38)
End if 

If ([eWires:13]doTransferToBank:33)
	$message:=$message+"** Please TRANSFER money  to bank : "+[eWires:13]BeneficiaryBankDetails:38
End if 

If ([eWires:13]doDeliverToAddress:32)
	$message:=$message+"*** Please DELIVER money to address. : "+[eWires:13]DeliveryAddress:37
End if 

$0:=$message