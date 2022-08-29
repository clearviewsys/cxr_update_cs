

C_TEXT:C284($filePathID)
$filePathID:=pickFilePathCurrencies(""; "BOJ_CounterRates")
If ($filePathID#"")
	BOJ_importRates($filePathID)
End if 
