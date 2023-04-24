//%attributes = {}

//getCountryCodeBy3charCode ( 3 chars ISO code) -> 2 char country code

ARRAY TEXT:C222($arr2Chars; 0)
ARRAY TEXT:C222($arr3Chars; 0)
C_TEXT:C284($1; $0)
C_LONGINT:C283($found)
C_TEXT:C284($code2A; $code3A)

Case of 
	: (Count parameters:C259=0)
		$code3A:="BRB"
		
	: (Count parameters:C259=1)
		$code3A:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

APPEND TO ARRAY:C911($arr2Chars; "AF")
APPEND TO ARRAY:C911($arr2Chars; "AX")
APPEND TO ARRAY:C911($arr2Chars; "AL")
APPEND TO ARRAY:C911($arr2Chars; "DZ")
APPEND TO ARRAY:C911($arr2Chars; "AS")
APPEND TO ARRAY:C911($arr2Chars; "AD")
APPEND TO ARRAY:C911($arr2Chars; "AO")
APPEND TO ARRAY:C911($arr2Chars; "AI")
APPEND TO ARRAY:C911($arr2Chars; "AQ")
APPEND TO ARRAY:C911($arr2Chars; "AG")
APPEND TO ARRAY:C911($arr2Chars; "AR")
APPEND TO ARRAY:C911($arr2Chars; "AM")
APPEND TO ARRAY:C911($arr2Chars; "AW")
APPEND TO ARRAY:C911($arr2Chars; "AU")
APPEND TO ARRAY:C911($arr2Chars; "AT")
APPEND TO ARRAY:C911($arr2Chars; "AZ")

APPEND TO ARRAY:C911($arr2Chars; "BS")
APPEND TO ARRAY:C911($arr2Chars; "BH")
APPEND TO ARRAY:C911($arr2Chars; "BD")
APPEND TO ARRAY:C911($arr2Chars; "BB")
APPEND TO ARRAY:C911($arr2Chars; "BY")
APPEND TO ARRAY:C911($arr2Chars; "BE")
APPEND TO ARRAY:C911($arr2Chars; "BZ")
APPEND TO ARRAY:C911($arr2Chars; "BJ")
APPEND TO ARRAY:C911($arr2Chars; "BM")
APPEND TO ARRAY:C911($arr2Chars; "BT")
APPEND TO ARRAY:C911($arr2Chars; "BO")
APPEND TO ARRAY:C911($arr2Chars; "BA")
APPEND TO ARRAY:C911($arr2Chars; "BW")
APPEND TO ARRAY:C911($arr2Chars; "BV")
APPEND TO ARRAY:C911($arr2Chars; "BR")
APPEND TO ARRAY:C911($arr2Chars; "VG")
APPEND TO ARRAY:C911($arr2Chars; "IO")
APPEND TO ARRAY:C911($arr2Chars; "BN")
APPEND TO ARRAY:C911($arr2Chars; "BG")
APPEND TO ARRAY:C911($arr2Chars; "BF")
APPEND TO ARRAY:C911($arr2Chars; "BI")

APPEND TO ARRAY:C911($arr2Chars; "KH")
APPEND TO ARRAY:C911($arr2Chars; "CM")
APPEND TO ARRAY:C911($arr2Chars; "CA")
APPEND TO ARRAY:C911($arr2Chars; "CV")
APPEND TO ARRAY:C911($arr2Chars; "KY")
APPEND TO ARRAY:C911($arr2Chars; "CF")
APPEND TO ARRAY:C911($arr2Chars; "TD")
APPEND TO ARRAY:C911($arr2Chars; "CL")
APPEND TO ARRAY:C911($arr2Chars; "CN")
APPEND TO ARRAY:C911($arr2Chars; "HK")
APPEND TO ARRAY:C911($arr2Chars; "MO")
APPEND TO ARRAY:C911($arr2Chars; "CX")
APPEND TO ARRAY:C911($arr2Chars; "CC")
APPEND TO ARRAY:C911($arr2Chars; "CO")
APPEND TO ARRAY:C911($arr2Chars; "KM")
APPEND TO ARRAY:C911($arr2Chars; "CG")
APPEND TO ARRAY:C911($arr2Chars; "CD")
APPEND TO ARRAY:C911($arr2Chars; "CK")
APPEND TO ARRAY:C911($arr2Chars; "CR")
APPEND TO ARRAY:C911($arr2Chars; "CI")
APPEND TO ARRAY:C911($arr2Chars; "HR")
APPEND TO ARRAY:C911($arr2Chars; "CU")
APPEND TO ARRAY:C911($arr2Chars; "CY")
APPEND TO ARRAY:C911($arr2Chars; "CZ")

