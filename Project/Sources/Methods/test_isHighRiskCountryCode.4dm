//%attributes = {}

ASSERT:C1129(isHighRiskCountryCode("IR"))
ASSERT:C1129(isHighRiskCountryCode("US")=False:C215)
ASSERT:C1129(isHighRiskCountryCode("CA")=False:C215)
