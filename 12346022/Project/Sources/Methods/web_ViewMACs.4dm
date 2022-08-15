//%attributes = {"publishedWeb":true}
//webViewID (->[MACs];->[MACs]MACAddress;$1)


// webViewID(->table;->IDField;->IDValue)



C_TEXT:C284($1; $mac)
$mac:=Substring:C12($1; 2; 99)
If ($mac="")
	$mac:=UTIL_getMacAddress
End if 
QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=$mac)
If (Records in selection:C76([MACs:18])=1)
	SetVariablesToFields(->[MACs:18])
	web_SendHTMLPage(->[MACs:18]; "View")
Else 
	web_SendErrorMsg("MAC Address is not valid")
End if 