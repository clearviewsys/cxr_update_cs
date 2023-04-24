var $collect : Text
$collect:=utils_getValueFromObject([SanctionLists:113]Details:13; "default"; \
"OpenSanctions"; "collections")

util_openURL("https://www.opensanctions.org/datasets/"+$collect+"/")