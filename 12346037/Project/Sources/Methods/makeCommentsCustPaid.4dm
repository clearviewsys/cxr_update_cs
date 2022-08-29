//%attributes = {}
C_TEXT:C284($0)

$0:="Customer "+[Customers:3]FullName:40
$0:=$0+" paid "+String:C10([Registers:10]Debit:8)+[Accounts:9]Currency:6
$0:=$0+" in "+[Registers:10]RegisterType:4  //+" from  "+[Registers]CustomerBankInfo
$0:=$0+", dated "+String:C10([Registers:10]RegisterDate:2)
//If ([Registers]_#"")
//$0:=$0+" , with serial# "+[Registers]_
//End if 
$0:=$0+". Refer to Invoice "+[Registers:10]InvoiceNumber:10