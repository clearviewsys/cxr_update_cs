
C_OBJECT:C1216($es; $rec)
C_TIME:C306($ref)
C_TEXT:C284($data; $currOnErr)


$ref:=Create document:C266("")

If (OK=1)
	$currOnErr:=Method called on error:C704
	ON ERR CALL:C155("errorIgnore")
	
	$es:=Create entity selection:C1512([WebEWires:149])
	$data:=""
	
	$data:=$data+"ID\tType\tStatus\tCreateDate\tCustomerName\tDOB\tCity\tCountry\tGender\tOccupation\t"
	$data:=$data+"FromCountry\tFromCCY\tToCountry\ttoCcY\tFromAmount\tToAmount\tGateway\tRelationship\t"
	$data:=$data+"Purpose\tSource\tGeoHost\tGeoCountry\tGeoRegion\tGeoCity\tUserAgent\r"
	
	For each ($rec; $es)
		If ($rec.paymentInfo.origin="ProfixWebApp")
		Else 
			$data:=$data+$rec.WebEwireID+"\t"
			If ($rec.paymentInfo.bookingType=Null:C1517)
				$data:=$data+"\t"
			Else 
				$data:=$data+$rec.paymentInfo.bookingType+"\t"
			End if 
			$data:=$data+String:C10($rec.status)+"\t"
			$data:=$data+String:C10($rec.creationDate)+"\t"
			$data:=$data+$rec.customer.FullName+"\t"
			$data:=$data+String:C10($rec.customer.DOB)+"\t"
			$data:=$data+$rec.customer.City+"\t"
			$data:=$data+$rec.customer.CountryCode+"\t"
			$data:=$data+$rec.customer.Gender+"\t"
			If ($rec.fromParty[Info_Occupation]=Null:C1517)
				$data:=$data+"\t"
			Else 
				$data:=$data+$rec.fromParty[Info_Occupation]+"\t"
			End if 
			$data:=$data+$rec.fromCountryCode+"\t"
			$data:=$data+$rec.fromCCY+"\t"
			$data:=$data+$rec.toCountryCode+"\t"
			$data:=$data+$rec.toCCY+"\t"
			$data:=$data+String:C10($rec.fromAmount)+"\t"
			$data:=$data+String:C10($rec.toAmount)+"\t"
			If ($rec.paymentInfo.gateway=Null:C1517)
				$data:=$data+"\t"
			Else 
				$data:=$data+$rec.paymentInfo.gateway+"\t"
			End if 
			$data:=$data+$rec.toParty[Info_Relationship]+"\t"
			$data:=$data+$rec.AML_Info[AML_purposeOfTransaction]+"\t"
			$data:=$data+$rec.AML_Info[AML_sourceOfFunds]+"\t"
			If ($rec.fromParty.geo=Null:C1517)
				$data:=$data+"\t\t\t\t"
			Else 
				$data:=$data+$rec.fromParty.geo.host+"\t"
				$data:=$data+$rec.fromParty.geo.country_name+"\t"
				$data:=$data+$rec.fromParty.geo.region_name+"\t"
				$data:=$data+$rec.fromParty.geo.city+"\t"
			End if 
			If ($rec.fromParty.userAgent=Null:C1517)
				$data:=$data+"\r"
			Else 
				$data:=$data+$rec.fromParty.userAgent+"\r"
			End if 
		End if 
	End for each 
	
	SEND PACKET:C103($ref; $data)
	CLOSE DOCUMENT:C267($ref)
	
	ON ERR CALL:C155($currOnErr)
End if 