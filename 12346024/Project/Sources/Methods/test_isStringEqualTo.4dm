//%attributes = {}


C_TEXT:C284($a; $b; $given)

ASSERT:C1129(isStringEqualTo("hello"; "hello")=True:C214)
ASSERT:C1129(isStringEqualTo("hello world"; "hello world")=True:C214)
ASSERT:C1129(isStringEqualTo("hello"; "Hello"; ck diacritical:K85:3)=False:C215)
ASSERT:C1129(isStringEqualTo("hello"; "hell@"; ck diacritical:K85:3)=False:C215)
ASSERT:C1129(isStringEqualTo("hell@@"; "hell@"; ck diacritical:K85:3)=False:C215)
ASSERT:C1129(isStringEqualTo("hell@o"; "hello@")=False:C215)
ASSERT:C1129(isStringEqualTo("tiran@mac.com"; "tiranbehrouz@mac.com")=False:C215)