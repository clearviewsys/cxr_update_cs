//%attributes = {}
// selectChequeDepositableAccounts

// select all the accounts that are either a bank or cheque receivable of currency vAccountCurrency

// PRE: vAccountCurrency must be already assigned a valid currency code


QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214; *)  // select all bank accounts

QUERY:C277([Accounts:9];  | ; [Accounts:9]AccountID:1=makeChequeAccountID(vAccountCurrency; False:C215); *)  // also select cheque receivableand payable accounts

QUERY:C277([Accounts:9];  | ; [Accounts:9]AccountID:1=makeChequeAccountID(vAccountCurrency; True:C214))
QUERY SELECTION:C341([Accounts:9]; [Accounts:9]Currency:6=vAccountCurrency)  // filter only vAccountCurrency