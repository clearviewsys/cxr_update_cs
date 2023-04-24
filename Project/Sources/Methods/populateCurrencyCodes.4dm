//%attributes = {}
// populateCurrencyCodes
// this method adds currency codes along with their country name and other info
// if the flags folder is defined in the FilesPath as 'FlagsFolder' (JPG) it will also load the pictures

#DECLARE()->$success : Boolean

var $col : Collection
var $entity; $curr : Object
var $picture : Picture
var $picturePath : Text

//[Flags]Country
//[Flags]CurrencyCode
//[Flags]CurrencyName
//[Flags]flag

$col:=New collection:C1472()
$col.push(New object:C1471("Country"; "AF"; "CurrencyCode"; "AFN"; "CurrencyName"; "Afghan Afghani"))
$col.push(New object:C1471("Country"; "EU"; "CurrencyCode"; "EUR"; "CurrencyName"; "European Union"))
$col.push(New object:C1471("Country"; "AL"; "CurrencyCode"; "ALL"; "CurrencyName"; "Albanian Lek"))
$col.push(New object:C1471("Country"; "DZ"; "CurrencyCode"; "DZD"; "CurrencyName"; "Algerian Dinar"))
$col.push(New object:C1471("Country"; "AO"; "CurrencyCode"; "AOA"; "CurrencyName"; "Angolan Kwanza"))
$col.push(New object:C1471("Country"; "AG"; "CurrencyCode"; "XCD"; "CurrencyName"; "East Caribbean Dollar"))
$col.push(New object:C1471("Country"; "AR"; "CurrencyCode"; "ARS"; "CurrencyName"; "Argentine Peso"))
$col.push(New object:C1471("Country"; "AM"; "CurrencyCode"; "AMD"; "CurrencyName"; "Armenian Dram"))
$col.push(New object:C1471("Country"; "AW"; "CurrencyCode"; "AWG"; "CurrencyName"; "Aruban Florin"))
$col.push(New object:C1471("Country"; "AC"; "CurrencyCode"; "SHP"; "CurrencyName"; "Saint Helena Pound"))
$col.push(New object:C1471("Country"; "AU"; "CurrencyCode"; "AUD"; "CurrencyName"; "Australian Dollar"))
$col.push(New object:C1471("Country"; "AZ"; "CurrencyCode"; "AZN"; "CurrencyName"; "Azerbaijani Manat"))
$col.push(New object:C1471("Country"; "BS"; "CurrencyCode"; "BSD"; "CurrencyName"; "Bahamian Dollar"))
$col.push(New object:C1471("Country"; "BH"; "CurrencyCode"; "BHD"; "CurrencyName"; "Bahraini Dinar"))
$col.push(New object:C1471("Country"; "BD"; "CurrencyCode"; "BDT"; "CurrencyName"; "Bangladeshi Taka"))
$col.push(New object:C1471("Country"; "BB"; "CurrencyCode"; "BBD"; "CurrencyName"; "Barbadian Dollar"))
$col.push(New object:C1471("Country"; "BY"; "CurrencyCode"; "BYN"; "CurrencyName"; "Belarusian Ruble"))
$col.push(New object:C1471("Country"; "BZ"; "CurrencyCode"; "BZD"; "CurrencyName"; "Belize Dollar"))
$col.push(New object:C1471("Country"; "BM"; "CurrencyCode"; "BMD"; "CurrencyName"; "Bermudan Dollar"))
$col.push(New object:C1471("Country"; "BO"; "CurrencyCode"; "BOB"; "CurrencyName"; "Bolivian Boliviano"))
$col.push(New object:C1471("Country"; "BA"; "CurrencyCode"; "BAM"; "CurrencyName"; "Bosnia-Herzegovina Convertible Mark"))
$col.push(New object:C1471("Country"; "BW"; "CurrencyCode"; "BWP"; "CurrencyName"; "Botswanan Pula"))
$col.push(New object:C1471("Country"; "BR"; "CurrencyCode"; "BRL"; "CurrencyName"; "Brazilian Real"))
$col.push(New object:C1471("Country"; "BN"; "CurrencyCode"; "BND"; "CurrencyName"; "Brunei Dollar"))
$col.push(New object:C1471("Country"; "BG"; "CurrencyCode"; "BGN"; "CurrencyName"; "Bulgarian Lev"))
$col.push(New object:C1471("Country"; "BI"; "CurrencyCode"; "BIF"; "CurrencyName"; "Burundian Franc"))
$col.push(New object:C1471("Country"; "KH"; "CurrencyCode"; "KHR"; "CurrencyName"; "Cambodian Riel"))
$col.push(New object:C1471("Country"; "CA"; "CurrencyCode"; "CAD"; "CurrencyName"; "Canadian Dollar"))
$col.push(New object:C1471("Country"; "CV"; "CurrencyCode"; "CVE"; "CurrencyName"; "Cape Verdean Escudo"))
$col.push(New object:C1471("Country"; "KY"; "CurrencyCode"; "KYD"; "CurrencyName"; "Cayman Islands Dollar"))
$col.push(New object:C1471("Country"; "CL"; "CurrencyCode"; "CLP"; "CurrencyName"; "Chilean Peso"))
$col.push(New object:C1471("Country"; "CN"; "CurrencyCode"; "CNY"; "CurrencyName"; "Chinese Yuan"))
$col.push(New object:C1471("Country"; "CO"; "CurrencyCode"; "COP"; "CurrencyName"; "Colombian Peso"))
$col.push(New object:C1471("Country"; "KM"; "CurrencyCode"; "KMF"; "CurrencyName"; "Comorian Franc"))
$col.push(New object:C1471("Country"; "CD"; "CurrencyCode"; "CDF"; "CurrencyName"; "Congolese Franc"))
$col.push(New object:C1471("Country"; "CR"; "CurrencyCode"; "CRC"; "CurrencyName"; "Costa Rican Colón"))
$col.push(New object:C1471("Country"; "HR"; "CurrencyCode"; "HRK"; "CurrencyName"; "Croatian Kuna"))
$col.push(New object:C1471("Country"; "CU"; "CurrencyCode"; "CUP"; "CurrencyName"; "Cuban Peso"))
$col.push(New object:C1471("Country"; "CZ"; "CurrencyCode"; "CZK"; "CurrencyName"; "Czech Republic Koruna"))
$col.push(New object:C1471("Country"; "DK"; "CurrencyCode"; "DKK"; "CurrencyName"; "Danish Krone"))
$col.push(New object:C1471("Country"; "DJ"; "CurrencyCode"; "DJF"; "CurrencyName"; "Djiboutian Franc"))
$col.push(New object:C1471("Country"; "DO"; "CurrencyCode"; "DOP"; "CurrencyName"; "Dominican Peso"))
$col.push(New object:C1471("Country"; "EG"; "CurrencyCode"; "EGP"; "CurrencyName"; "Egyptian Pound"))
$col.push(New object:C1471("Country"; "SV"; "CurrencyCode"; "SVC"; "CurrencyName"; "Salvadoran Colón"))
$col.push(New object:C1471("Country"; "ER"; "CurrencyCode"; "ERN"; "CurrencyName"; "Eritrean Nakfa"))
$col.push(New object:C1471("Country"; "ET"; "CurrencyCode"; "ETB"; "CurrencyName"; "Ethiopian Birr"))
$col.push(New object:C1471("Country"; "FK"; "CurrencyCode"; "FKP"; "CurrencyName"; "Falkland Islands Pound"))
$col.push(New object:C1471("Country"; "FJ"; "CurrencyCode"; "FJD"; "CurrencyName"; "Fijian Dollar"))

