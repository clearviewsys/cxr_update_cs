//%attributes = {}
C_TEXT:C284($bank)

// [list_banks];"Pick"

pickList_Banks(->$bank)

myAlert("Your selection is"+[List_Banks:134]ShortName:2+" "+[List_Banks:134]BankName:3)
$bank:="BMO"
pickList_Banks(->$bank; False:C215)  // don't force dialog
myAlert("Your selection is"+[List_Banks:134]ShortName:2+" "+[List_Banks:134]BankName:3)

pickList_Banks(->$bank; True:C214)  // forece dialog
myAlert("Your selection is"+[List_Banks:134]ShortName:2+" "+[List_Banks:134]BankName:3)

