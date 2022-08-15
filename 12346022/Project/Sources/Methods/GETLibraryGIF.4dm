//%attributes = {"publishedWeb":true}
// GETLibraryGIF (libraryPictureName)

// this method must be called from a URL 

// <IMG SRC="4DACTION/GETLibraryGIF/USD">


C_TEXT:C284($1)
C_PICTURE:C286($pict)
C_BLOB:C604($blob)

loadPictureResource(Substring:C12($1; 2; 99); ->$pict)
//GET PICTURE FROM LIBRARY(Substring($1; 2; 99); $pict)
//_O_PICTURE TO GIF($pict;$blob)
PICTURE TO BLOB:C692($pict; $blob; ".gif")
WEB SEND BLOB:C654($blob; "image/gif")

