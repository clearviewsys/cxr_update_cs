//%attributes = {}
// declaration of global variables 
// SEE ALSO : loadPreferences
//Some of these variables are dirrectly connected inside the [ServerPrefs]

C_BOOLEAN:C305(<>orderFirstNameLastName)
<>orderFirstNameLastName:=True:C214

C_BOOLEAN:C305(<>DisplayPageSetup)
<>DisplayPageSetup:=False:C215

C_LONGINT:C283(<>RecordNo)
C_TEXT:C284(<>LastUpdateTime)
C_TEXT:C284(<>CurrentUser; <>ApplicationUser; <>UserID)
C_REAL:C285(<>maxPCTChangeAllowance)
<>maxPCTChangeAllowance:=500  // 500% is the maximum allowed pct change for spot rates

C_TEXT:C284(<>Shell_DatabaseName)
<>Shell_DatabaseName:="CurrencyXchanger"

C_TEXT:C284(<>wsUser)
C_TEXT:C284(<>wsPassword)
<>wsUser:="wServiceSupervisor"
<>wsPassword:="{75x2D6M5-32rA-4E18-B5a1-W098CeA3F7T8}"

initServerPrefsVars
initNextCustomer
enableTriggers

C_PICTURE:C286(<>userPicture)

setCopyrightText

C_REAL:C285(<>epsilon)
<>epsilon:=0.01

C_TEXT:C284(<>hmReportLicense)


C_BOOLEAN:C305(<>Shell_Quit)
<>Shell_Quit:=False:C215