APPEND TO ARRAY:C911($arr2Chars; "DK")
APPEND TO ARRAY:C911($arr2Chars; "DJ")
APPEND TO ARRAY:C911($arr2Chars; "DM")
APPEND TO ARRAY:C911($arr2Chars; "DO")

APPEND TO ARRAY:C911($arr2Chars; "EC")
APPEND TO ARRAY:C911($arr2Chars; "EG")
APPEND TO ARRAY:C911($arr2Chars; "SV")
APPEND TO ARRAY:C911($arr2Chars; "GQ")
APPEND TO ARRAY:C911($arr2Chars; "ER")
APPEND TO ARRAY:C911($arr2Chars; "EE")
APPEND TO ARRAY:C911($arr2Chars; "ET")

APPEND TO ARRAY:C911($arr2Chars; "FK")
APPEND TO ARRAY:C911($arr2Chars; "FO")
APPEND TO ARRAY:C911($arr2Chars; "FJ")
APPEND TO ARRAY:C911($arr2Chars; "FI")
APPEND TO ARRAY:C911($arr2Chars; "FR")
APPEND TO ARRAY:C911($arr2Chars; "GF")
APPEND TO ARRAY:C911($arr2Chars; "PF")
APPEND TO ARRAY:C911($arr2Chars; "TF")

APPEND TO ARRAY:C911($arr2Chars; "GA")
APPEND TO ARRAY:C911($arr2Chars; "GM")
APPEND TO ARRAY:C911($arr2Chars; "GE")
APPEND TO ARRAY:C911($arr2Chars; "DE")
APPEND TO ARRAY:C911($arr2Chars; "GH")
APPEND TO ARRAY:C911($arr2Chars; "GI")
APPEND TO ARRAY:C911($arr2Chars; "GR")
APPEND TO ARRAY:C911($arr2Chars; "GL")
APPEND TO ARRAY:C911($arr2Chars; "GD")
APPEND TO ARRAY:C911($arr2Chars; "GP")
APPEND TO ARRAY:C911($arr2Chars; "GU")
APPEND TO ARRAY:C911($arr2Chars; "GT")
APPEND TO ARRAY:C911($arr2Chars; "GG")
APPEND TO ARRAY:C911($arr2Chars; "GN")
APPEND TO ARRAY:C911($arr2Chars; "GW")
APPEND TO ARRAY:C911($arr2Chars; "GY")

APPEND TO ARRAY:C911($arr2Chars; "HT")
APPEND TO ARRAY:C911($arr2Chars; "HM")
APPEND TO ARRAY:C911($arr2Chars; "VA")
APPEND TO ARRAY:C911($arr2Chars; "HN")
APPEND TO ARRAY:C911($arr2Chars; "HU")
APPEND TO ARRAY:C911($arr2Chars; "IS")

APPEND TO ARRAY:C911($arr2Chars; "IN")
APPEND TO ARRAY:C911($arr2Chars; "ID")
APPEND TO ARRAY:C911($arr2Chars; "IR")
APPEND TO ARRAY:C911($arr2Chars; "IQ")
APPEND TO ARRAY:C911($arr2Chars; "IE")
APPEND TO ARRAY:C911($arr2Chars; "IM")
APPEND TO ARRAY:C911($arr2Chars; "IL")
APPEND TO ARRAY:C911($arr2Chars; "IT")

APPEND TO ARRAY:C911($arr2Chars; "JM")
APPEND TO ARRAY:C911($arr2Chars; "JP")
APPEND TO ARRAY:C911($arr2Chars; "JE")
APPEND TO ARRAY:C911($arr2Chars; "JO")

APPEND TO ARRAY:C911($arr2Chars; "KZ")
APPEND TO ARRAY:C911($arr2Chars; "KE")
APPEND TO ARRAY:C911($arr2Chars; "KI")
APPEND TO ARRAY:C911($arr2Chars; "KP")
APPEND TO ARRAY:C911($arr2Chars; "KR")
APPEND TO ARRAY:C911($arr2Chars; "KW")
APPEND TO ARRAY:C911($arr2Chars; "KG")

