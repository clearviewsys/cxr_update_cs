var $es; $success : Object
var $n : Integer
var $metaData : Object

If (getKeyValue("CAB.TestMode")="true")
	// getTransactionStats
	//initStorageObject
	$es:=ds:C1482.Registers.query("CustomerID = :1"; [Customers:3]CustomerID:1)
	
	var $e : cs:C1710.RegistersEntity
	
	//If ($n>0)
	//For ($i; 1; $n)
	$e:=$es.first()
	
	$metaData:=New object:C1471
	$metaData.destinationCountry:="IR"
	$metaData.sourceOfFund:="SOF"
	$metaData.purposeOfTransaction:="POT"
	$metaData.typeOfTransaction:="TOT"
	
	$e.metaData:=$metaData
	$e.BranchID:="BB"
	$success:=$e.save()  //end for
	
	$e:=$e.next()
	
	$metaData:=New object:C1471
	$metaData.destinationCountry:="NK"
	$metaData.sourceOfFund:="Sales of Real Estate Property"
	$metaData.purposeOfTransaction:="Charitable Donation"
	$metaData.typeOfTransaction:="EFT"
	
	$e.metaData:=$metaData
	$e.BranchID:="BO"
	$success:=$e.save()
	
	$e:=$e.next()
	
	$metaData:=New object:C1471
	$metaData.destinationCountry:="RS"
	$metaData.sourceOfFund:="Bank Loan"
	$metaData.purposeOfTransaction:="Family Support"
	$metaData.typeOfTransaction:="Cash"
	
	$e.metaData:=$metaData
	$e.BranchID:="BO"
	$success:=$e.save()
	//If ($n>1)
	////If ($n>0)
	////For ($i; 1; $n)
	//$es[1].metaData:=New object()
	//$es[1].metaData.destinationCountry:="NK"
	//$es[1].metaData.purposeOfTransactions:="POT2"
	//$es[1].metaData.sourceOfFunds:="SOF2"
	//$success:=$es[0].save()  //end for
	//End if 
End if 