$col.push(New object:C1471("Country"; "PF"; "CurrencyCode"; "XPF"; "CurrencyName"; "CFP Franc"))
$col.push(New object:C1471("Country"; "GM"; "CurrencyCode"; "GMD"; "CurrencyName"; "Gambian Dalasi"))
$col.push(New object:C1471("Country"; "GE"; "CurrencyCode"; "GEL"; "CurrencyName"; "Georgian Lari"))
$col.push(New object:C1471("Country"; "GH"; "CurrencyCode"; "GHS"; "CurrencyName"; "Ghanaian Cedi"))
$col.push(New object:C1471("Country"; "GI"; "CurrencyCode"; "GIP"; "CurrencyName"; "Gibraltar Pound"))
$col.push(New object:C1471("Country"; "GT"; "CurrencyCode"; "GTQ"; "CurrencyName"; "Guatemalan Quetzal"))
$col.push(New object:C1471("Country"; "GN"; "CurrencyCode"; "GNF"; "CurrencyName"; "Guinean Franc"))
$col.push(New object:C1471("Country"; "GY"; "CurrencyCode"; "GYD"; "CurrencyName"; "Guyanaese Dollar"))
$col.push(New object:C1471("Country"; "HT"; "CurrencyCode"; "HTG"; "CurrencyName"; "Haitian Gourde"))
$col.push(New object:C1471("Country"; "HN"; "CurrencyCode"; "HNL"; "CurrencyName"; "Honduran Lempira"))
$col.push(New object:C1471("Country"; "HK"; "CurrencyCode"; "HKD"; "CurrencyName"; "Hong Kong Dollar"))
$col.push(New object:C1471("Country"; "HU"; "CurrencyCode"; "HUF"; "CurrencyName"; "Hungarian Forint"))
$col.push(New object:C1471("Country"; "IS"; "CurrencyCode"; "ISK"; "CurrencyName"; "Icelandic Króna"))
$col.push(New object:C1471("Country"; "IN"; "CurrencyCode"; "INR"; "CurrencyName"; "Indian Rupee"))
$col.push(New object:C1471("Country"; "ID"; "CurrencyCode"; "IDR"; "CurrencyName"; "Indonesian Rupiah"))
$col.push(New object:C1471("Country"; "IR"; "CurrencyCode"; "IRR"; "CurrencyName"; "Iranian Rial"))
$col.push(New object:C1471("Country"; "IQ"; "CurrencyCode"; "IQD"; "CurrencyName"; "Iraqi Dinar"))
$col.push(New object:C1471("Country"; "IL"; "CurrencyCode"; "ILS"; "CurrencyName"; "Israeli New Sheqel"))
$col.push(New object:C1471("Country"; "JM"; "CurrencyCode"; "JMD"; "CurrencyName"; "Jamaican Dollar"))
$col.push(New object:C1471("Country"; "JP"; "CurrencyCode"; "JPY"; "CurrencyName"; "Japanese Yen"))
$col.push(New object:C1471("Country"; "JO"; "CurrencyCode"; "JOD"; "CurrencyName"; "Jordanian Dinar"))
$col.push(New object:C1471("Country"; "KZ"; "CurrencyCode"; "KZT"; "CurrencyName"; "Kazakhstani Tenge"))
$col.push(New object:C1471("Country"; "KE"; "CurrencyCode"; "KES"; "CurrencyName"; "Kenyan Shilling"))
$col.push(New object:C1471("Country"; "KW"; "CurrencyCode"; "KWD"; "CurrencyName"; "Kuwaiti Dinar"))
$col.push(New object:C1471("Country"; "KG"; "CurrencyCode"; "KGS"; "CurrencyName"; "Kyrgystani Som"))
$col.push(New object:C1471("Country"; "LA"; "CurrencyCode"; "LAK"; "CurrencyName"; "Laotian Kip"))
$col.push(New object:C1471("Country"; "LB"; "CurrencyCode"; "LBP"; "CurrencyName"; "Lebanese Pound"))
$col.push(New object:C1471("Country"; "LS"; "CurrencyCode"; "LSL"; "CurrencyName"; "Lesotho Loti"))
$col.push(New object:C1471("Country"; "LR"; "CurrencyCode"; "LRD"; "CurrencyName"; "Liberian Dollar"))
$col.push(New object:C1471("Country"; "LY"; "CurrencyCode"; "LYD"; "CurrencyName"; "Libyan Dinar"))
$col.push(New object:C1471("Country"; "MO"; "CurrencyCode"; "MOP"; "CurrencyName"; "Macanese Pataca"))
$col.push(New object:C1471("Country"; "MK"; "CurrencyCode"; "MKD"; "CurrencyName"; "Macedonian Denar"))
$col.push(New object:C1471("Country"; "MG"; "CurrencyCode"; "MGA"; "CurrencyName"; "Malagasy Ariary"))
$col.push(New object:C1471("Country"; "MW"; "CurrencyCode"; "MWK"; "CurrencyName"; "Malawian Kwacha"))

