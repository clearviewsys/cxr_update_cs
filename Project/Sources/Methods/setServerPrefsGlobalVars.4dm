//%attributes = {}
initGlobalVars

C_REAL:C285(<>errorTolerance)  // this is the acceptable tolerace 

<>errorTolerance:=0.035  // in percentage

<>StartInvoiceNumber:=10001  // preferences


C_TIME:C306(<>inactivityTimeAllowed)
<>inactivityTimeAllowed:=?00:10:00?

C_LONGINT:C283(<>updateFrequency; <>minUpdateTime)
<>updateFrequency:=10  // internet refresh frequnecy in minutes

<>minUpdateTime:=20