APPEND TO ARRAY:C911($arr2Chars; "LA")
APPEND TO ARRAY:C911($arr2Chars; "LV")
APPEND TO ARRAY:C911($arr2Chars; "LB")
APPEND TO ARRAY:C911($arr2Chars; "LS")
APPEND TO ARRAY:C911($arr2Chars; "LR")
APPEND TO ARRAY:C911($arr2Chars; "LY")
APPEND TO ARRAY:C911($arr2Chars; "LI")
APPEND TO ARRAY:C911($arr2Chars; "LT")
APPEND TO ARRAY:C911($arr2Chars; "LU")

APPEND TO ARRAY:C911($arr2Chars; "MK")
APPEND TO ARRAY:C911($arr2Chars; "MG")
APPEND TO ARRAY:C911($arr2Chars; "MW")
APPEND TO ARRAY:C911($arr2Chars; "MY")
APPEND TO ARRAY:C911($arr2Chars; "MV")
APPEND TO ARRAY:C911($arr2Chars; "ML")
APPEND TO ARRAY:C911($arr2Chars; "MT")
APPEND TO ARRAY:C911($arr2Chars; "MH")
APPEND TO ARRAY:C911($arr2Chars; "MQ")
APPEND TO ARRAY:C911($arr2Chars; "MR")
APPEND TO ARRAY:C911($arr2Chars; "MU")
APPEND TO ARRAY:C911($arr2Chars; "YT")
APPEND TO ARRAY:C911($arr2Chars; "MX")
APPEND TO ARRAY:C911($arr2Chars; "FM")
APPEND TO ARRAY:C911($arr2Chars; "MD")
APPEND TO ARRAY:C911($arr2Chars; "MC")
APPEND TO ARRAY:C911($arr2Chars; "MN")
APPEND TO ARRAY:C911($arr2Chars; "ME")
APPEND TO ARRAY:C911($arr2Chars; "MS")
APPEND TO ARRAY:C911($arr2Chars; "MA")
APPEND TO ARRAY:C911($arr2Chars; "MZ")
APPEND TO ARRAY:C911($arr2Chars; "MM")

APPEND TO ARRAY:C911($arr2Chars; "NA")
APPEND TO ARRAY:C911($arr2Chars; "NR")
APPEND TO ARRAY:C911($arr2Chars; "NP")
APPEND TO ARRAY:C911($arr2Chars; "NL")
APPEND TO ARRAY:C911($arr2Chars; "AN")
APPEND TO ARRAY:C911($arr2Chars; "NC")
APPEND TO ARRAY:C911($arr2Chars; "NZ")
APPEND TO ARRAY:C911($arr2Chars; "NI")
APPEND TO ARRAY:C911($arr2Chars; "NE")
APPEND TO ARRAY:C911($arr2Chars; "NG")
APPEND TO ARRAY:C911($arr2Chars; "NU")
APPEND TO ARRAY:C911($arr2Chars; "NF")
APPEND TO ARRAY:C911($arr2Chars; "MP")
APPEND TO ARRAY:C911($arr2Chars; "NO")

APPEND TO ARRAY:C911($arr2Chars; "OM")

APPEND TO ARRAY:C911($arr2Chars; "PK")
APPEND TO ARRAY:C911($arr2Chars; "PW")
APPEND TO ARRAY:C911($arr2Chars; "PS")
APPEND TO ARRAY:C911($arr2Chars; "PA")
APPEND TO ARRAY:C911($arr2Chars; "PG")
APPEND TO ARRAY:C911($arr2Chars; "PY")
APPEND TO ARRAY:C911($arr2Chars; "PE")
APPEND TO ARRAY:C911($arr2Chars; "PH")
APPEND TO ARRAY:C911($arr2Chars; "PN")
APPEND TO ARRAY:C911($arr2Chars; "PL")
APPEND TO ARRAY:C911($arr2Chars; "PT")
APPEND TO ARRAY:C911($arr2Chars; "PR")

APPEND TO ARRAY:C911($arr2Chars; "QA")

APPEND TO ARRAY:C911($arr2Chars; "RE")
APPEND TO ARRAY:C911($arr2Chars; "RO")
APPEND TO ARRAY:C911($arr2Chars; "RU")
APPEND TO ARRAY:C911($arr2Chars; "RW")