$col.push(New object:C1471("Country"; "MY"; "CurrencyCode"; "MYR"; "CurrencyName"; "Malaysian Ringgit"))
$col.push(New object:C1471("Country"; "MV"; "CurrencyCode"; "MVR"; "CurrencyName"; "Maldivian Rufiyaa"))
$col.push(New object:C1471("Country"; "MR"; "CurrencyCode"; "MRU"; "CurrencyName"; "Ouguiya"))
$col.push(New object:C1471("Country"; "MU"; "CurrencyCode"; "MUR"; "CurrencyName"; "Mauritian Rupee"))
$col.push(New object:C1471("Country"; "MX"; "CurrencyCode"; "MXN"; "CurrencyName"; "Mexican Peso"))
$col.push(New object:C1471("Country"; "MD"; "CurrencyCode"; "MDL"; "CurrencyName"; "Moldovan Leu"))
$col.push(New object:C1471("Country"; "MN"; "CurrencyCode"; "MNT"; "CurrencyName"; "Mongolian Tugrik"))
$col.push(New object:C1471("Country"; "MA"; "CurrencyCode"; "MAD"; "CurrencyName"; "Moroccan Dirham"))
$col.push(New object:C1471("Country"; "MZ"; "CurrencyCode"; "MZN"; "CurrencyName"; "Mozambican Metical"))
$col.push(New object:C1471("Country"; "MM"; "CurrencyCode"; "MMK"; "CurrencyName"; "Myanma Kyat"))

