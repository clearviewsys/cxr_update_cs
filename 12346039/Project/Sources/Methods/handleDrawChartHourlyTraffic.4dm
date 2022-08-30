//%attributes = {}
// User (OS) : Paul Kuhn - BlueCompany
// Date  : 11/03/13, 14:52:22
// ----------------------------------------------------
// Method : Exemple_Barres2
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222($paramNames; 1)
ARRAY TEXT:C222($arrOrdinals; 24)
ARRAY REAL:C219($arrValues1; 2; 24)
ARRAY REAL:C219($arrValues2; 2; 24)


C_TEXT:C284($type; $title; $alignement; $texteSVG)
C_LONGINT:C283($NumOfBars; $i)

$alignement:="Vertical"

$NumOfBars:=1

$type:="Bar"

C_LONGINT:C283($titleFontSize; $0; $arrValues1FontSize; $LegendFontSize; $BarWidth; $SpaceBar; $TitleOffSet)

$TitleFontSize:=48
$LegendFontSize:=36

$title:="Number of Transactions in different hours of the day"


ARRAY TEXT:C222($DataGrapheName; 0)
ARRAY TEXT:C222($DataGraphe; 0)
APPEND TO ARRAY:C911($DataGrapheName; "Title")
APPEND TO ARRAY:C911($DataGraphe; $title)  // 1 - Titre du graphe

APPEND TO ARRAY:C911($DataGrapheName; "GraphOrientation")
APPEND TO ARRAY:C911($DataGraphe; $alignement)  // 2 - orientation des abcisses"

APPEND TO ARRAY:C911($DataGrapheName; "abscissaName")
APPEND TO ARRAY:C911($DataGraphe; "Hours")  // 3 - libellé des abcisses

APPEND TO ARRAY:C911($DataGrapheName; "ordinateName")
APPEND TO ARRAY:C911($DataGraphe; "No. of Transactions")  // 4 - libellé des $arrOrdinalss

APPEND TO ARRAY:C911($DataGrapheName; "ShowLegend")
APPEND TO ARRAY:C911($DataGraphe; "No")  // 5 - Affichage de la légende


APPEND TO ARRAY:C911($DataGrapheName; "ForcingScalesToZero")
APPEND TO ARRAY:C911($DataGraphe; "oui")  // 7 - Forçage du zéro des échelles

APPEND TO ARRAY:C911($DataGrapheName; "TitleFontStyle")
APPEND TO ARRAY:C911($DataGraphe; String:C10(Bold:K14:2))
APPEND TO ARRAY:C911($DataGrapheName; "TitleFontSize")
APPEND TO ARRAY:C911($DataGraphe; String:C10($titleFontSize))


APPEND TO ARRAY:C911($DataGrapheName; "BarWidth")
APPEND TO ARRAY:C911($DataGraphe; String:C10(70))

APPEND TO ARRAY:C911($DataGrapheName; "Space between bars")
APPEND TO ARRAY:C911($DataGraphe; String:C10(0))

APPEND TO ARRAY:C911($DataGrapheName; "$arrValues1format")
APPEND TO ARRAY:C911($DataGraphe; "### ### ##0")

APPEND TO ARRAY:C911($DataGrapheName; "X-LegendOrientation")  // normal - Quinconce - rotation:30
APPEND TO ARRAY:C911($DataGraphe; "rotation:0")

APPEND TO ARRAY:C911($DataGrapheName; "X-FontSize")
APPEND TO ARRAY:C911($DataGraphe; String:C10($LegendFontSize))

APPEND TO ARRAY:C911($DataGrapheName; "Y-FontSize")
APPEND TO ARRAY:C911($DataGraphe; String:C10($LegendFontSize))
//APPEND TO ARRAY($DataGrapheName;"Y-FontStyle")
//APPEND TO ARRAY($DataGraphe;String(Underline))

APPEND TO ARRAY:C911($DataGrapheName; "Ratio")
APPEND TO ARRAY:C911($DataGraphe; "40")

