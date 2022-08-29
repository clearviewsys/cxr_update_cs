C_TEXT:C284(vMACAddress; vEncryptedString)
C_BLOB:C604($blob)

READ WRITE:C146([MACs:18])
//starttransaction // disabled by: Barclay Berry (2/24/13) per Tiran

QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=vMACAddress)

If (Records in selection:C76([MACs:18])>0)  // found, therefore modify
	LOAD RECORD:C52([MACs:18])
Else 
	CREATE RECORD:C68([MACs:18])
End if 
If (vEncryptedString#"")
	TEXT TO BLOB:C554(vEncryptedString; $blob; Mac text without length:K22:10)
Else 
	loadBLOBFromFile(->$blob; "")
End if 

BLOBToRecord(->[MACs:18]; ->$blob)

SAVE RECORD:C53([MACs:18])
UNLOAD RECORD:C212([MACs:18])

//validatetransaction // disabled by: Barclay Berry (2/24/13) per Tiran
