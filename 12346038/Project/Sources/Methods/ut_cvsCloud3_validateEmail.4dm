//%attributes = {"shared":true}
// __UNIT_TEST
//by @Zoya - June 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("cvsClaoud3_validateEmail"; Current method name:C684; "API.ZeroBounce")

C_COLLECTION:C1488($testData)
$testData:=New collection:C1472("disposable@example.com"; \
"invalid@example.com"; "valid@example.com"; "toxic@example.com"; "donotmail@example.com"; \
"spamtrap@example.com"; \
"abuse@example.com"; \
"unknown@example.com"; \
"catch_all@example.com"; \
"antispam_system@example.com"; \
"does_not_accept_mail@example.com"; \
"exception_occurred@example.com"; \
"failed_smtp_connection@example.com"; \
"failed_syntax_check@example.com"; \
"forcible_disconnect@example.com"; \
"global_suppression@example.com"; \
"greylisted@example.com"; \
"leading_period_removed@example.com"; \
"mail_server_did_not_respond@example.com"; \
"mail_server_temporary_error@example.com"; \
"mailbox_quota_exceeded@example.com"; "mailbox_not_found@example.com"; \
"no_dns_entries@example.com"; "possible_trap@example.com"; \
"possible_typo@example.com"; "role_based@example.com"; \
"timeout_exceeded@example.com"; "unroutable_ip_address@example.com"; \
"free_email@example.com"; "role_based_catch_all@example.com")

C_TEXT:C284($testD)

For each ($testD; $testData)
	AJ_assert($test; cvsCloud3_validateEmail("$testD").response.status; "Valid"; $testD; "return Valid")
	//AJ_assert($test; cvsCloud3_validateEmail("$testD"); "success"; $testD; "return success")
	
End for each 

//AJ_assert($test; cvsCloud3_validateEmail("no_dns_entries@example.com").response.status; "success"; "no_dns_entries@example.com"; "return success")



