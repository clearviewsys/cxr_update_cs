If (Self:C308->)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankDetails:38; True:C214)
	GOTO OBJECT:C206([eWires:13]BeneficiaryBankDetails:38)
Else 
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankDetails:38; False:C215)
	[eWires:13]BeneficiaryBankDetails:38:=""
End if 


If (([eWires:13]doTransferToBank:33) & ([eWires:13]BeneficiaryBankDetails:38=""))
	[eWires:13]BeneficiaryBankDetails:38:=[Links:17]BankingDetails:9
End if 