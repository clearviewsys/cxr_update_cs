handleViewFormMethod

C_LONGINT:C283($type)
If ([SanctionCheckLog:111]isEntity:11)
	$type:=2
Else 
	$type:=1
End if 

C_TEXT:C284($version)
$version:=sl_getSanctionSourceForRecord(\
ds:C1482.SanctionCheckLog.query("UUID=:1"; [SanctionCheckLog:111]UUID:14\
).first()\
)

Case of 
	: ($version="v2")
		If (Form event code:C388=On Load:K2:1)
			FORM GOTO PAGE:C247(2)
			Form:C1466.basic:=sl_createDisplayResultOptions(\
				ds:C1482.SanctionCheckLog.query("UUID = :1"; [SanctionCheckLog:111]UUID:14); \
				True:C214)
			sl_handleSanctionListMatches(Form:C1466.basic)
		End if 
		
		sl_handleReviewFormEvent(Form:C1466.basic)
End case 