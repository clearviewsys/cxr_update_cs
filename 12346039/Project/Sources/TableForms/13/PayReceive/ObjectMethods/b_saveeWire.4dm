//[eWires]Author:=Current user
//[eWires]AuthorizedUser:=[Links]AuthorizedUser
//[eWires]CustomerID:=[Links]CustomerID
//[eWires]CustomerName:=[Links]CustomerName
//
//checkInit 
//validateeWires 
//
//If (isValidationConfirmed )
//  `If ([eWires]RegisterID="")  ` not linked therefore create one????
//  `[eWires]RegisterID:=makeRegisterID 
//  `End if 
//  `SAVE RECORD(Current form table->)
//  `createRegisterFromInvoice ([eWires]RegisterID;"eWire";Not([eWires]isPaymentSent);[eWires]OurInvoiceNumber;[eWires]_CustomerID;[eWires]ToAmount;->[eWires];[eWires]ForeignAccount;[eWires]FromCurrency;[eWires]SendDate)
// 
//Else 
//REJECT
//End if 

handleSaveEWireButton(True:C214)  // offline ewire

