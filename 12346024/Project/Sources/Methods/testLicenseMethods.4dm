//%attributes = {"shared":true}
// __UNIT_TEST
// author @blake
// converted @waikin

START TRANSACTION:C239

C_OBJECT:C1216($test; $forumla)
C_TEXT:C284($should)
$test:=AJ_UnitTest.new("License Methods"; Current method name:C684)

$should:="return license value"
AJ_assert($test; setLicenseValue("Test1"; "Test1"); "Test1"; \
"Create a license"; $should)\
  //ASSERT(setLicenseValue("Test1";"Test1")="Test1")
AJ_assert($test; getLicenseValue("Test1"); "Test1"; \
"Gets a license"; $should)\
  //ASSERT(getLicenseValue("Test1")="Test1")
AJ_assert($test; setLicenseValue("Test1"; "Test2"); "Test2"; \
"Change a license value"; $should)\
  //ASSERT(setLicenseValue("Test1";"Test2")="Test2")
AJ_assert($test; getLicenseValue("Test1"); "Test2"; \
"Get edit license value."; $should)\
  //ASSERT(getLicenseValue("Test1")="Test2")
//Check the method works when a license is not found
AJ_assert($test; getLicenseValue("vnaeobavevosnaceonvrkn"); ""; \
"Get nonexistance license value."; $should)\
  //ASSERT(getLicenseValue("vnaeobavevosnaceonvrkn")="")


$should:="return true for success"
AJ_assert($test; setLicenseExpiry("Test1"; Date:C102("07/27/20")); True:C214; \
"Set license expire date"; $should)\
  //ASSERT(setLicenseExpiry("Test1";Date("07/27/20"))=True)
$should:="return date"
AJ_assert($test; Date:C102(getLicenseExpiry("Test1")); Date:C102("07/27/20"); \
"Get license expire date"; $should)\
  //ASSERT(Date(getLicenseExpiry("Test1"))=Date("07/27/20"))
$should:="return false for failure."
AJ_assert($test; setLicenseExpiry("vnaeobavevosnaceonvrkn"; Date:C102("07/27/20")); False:C215; \
"Set an expire date from a nonexisting license"; $should)\
  //ASSERT(setLicenseExpiry("vnaeobavevosnaceonvrkn";Date("07/27/20"))=False)
$should:="Return date !00-00-00!"
AJ_assert($test; Date:C102(getLicenseExpiry("vnaeobavevosnaceonvrkn")); Date:C102("00/00/00"); \
"Get an expire date from a nonexisting license"; $should)\
  //ASSERT(Date(getLicenseExpiry("vnaeobavevosnaceonvrkn"))=Date("00/00/00"))
$should:="return password"
AJ_assert($test; setLicensePassword("Test1"; "TestPassword"); "TestPassword"; \
"Get a license password"; $should)\
  //ASSERT(setLicensePassword("Test1";"TestPassword")="TestPassword")
AJ_assert($test; getLicensePassword("Test1"); "TestPassword"; \
"Get a license password."; $should)\
  //ASSERT(getLicensePassword("Test1")="TestPassword")
AJ_assert($test; setLicensePassword("vnaeobavevosnaceonvrkn"; "TestPassword"); ""; \
"Get a license password."; $should)\
  // ASSERT(setLicensePassword("vnaeobavevosnaceonvrkn";"TestPassword")="")
AJ_assert($test; getLicensePassword("vnaeobavevosnaceonvrkn"); ""; \
"Get a nonexisting license password."; $should)\
  // ASSERT(getLicensePassword("vnaeobavevosnaceonvrkn")="")

$should:="return license max value"
AJ_assert($test; setLicenseMaxMonthly("Test1"; 12); 12; \
"Set a monthly max to a license"; $should)\
  //ASSERT(setLicenseMaxMonthly("Test1";12)=12)
AJ_assert($test; setLicenseMaxTotal("Test1"; 24); 24; \
"Set a total max to a license"; $should)\
  // ASSERT(setLicenseMaxTotal("Test1";24)=24)
AJ_assert($test; getLicenseMaxMonthly("Test1"); 12; \
"get a license monthly max"; $should)\
  // ASSERT(getLicenseMaxMonthly("Test1")=12)
AJ_assert($test; setLicenseMaxMonthly("vnaeobavevosnaceonvrkn"; 12); 0; \
"Set a nonexisting license monthly max"; $should)\
  //ASSERT(setLicenseMaxMonthly("vnaeobavevosnaceonvrkn";12)=0)
