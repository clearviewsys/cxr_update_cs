//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021

// DO NOT USE ANY OTHER EMAIL ADDRESSES - THESE ARE ZERO BOUNCE TEST EMAILS
// ANY OTHER EMAILS WILL COST MONEY TO VALIDATE AND SHOULD ONLY BE USED IN PRODUCTION

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("validateEmailWithZeroBounce"; Current method name:C684; "API.ZeroBounce")
// validateEmailWithZeroBounce
C_TEXT:C284($email; $ip_address)
C_OBJECT:C1216($res)
C_LONGINT:C283($HTTPStatus; $exprectedHTTPStatus)
C_TEXT:C284($emailStatus; $expectedEmailStatus; $should; $given; $result)

$email:="valid@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid request being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="valid"
$given:="a valid email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="invalid@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid request being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="invalid"
$given:="an invalid email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="disposable@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="do_not_mail"
$given:="a disposable email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="toxic@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="do_not_mail"
$given:="a toxic email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="catch_all@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="catch-all"
$given:="a catch-all email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="unknown@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="unknown"
$given:="an unknown email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="abuse@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="abuse"
$given:="an abuse prone email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="spamtrap@example.com"
$res:=validateEmailWithZeroBounce($email)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="spamtrap"
$given:="a Spam Trap email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$email:="valid@example.com"
$ip_address:="99.123.12.122"
$res:=validateEmailWithZeroBounce($email; $ip_address)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made with 2 parameters"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="valid"
$given:="a valid email and IP address being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)
$should:="return region 'Texas' from the IP address passed in"
$result:=$res.response.region
AJ_assert($test; $result; "Texas"; $given; $should)

$email:="valid@example.com"
$ip_address:="99.123.12.122222222222"
$res:=validateEmailWithZeroBounce($email; $ip_address)
$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid call being made with 2 parameters"; "return status code 200")
$emailStatus:=$res.response.status
$expectedEmailStatus:="valid"
$given:="a valid email and invalid IP address being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)
$should:="return region 'Null' from the invalid IP address passed in"
AJ_assert($test; (OB Get type:C1230($res.response; "region")=Is null:K8:31); True:C214; $given; $should)