APPEND TO ARRAY:C911($arr2Chars; "BL")
APPEND TO ARRAY:C911($arr2Chars; "SH")
APPEND TO ARRAY:C911($arr2Chars; "KN")
APPEND TO ARRAY:C911($arr2Chars; "LC")
APPEND TO ARRAY:C911($arr2Chars; "MF")
APPEND TO ARRAY:C911($arr2Chars; "PM")
APPEND TO ARRAY:C911($arr2Chars; "VC")
APPEND TO ARRAY:C911($arr2Chars; "WS")
APPEND TO ARRAY:C911($arr2Chars; "SM")
APPEND TO ARRAY:C911($arr2Chars; "ST")
APPEND TO ARRAY:C911($arr2Chars; "SA")
APPEND TO ARRAY:C911($arr2Chars; "SN")
APPEND TO ARRAY:C911($arr2Chars; "RS")
APPEND TO ARRAY:C911($arr2Chars; "SC")
APPEND TO ARRAY:C911($arr2Chars; "SL")
APPEND TO ARRAY:C911($arr2Chars; "SG")
APPEND TO ARRAY:C911($arr2Chars; "SK")
APPEND TO ARRAY:C911($arr2Chars; "SI")
APPEND TO ARRAY:C911($arr2Chars; "SB")
APPEND TO ARRAY:C911($arr2Chars; "SO")
APPEND TO ARRAY:C911($arr2Chars; "ZA")
APPEND TO ARRAY:C911($arr2Chars; "GS")
APPEND TO ARRAY:C911($arr2Chars; "SS")
APPEND TO ARRAY:C911($arr2Chars; "ES")
APPEND TO ARRAY:C911($arr2Chars; "LK")
APPEND TO ARRAY:C911($arr2Chars; "SD")
APPEND TO ARRAY:C911($arr2Chars; "SR")
APPEND TO ARRAY:C911($arr2Chars; "SJ")
APPEND TO ARRAY:C911($arr2Chars; "SZ")
APPEND TO ARRAY:C911($arr2Chars; "SE")
APPEND TO ARRAY:C911($arr2Chars; "CH")
APPEND TO ARRAY:C911($arr2Chars; "SY")

APPEND TO ARRAY:C911($arr2Chars; "TW")
APPEND TO ARRAY:C911($arr2Chars; "TJ")
APPEND TO ARRAY:C911($arr2Chars; "TZ")
APPEND TO ARRAY:C911($arr2Chars; "TH")
APPEND TO ARRAY:C911($arr2Chars; "TL")
APPEND TO ARRAY:C911($arr2Chars; "TG")
APPEND TO ARRAY:C911($arr2Chars; "TK")
APPEND TO ARRAY:C911($arr2Chars; "TO")
APPEND TO ARRAY:C911($arr2Chars; "TT")
APPEND TO ARRAY:C911($arr2Chars; "TN")
APPEND TO ARRAY:C911($arr2Chars; "TR")
APPEND TO ARRAY:C911($arr2Chars; "TM")
APPEND TO ARRAY:C911($arr2Chars; "TC")
APPEND TO ARRAY:C911($arr2Chars; "TV")

APPEND TO ARRAY:C911($arr2Chars; "UG")
APPEND TO ARRAY:C911($arr2Chars; "UA")
APPEND TO ARRAY:C911($arr2Chars; "AE")
APPEND TO ARRAY:C911($arr2Chars; "GB")
APPEND TO ARRAY:C911($arr2Chars; "US")
APPEND TO ARRAY:C911($arr2Chars; "UM")
APPEND TO ARRAY:C911($arr2Chars; "UY")
APPEND TO ARRAY:C911($arr2Chars; "UZ")

APPEND TO ARRAY:C911($arr2Chars; "VU")
APPEND TO ARRAY:C911($arr2Chars; "VE")
APPEND TO ARRAY:C911($arr2Chars; "VN")
APPEND TO ARRAY:C911($arr2Chars; "VI")

APPEND TO ARRAY:C911($arr2Chars; "WF")
APPEND TO ARRAY:C911($arr2Chars; "EH")

APPEND TO ARRAY:C911($arr2Chars; "YE")
APPEND TO ARRAY:C911($arr2Chars; "ZM")
APPEND TO ARRAY:C911($arr2Chars; "ZW")

//

