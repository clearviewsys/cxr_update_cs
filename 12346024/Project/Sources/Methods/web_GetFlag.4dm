//%attributes = {"publishedWeb":true}
// GETLibraryGIF (libraryPictureName)

// this method must be called from a URL 

// <IMG SRC="4DACTION/GETLibraryGIF/USD">


C_TEXT:C284($1; $code)
C_PICTURE:C286($pict)
C_BLOB:C604($blob)
//GET PICTURE FROM LIBRARY("flag_CAD";$pict)

$code:=Substring:C12($1; 2)
QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=$code)

$pict:=[Flags:19]flag:4
//_O_PICTURE TO GIF($pict;$blob)
PICTURE TO BLOB:C692($pict; $blob; ".gif")
WEB SEND BLOB:C654($blob; "image/gif")

