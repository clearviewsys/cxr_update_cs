//%attributes = {}
// getHighRiskCountryCodes
// returns a collection of country codes of high risk or sanctioned countries
// see also : initStorageObject

#DECLARE()->$es : Collection

//[Countries]RiskLevel
//[Countries]isSanctioned
//[Countries]CountryCode

$es:=ds:C1482.Countries.query("RiskLevel >= 4 OR isSanctioned== true").distinct("CountryCode")