APPEND TO ARRAY:C911($DataGrapheName; "ShowSumOfBars")
APPEND TO ARRAY:C911($DataGraphe; "yes")

APPEND TO ARRAY:C911($DataGrapheName; "SumOfBarsDelta")
APPEND TO ARRAY:C911($DataGraphe; "0")


APPEND TO ARRAY:C911($DataGrapheName; "SumOfBarsPositiveColor")
APPEND TO ARRAY:C911($DataGraphe; "Green")
APPEND TO ARRAY:C911($DataGrapheName; "SumOfBarsNegativeColor")
APPEND TO ARRAY:C911($DataGraphe; "Red")

APPEND TO ARRAY:C911($DataGrapheName; "SumOfBarsFont")
APPEND TO ARRAY:C911($DataGraphe; "Times")
APPEND TO ARRAY:C911($DataGrapheName; "SumOfBarsFontSize")
APPEND TO ARRAY:C911($DataGraphe; "24")
APPEND TO ARRAY:C911($DataGrapheName; "SumOfBarsFontStyle")
APPEND TO ARRAY:C911($DataGraphe; String:C10(Bold:K14:2))

//Paramétrage des différentes courbes
ARRAY TEXT:C222($arrSeriesParams; $NumOfBars; 13)  //N courbes avec leur 13 paramètres
$arrSeriesParams{1}{1}:=$type  //type de courbe
$arrSeriesParams{1}{2}:="blue"  //Couleur
$arrSeriesParams{1}{3}:="1"  //Ordre de traçage
$arrSeriesParams{1}{4}:=""  //Unité
$arrSeriesParams{1}{5}:="0"  //Nbre de décimales
$arrSeriesParams{1}{6}:="triangle"  //marque sur les valeurs (Uniquement pour les courbes) non/carré/rond/triangle

$arrSeriesParams{1}{7}:="yes"  //Affichage des valeurs et position 

$arrSeriesParams{1}{8}:="24"  //Taille de police d'affichage des valeurs de la courbe
$arrSeriesParams{1}{9}:="100"  //Transparence
$arrSeriesParams{1}{10}:="0"  // pourtour des symboles
$arrSeriesParams{1}{11}:="darkblue"  // Couleur de la police des valeurs
$arrSeriesParams{1}{12}:="darkblue"  //Couleur 1 pour le dégradé
$arrSeriesParams{1}{13}:="black"  //Couleur 2 pour le dégradé

//$arrSeriesParams{2}{1}:=$type
//$arrSeriesParams{2}{2}:="purple"
//$arrSeriesParams{2}{3}:="2"
//$arrSeriesParams{2}{4}:=""
//$arrSeriesParams{2}{5}:="0"
//$arrSeriesParams{2}{6}:="Non"
//$arrSeriesParams{2}{7}:="yes"  //Affichage des valeurs et position 
//$arrSeriesParams{2}{8}:="18"
//$arrSeriesParams{2}{9}:="100"
//$arrSeriesParams{2}{10}:="0"
//$arrSeriesParams{2}{11}:="teal"
//$arrSeriesParams{2}{12}:="white"  //Couleur 1 pour le dégradé
//$arrSeriesParams{2}{13}:="red"  //Couleur 2 pour le dégradé


$paramNames{1}:="# of Trans."
//$paramNames{2}:="-"

//Génération et remplissage des données


C_DATE:C307($fromDate; $toDate)
$fromDate:=vFromDate
$toDate:=vToDate

For ($i; 0; 23)  // hours in the day
	$arrOrdinals{$i}:=String:C10($i)
	$arrValues1{1}{$i}:=getNumOfTransInAnHour($i; $fromDate; $toDate)
	//$arrValues1{2}{$i}:=0
End for 


$texteSVG:=""
//vChart:=SGR_Generate_Graph (->$DataGrapheName;->$DataGraphe;->$paramNames;->$arrOrdinals;->$arrValues1;->$arrSeriesParams;->$arrValues2;->$texteSVG)
