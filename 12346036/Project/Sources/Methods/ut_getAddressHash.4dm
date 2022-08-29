//%attributes = {"shared":true}
// __UNIT_TEST
// written by @amir
// converted to AJAR by @zoya
// Dec 2020


C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("GetAddresHash"; Current method name:C684; "API.CanadaPost")

//test method for Address_GetAddressHash

C_OBJECT:C1216($addressObj)
C_OBJECT:C1216($hashObj)
$addressObj:=newAddress("CA"; ""; "Vancouver"; "V6B 3A3"; "646 Richards St."; "")
$hashObj:=getAddressHash($addressObj)
//ASSERT($hashObj.hashForProximity="47f8a9da06ab9fea3bbc1f6ef8af704d";"Expectation failed for address hash up to postal code")
AJ_assert($test; $hashObj.hashForProximity; "47f8a9da06ab9fea3bbc1f6ef8af704d"; JSON Stringify:C1217($addressObj); "Expectation failed for address hash up to postal code")
//ASSERT($hashObj.hashForExactMatch="eaee478431208e696b417cb60fc8363b";"Expectation failed for address hash up to unit number")
AJ_assert($test; $hashObj.hashForExactMatch; "eaee478431208e696b417cb60fc8363b"; JSON Stringify:C1217($addressObj); "Expectation failed for address hash up to unit number")

$addressObj:=newAddress("CA"; ""; "Vancouver"; "V6B 3A3"; "646 Richards St."; "100")
$hashObj:=getAddressHash($addressObj)
//ASSERT($hashObj.hashForProximity="47f8a9da06ab9fea3bbc1f6ef8af704d";"Expectation failed for address hash up to postal code")
AJ_assert($test; $hashObj.hashForProximity; "47f8a9da06ab9fea3bbc1f6ef8af704d"; JSON Stringify:C1217($addressObj); "Expectation failed for address hash up to postal code")
//ASSERT($hashObj.hashForExactMatch="2074ee03cac2f68b7425ea8009d67b55";"Expectation failed for address hash up to unit number")
AJ_assert($test; $hashObj.hashForExactMatch; "2074ee03cac2f68b7425ea8009d67b55"; JSON Stringify:C1217($addressObj); "Expectation failed for address hash up to unit number")
//hash should be case insensitive

$addressObj:=newAddress("CA"; ""; "VANCOUVER"; "V6B 3A3"; "646 RICHARDS ST."; "100")
$hashObj:=getAddressHash($addressObj)
//ASSERT($hashObj.hashForProximity="47f8a9da06ab9fea3bbc1f6ef8af704d";"Expectation failed for address hash up to postal code")
AJ_assert($test; $hashObj.hashForProximity; "47f8a9da06ab9fea3bbc1f6ef8af704d"; JSON Stringify:C1217($addressObj); "Expectation failed for address hash up to postal code")
//ASSERT($hashObj.hashForExactMatch="2074ee03cac2f68b7425ea8009d67b55";"Expectation failed for address hash up to unit number")
AJ_assert($test; $hashObj.hashForExactMatch; "2074ee03cac2f68b7425ea8009d67b55"; JSON Stringify:C1217($addressObj); "Expectation failed for address hash up to unit number")