$col.push(New object:C1471("Country"; "NA"; "CurrencyCode"; "NAD"; "CurrencyName"; "Namibian Dollar"))
$col.push(New object:C1471("Country"; "NP"; "CurrencyCode"; "NPR"; "CurrencyName"; "Nepalese Rupee"))
$col.push(New object:C1471("Country"; "AN"; "CurrencyCode"; "ANG"; "CurrencyName"; "Netherlands Antillean Guilder"))
$col.push(New object:C1471("Country"; "NZ"; "CurrencyCode"; "NZD"; "CurrencyName"; "New Zealand Dollar"))
$col.push(New object:C1471("Country"; "NI"; "CurrencyCode"; "NIO"; "CurrencyName"; "Nicaraguan Córdoba"))
$col.push(New object:C1471("Country"; "NG"; "CurrencyCode"; "NGN"; "CurrencyName"; "Nigerian Naira"))
$col.push(New object:C1471("Country"; "KP"; "CurrencyCode"; "KPW"; "CurrencyName"; "North Korean Won"))

$col.push(New object:C1471("Country"; "NO"; "CurrencyCode"; "NOK"; "CurrencyName"; "Norwegian Krone"))
$col.push(New object:C1471("Country"; "OM"; "CurrencyCode"; "OMR"; "CurrencyName"; "Omani Rial"))
$col.push(New object:C1471("Country"; "PK"; "CurrencyCode"; "PKR"; "CurrencyName"; "Pakistani Rupee"))

//$col.push(New object("Country"; "PS"; "CurrencyCode"; "JOD"; "CurrencyName"; "Jordanian Dinar"))

$col.push(New object:C1471("Country"; "PA"; "CurrencyCode"; "PAB"; "CurrencyName"; "Panamanian Balboa"))
$col.push(New object:C1471("Country"; "PG"; "CurrencyCode"; "PGK"; "CurrencyName"; "Papua New Guinean Kina"))
$col.push(New object:C1471("Country"; "PY"; "CurrencyCode"; "PYG"; "CurrencyName"; "Paraguayan Guarani"))
$col.push(New object:C1471("Country"; "PE"; "CurrencyCode"; "PEN"; "CurrencyName"; "Peruvian Nuevo Sol"))
$col.push(New object:C1471("Country"; "PH"; "CurrencyCode"; "PHP"; "CurrencyName"; "Philippine Peso"))
$col.push(New object:C1471("Country"; "PL"; "CurrencyCode"; "PLN"; "CurrencyName"; "Polish Zloty"))
$col.push(New object:C1471("Country"; "QA"; "CurrencyCode"; "QAR"; "CurrencyName"; "Qatari Rial"))
$col.push(New object:C1471("Country"; "RO"; "CurrencyCode"; "RON"; "CurrencyName"; "Romanian Leu"))