APPEND TO ARRAY:C911($arr3Chars; "AFG")
APPEND TO ARRAY:C911($arr3Chars; "ALA")
APPEND TO ARRAY:C911($arr3Chars; "ALB")
APPEND TO ARRAY:C911($arr3Chars; "DZA")
APPEND TO ARRAY:C911($arr3Chars; "ASM")
APPEND TO ARRAY:C911($arr3Chars; "AND")
APPEND TO ARRAY:C911($arr3Chars; "AGO")
APPEND TO ARRAY:C911($arr3Chars; "AIA")
APPEND TO ARRAY:C911($arr3Chars; "ATA")
APPEND TO ARRAY:C911($arr3Chars; "ATG")
APPEND TO ARRAY:C911($arr3Chars; "ARG")
APPEND TO ARRAY:C911($arr3Chars; "ARM")
APPEND TO ARRAY:C911($arr3Chars; "ABW")
APPEND TO ARRAY:C911($arr3Chars; "AUS")
APPEND TO ARRAY:C911($arr3Chars; "AUT")
APPEND TO ARRAY:C911($arr3Chars; "AZE")

APPEND TO ARRAY:C911($arr3Chars; "BHS")
APPEND TO ARRAY:C911($arr3Chars; "BHR")
APPEND TO ARRAY:C911($arr3Chars; "BGD")
APPEND TO ARRAY:C911($arr3Chars; "BRB")
APPEND TO ARRAY:C911($arr3Chars; "BLR")
APPEND TO ARRAY:C911($arr3Chars; "BEL")
APPEND TO ARRAY:C911($arr3Chars; "BLZ")
APPEND TO ARRAY:C911($arr3Chars; "BEN")
APPEND TO ARRAY:C911($arr3Chars; "BMU")
APPEND TO ARRAY:C911($arr3Chars; "BTN")
APPEND TO ARRAY:C911($arr3Chars; "BOL")
APPEND TO ARRAY:C911($arr3Chars; "BIH")
APPEND TO ARRAY:C911($arr3Chars; "BWA")
APPEND TO ARRAY:C911($arr3Chars; "BVT")
APPEND TO ARRAY:C911($arr3Chars; "BRA")
APPEND TO ARRAY:C911($arr3Chars; "VGB")
APPEND TO ARRAY:C911($arr3Chars; "IOT")
APPEND TO ARRAY:C911($arr3Chars; "BRN")
APPEND TO ARRAY:C911($arr3Chars; "BGR")
APPEND TO ARRAY:C911($arr3Chars; "BFA")
APPEND TO ARRAY:C911($arr3Chars; "BDI")

APPEND TO ARRAY:C911($arr3Chars; "KHM")
APPEND TO ARRAY:C911($arr3Chars; "CMR")
APPEND TO ARRAY:C911($arr3Chars; "CAN")
APPEND TO ARRAY:C911($arr3Chars; "CPV")
APPEND TO ARRAY:C911($arr3Chars; "CYM")
APPEND TO ARRAY:C911($arr3Chars; "CAF")
APPEND TO ARRAY:C911($arr3Chars; "TCD")
APPEND TO ARRAY:C911($arr3Chars; "CHL")
APPEND TO ARRAY:C911($arr3Chars; "CHN")
APPEND TO ARRAY:C911($arr3Chars; "HKG")
APPEND TO ARRAY:C911($arr3Chars; "MAC")
APPEND TO ARRAY:C911($arr3Chars; "CXR")
APPEND TO ARRAY:C911($arr3Chars; "CCK")
APPEND TO ARRAY:C911($arr3Chars; "COL")
APPEND TO ARRAY:C911($arr3Chars; "COM")
APPEND TO ARRAY:C911($arr3Chars; "COG")
APPEND TO ARRAY:C911($arr3Chars; "COD")
APPEND TO ARRAY:C911($arr3Chars; "COK")
APPEND TO ARRAY:C911($arr3Chars; "CRI")
APPEND TO ARRAY:C911($arr3Chars; "CIV")
APPEND TO ARRAY:C911($arr3Chars; "HRV")
APPEND TO ARRAY:C911($arr3Chars; "CUB")
APPEND TO ARRAY:C911($arr3Chars; "CYP")
APPEND TO ARRAY:C911($arr3Chars; "CZE")

APPEND TO ARRAY:C911($arr3Chars; "DNK")
APPEND TO ARRAY:C911($arr3Chars; "DJI")
APPEND TO ARRAY:C911($arr3Chars; "DMA")
APPEND TO ARRAY:C911($arr3Chars; "DOM")

