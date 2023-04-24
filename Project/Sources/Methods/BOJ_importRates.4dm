//%attributes = {}
//BOJ_importRates(FilePathID)  
C_TEXT:C284($1; $tRatetoImport)
C_OBJECT:C1216($0; $status)

C_LONGINT:C283($iCounterValues; $iCounterHeader)

Case of 
	: (Count parameters:C259=1)
		$tRatetoImport:=$1  //CounterRates or BookRates
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$status:=New object:C1471
$status.success:=True:C214
$status.statusText:=$tRatetoImport

C_TEXT:C284($filePath)
$filePath:=getFilePathByID($tRatetoImport)
READ WRITE:C146([Currencies:6])
If ($filePath="")
	myAlert("File path <X> not valid"; $filePath)
	UTIL_Log(Current method name:C684; $tRatetoImport+" not imported. FilePath NOT found.")
	
	$status.success:=False:C215
	$status.statusText:="File path <X> not valid: "+$filePath
Else 
	
	C_OBJECT:C1216($params)
	OB SET:C1220($params; \
		"in"; $filePath; \
		"encoding"; "utf-8")
	
	ARRAY TEXT:C222($atvalues; 0; 0)
	CSVtoTextMatrix($params; ->$atvalues)  //put the values into array
	
	//check where is currecy column
	C_LONGINT:C283($ISOindex; $count)
	For ($count; 1; Size of array:C274($atvalues))  //loop thru the headers and assign the value
		If (($atvalues{$count}{1})="ISO")
			$ISOindex:=$count
			$count:=Size of array:C274($atvalues)
		End if 
	End for 
	
	If ($ISOindex=0)  //no header found
		$status.success:=False:C215
		$status.statusText:="NO header found"
		UTIL_Log(Current method name:C684; $tRatetoImport+" not imported. "+$status.statusText)
		myAlert($tRatetoImport+" not imported. "+$status.statusText)
	Else 
		
		
		C_OBJECT:C1216($obSuccess)
		C_TEXT:C284($alertInfoNotUpdated)
		$alertInfoNotUpdated:=""
		
		//MESSAGE("Updating "+$tRatetoImport+".......") // we shouldn't display any message as we are on the server
		
		For ($iCounterValues; 1; Size of array:C274($atvalues{1}))  //loop thru values
			C_OBJECT:C1216($obCurrencyRecord; $obCurrencyRecordDraft; $obCurrencyRecordCoin)
			If ($iCounterValues=1)  //means the header
				//skip
			Else 
				$obCurrencyRecord:=ds:C1482.Currencies.query("CurrencyCode = :1"; $atvalues{$ISOindex}{$iCounterValues}).first()  //query the currency code
				If ($obCurrencyRecord=Null:C1517)  //if no record
					//myAlert (($atvalues{$ISOindex}{$iCounterValues})+" currency is not existing in the Currencies table. The rate "+$tRatetoImport+" for this currency will not be imported.")
					$alertInfoNotUpdated:=($atvalues{$ISOindex}{$iCounterValues})+","+$alertInfoNotUpdated
					// create new
					////$obCurrencyRecord:=ds.Currencies.new()
					//End if 
				Else 
					C_REAL:C285($rDraft; $rCoin; $rCounterSell; $rMarketRate)
					C_TEXT:C284($tCurrCode; $tCurrencyName; $tCurrCodeDraft; $tCurrCodeCoin)
					$rDraft:=0
					$rCoin:=0
					$rCounterSell:=0
					$rMarketRate:=0
					If ($obCurrencyRecord.CurrencyCode#"")
						For ($iCounterHeader; 1; Size of array:C274($atvalues))  //loop thru the headers and assign the value
							Case of 
								: (($atvalues{$iCounterHeader}{1})="ISO")  //Book rates and Counter rates columns
									$tCurrCode:=$atvalues{$iCounterHeader}{$iCounterValues}
									$obCurrencyRecord.CurrencyCode:=$tCurrCode
								: (($atvalues{$iCounterHeader}{1})="Currency")  //Book rates and Counter rates columns
									$tCurrencyName:=$atvalues{$iCounterHeader}{$iCounterValues}
									$obCurrencyRecord.Name:=$tCurrencyName
								: (($atvalues{$iCounterHeader}{1})="Rate")  //Book rates columns
									$obCurrencyRecord.SpotRateLocal:=Num:C11($atvalues{$iCounterHeader}{$iCounterValues})
									$rDraft:=$obCurrencyRecord.SpotRateLocal
									$rCoin:=$obCurrencyRecord.SpotRateLocal
									$rMarketRate:=$obCurrencyRecord.SpotRateLocal
								: (($atvalues{$iCounterHeader}{1})="CounterBuyNotes")  // Counter rates columns
									$obCurrencyRecord.OurBuyRateLocal:=Num:C11($atvalues{$iCounterHeader}{$iCounterValues})
								: (($atvalues{$iCounterHeader}{1})="CounterSell")  // Counter rates columns
									$obCurrencyRecord.OurSellRateLocal:=Num:C11($atvalues{$iCounterHeader}{$iCounterValues})
									$rCounterSell:=$obCurrencyRecord.OurSellRateLocal
								: (($atvalues{$iCounterHeader}{1})="DMDTT")  // Counter rates columns //demand Items and telegraphic transfer
									$rDraft:=Num:C11($atvalues{$iCounterHeader}{$iCounterValues})
								: (($atvalues{$iCounterHeader}{1})="CounterBuyCoins")  // Counter rates columns
									$rCoin:=Num:C11($atvalues{$iCounterHeader}{$iCounterValues})
							End case 
							
							If (Size of array:C274($atvalues)=$iCounterHeader)  //end of the loop, create record for draft and coin
								$obSuccess:=$obCurrencyRecord.save()  //save the updated record
								//update record for Coin and Draft
								If ($rDraft#0) & ($obSuccess.success)
									$tCurrCodeDraft:=$tCurrCode+"-DRFT"
									$obCurrencyRecordDraft:=ds:C1482.Currencies.query("CurrencyCode = :1"; $tCurrCodeDraft).first()  //query the currency code
									If ($obCurrencyRecordDraft=Null:C1517)
										//myAlert ($tCurrCodeDraft+" currency is not existing in the Currencies table. The rate "+$tRatetoImport+" for this currency will not be imported.")
										$alertInfoNotUpdated:=$tCurrCodeDraft+","+$alertInfoNotUpdated
									Else 
										$obCurrencyRecordDraft.CurrencyCode:=$tCurrCodeDraft
										$obCurrencyRecordDraft.Name:=$tCurrencyName
										If ($tRatetoImport="BookRate@")
											$obCurrencyRecordDraft.SpotRateLocal:=$rMarketRate
										Else   //counter rate
											$obCurrencyRecordDraft.OurBuyRateLocal:=$rDraft
											$obCurrencyRecordDraft.OurSellRateLocal:=0
										End if 
										$obSuccess:=$obCurrencyRecordDraft.save()  //save the updated record
										$rDraft:=0
									End if 
									
									If ($rCoin#0) & ($obSuccess.success)
										$tCurrCodeCoin:=$tCurrCode+"-COIN"
										$obCurrencyRecordCoin:=ds:C1482.Currencies.query("CurrencyCode = :1"; $tCurrCodeCoin).first()  //query the currency code
										If ($obCurrencyRecordCoin=Null:C1517)
											//myAlert ($tCurrCodeCoin+" currency is not existing in the Currencies table. The rate "+$tRatetoImport+" for this currency will not be imported.")
											$alertInfoNotUpdated:=$tCurrCodeCoin+","+$alertInfoNotUpdated
										Else 
											$obCurrencyRecordCoin.CurrencyCode:=$tCurrCodeCoin
											$obCurrencyRecordCoin.Name:=$tCurrencyName
											If ($tRatetoImport="BookRate@")
												$obCurrencyRecordCoin.SpotRateLocal:=$rMarketRate
											Else   //counter rate
												$obCurrencyRecordCoin.OurBuyRateLocal:=$rCoin
												$obCurrencyRecordCoin.OurSellRateLocal:=$rCounterSell
											End if 
											$obSuccess:=$obCurrencyRecordCoin.save()  //save the updated record
											$rCoin:=0
										End if 
										
										If ($obSuccess.success=False:C215)
											// get out of the loop if one of the record is not save
											$iCounterValues:=Size of array:C274($atvalues{1})
										End if 
									End if 
									$rCounterSell:=0
									$rMarketRate:=0
								End if 
							End if 
						End for 
					End if 
					
				End if 
			End if 
		End for 
		
		
		If ($obSuccess.success#Null:C1517)
			If ($obSuccess.success=True:C214)
				If ($alertInfoNotUpdated#"")
					$alertInfoNotUpdated:="The following rates are not existing in the database: "+$alertInfoNotUpdated
				End if 
				myAlert($tRatetoImport+" successfully updated. "+$alertInfoNotUpdated)  // remove this code once tested
				UTIL_Log(Current method name:C684; $tRatetoImport+" successfully updated. "+$alertInfoNotUpdated)
			Else 
				UTIL_Log(Current method name:C684; $tRatetoImport+" not imported. "+$obSuccess.statusText)
				myAlert($tRatetoImport+" not imported. "+$obSuccess.statusText)
			End if 
		End if 
		
	End if 
	
End if 

$0:=$status