$col.push(New object:C1471("Country"; "RU"; "CurrencyCode"; "RUB"; "CurrencyName"; "Russian Ruble"))
$col.push(New object:C1471("Country"; "RW"; "CurrencyCode"; "RWF"; "CurrencyName"; "Rwandan Franc"))
$col.push(New object:C1471("Country"; "WS"; "CurrencyCode"; "WST"; "CurrencyName"; "Samoan Tala"))
$col.push(New object:C1471("Country"; "ST"; "CurrencyCode"; "STN"; "CurrencyName"; "Dobra"))
$col.push(New object:C1471("Country"; "SA"; "CurrencyCode"; "SAR"; "CurrencyName"; "Saudi Riyal"))
$col.push(New object:C1471("Country"; "RS"; "CurrencyCode"; "RSD"; "CurrencyName"; "Serbian Dinar"))
$col.push(New object:C1471("Country"; "SC"; "CurrencyCode"; "SCR"; "CurrencyName"; "Seychellois Rupee"))
$col.push(New object:C1471("Country"; "SL"; "CurrencyCode"; "SLL"; "CurrencyName"; "Sierra Leonean Leone"))
$col.push(New object:C1471("Country"; "SG"; "CurrencyCode"; "SGD"; "CurrencyName"; "Singapore Dollar"))
$col.push(New object:C1471("Country"; "SB"; "CurrencyCode"; "SBD"; "CurrencyName"; "Solomon Islands Dollar"))

$col.push(New object:C1471("Country"; "SO"; "CurrencyCode"; "SOS"; "CurrencyName"; "Somali Shilling"))
$col.push(New object:C1471("Country"; "ZA"; "CurrencyCode"; "ZAR"; "CurrencyName"; "South African Rand"))
$col.push(New object:C1471("Country"; "KR"; "CurrencyCode"; "KRW"; "CurrencyName"; "South Korean Won"))
$col.push(New object:C1471("Country"; "SS"; "CurrencyCode"; "SSP"; "CurrencyName"; "South Sudanese Pound"))
$col.push(New object:C1471("Country"; "LK"; "CurrencyCode"; "LKR"; "CurrencyName"; "Sri Lankan Rupee"))
$col.push(New object:C1471("Country"; "SD"; "CurrencyCode"; "SDG"; "CurrencyName"; "Sudanese Pound"))
$col.push(New object:C1471("Country"; "SR"; "CurrencyCode"; "SRD"; "CurrencyName"; "Surinamese Dollar"))
$col.push(New object:C1471("Country"; "SZ"; "CurrencyCode"; "SZL"; "CurrencyName"; "Swazi Lilangeni"))
$col.push(New object:C1471("Country"; "SE"; "CurrencyCode"; "SEK"; "CurrencyName"; "Swedish Krona"))
$col.push(New object:C1471("Country"; "CH"; "CurrencyCode"; "CHF"; "CurrencyName"; "Swiss Franc"))

$col.push(New object:C1471("Country"; "SY"; "CurrencyCode"; "SYP"; "CurrencyName"; "Syrian Pound"))
$col.push(New object:C1471("Country"; "TW"; "CurrencyCode"; "TWD"; "CurrencyName"; "New Taiwan Dollar"))
$col.push(New object:C1471("Country"; "TJ"; "CurrencyCode"; "TJS"; "CurrencyName"; "Tajikistani Somoni"))
$col.push(New object:C1471("Country"; "TZ"; "CurrencyCode"; "TZS"; "CurrencyName"; "Tanzanian Shilling"))
$col.push(New object:C1471("Country"; "TH"; "CurrencyCode"; "THB"; "CurrencyName"; "Thai Baht"))
$col.push(New object:C1471("Country"; "TG"; "CurrencyCode"; "XOF"; "CurrencyName"; "CFA Franc BCEAO"))

