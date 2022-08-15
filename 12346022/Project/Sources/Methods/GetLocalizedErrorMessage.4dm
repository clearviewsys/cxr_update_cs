//%attributes = {}



// getLocalizedErrorMessage (XLIFF ID: LONGINT; {xtag; {ytag; {ztag}}}) 
// this method returns the error message
// this wrapper method may be modified later to have a log or something

C_LONGINT:C283($1; $xliffID)
C_TEXT:C284($str1; $str2; $str3)
C_TEXT:C284($0; $err; $errCode)

Case of 
	: (Count parameters:C259=0)
		$xliffID:=3557
		$str1:="customers"
	: (Count parameters:C259=1)
		$xliffID:=$1
	: (Count parameters:C259=2)
		$xliffID:=$1
		$str1:=$2
	: (Count parameters:C259=3)
		$xliffID:=$1
		$str1:=$2
		$str2:=$3
	: (Count parameters:C259=4)
		$xliffID:=$1
		$str1:=$2
		$str2:=$3
		$str3:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$errCode:="err_"+String:C10($xliffID)

//replaceXYZTags (->$err;$str1;$str2;$str3)

$err:=Get localized string:C991($errCode)

If ($err="")
	C_TEXT:C284($language; $error)
	$language:=GetCurrentLocalization
	
	If ($language="en-US")
		
		// Replaced by CVS Dev. Team. Jan 25/2017
		
		Begin SQL
			SELECT Keywords.sourceText FROM Keywords WHERE Keywords.keyword = :$errCode
			INTO <<$error>>
		End SQL
		
		// READ ONLY([Keywords])
		//QUERY([Keywords];[Keywords]keyword=$errCode)
		//$error:=[Keywords]sourceText
	Else 
		
		// Replaced by CVS Dev. Team. Jan 25/2017
		
		Begin SQL
			SELECT DB_Translations.Translation FROM DB_Keywords, DB_Translations 
			WHERE DB_Keywords.keyword = :$errCode AND DB_Keywords.ID = DB_Translations.KeywordID AND DB_Translations.languageCode = :$language
			INTO <<$error>>
		End SQL
		
		// READ ONLY([Translations])
		//QUERY([Translations];[Translations]KeywordID=$errCode;*)
		//QUERY([Translations]; & ;[Translations]languageCode=$language)
		//$error:=[Translations]Translation
		
	End if 
	
	replaceXYZTags(->$error; $str1; $str2; $str3)
	$0:="Error: "+String:C10($xliffID)+CRLF+$error
Else 
	replaceXYZTags(->$err; $str1; $str2; $str3)
	$0:=$err
End if 