AJ_assert($test; getLicenseMaxMonthly("vnaeobavevosnaceonvrkn"); 0; \
"Set a nonexisting license monthly max"; $should)\
  // ASSERT(getLicenseMaxMonthly("vnaeobavevosnaceonvrkn")=0)
AJ_assert($test; setLicenseMaxMonthly("Test1"; 12); 12; \
"Set a license monthly max"; $should)\
  // ASSERT(setLicenseMaxMonthly("Test1";12)=12)

$should:="number of hits"
AJ_assert($test; incrementLicenseMonthlyHits("Test1"; 6; True:C214); 6; \
"increment license hit to 6"; $should)\
  //ASSERT(incrementLicenseMonthlyHits("Test1";6;True)=6)
AJ_assert($test; incrementLicenseMonthlyHits("Test1"; 15; True:C214); 15; \
"increment license hit to 15"; $should)\
  // ASSERT(incrementLicenseMonthlyHits("Test1";15;True)=15)
AJ_assert($test; incrementLicenseMonthlyHits("Test1"); 16; \
"increment license hit by 1"; $should)\
  // ASSERT(incrementLicenseMonthlyHits("Test1";15;True)=16)
AJ_assert($test; incrementLicenseMonthlyHits("Test1"; 12); 28; \
"increment license hit by 12"; $should)\
  // ASSERT(incrementLicenseMonthlyHits("Test1";12)=28)


AJ_assert($test; incrementLicenseTotalHits("Test1"; 3; True:C214); 3; \
"increment license hit to 3"; $should)\
  // ASSERT(incrementLicenseTotalHits("Test1";12;True)=12)
AJ_assert($test; incrementLicenseTotalHits("Test1"; 12; True:C214); 12; \
"increment license hit to 12"; $should)\
  // ASSERT(incrementLicenseTotalHits("Test1";12;True)=12)
AJ_assert($test; incrementLicenseTotalHits("Test1"); 13; \
"increment license hit by 1"; $should)\
  // ASSERT(incrementLicenseTotalHits("Test1")=13)
AJ_assert($test; incrementLicenseTotalHits("Test1"; 7); 20; \
"increment license hit by 7"; $should)\
  // ASSERT(incrementLicenseTotalHits("Test1";7)=20)

$should:="is expired?"
AJ_assert($test; isLicenseRecordExpired("Test1"); True:C214; \
"check license expired date set to 07/27/20"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=True)
setLicenseExpiry("Test1"; Add to date:C393(Current date:C33; 0; 0; 1))
incrementLicenseMonthlyHits("Test1"; 0; True:C214)
incrementLicenseTotalHits("Test1"; 0; True:C214)
AJ_assert($test; isLicenseRecordExpired("Test1"); False:C215; \
"check license expired date set to tomorrow"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=False)
setLicenseExpiry("Test1"; Current date:C33)
AJ_assert($test; isLicenseRecordExpired("Test1"); False:C215; \
"check license expired date set to today"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=True)
setLicenseExpiry("Test1"; Add to date:C393(Current date:C33; 0; 0; -1))
AJ_assert($test; isLicenseRecordExpired("Test1"); True:C214; \
"check license expired to yesterday"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=True)
// hits check
setLicenseExpiry("Test1"; Add to date:C393(Current date:C33; 0; 0; 1))
incrementLicenseMonthlyHits("Test1"; 30; True:C214)
AJ_assert($test; isLicenseRecordExpired("Test1"); True:C214; \
"check license monthly count at 30"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=True)
incrementLicenseMonthlyHits("Test1"; 0; True:C214)
incrementLicenseTotalHits("Test1"; 45; True:C214)
AJ_assert($test; isLicenseRecordExpired("Test1"); True:C214; \
"check license total count at 45"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=True)
incrementLicenseTotalHits("Test1"; 0; True:C214)

AJ_assert($test; isLicenseRecordExpired("Test1"); False:C215; \
"check license total hit to 0"; $should)\
  // ASSERT(isLicenseRecordExpired("Test1")=False)

//READ WRITE([Licenses])
//QUERY([Licenses];[Licenses]LicenseID="Test1")
//If (Records in selection([Licenses])=1)
//LOAD RECORD([Licenses])
//DELETE RECORD([Licenses])
//End if 
//UNLOAD RECORD([Licenses])
//READ ONLY([Licenses])

//ALERT("Done")
CANCEL TRANSACTION:C241
