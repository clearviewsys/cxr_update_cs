//%attributes = {"publishedWeb":true}
// GETLibraryGIF (libraryPictureName)

// this method must be called from a URL 

// <IMG SRC="4DACTION/GETLibraryGIF/USD">

C_POINTER:C301($1)
C_PICTURE:C286($pict)
C_BLOB:C604($blob)
$pict:=[Currencies:6]Flag:3  // point to picture

//_O_PICTURE TO GIF($pict;$blob)
PICTURE TO BLOB:C692($pict; $blob; ".gif")
WEB SEND BLOB:C654($blob; "image/gif")

