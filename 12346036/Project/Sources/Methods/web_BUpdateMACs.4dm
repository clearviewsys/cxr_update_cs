//%attributes = {"publishedWeb":true}
// webBUpdateMACs

C_TEXT:C284(webMacAddress)

READ WRITE:C146([MACs:18])
QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=webMacAddress)
LOAD RECORD:C52([MACs:18])
SetFieldsToVariables(->[MACs:18])

SAVE RECORD:C53([MACs:18])
UNLOAD RECORD:C212([MACs:18])
web_SendErrorMsg("Update Value Sent")
READ ONLY:C145([MACs:18])