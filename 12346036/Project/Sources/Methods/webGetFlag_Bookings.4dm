//%attributes = {"shared":true}
//formats image for paramquery grid cell

C_OBJECT:C1216($1)

C_TEXT:C284($0; $currOnErr)

C_PICTURE:C286($picture)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$picture:=ds:C1482.Flags.query("CurrencyCode == :1"; $1.Currency).first().flag

//QUERY([Flags];[Flags]CurrencyCode=[Bookings]Currency)

$0:="<content type=\"html\"><img src=\"data:image/jpg;base64, "+WAPI_pict2Base64(->$picture; 50)+"\"></content>"

ON ERR CALL:C155($currOnErr)