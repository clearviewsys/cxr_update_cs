//%attributes = {}
// populateIndustries_NAICS ({2-6})

// this will populate the Industries table with North American Industry Classification System (6 digits only)

// ([Industries];"Listbox")
C_LONGINT:C283($1; $len)
Case of 
	: (Count parameters:C259=0)
		$len:=2  // by default use the NAICS 2 digit codes 
	: (Count parameters:C259=1)
		$len:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($CodesArray; 0)
ARRAY TEXT:C222($IndustriesArray; 0)

ALL RECORDS:C47([Industries:114])
SELECTION TO ARRAY:C260([Industries:114]Code:6; $CodesArray; [Industries:114]Industry:2; $IndustriesArray)

Case of 
	: ($len=2)
		populateIndustryArrays_NAICS_2(->$CodesArray; ->$IndustriesArray)
		
	: ($len=3)
		populateIndustryArrays_NAICS_3(->$CodesArray; ->$IndustriesArray)
		
	: ($len=4)
		populateIndustryArrays_NAICS_4(->$CodesArray; ->$IndustriesArray)
		
	: ($len=5)
		populateIndustryArrays_NAICS_5(->$CodesArray; ->$IndustriesArray)
		
	: ($len=6)
		populateIndustryArrays_NAICS_6(->$CodesArray; ->$IndustriesArray)
	Else 
		ASSERT:C1129(False:C215; "Invalid parameter to fun")
End case 

ARRAY TO SELECTION:C261($CodesArray; [Industries:114]Code:6; $IndustriesArray; [Industries:114]Industry:2)
UNLOAD RECORD:C212([SanctionLists:113])

READ ONLY:C145([Industries:114])  //5/23/18 IBB added

allRecordsIndustries