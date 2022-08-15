//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/25/20, 16:47:50
// ----------------------------------------------------
// Method: webLoginCreateLog
// Description
// 
//
// Parameters
// ----------------------------------------------------



CREATE RECORD:C68([WebAccessLog:16])
[WebAccessLog:16]sessionID:8:=WEB Get current session ID:C1162
[WebAccessLog:16]loginID:1:=WAPI_getSession("username")
[WebAccessLog:16]contextID:2:=WAPI_getSession("context")
[WebAccessLog:16]IPNumber:3:=WAPI_getSession("ipAddress")
[WebAccessLog:16]loginDate:4:=Current date:C33(*)
[WebAccessLog:16]loginTime:5:=Current time:C178(*)
SAVE RECORD:C53([WebAccessLog:16])