APPEND TO ARRAY:C911($arr3Chars; "ECU")
APPEND TO ARRAY:C911($arr3Chars; "EGY")
APPEND TO ARRAY:C911($arr3Chars; "SLV")
APPEND TO ARRAY:C911($arr3Chars; "GNQ")
APPEND TO ARRAY:C911($arr3Chars; "ERI")
APPEND TO ARRAY:C911($arr3Chars; "EST")
APPEND TO ARRAY:C911($arr3Chars; "ETH")

APPEND TO ARRAY:C911($arr3Chars; "FLK")
APPEND TO ARRAY:C911($arr3Chars; "FRO")
APPEND TO ARRAY:C911($arr3Chars; "FJI")
APPEND TO ARRAY:C911($arr3Chars; "FIN")
APPEND TO ARRAY:C911($arr3Chars; "FRA")
APPEND TO ARRAY:C911($arr3Chars; "GUF")
APPEND TO ARRAY:C911($arr3Chars; "PYF")
APPEND TO ARRAY:C911($arr3Chars; "ATF")

APPEND TO ARRAY:C911($arr3Chars; "GAB")
APPEND TO ARRAY:C911($arr3Chars; "GMB")
APPEND TO ARRAY:C911($arr3Chars; "GEO")
APPEND TO ARRAY:C911($arr3Chars; "DEU")
APPEND TO ARRAY:C911($arr3Chars; "GHA")
APPEND TO ARRAY:C911($arr3Chars; "GIB")
APPEND TO ARRAY:C911($arr3Chars; "GRC")
APPEND TO ARRAY:C911($arr3Chars; "GRL")
APPEND TO ARRAY:C911($arr3Chars; "GRD")
APPEND TO ARRAY:C911($arr3Chars; "GLP")
APPEND TO ARRAY:C911($arr3Chars; "GUM")
APPEND TO ARRAY:C911($arr3Chars; "GTM")
APPEND TO ARRAY:C911($arr3Chars; "GGY")
APPEND TO ARRAY:C911($arr3Chars; "GIN")
APPEND TO ARRAY:C911($arr3Chars; "GNB")
APPEND TO ARRAY:C911($arr3Chars; "GUY")

APPEND TO ARRAY:C911($arr3Chars; "HTI")
APPEND TO ARRAY:C911($arr3Chars; "HMD")
APPEND TO ARRAY:C911($arr3Chars; "VAT")
APPEND TO ARRAY:C911($arr3Chars; "HND")
APPEND TO ARRAY:C911($arr3Chars; "HUN")
APPEND TO ARRAY:C911($arr3Chars; "ISL")

APPEND TO ARRAY:C911($arr3Chars; "IND")
APPEND TO ARRAY:C911($arr3Chars; "IDN")
APPEND TO ARRAY:C911($arr3Chars; "IRN")
APPEND TO ARRAY:C911($arr3Chars; "IRQ")
APPEND TO ARRAY:C911($arr3Chars; "IRL")
APPEND TO ARRAY:C911($arr3Chars; "IMN")
APPEND TO ARRAY:C911($arr3Chars; "ISR")
APPEND TO ARRAY:C911($arr3Chars; "ITA")

APPEND TO ARRAY:C911($arr3Chars; "JAM")
APPEND TO ARRAY:C911($arr3Chars; "JPN")
APPEND TO ARRAY:C911($arr3Chars; "JEY")
APPEND TO ARRAY:C911($arr3Chars; "JOR")

APPEND TO ARRAY:C911($arr3Chars; "KAZ")
APPEND TO ARRAY:C911($arr3Chars; "KEN")
APPEND TO ARRAY:C911($arr3Chars; "KIR")
APPEND TO ARRAY:C911($arr3Chars; "PRK")
APPEND TO ARRAY:C911($arr3Chars; "KOR")
APPEND TO ARRAY:C911($arr3Chars; "KWT")
APPEND TO ARRAY:C911($arr3Chars; "KGZ")

