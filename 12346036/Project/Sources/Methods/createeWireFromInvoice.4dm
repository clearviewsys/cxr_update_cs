//%attributes = {}
C_TEXT:C284($eWireID; $0; vSenderMessage)
C_PICTURE:C286(vAttachedPicture)
READ WRITE:C146([eWires:13])
CREATE RECORD:C68([eWires:13])
[eWires:13]AgentID:26:=[Links:17]AuthorizedUser:13
[eWires:13]LinkID:8:=[Links:17]LinkID:1
[eWires:13]FromAmount:13:=vFromAmount
[eWires:13]ToAmount:14:=vToAmount
[eWires:13]FromCurrency:11:=[Invoices:5]fromCurrency:3
[eWires:13]Currency:12:=[Invoices:5]toCurrency:8
//[eWires]fromCountry:=<>CompanyCountry
//[eWires]toCountry:=[Links]Country
[eWires:13]isPaymentSent:20:=True:C214
[eWires:13]CustomerMsg:16:=vSenderMessage
[eWires:13]AttachedPicture:25:=vAttachedPicture
[eWires:13]InvoiceNumber:29:=[Invoices:5]InvoiceID:1
[eWires:13]AccountID:30:=[Accounts:9]AccountID:1
[eWires:13]isSettled:23:=False:C215
SAVE RECORD:C53([eWires:13])
$eWireID:=[eWires:13]eWireID:1
UNLOAD RECORD:C212([eWires:13])
READ ONLY:C145([eWires:13])
$0:=$eWireID
[Invoices:5]eWireID:23:=$eWireID  // this is to link the invoice to the eWire

READ WRITE:C146([Registers:10])
CREATE RECORD:C68([Registers:10])
[Registers:10]InvoiceNumber:10:=[Invoices:5]InvoiceID:1
[Registers:10]isReceived:13:=False:C215
[Registers:10]RegisterType:4:="eWire"
//[Registers]_:=$eWireID
[Registers:10]Credit:7:=vRemainPaid
[Registers:10]AutoComments:12:=True:C214
[Registers:10]CustomerID:5:=[Invoices:5]CustomerID:2
[Registers:10]RegisterDate:2:=Current date:C33
[Registers:10]AccountID:6:=[Accounts:9]AccountID:1
//[Registers]CustomerBankInfo:=[Links]CustomerBankInfo
SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
READ ONLY:C145([Registers:10])

relateManyRegisters