var $reader : cs:C1710.DocReader
var $file : 4D:C1709.File

openPictureID(->[Customers:3]PictureID_Image:53)
$reader:=createDocReader.addImage([Customers:3]PictureID_Image:53)
var $process : Integer
$process:=Progress New
Progress SET TITLE($process; "Document Reader")
Progress SET MESSAGE($process; "Processing Data...")
Progress SET WINDOW VISIBLE(True:C214)
$reader.processData()
Progress QUIT($process)
Progress SET WINDOW VISIBLE(False:C215)
$reader.fillCustomerData()