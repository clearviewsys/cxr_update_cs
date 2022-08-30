//%attributes = {}
//author: Amir
//date: 7th Oct 2019
//returns base url for person search, depending on "prod" or "test" environment
//text base Url := BisnodeCI_getPersonBaseUrl
C_TEXT:C284($environment)

$environment:=BisN_getEnvironment

C_TEXT:C284($0)
Case of 
	: $environment="test"
		$0:="https://api.bisnode.com/cia-public-api-test/v2"
	: $environment="prod"
		$0:="https://api.bisnode.com/consumerintelligence/person/v2"
End case 
