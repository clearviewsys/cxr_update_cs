C_TEXT:C284(vFullComments; vWarning; vFromCurrency; vToCurrency; vFromCurrency; vToCurrency)
C_REAL:C285(vFromAmount; vToAmount; vExchangeRate; vFromBalanceAfter; vToBalanceAfter)

If (Form event code:C388=On Load:K2:1)
	vTransferDate:=Current date:C33
	//initialize other vars
	vFromAmount:=0
	vFromBalanceAfter:=0
	vToBalanceAfter:=0
	vFromBalance:=0
	vtoBalance:=0
	vfromCurrency:=""
	vFromAccount:=""
	vToAccount:=""
	vtoAmount:=0
	vtoCurrency:=""
	vComments:=""
	vExchangeRate:=0
	vWarning:=""
	OBJECT SET ENTERABLE:C238(bValidate; False:C215)
	OBJECT SET VISIBLE:C603(vExchangeRate; False:C215)
	OBJECT SET VISIBLE:C603(vToAmount; False:C215)
	//SET VISIBLE(vToCurrency;False)
	
	
End if 

//If (Form event=On Data Change )
//If (vTransferDate=!00/00/00!)
//vTransferDate:=Current date
//End if 
//End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	//If (vTransferDate=!00/00/00!)
	//vTransferDate:=Current date
	//End if 
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=vFromAccount)
	vFromCurrency:=[Accounts:9]Currency:6
	vFromBalance:=getBankAccountBalance([Accounts:9]AccountID:1)
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=vToAccount)
	vToCurrency:=[Accounts:9]Currency:6
	vToBalance:=getBankAccountBalance([Accounts:9]AccountID:1)
	
	If ((vFromAccount#"") & (vToAccount#""))
		// both accounts are entered
		If (vFromCurrency#vToCurrency)
			OBJECT SET VISIBLE:C603(vExchangeRate; True:C214)
			OBJECT SET VISIBLE:C603(vToAmount; True:C214)
			
			vExchangeRate:=calcExchangeRate(vFromCurrency; vToCurrency)
			
		Else 
			vExchangeRate:=1
			OBJECT SET VISIBLE:C603(vExchangeRate; False:C215)
			OBJECT SET VISIBLE:C603(vToAmount; False:C215)
		End if 
		
		If (vFromAccount=vToAccount)
			ALERT:C41("Cannot transfer to same account. Please select a different account!")
			POST OUTSIDE CALL:C329(Current process:C322)  // refresh the calculations
		End if 
		
	End if 
End if 

vToAmount:=vFromAmount*vExchangeRate
vFromBalanceAfter:=vFromBalance-vFromAmount
vToBalanceAfter:=vToBalance+vtoAmount
//If (vFromBalanceAfter<0)
//vWarning:="Not enough fund available in account "+vFromAccount
//Else 
//vWarning:=""
//End if 

vFullComments:="Transfer "+String:C10(vFromAmount)+" "+vFromCurrency+" from "+vFromAccount+" to account "+vToAccount
If (vExchangeRate#1)
	vFullComments:=vFullComments+" ("+String:C10(vToAmount)+" "+vToCurrency+" exchanged at "+String:C10(vExchangeRate)+")"
End if 
vFullComments:=vFullComments+"."+vComments