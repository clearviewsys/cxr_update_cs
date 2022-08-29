//%attributes = {}
createCashMainAccount  // first create the main CASH account 
createForeignCurrAccount
//createBanksMainAccount   `  create banks

//createReceivablesMainAccount   `  create all receivables
//createPayablesMainAccount   `  create payables
//createMainAccount (c_Expenses ;"Expenses Account";enum_Expenses ;"The main expenses account";True;True)

//createMainAccount ("Opening";"Opening";enum_Equities ;"Opening Balance";False;True)

createCashRegisterID
//createCashAccount (◊baseCurrency)  ` second create a CASH account of that currency

// DO NOT CHANGE THE ORDER ****** START
C_LONGINT:C283($i)
For ($i; 1; <>totalCashRegisters)
	createCashRegisterID(String:C10($i; "00"); "Cash Register "+String:C10($i; "00"))
End for 

createAllCashAccounts  //
assignAllCashToCashRegisters

// DO NO CHANGE THE ORDER ********* END

//createChequeReceivable (◊baseCurrency)  ` third : create cheque accounts
//createChequePayable (◊baseCurrency)  ` fourth : create cheque payables
//createPrimaryBankAccount 

//createAccount ("Expenses_Rent";c_Expenses ;◊baseCurrency;0;0;Current date;True)
//createAccount ("Expenses_Salary";c_Expenses ;◊baseCurrency;0;0;Current date;True)
//createAccount ("Expenses_Other";c_Expenses ;◊baseCurrency;0;0;Current date;True)
