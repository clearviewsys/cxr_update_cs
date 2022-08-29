//%attributes = {}
/** Saves a KYC2020 Decision IQ Report

TODO: Stub method

*/
#DECLARE($smartScanParam : Object; $tableIdParam : Integer; $recordIdParam : Text)
var $smartScan : Object
var $tableId : Integer
var $recordId : Text

/**  
| diq-summary key                 |type |diq-summary description                                |
|---------------------------------|-----|-------------------------------------------------------|
|decision                         |text |DecisionIQ outcome, possible values: PASS, FAIL, VERIFY|
|diqCustomerId                    |text |Unique Search ID used for Ongoing Monitoring           |
|reason                           |text |Reason for the decision taken by DecisionIQ            |
|powUrl                           |text |URL of the Proof of Decision File                      |
|score                            |text |Highest SmartScan score                                |
|timestamp                        |text |Timestamp of search performed                          |
|processingTime                   |text |Response time for the Decision                         |
|recordsContributingToResult      |text |ID of records contributing to the decision             |
|recordsContributingToFail        |text |ID of records contributing to the FAIL decision        |
|recordsContributingToVerify      |text |ID of records contributing to the VERIFY decision      |
|search-dump-id                   |text |Internal ID                                            |
|diqResultsByWatchlistType        |Array|                                                       |
|diqResultsByWatchlistType.type   |text |text field indicating the list type                    |
|diqResultsByWatchlistType.value  |text | field indicating the quality of match                 |
|highRiskBusinessAssociation      |Array|                                                       |
|highRiskBusinessAssociation.type |text |Business Type                                          |
|highRiskBusinessAssociation.value|text |indicating the quality of match                        |
*/

Case of 
	: (Count parameters:C259=3)
		$smartScan:=$smartScanParam
		$tableId:=$tableIdParam
		$recordId:=$recordIdParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 