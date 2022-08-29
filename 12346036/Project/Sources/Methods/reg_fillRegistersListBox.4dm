//%attributes = {}
READ ONLY:C145([Registers:10])

SET AUTOMATIC RELATIONS:C310(True:C214; False:C215)

SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; reg_arrRegisterID; [Registers:10]isTransfer:3; reg_arrisTransfer; [Registers:10]RegisterDate:2; reg_arrRegisterDate; [Registers:10]InvoiceNumber:10; reg_arrInvoiceNumber; [Customers:3]FullName:40; reg_arrCustomerName; [Registers:10]AccountID:6; reg_arrAccountID)
SELECTION TO ARRAY:C260([Registers:10]Debit:8; reg_arrDebit; [Registers:10]Credit:7; reg_arrCredit; [Registers:10]Currency:19; reg_arrCurrency; [Registers:10]OurRate:25; reg_arrOurRate; [Registers:10]totalFees:30; reg_arrTotalFees; [Registers:10]DebitLocal:23; reg_arrDebitLocal; [Registers:10]CreditLocal:24; reg_arrCreditLocal; [Registers:10]Comments:9; reg_arrComments)

//C_LONGINT($n;$i)
//$n:=Records in selection([Registers])
//For ($i;1;$n)
//
//end for
C_LONGINT:C283(vTotalRows)
vTotalRows:=Records in selection:C76([Registers:10])

SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
