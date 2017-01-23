#NoTrayIcon
#SingleInstance Force

Gui, +MinSize640x 
Gui, font, s12
Gui, Add, Picture, x0 y100, tacobell.png
Gui, Add, Text, x20 y83 +BackgroundTrans

Gui, font, s20
Gui, Add, Text, +Wrap x15 y20 w680, Quick Knowledge
Gui, font, s12
Gui, Add, Text, +Wrap x60 y55 w680, written by 
Gui, Add, Text, +Wrap x80 y75 w680, Mark Laxmeter
Gui, Add, Text, +Wrap x80 y95 w680, 



Gui, font, s15
Gui, Add, Text, +Wrap x20 y125 w400, Select from the dropdowns to copy a KB number to the clipboard for fast knowledge access

Gui, font, s13

Gui, Add, Text, x20 y200 w400, Quick Phone Numbers
Gui, Add, DropDownList, x20 y230 w475 vListPHONE gOnselect, RANT AND RAVE|POS Queue|TACO Queue|eRestaurant Queue|Learning Zone Queue

Gui, Add, Text, x20 y270 w400, Common POS Knowledge
Gui, Add, DropDownList, x20 y300 w475 vListKBPOS gOnselect, Kitchen orders not sending or bumping issues|Bind IP error or stuck on the blue QSR screen|Xpient register is running slow or locking up|Single register offline|Multiple registers offline|Register is frozen or locked up|Touch screen needs calibration or is unresponsive|Disable Biometrics via text file|Biometrics is not working|Need to bypass or disable biometrics scanner|Manually closing a drawer|POS - Stuck on EOD|

Gui, Add, Text, x20 y340 w400, Common TACO Knowledge
Gui, Add, DropDownList, x20 y370 w475 vListKBTACO gOnselect, Unable to poll the register issues|Gross sales do not equal total of register sales|Printer – Brother printer is not working decision tree|End of Day is not successful, requiring Manual Sales|Getting a black screen after logging into TACO|Non-resettable total error (error 15)|Receipt information and troubleshooting|Register sales overring or refund does not equal gross sales|Closing outside of shift|HME – Detection points and error codes|

Gui, Add, Text, x20 y410 w400, Common eR Knowledge
Gui, Add, DropDownList, x20 y440 w475 vListKBER gOnselect, Printer troubleshooting|TACO to eRestaurant conversions|New store install checklist for eRestaurant|BOH PC will not boot up|

Gui, Add, Text, x20 y480 w400, Common LZ Knowledge
Gui, Add, DropDownList, x20 y510 w475 vListKBLZ gOnselect, LZ Course and Track issues|LZ Login Issues|Getting white screen in LZ on TACO PC|LZ Reporting Issues|Restoring WiFi connection on a managed tablet|

Gui, Add, Text, x20 y620 w400, Generic Knowledge
Gui, Add, DropDownList, x20 y650 w475 vListKBGEN gOnselect, KA unavailable Knowledge Missing form submitted|Duplicate case|Store Solved|No trouble found|Case was closed in Remedy, but not in ServiceNow|Referred|"Awaiting User Info" for over 5 days|Unable to reach user|Temporary service interruption|Store Declined Assistance|


return

OnSelect:
Gui, Submit, nohide


if (ListPHONE = "RANT AND RAVE")
{
	clipboard = 1-949-304-5259
}
if (ListPHONE = "POS Queue")
{
	clipboard = 9008
}
if (ListPHONE = "TACO Queue")
{
	clipboard = 9009
}
if (ListPHONE = "eRestaurant Queue")
{
	clipboard = 949-863-4049
}
if (ListPHONE = "Learning Zone Queue")
{
	clipboard = 9011
}



if (ListKBPOS = "Kitchen orders not sending or bumping issues")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Bind IP error or stuck on the blue QSR screen")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Xpient register is running slow or locking up")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Single register offline")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Multiple registers offline")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Register is frozen or locked up")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Touch screen needs calibration or is unresponsive")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Disable Biometrics via text file")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Biometrics is not working")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Need to bypass or disable biometrics scanner")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "Manually closing a drawer")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBPOS = "POS - Stuck on EOD")
{
	clipboard = CLIPBOARDcontentsHERE
}


if (ListKBTACO = "Unable to poll the register issues")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Gross sales do not equal total of register sales")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Printer – Brother printer is not working decision tree")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "End of Day is not successful, requiring Manual Sales")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Getting a black screen after logging into TACO")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Non-resettable total error (error 15)")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Receipt information and troubleshooting")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Register sales overring or refund does not equal gross sales")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "Closing outside of shift")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBTACO = "HME – Detection points and error codes")
{
	clipboard = CLIPBOARDcontentsHERE
}


if (ListKBER = "Printer troubleshooting")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBER = "TACO to eRestaurant conversions")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBER = "New store install checklist for eRestaurant")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBER = "BOH PC will not boot up")
{
	clipboard = CLIPBOARDcontentsHERE
}


if (ListKBLZ = "LZ Course and Track issues")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBLZ = "LZ Login Issues")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBLZ = "Getting white screen in LZ on TACO PC")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBLZ = "LZ Reporting Issues")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBLZ = "Restoring WiFi connection on a managed tablet")
{
	clipboard = CLIPBOARDcontentsHERE
}
if (ListKBLZ = "PipedListItemNameHere")
{
	clipboard = CLIPBOARDcontentsHERE
}



if (ListKBGEN = "testitem")
{
	clipboard = CLIPBOARDcontentsHERE
	Gui, font, s16
	Gui, Add, Text, x20 y690 w400, SOPNAME
	Gui, font, s13
	Gui, Add, Text, x20 y720 w400, LoremIpsumissimplydummytextoftheprintingandtypesettingindustry.LoremIpsumhasbeentheindustry'sstandarddummytexteversincethe1500s,whenanunknownprintertookagalleyoftypeandscrambledittomakeatypespecimenbook.Ithassurvivednotonlyfivecenturies,butalsotheleapintoelectronictypesetting,remainingessentiallyunchanged.Itwaspopularisedinthe1960swiththereleaseofLetrasetsheetscontainingLoremIpsumpassages,andmorerecentlywithdesktoppublishingsoftwarelikeAldusPageMakerincludingversionsofLoremIpsum
	Gui, font, s20
}


return


Datum:
if A_GuiEvent=Normal
{
StringSplit, VonBis, ADat,-
FormatTime, ADat1, %VonBis1%, %F%
FormatTime, ADat2, %VonBis2%, %F%
if (ADat1=ADat2)
ADat:=%ADat1%
else
ADat:=%ADat1% - %ADat2%
return
}
SetFinalPre(){
FinalPre = ""
InputBox, FinalPre, Select Final Or Prelim, Enter 0 for Final or 1 for Preliminary:, , 200, 150 
Gui, Show
Return FinalPre
}
SetPeriod(){
Period = ""
InputBox, Period, Select Period, Please type the Period number:, , 200, 150 
Gui, Show
Return Period
}
SetWeek(){
Week = ""
InputBox, Week, Select Week, Please type the Week number:, , 200, 150 
Gui, Show
return Week
}
SetDayEnd(){
DayEnd = ""
InputBox, DayEnd, Select DayEnd, Please type the Day End number:, , 200, 150 
Gui, Show
return DayEnd
}
SetShift(){
Shift = ""
InputBox, shift, Select shift, Please type the shift number:, , 200, 150 
Gui, Show
return Shift
}

MenuFileExit:
^z::Process,Close,TacoReportsV4.exe