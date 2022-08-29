//%attributes = {}
C_TEXT:C284(vPaymentType; vRegisterType; vSerialNo; vCustomerBankInfo)
C_DATE:C307(vDueDate)
C_REAL:C285(vAmount)

vPaymentType:=""
vRegisterType:=""
vSerialNo:=""
vAmount:=0
vDueDate:=Current date:C33
vCustomerBankInfo:=""
ARRAY TEXT:C222(arrOurBankAccount; 1)
arrOurBankAccount{1}:=""
