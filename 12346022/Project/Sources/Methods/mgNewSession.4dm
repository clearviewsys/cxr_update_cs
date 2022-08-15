//%attributes = {}
//  // opens new session with MoneyGram using HTTP Client command and returns session object
//  // not used

//C_OBJECT($0)
//C_OBJECT($1;$credentials)
//C_BOOLEAN($2;$debug)
//C_TEXT($requestBody;$responsetxt;$url)
//C_LONGINT($err)
//C_COLLECTION($col)
//C_BLOB($response)
//C_OBJECT($endPoints)

//$credentials:=$1
//If (Count parameters>1)
//$debug:=$2
//Else 
//$debug:=False
//End if 

//$endPoints:=mgGetEndPoints 

//$0:=New object

//  // $0.url:="https://tmg15.sb.com.ua/MG/CXR/IntegratedLogin.aspx"

//$0.endpoints:=$endPoints
//$url:=$0.endpoints.newSession

//mgSetHTTPCertificates (mgGetResourcesPath )

//If ($debug)
//$requestBody:="login="+$credentials.username+"&locale=en&pass="+$credentials.password+"&agentId="+$credentials.agentID+"&isDebug=true\n"
//Else 
//$requestBody:="login="+$credentials.username+"&locale=en&pass="+$credentials.password+"&agentId="+$credentials.agentID+"\n"
//End if 

//ARRAY TEXT($headerNames;0)
//ARRAY TEXT($headerValues;0)

//If ($requestBody#"")
//APPEND TO ARRAY($headerNames;"Content-Type")
//APPEND TO ARRAY($headerValues;"application/x-www-form-urlencoded")
//APPEND TO ARRAY($headerNames;"Content-Length")
//APPEND TO ARRAY($headerValues;String(Length($requestBody)))
//End if 

//$err:=HTTP Request(HTTP POST method;$url;$requestBody;$response;$headerNames;$headerValues)

//$responsetxt:=BLOB to text($response;UTF8 text without length)

//$0.httpCode:=$err

//If ($err=200)

//  // we have to pass this cookies in each request

//$col:=getCookiesInCollection (->$headerNames;->$headerValues;New collection(".MG1512ASPAUTH";"ASP.NET_SessionId";"mgAgentCountry";"mgLocale"))

//$0.cookies:=$col
//$0.debug:=$debug

//End if 
