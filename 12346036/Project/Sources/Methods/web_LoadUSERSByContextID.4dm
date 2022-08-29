//%attributes = {"publishedWeb":true}
// webLoadUSERByContextID (webContextID)
// select the loginID by looking for the ContextID
C_TEXT:C284($1)
QUERY:C277([WebSessions:15]; [WebSessions:15]SessionID:1=$1)
RELATE ONE:C42([WebSessions:15]webUsername:2)
SetVariablesToFields(->[WebSessions:15])
