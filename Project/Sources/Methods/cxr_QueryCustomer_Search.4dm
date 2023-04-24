//%attributes = {}
// cxr_QueryCustomer_Search
// Pulll a Customer by CustomerNo from Oracle Flex Cube

#DECLARE($params : Object)->$customer : Object

var $endPoint : Text
var $customer : Object
var $http : Integer

$customer:=New object:C1471

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)

APPEND TO ARRAY:C911($headerNames; "SOURCE")
APPEND TO ARRAY:C911($headerValues; $params.source)

APPEND TO ARRAY:C911($headerNames; "USERID")
APPEND TO ARRAY:C911($headerValues; $params.userid)

APPEND TO ARRAY:C911($headerNames; "ENTITY")
APPEND TO ARRAY:C911($headerValues; $params.entity)

APPEND TO ARRAY:C911($headerNames; "BRANCH")
APPEND TO ARRAY:C911($headerValues; $params.branch)


$endPoint:="http://demo6874436.mockable.io/CustomerSearchService/CustomerSearch/QueryCustomer-Search/customerNo/"
$endPoint:=$endPoint+$params.customerNo

$http:=HTTP Get:C1157($endPoint; $customer; $headerNames; $headerValues)

UTIL_Log("PullCustomers"; "Pulled: "+$params.customerNo+" FullName: "+$customer.firstName+" "+$customer.lastName)




