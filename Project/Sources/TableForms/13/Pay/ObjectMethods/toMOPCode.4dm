handlePickPaymentType(->[eWires:13]toMOP_Code:114; ->[eWires:13]toMOP:116; False:C215)

If ([eWires:13]toMOP_Code:114=getKeyValue("ewire.tomop.mobilewallet"; "N-M"))  //hard code for now
	OBJECT SET ENTERABLE:C238(*; "MOBILE_@"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "BANK_@"; False:C215)
	OBJECT SET ENABLED:C1123(*; "BANK_@"; False:C215)
	[eWires:13]doTransferToBank:33:=False:C215
	//[eWires]BeneficiaryBank:=""
	[eWires:13]BeneficiaryBank:124:=New object:C1471  // Syntax error Fixed By JA
	[eWires:13]BeneficiaryBankAccountNo:66:=""
Else 
	OBJECT SET ENTERABLE:C238(*; "MOBILE_@"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "BANK_doTransfer@"; True:C214)
	OBJECT SET ENABLED:C1123(*; "BANK_doTransfer@"; True:C214)
End if 