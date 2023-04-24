//%attributes = {}

#DECLARE()->$isNewVersion : Boolean

var $repositoryURL : Text
var $status : Integer
var $headers; $requestParameters; $emptyObj; $response; $cmd : Object


ARRAY TEXT:C222($arrHeader; 0)
ARRAY TEXT:C222($arrFileName; 0)
ARRAY TEXT:C222($arrHeaderValues; 0)


$repositoryURL:=getKeyValue("AU.GitHubRepo"; "https://api.github.com/repos/clearviewsys/cxr_update_cs/releases/latest")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $repositoryURL; $emptyObj; $response; $arrHeader; $arrHeaderValues)

$isNewVersion:=False:C215

If ($status=200)
	
	If ($response.tag_name>getBuild)
		$isNewVersion:=True:C214
	End if 
	
End if 



