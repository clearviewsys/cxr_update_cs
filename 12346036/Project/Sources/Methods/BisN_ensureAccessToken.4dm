//%attributes = {}
//author: Amir
//date: 25th Sept 2019
//returns bool (success):=Bisnode_ensureAccessToken()

ARRAY TEXT:C222($credentials; 2)
C_TEXT:C284($clientId; $clientSecret)

BisN_getClientIdAndSecret(->$credentials)

C_OBJECT:C1216(<>BisnodeCI_accessToken)

C_BOOLEAN:C305($isSuccess)
$isSuccess:=True:C214
If ((<>BisnodeCI_accessToken=Null:C1517) | (<>BisnodeCI_accessToken.access_token=Null:C1517) | (Not:C34(<>BisnodeCI_accessToken.error=Null:C1517)))
	<>BisnodeCI_accessToken:=New object:C1471
	<>BisnodeCI_accessToken.access_token:=Null:C1517
	<>BisnodeCI_accessToken.token_type:=Null:C1517
	<>BisnodeCI_accessToken.expires_in:=Null:C1517
	$isSuccess:=BisN_getNewAccessToken(->$credentials; -><>BisnodeCI_accessToken)
	If ($isSuccess)
		<>BisnodeCI_accessToken.expireyTime:=Current time:C178+Time:C179(<>BisnodeCI_accessToken.expires_in)
	End if 
End if 
//if token is about to expire (less than two minutes), renew it
If (Not:C34(<>BisnodeCI_accessToken.expireyTime=Null:C1517))
	If (<>BisnodeCI_accessToken.expireyTime-Current time:C178<Time:C179("00:02:00"))
		$isSuccess:=BisN_getNewAccessToken(->$credentials; -><>BisnodeCI_accessToken)
		If ($isSuccess)
			<>BisnodeCI_accessToken.expireyTime:=Current time:C178+Time:C179(<>BisnodeCI_accessToken.expires_in)
		End if 
	End if 
End if 

If (Not:C34(<>BisnodeCI_accessToken.error=Null:C1517))
	$isSuccess:=False:C215
End if 

$0:=$isSuccess