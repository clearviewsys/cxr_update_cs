//%attributes = {}
/** Get KYC2020 Record details, via either 
1 form the object saved into the database; or if not found
2 from KYC2020 Server

#param $listParam
       the list with all the record details
#param $detailIdParam
       the id to search
#param $callServerParam
       call the sever if not found?
#param $logId
       the place to save the record detail for later review
#author @wai-kin
*/
#DECLARE($listParam : Object; $detailIdParam : Text; \
$callServerParam : Boolean; $logId : Object)->$result : Object
var $list : Object
var $detailId : Text
var $callServer : Boolean
var $logId : Object

Case of 
	: (Count parameters:C259=2)
		$list:=$listParam
		$detailId:=$detailIdParam
	: (Count parameters:C259=3)
		$list:=$listParam
		$detailId:=$detailIdParam
		$callServer:=$callServerParam
	: (Count parameters:C259=4)
		$list:=$listParam
		$detailId:=$detailIdParam
		$callServer:=$callServerParam
		$logId:=$logId
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: (OB Is defined:C1231($list; $detailId))
		$result:=$list[$detailId]
	: ($callServer & Not:C34(isLicenseRecordExpired("KYC2020")))
		var $content; $response : Object
		var $status : Integer
		var $url : Text
		$url:="https://pdbapi.kyc2020.com:8088/KYC2020/RecordDetails"
		$content:=New object:C1471
		$content.Email:=getLicenseValue("KYC2020")
		$content.APIKey:=getLicensePassword("KYC2020")
		$content.SearchReferenceID:=$detailId
		$response:=New object:C1471
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)
		$list[$detailId]:=$response
		
		If ($logId#Null:C1517)
			var $log : cs:C1710.SanctionCheckLog
			$log:=ds:C1482.SanctionCheckLog.query("UUID = :1"; $logId).first()
			$log.ResponseJSON.details[$detailId]:=$response
			$log.save()
		End if 
		$result:=$response
	Else 
		$result:=Null:C1517
End case 