$col.push(New object:C1471("Country"; "TO"; "CurrencyCode"; "TOP"; "CurrencyName"; "Tongan Paʻanga"))
$col.push(New object:C1471("Country"; "TT"; "CurrencyCode"; "TTD"; "CurrencyName"; "Trinidad and Tobago Dollar"))

//$col.push(New object("Country"; "TA"; "CurrencyCode"; "SHP"; "CurrencyName"; "Saint Helena Pound"))

$col.push(New object:C1471("Country"; "TN"; "CurrencyCode"; "TND"; "CurrencyName"; "Tunisian Dinar"))
$col.push(New object:C1471("Country"; "TR"; "CurrencyCode"; "TRY"; "CurrencyName"; "Turkish Lira"))
$col.push(New object:C1471("Country"; "TM"; "CurrencyCode"; "TMT"; "CurrencyName"; "Turkmenistani Manat"))

$col.push(New object:C1471("Country"; "UG"; "CurrencyCode"; "UGX"; "CurrencyName"; "Ugandan Shilling"))
$col.push(New object:C1471("Country"; "UA"; "CurrencyCode"; "UAH"; "CurrencyName"; "Ukrainian Hryvnia"))
$col.push(New object:C1471("Country"; "AE"; "CurrencyCode"; "AED"; "CurrencyName"; "United Arab Emirates Dirham"))
$col.push(New object:C1471("Country"; "GB"; "CurrencyCode"; "GBP"; "CurrencyName"; "Pound Sterling"))
$col.push(New object:C1471("Country"; "US"; "CurrencyCode"; "USD"; "CurrencyName"; "US Dollar"))
$col.push(New object:C1471("Country"; "UY"; "CurrencyCode"; "UYU"; "CurrencyName"; "Uruguayan Peso"))
$col.push(New object:C1471("Country"; "UZ"; "CurrencyCode"; "UZS"; "CurrencyName"; "Uzbekistan Som"))
$col.push(New object:C1471("Country"; "VU"; "CurrencyCode"; "VUV"; "CurrencyName"; "Vanuatu Vatu"))
$col.push(New object:C1471("Country"; "VE"; "CurrencyCode"; "VES"; "CurrencyName"; "Bolívar Soberano"))
$col.push(New object:C1471("Country"; "VN"; "CurrencyCode"; "VND"; "CurrencyName"; "Vietnamese Dong"))

//$col.push(New object("Country"; "EH"; "CurrencyCode"; "MAD"; "CurrencyName"; "Moroccan Dirham"))

$col.push(New object:C1471("Country"; "YE"; "CurrencyCode"; "YER"; "CurrencyName"; "Yemeni Rial"))
$col.push(New object:C1471("Country"; "ZM"; "CurrencyCode"; "ZMW"; "CurrencyName"; "Zambian Kwacha"))
$col.push(New object:C1471("Country"; "ZW"; "CurrencyCode"; "ZWL"; "CurrencyName"; "Zimbabwean Dollar"))

var $status : Object

$picturePath:=getFilePathByID("FlagsFolder")
If ($picturePath="")
	notifyAlert("Missing FilePath"; "Please define FlagsFolder in the FilePath. "+\
		"The folder should containt JPG flags for currencies.")
End if 


var $folderPath : Text
$folderPath:=getFilePathByID("FlagsFolder")

If (ds:C1482.Flags.all().length=0)
	For each ($curr; $col)
		
		
		$entity:=ds:C1482.Flags.new()
		
		$entity.Country:=$curr.Country
		$entity.CurrencyCode:=$curr.CurrencyCode
		$entity.CurrencyName:=$curr.CurrencyName
		//$entity.flag:=getImageFromURL("https://countryflagsapi.com/png/"+Lowercase($curr.Country))
		$picturePath:=$folderPath+$curr.CurrencyCode+".JPG"
		If ($picturePath#"")
			loadPicture($picturePath; ->$picture)
			$entity.flag:=$picture
		End if 
		
		$status:=$entity.save()
		If ($status.success)
		Else 
			notifyAlert("Cannot Save"; "Error occured during save")
			$success:=False:C215
			break
		End if 
		
	End for each 
	$success:=True:C214
	
Else 
	$success:=False:C215
	notifyAlert("Cannot populate into non-empty table!")
End if 

