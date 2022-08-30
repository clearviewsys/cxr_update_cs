//%attributes = {}


C_TEXT:C284($1; $tFormName)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)

C_TEXT:C284($0)

C_TEXT:C284($tContext; $tValue; $message; $tMessage)


$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6


$tContext:=WAPI_getSession("context")


$tValue:=WAPI_getParameter($tSource)
$message:=getKeyValue("web.customers.login.contact.alert")
If ($message="")
Else 
	$message:="<br><br>"+$message
End if 


Case of 
	: ($tSource="userEmail")
		If (ds:C1482.WebUsers.query("Email IS :1"; $tValue).length=0)
			//WAPI_pushJs("$('#submit-input').prop('disabled', false);")
		Else 
			WAPI_pushDOMValue($tSource; "")
			WAPI_pushDisplayMessage("Email Adddress"; "<strong>"+$tValue+"</strong> is already in use. Please try again"+$message)
			WAPI_pushJs("$('#submit-input').prop('disabled', true);")
			WAPI_pushDOMFocus($tSource)
		End if 
		
	: ($tSource="userName")
		If (ds:C1482.WebUsers.query("webUsername IS :1"; $tValue).length=0)
			//WAPI_pushJs("$('#submit-input').prop('disabled', false);")
		Else 
			WAPI_pushDOMValue($tSource; "")
			WAPI_pushDisplayMessage("User Name"; "<strong>"+$tValue+"</strong> is already in use. Please try again"+$message)
			WAPI_pushJs("$('#submit-input').prop('disabled', true);")
			WAPI_pushDOMFocus($tSource)
		End if 
		
	: ($tSource="userPassword@")
		$tMessage:=""
		
		checkInit
		
		If (isPasswordStrong($tValue; ->$tMessage))
			//WAPI_pushJs("$('#submit-input').prop('disabled', false);")
		Else 
			WAPI_pushDisplayMessage("Password"; "The password does not meet strength requirements. Please try again"+$message)
			WAPI_pushJs("$('#submit-input').prop('disabled', true);")
			WAPI_pushDOMFocus($tSource)
		End if 
		
End case 


If (getKeyValue("web.customers.login.invite.only")="true")
	$tValue:=WAPI_getParameter("invitationCode")
	If ($tValue=getKeyValue("web.customers.login.invite.code"))
		WAPI_pushDOMReadOnly("userName"; False:C215)
		WAPI_pushDOMReadOnly("userEmail"; False:C215)
		WAPI_pushDOMReadOnly("userEmail_again"; False:C215)
		WAPI_pushDOMReadOnly("userPassword"; False:C215)
		WAPI_pushDOMReadOnly("userPhone"; False:C215)
	Else 
		WAPI_pushDisplayMessage("Invitation Code"; "<strong>"+$tValue+"</strong> is not a valid code.")
		
		WAPI_pushDOMValue("userName"; "")
		WAPI_pushDOMValue("userEmail"; "")
		WAPI_pushDOMValue("userEmail_again"; "")
		WAPI_pushDOMValue("userPassword"; "")
		WAPI_pushDOMValue("userPhone"; "")
		
		WAPI_pushDOMReadOnly("userName"; True:C214)
		WAPI_pushDOMReadOnly("userEmail"; True:C214)
		WAPI_pushDOMReadOnly("userEmail_again"; True:C214)
		WAPI_pushDOMReadOnly("userPassword"; True:C214)
		WAPI_pushDOMReadOnly("userPhone"; True:C214)
		
		WAPI_pushJs("$('#submit-input').prop('disabled', true);")
		WAPI_pushDOMFocus("invitationCode")
	End if 
	
End if 


$0:=WAPI_pullJsStack