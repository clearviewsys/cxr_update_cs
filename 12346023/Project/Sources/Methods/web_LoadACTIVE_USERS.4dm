//%attributes = {"publishedWeb":true}
// webLoadActive_USERS (VloginID)
// POST: all ACTIVE_USERS variables will be defined

C_TEXT:C284($1)
QUERY:C277([WebSessions:15]; [WebSessions:15]webUsername:2=$1)
SetVariablesToFields(->[WebSessions:15])
