//%attributes = {}

//
// Set Languages arrays defined in the application (possible translations)
//


ARRAY TEXT:C222(arrTargetLangs; 0)
ARRAY TEXT:C222(arrTargetLangsDesc; 0)

If (Count parameters:C259=1)
	C_BOOLEAN:C305($1)  // True: Add English, False: Do not add English
End if 

If (Count parameters:C259=0)
	APPEND TO ARRAY:C911(arrTargetLangs; "en-US")
	APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("en-US"))
End if 

APPEND TO ARRAY:C911(arrTargetLangs; "es-ES")
APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("es-ES"))

APPEND TO ARRAY:C911(arrTargetLangs; "fr-CH")
APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("fr-CH"))

APPEND TO ARRAY:C911(arrTargetLangs; "de-CH")
APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("de-CH"))

APPEND TO ARRAY:C911(arrTargetLangs; "it-CH")
APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("it-CH"))

APPEND TO ARRAY:C911(arrTargetLangs; "pt-PT")
APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("pt-PT"))

APPEND TO ARRAY:C911(arrTargetLangs; "sv-SE")
APPEND TO ARRAY:C911(arrTargetLangsDesc; Get localized string:C991("sv-SE"))

MULTI SORT ARRAY:C718(arrTargetLangs; >; arrTargetLangsDesc; >)
arrTargetLangs:=1
arrTargetLangsDesc:=1

