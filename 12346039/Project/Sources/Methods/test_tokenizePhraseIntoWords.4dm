//%attributes = {}
C_TEXT:C284($phrase)
ARRAY TEXT:C222($arrTokens; 0)

$phrase:=""
tokenizePhraseIntoWords($phrase; ->$arrTokens; " ")

$phrase:="Tiran Behrouz"
tokenizePhraseIntoWords($phrase; ->$arrTokens; " ")

$phrase:="Baba-Ab_Dad"
tokenizePhraseIntoWords($phrase; ->$arrTokens; "-")

$phrase:="S T"
tokenizePhraseIntoWords($phrase; ->$arrTokens; " ")