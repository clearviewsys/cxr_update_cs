//%attributes = {}
// webCreateACTIVE_USER (vLoginID)
C_TEXT:C284($1)
C_TEXT:C284(webClientIP)

// ASSERT vLoginID <> ""
CREATE RECORD:C68([WebSessions:15])
[WebSessions:15]IPNumber:3:=webClientIP
[WebSessions:15]webUsername:2:=webLoginID
SAVE RECORD:C53([WebSessions:15])
SetVariablesToFields(->[WebSessions:15])
//UNLOAD RECORD([ACTIVE_USERS])
