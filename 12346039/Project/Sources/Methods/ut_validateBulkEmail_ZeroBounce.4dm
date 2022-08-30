//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021
// DO NOT USE ANY OTHER EMAIL ADDRESSES - THESE ARE ZERO BOUNCE TEST EMAILS
// ANY OTHER EMAILS WILL COST MONEY TO VALIDATE AND SHOULD ONLY BE USED IN PRODUCTION

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("bulkValidateEmailWithZeroBounce"; Current method name:C684; "API.ZeroBounce")
// bulkValidateEmailWithZeroBounce
C_TEXT:C284($email; $ip_address)
C_OBJECT:C1216($res)
C_LONGINT:C283($HTTPStatus; $exprectedHTTPStatus; $i)
C_TEXT:C284($emailStatus; $expectedEmailStatus; $should; $given; $result)
C_COLLECTION:C1488($emailCollection; $objCollection)
C_OBJECT:C1216($obj1; $obj2; $obj3; $obj4; $obj5; $obj6; $obj7; $obj8; $obj9; $obj10; $obj11)

$email:="valid@example.com"
OB SET:C1220($obj1; "email_address"; $email)
$email:="invalid@example.com"
OB SET:C1220($obj2; "email_address"; $email)
$email:="disposable@example.com"
OB SET:C1220($obj3; "email_address"; $email)
$email:="toxic@example.com"
OB SET:C1220($obj4; "email_address"; $email)
$email:="catch_all@example.com"
OB SET:C1220($obj5; "email_address"; $email)
$email:="unknown@example.com"
OB SET:C1220($obj6; "email_address"; $email)
$email:="abuse@example.com"
OB SET:C1220($obj7; "email_address"; $email)
$email:="spamtrap@example.com"
OB SET:C1220($obj8; "email_address"; $email)
$email:="valid@example.com"
$ip_address:="99.123.12.122"
OB SET:C1220($obj9; "email_address"; $email)  //;"ip_address";$ip_address)
$email:="valid@example.com"
$ip_address:="99.123.12.122222222222"
OB SET:C1220($obj10; "email_address"; $email; "ip_address"; $ip_address)

$objCollection:=New collection:C1472($obj1; $obj2; $obj3; $obj4; $obj5; $obj6; $obj7; $obj8; $obj9; $obj10)

$res:=bulkValidateEmailWithZeroBounce($objCollection)


$HTTPStatus:=$res.status
$exprectedHTTPStatus:=200
AJ_assert($test; $HTTPStatus; $exprectedHTTPStatus; "A valid request being made"; "return status code 200")

$i:=0
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="valid"
$given:="a valid email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="invalid"
$given:="an invalid email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="do_not_mail"
$given:="a disposable email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="do_not_mail"
$given:="a toxic email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="catch-all"
$given:="a catch-all email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="unknown"
$given:="an unknown email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="abuse"
$given:="an abuse prone email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="spamtrap"
$given:="a Spam Trap email being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="valid"
$given:="a valid email and IP address being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)
$should:="return region 'Texas' from the IP address passed in"
//$result:=$res.response.email_batch[$i].region
//AJ_assert($test;$result;"Texas";$given;$should) // THIS SHOULD BE WORING BUT THEIR API IS NOT GIVING A CORRECT RESPONSE IN OR OUTSIDE OF 4d

$i:=$i+1
$emailStatus:=$res.response.email_batch[$i].status
$expectedEmailStatus:="valid"
$given:="a valid email and invalid IP address being passed"
$should:="return '"+$expectedEmailStatus+"' in response."
AJ_assert($test; $emailStatus; $expectedEmailStatus; $given; $should)
$should:="return region 'Null' from the invalid IP address passed in"
AJ_assert($test; (OB Get type:C1230($res.response.email_batch[$i]; "region")=Is null:K8:31); True:C214; $given; $should)

