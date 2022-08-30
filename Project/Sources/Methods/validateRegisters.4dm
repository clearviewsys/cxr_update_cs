//%attributes = {}
//checkIfNullString (->vOurBankAccountID{vOurBankAccountID};"Bank account short name.")

//

//checkIfNullString (->[Registers]CustomerID;"Customer ID")

//checkIfNullString (->[Registers]RegisterType;"Register Type")

//  `checkIfNullString (->vecPaymentType{vecPaymentType};"Type of Payment")

//checkIfNullString (->vCurrencyPopUp{vCurrencyPopUp};"Currency of payment")

//

//  `If ((getRegisterTypeEnum ([Registers]RegisterType)>1) & (vecPaymentType=2))  ` cheque or wire, received

//  `checkIfNullString (->[Registers]CustomerBankInfo;"Customer Bank Information")

//  `checkIfNullString (->[Registers]SerialNo;[Registers]RegisterType+" serial number")

//  `End if 

//

//  `If ((getRegisterTypeEnum ([Registers]RegisterType)>1) & (vecPaymentType=3))  ` cheque or wire, paid

//  `checkIfNullString (->[Registers]SerialNo;[Registers]RegisterType+" serial number")

//  `If (getRegisterTypeEnum ([Registers]RegisterType)=3)  ` for transfers/wire only

//  `checkIfNullString (->[Registers]CustomerBankInfo;"Customer Bank (Wire Only)")

//  `End if 

//  `End if 

//

//Case of 

//: (vecPaymentType=2)  `  received

//checkLowerBound (->[Registers]Debit;"Amount Received from Customer";1)

//: (vecPaymentType=3)  `  paid

//checkLowerBound (->[Registers]Credit;"Amount Paid to Customer";1)

//If (vBankBalanceAfter<0)

//checkAddWarning ("Bank Balance will be negative after this payment!")

//End if 

//End case 