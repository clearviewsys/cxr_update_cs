//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021
// *****IF THE HTTPRequest TEST IS FAILING -> CHECK IF API LINKS HAVE BEEN OUTDATED*****

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("HTTPRequest"; Current method name:C684; "API.HTTPRequest")
// HTTPRequest


C_OBJECT:C1216($res; $body; $header)
C_TEXT:C284($url; $should; $given)

//Passing only a URL with URL parematers
$url:="https://api.domainsdb.info/v1/domains/search?domain=clearviewsys.com"
$res:=HTTPRequest("GET"; $url)
$given:="Passing only a url with paramters declared in the url"
$should:="return http status code 200"
AJ_assert($test; $res.status; 200; $given; $should)
$should:="return message 'success'"
AJ_assert($test; $res.message; "success"; $given; $should)
$given:="Passing clearviewsys.com as the domain paramter in url"
$should:="return first domain in list to be 'clearviewsys.com'"
AJ_assert($test; $res.response.domains[0].domain; "clearviewsys.com"; $given; $should)


//Passing a URL and body with parematers in body
$url:="https://api.domainsdb.info/v1/domains/search"
$body:=New object:C1471
$body.domain:="clearviewsys.com"
$res:=HTTPRequest("GET"; $url; $body)
$given:="Passing a url and body with paramters declared in body"
$should:="return http status code 200"
AJ_assert($test; $res.status; 200; $given; $should)
$should:="return message 'success'"
AJ_assert($test; $res.message; "success"; $given; $should)
$given:="Passing clearviewsys.com in the body object"
$should:="return first domain in list to be 'clearviewsys.com'"
AJ_assert($test; $res.response.domains[0].domain; "clearviewsys.com"; $given; $should)


//Passing a URL and body with parematers in body along with Header and Content-Type
$url:="https://api.domainsdb.info/v1/domains/search"
$body:=New object:C1471
$body.domain:="clearviewsys.com"
$header:=New object:C1471
$header["Content-Type"]:="application/x-www-form-urlencoded"
$res:=HTTPRequest("GET"; $url; $body; $header)
$given:="Passing a url and body with paramters declared in body and header with Content-Type"
$should:="return http status code 200"
AJ_assert($test; $res.status; 200; $given; $should)
$should:="return message 'success'"
AJ_assert($test; $res.message; "success"; $given; $should)
$given:="Passing clearviewsys.com as the domain paramter in url and Content-Type x-www-form-urlencoded in header"
$should:="return first domain in list to be 'clearviewsys.com'"
AJ_assert($test; $res.response.domains[0].domain; "clearviewsys.com"; $given; $should)


// CALLING A POST METHOD WHERE METHOD IS NOT ALLOWED
$url:="https://api.domainsdb.info/v1/domains/search"
$body:=New object:C1471
$body.domain:="clearviewsys.com"
$header:=New object:C1471
$header["Content-Type"]:="application/x-www-form-urlencoded"
$res:=HTTPRequest("POST"; $url; $body; $header)
$given:="Making a 'POST' request where only a 'GET' request is allowed"
$should:="return http status code 450"
AJ_assert($test; $res.status; 405; $given; $should)
$should:="return message 'success'"
AJ_assert($test; $res.message; "success"; $given; $should)
$should:="return a respose with a message saying the method is not allowed"
AJ_assert($test; $res.response.message; "The method is not allowed for the requested URL."; $given; $should)


// Making a call to a URL that does not exist
$url:="http://kjalsdfkjafsdlfksj.com/"
$res:=HTTPRequest("GET"; $url)
$given:="Making a request to a non existant url"
$should:="return http status code 0"
AJ_assert($test; $res.status; 0; $given; $should)
$should:="return message should tell you there is an error"
AJ_assert($test; $res.message; "Error #30. There was a problem trying to reach URL: "+$url; $given; $should)


// Making a request with header Content-Type application/json
C_OBJECT:C1216($obj1; $obj2; $obj3; $headers)
C_COLLECTION:C1488($col)
$col:=New collection:C1472
OB SET:C1220($obj1; "email_address"; "valid@example.com")  // DO NOT CHANGE - WILL BE CHARGED $$ - THESE ARE TEST ADDRESSES
OB SET:C1220($obj2; "email_address"; "invalid@example.com"; "ip_address"; "1.1.1.1")  // DO NOT CHANGE - WILL BE CHARGED $$ _ THESE ARE TEST ADDRESSES
OB SET:C1220($obj3; "email_address"; "disposable@example.com")  // DO NOT CHANGE - WILL BE CHARGED $$ - THESE ARE TEST ADDRESSES
$col:=New collection:C1472($obj1; $obj2; $obj3)
$url:="https://bulkapi.zerobounce.net/v2/validatebatch"
$body.email_batch:=$col
$body.api_key:=getKeyValue("zeroBounce.apiKey"; "noKeySet")
$headers:=New object:C1471
$headers["Content-Type"]:="application/json"
$res:=HTTPRequest("POST"; $url; $body; $headers)
$given:="The KeyValue 'zeroBounce.apiKey' was set"
$should:="return true if the it found a keyValue"
AJ_assert($test; $body.api_key#"noKeySet"; True:C214; $given; $should)  // Here just to make sure this call will be successful
$given:="The call was successfully make"
$should:="return an collection of lenght 3 in the respose.email_batch"
AJ_assert($test; $res.response.email_batch.length; 3; $given; $should)
