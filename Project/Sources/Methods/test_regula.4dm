//%attributes = {}

// MARK: Image + Variables
var $image : Picture
var $file : 4D:C1709.File
var $folder : 4D:C1709.Folder
$folder:=Folder:C1567(Get 4D folder:C485(Current resources folder:K5:16); fk platform path:K87:2)
$file:=File:C1566($folder.path+"Images/library/sample_id.jpg")
READ PICTURE FILE:C678($file.platformPath; $image; *)


var $lastName; $firstName; $nationality : Text
var $dob : Date
// MARK: General verison
var $reader : cs:C1710.DocReader
$reader:=createDocReader
$reader.addImage($image)
$reader.processData()
$firstName:=$reader.getFirstName()
$lastName:=$reader.getLastName()
$dob:=$reader.getDOB()

// MARK: Regula Version
var $reader1 : cs:C1710.RegulaDocReader
$reader1:=cs:C1710.RegulaDocReader.new().addImage($image).processData()
$lastName:=$reader1.getText(regula_FamilyName)
$firstName:=$reader1.getText(regula_GivenName)
$nationality:=$reader1.getText(regula_NationalityCode)