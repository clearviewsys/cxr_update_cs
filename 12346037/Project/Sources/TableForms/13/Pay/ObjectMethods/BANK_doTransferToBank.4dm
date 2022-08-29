If (Self:C308->)  // if direct deposit into bank
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankName:76; True:C214)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankTransitCode:77; True:C214)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankAccountNo:66; True:C214)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankDetails:38; True:C214)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiarySWIFT:105; True:C214)
	
	GOTO OBJECT:C206([eWires:13]BeneficiaryBankName:76)
Else 
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankName:76; False:C215)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankTransitCode:77; False:C215)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankAccountNo:66; False:C215)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiaryBankDetails:38; False:C215)
	OBJECT SET ENTERABLE:C238([eWires:13]BeneficiarySWIFT:105; False:C215)
	
End if 


If (([eWires:13]doTransferToBank:33) & ([eWires:13]BeneficiaryBankName:76=""))
	[eWires:13]BeneficiaryBankName:76:=[Links:17]BankName:28
	[eWires:13]BeneficiaryBankAccountNo:66:=[Links:17]BankAccountNo:31
	
	[eWires:13]BeneficiaryBankDetails:38:=[Links:17]BankingDetails:9
	[eWires:13]BeneficiaryBankTransitCode:77:=[Links:17]BankTransitCode:29
	[eWires:13]BeneficiarySWIFT:105:=[Links:17]BankSwift:62
End if 