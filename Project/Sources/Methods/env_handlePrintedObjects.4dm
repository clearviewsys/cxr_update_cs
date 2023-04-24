//%attributes = {}
C_LONGINT:C283(env_cbPrintLogo; env_cbPrintSender; env_cbCONFIDENTIAL; env_cbURGENT)
C_TEXT:C284(env_FullContactName; env_recepientAddress; env_CompanyAddress)


showObjectOnTrue(env_cbPrintLogo#0; "env_Logo")
showObjectOnTrue(env_cbPrintSender#0; "env_Sender@")
showObjectOnTrue(env_cbCONFIDENTIAL#0; "env_CONFI@")
showObjectOnTrue(env_cbURGENT#0; "env_URGENT@")

env_FullContactName:=env_makeCustomerFullName
env_recepientAddress:=env_makeAddressText([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
env_CompanyAddress:=env_makeAddressText(<>companyAddress; <>companyCity; ""; ""; <>companyCountry)