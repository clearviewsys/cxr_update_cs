//%attributes = {}
// AU_SetGitHubApiHeaders

C_POINTER:C301($1; $arrHeaderPtr; $2; $arrHeaderValuesPtr)

Case of 
	: (Count parameters:C259=2)
		$arrHeaderPtr:=$1
		$arrHeaderValuesPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


APPEND TO ARRAY:C911($arrHeaderPtr->; "Content-Type")
APPEND TO ARRAY:C911($arrHeaderValuesPtr->; "application/vnd.github+json")

APPEND TO ARRAY:C911($arrHeaderPtr->; "token")
APPEND TO ARRAY:C911($arrHeaderValuesPtr->; getKeyValue("AU.GitHubToken"; "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"))
