//%attributes = {"publishedWeb":true}
// webACTIVE_USERSLogout (ContextID)
// THIS METHOD will expire the contextID and logout the USER
C_TEXT:C284($1)
web_LoadUSERSByContextID($1)
UNLOAD RECORD:C212([WebSessions:15])
DELETE RECORD:C58([WebSessions:15])

initializeVariables(->[WebSessions:15])
