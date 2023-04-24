//C_REAL(vSumDebitsLocal;vSumCreditsLocal;vBalanceLocal;vSumFees)
//
//If (Form event=On Load)
//SELECTION TO ARRAY([Registers]RegisterID;reg_arrRegisterID;[Registers]RegisterDate;reg_arrRegisterDate;[Registers]InvoiceNumber;reg_arrInvoiceNumber)
//SELECTION TO ARRAY([Registers]Debit;reg_arrDebit;[Registers]Credit;reg_arrCredit;[Registers]Currency;reg_arrCurrency;[Registers]DebitLocal;reg_arrDebitLocal;[Registers]CreditLocal;reg_arrCreditLocal)
//
//End if 
//
//getRegisterSums (->vSumDebitsLocal;->vSumCreditsLocal;->vBalanceLocal;->vSumFees)
