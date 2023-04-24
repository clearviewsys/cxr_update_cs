//%attributes = {"shared":true}
// __UNIT_TEST
//By @Zoya Jun 2021

C_OBJECT:C1216($test)


$test:=AJ_UnitTest.new("RAL2_isLicenseValid"; Current method name:C684; "RAL2")
$dataApps:="AML_BR\rAPP.RateBoard-7290\rCX.MOB.BLA\rCXR.BE-2350\rCXR.Cloud\rCXR.POS-1120\rCXR.PRO-3140\rCXW.EmailVer\rCXW.Rate-4370\rCXW.SL.AUS\rCXW.SL.CVS\rCXW.SL.EU\rCXW.SL.FACFO.TN\rCXW.SL.FACFO.UA\rCXW.SL.NZ\rCXW.SL.OFAC\rCXW.SL.PEP\rCXW.SL.PSCA\rCXW."+"SL.RELE\rCXW.SL.SWISS\rCXW.SL.UK\rCXW.SL.UNSC"

ARRAY TEXT:C222($arr_names; 22)

C_LONGINT:C283($i)

C_TEXT:C284($dataApps)

var $line : Text

For each ($line; Split string:C1554($dataApps; "\r"))
	If ($i<Size of array:C274($arr_names))
		$arr_names{$i}:=$line
		
		AJ_assert($test; RAL2_isLicenseValid($arr_names{$i}); True:C214; $arr_names{$i}; " return True")
		$i:=$i+1
	End if 
End for each 

AJ_assert($test; RAL2_isLicenseValid("CXW.SL.OFACTTT"); False:C215; "an invalid Application ID: CXW.SL.OFACTTT"; " return False")
AJ_assert($test; RAL2_isLicenseValid("Rate"); False:C215; "an invalid Application ID: Rate"; " return False")

//@Zoya: according to Shaun the following three ones are false
AJ_assert($test; RAL2_isLicenseValid("CXW.SL.CANADA"); False:C215; "an invalid Application ID: CXW.SL.CANADA"; " return False")
AJ_assert($test; RAL2_isLicenseValid("CXW.SL.OSFI"); False:C215; "an invalid Application ID: CXW.SL.OSFI"; " return False")
AJ_assert($test; RAL2_isLicenseValid("CXW.SL.TEST"); False:C215; "an invalid Application ID: CXW.SL.TEST"; " return False")