APPEND TO ARRAY:C911($arr3Chars; "LAO")
APPEND TO ARRAY:C911($arr3Chars; "LVA")
APPEND TO ARRAY:C911($arr3Chars; "LBN")
APPEND TO ARRAY:C911($arr3Chars; "LSO")
APPEND TO ARRAY:C911($arr3Chars; "LBR")
APPEND TO ARRAY:C911($arr3Chars; "LBY")
APPEND TO ARRAY:C911($arr3Chars; "LIE")
APPEND TO ARRAY:C911($arr3Chars; "LTU")
APPEND TO ARRAY:C911($arr3Chars; "LUX")

APPEND TO ARRAY:C911($arr3Chars; "MKD")
APPEND TO ARRAY:C911($arr3Chars; "MDG")
APPEND TO ARRAY:C911($arr3Chars; "MWI")
APPEND TO ARRAY:C911($arr3Chars; "MYS")
APPEND TO ARRAY:C911($arr3Chars; "MDV")
APPEND TO ARRAY:C911($arr3Chars; "MLI")
APPEND TO ARRAY:C911($arr3Chars; "MLT")
APPEND TO ARRAY:C911($arr3Chars; "MHL")
APPEND TO ARRAY:C911($arr3Chars; "MTQ")
APPEND TO ARRAY:C911($arr3Chars; "MRT")
APPEND TO ARRAY:C911($arr3Chars; "MUS")
APPEND TO ARRAY:C911($arr3Chars; "MYT")
APPEND TO ARRAY:C911($arr3Chars; "MEX")
APPEND TO ARRAY:C911($arr3Chars; "FSM")
APPEND TO ARRAY:C911($arr3Chars; "MDA")
APPEND TO ARRAY:C911($arr3Chars; "MCO")
APPEND TO ARRAY:C911($arr3Chars; "MNG")
APPEND TO ARRAY:C911($arr3Chars; "MNE")
APPEND TO ARRAY:C911($arr3Chars; "MSR")
APPEND TO ARRAY:C911($arr3Chars; "MAR")
APPEND TO ARRAY:C911($arr3Chars; "MOZ")
APPEND TO ARRAY:C911($arr3Chars; "MMR")

APPEND TO ARRAY:C911($arr3Chars; "NAM")
APPEND TO ARRAY:C911($arr3Chars; "NRU")
APPEND TO ARRAY:C911($arr3Chars; "NPL")
APPEND TO ARRAY:C911($arr3Chars; "NLD")
APPEND TO ARRAY:C911($arr3Chars; "ANT")
APPEND TO ARRAY:C911($arr3Chars; "NCL")
APPEND TO ARRAY:C911($arr3Chars; "NZL")
APPEND TO ARRAY:C911($arr3Chars; "NIC")
APPEND TO ARRAY:C911($arr3Chars; "NER")
APPEND TO ARRAY:C911($arr3Chars; "NGA")
APPEND TO ARRAY:C911($arr3Chars; "NIU")
APPEND TO ARRAY:C911($arr3Chars; "NFK")
APPEND TO ARRAY:C911($arr3Chars; "MNP")
APPEND TO ARRAY:C911($arr3Chars; "NOR")

APPEND TO ARRAY:C911($arr3Chars; "OMN")

APPEND TO ARRAY:C911($arr3Chars; "PAK")
APPEND TO ARRAY:C911($arr3Chars; "PLW")
APPEND TO ARRAY:C911($arr3Chars; "PSE")
APPEND TO ARRAY:C911($arr3Chars; "PAN")
APPEND TO ARRAY:C911($arr3Chars; "PNG")
APPEND TO ARRAY:C911($arr3Chars; "PRY")
APPEND TO ARRAY:C911($arr3Chars; "PER")
APPEND TO ARRAY:C911($arr3Chars; "PHL")
APPEND TO ARRAY:C911($arr3Chars; "PCN")
APPEND TO ARRAY:C911($arr3Chars; "POL")
APPEND TO ARRAY:C911($arr3Chars; "PRT")
APPEND TO ARRAY:C911($arr3Chars; "PRI")

APPEND TO ARRAY:C911($arr3Chars; "QAT")

APPEND TO ARRAY:C911($arr3Chars; "REU")
APPEND TO ARRAY:C911($arr3Chars; "ROU")
APPEND TO ARRAY:C911($arr3Chars; "RUS")
APPEND TO ARRAY:C911($arr3Chars; "RWA")

