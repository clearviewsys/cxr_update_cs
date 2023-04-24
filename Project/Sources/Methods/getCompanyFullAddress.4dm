//%attributes = {}
// this returns the full address saved in the serverprefs
C_TEXT:C284($0; $address)
$address:=env_makeAddressText(<>companyAddress; <>companyCity; <>companyCity; ""; <>companyCountry)
$0:=$address