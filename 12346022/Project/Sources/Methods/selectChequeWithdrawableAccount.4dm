//%attributes = {}
// selectChequeDepositableAccounts

// select all the accounts that are either a bank or cheque payable of currency vAccountCurrency

// PRE: vAccountCurrency must be already assigned a valid currency code


QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214; *)  // select all bank accounts

QUERY:C277([Accounts:9];  | ; [Accounts:9]AccountID:1=makeChequePayable(vAccountCurrency))  // also select cheque receivable account

QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=vAccountCurrency)  // filter only vAccountCurrency