APPEND TO ARRAY:C911($arr3Chars; "BLM")
APPEND TO ARRAY:C911($arr3Chars; "SHN")
APPEND TO ARRAY:C911($arr3Chars; "KNA")
APPEND TO ARRAY:C911($arr3Chars; "LCA")
APPEND TO ARRAY:C911($arr3Chars; "MAF")
APPEND TO ARRAY:C911($arr3Chars; "SPM")
APPEND TO ARRAY:C911($arr3Chars; "VCT")
APPEND TO ARRAY:C911($arr3Chars; "WSM")
APPEND TO ARRAY:C911($arr3Chars; "SMR")
APPEND TO ARRAY:C911($arr3Chars; "STP")
APPEND TO ARRAY:C911($arr3Chars; "SAU")
APPEND TO ARRAY:C911($arr3Chars; "SEN")
APPEND TO ARRAY:C911($arr3Chars; "SRB")
APPEND TO ARRAY:C911($arr3Chars; "SYC")
APPEND TO ARRAY:C911($arr3Chars; "SLE")
APPEND TO ARRAY:C911($arr3Chars; "SGP")
APPEND TO ARRAY:C911($arr3Chars; "SVK")
APPEND TO ARRAY:C911($arr3Chars; "SVN")
APPEND TO ARRAY:C911($arr3Chars; "SLB")
APPEND TO ARRAY:C911($arr3Chars; "SOM")
APPEND TO ARRAY:C911($arr3Chars; "ZAF")
APPEND TO ARRAY:C911($arr3Chars; "SGS")
APPEND TO ARRAY:C911($arr3Chars; "SSD")
APPEND TO ARRAY:C911($arr3Chars; "ESP")
APPEND TO ARRAY:C911($arr3Chars; "LKA")
APPEND TO ARRAY:C911($arr3Chars; "SDN")
APPEND TO ARRAY:C911($arr3Chars; "SUR")
APPEND TO ARRAY:C911($arr3Chars; "SJM")
APPEND TO ARRAY:C911($arr3Chars; "SWZ")
APPEND TO ARRAY:C911($arr3Chars; "SWE")
APPEND TO ARRAY:C911($arr3Chars; "CHE")
APPEND TO ARRAY:C911($arr3Chars; "SYR")

APPEND TO ARRAY:C911($arr3Chars; "TWN")
APPEND TO ARRAY:C911($arr3Chars; "TJK")
APPEND TO ARRAY:C911($arr3Chars; "TZA")
APPEND TO ARRAY:C911($arr3Chars; "THA")
APPEND TO ARRAY:C911($arr3Chars; "TLS")
APPEND TO ARRAY:C911($arr3Chars; "TGO")
APPEND TO ARRAY:C911($arr3Chars; "TKL")
APPEND TO ARRAY:C911($arr3Chars; "TON")
APPEND TO ARRAY:C911($arr3Chars; "TTO")
APPEND TO ARRAY:C911($arr3Chars; "TUN")
APPEND TO ARRAY:C911($arr3Chars; "TUR")
APPEND TO ARRAY:C911($arr3Chars; "TKM")
APPEND TO ARRAY:C911($arr3Chars; "TCA")
APPEND TO ARRAY:C911($arr3Chars; "TUV")

APPEND TO ARRAY:C911($arr3Chars; "UGA")
APPEND TO ARRAY:C911($arr3Chars; "UKR")
APPEND TO ARRAY:C911($arr3Chars; "ARE")
APPEND TO ARRAY:C911($arr3Chars; "GBR")
APPEND TO ARRAY:C911($arr3Chars; "USA")
APPEND TO ARRAY:C911($arr3Chars; "UMI")
APPEND TO ARRAY:C911($arr3Chars; "URY")
APPEND TO ARRAY:C911($arr3Chars; "UZB")

APPEND TO ARRAY:C911($arr3Chars; "VUT")
APPEND TO ARRAY:C911($arr3Chars; "VEN")
APPEND TO ARRAY:C911($arr3Chars; "VNM")
APPEND TO ARRAY:C911($arr3Chars; "VIR")

APPEND TO ARRAY:C911($arr3Chars; "WLF")
APPEND TO ARRAY:C911($arr3Chars; "ESH")

APPEND TO ARRAY:C911($arr3Chars; "YEM")
APPEND TO ARRAY:C911($arr3Chars; "ZMB")
APPEND TO ARRAY:C911($arr3Chars; "ZWE")

$found:=Find in array:C230($arr3Chars; $code3A)
If ($found>0)
	$code2A:=$arr2Chars{$found}
End if 

$0:=$code2A