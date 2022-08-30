//%attributes = {}
QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=[Agents:22]AgentID:1)
READ WRITE:C146([WebUsers:14])
If (Records in selection:C76([WebUsers:14])>0)  // if such  alogin id currently exist
	
	LOAD RECORD:C52([WebUsers:14])
Else 
	CREATE RECORD:C68([WebUsers:14])
End if 
[WebUsers:14]webUsername:1:=[Agents:22]AgentID:1
[WebUsers:14]Password:2:=[Agents:22]Password:2
[WebUsers:14]Email:3:=[Agents:22]email:8
[WebUsers:14]confirmationToken:6:=[Agents:22]City:3+"/"+[Agents:22]Province:4
[WebUsers:14]countryCode:7:=[Agents:22]Country:5
[WebUsers:14]isAllowedAccess_NU:5:=[Agents:22]isAllowedAccess:7
[WebUsers:14]relatedTable:8:=Table:C252(->[Agents:22])
[WebUsers:14]recordID:9:=[Agents:22]AgentID:1
SAVE RECORD:C53([WebUsers:14])
UNLOAD RECORD:C212([WebUsers:14])
READ ONLY:C145([WebUsers:14])
