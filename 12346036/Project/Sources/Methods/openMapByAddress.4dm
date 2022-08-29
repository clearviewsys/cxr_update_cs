//%attributes = {}
// openMapByAddress (address;city; state; country; zip)

C_TEXT:C284($1; $2; $3; $4; $address; $city; $state; $country; $zip; $url)
$address:=$1
$city:=$2
$state:=$3
$country:=$4
$zip:=$5

$url:="http://www.mapquest.com/maps/map.adp?country="+$country+"&countryid=US&addtohistory=&searchtype=address&cat=&address="+$address+"&city="+$city+"&state="+$state+"&zipcode="+$zip+"&search=%20%20Search%20%20&searchtab=address"
OPEN URL:C673($url; *)