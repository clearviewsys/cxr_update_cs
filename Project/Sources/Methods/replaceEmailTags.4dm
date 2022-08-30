//%attributes = {}
C_TEXT:C284($text; $1; $0)

$text:=$1

$0:=Replace string:C233($text; "<CUSTOMER>"; [Customers:3]FullName:40)
$0:=Replace string:C233($0; "<ADDRESS>"; env_makeAddressText([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11))
$0:=Replace string:C233($0; "<CELL>"; [Customers:3]CellPhone:13)
$0:=Replace string:C233($0; "<PHONE>"; [Customers:3]HomeTel:6)
$0:=Replace string:C233($0; "<COMPANY>"; [Customers:3]CompanyName:42)
$0:=Replace string:C233($0; "<LAST>"; [Customers:3]LastName:4)
$0:=Replace string:C233($0; "<FIRST>"; [Customers:3]FirstName:3)

