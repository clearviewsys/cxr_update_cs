//%attributes = {}

C_TEXT:C284($0; $Addr_T)
C_LONGINT:C283($httpStatusCode_li)
$httpStatusCode_li:=HTTP Get:C1157("https://api.ipify.org"; $Addr_T)
$0:=$Addr_T