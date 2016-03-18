#NoTrayIcon
#SingleInstance Force


Global Period
Global Week
Global DayEnd
Global Shift
Global Adat
Global FinalPre
Gui, +MinSize640x 
Gui, font, s12
Gui, Add, Picture, x0 y100, tacobell.png
Gui, Add, Text, x20 y83 +BackgroundTrans
Gui, Add, Text, +Wrap x15 y0 w680, THIS TOOL WILL GET YOU INTO CORRECT DIRECTORY, REGENERATE REPORT AND PRINT IT WITH RIGHT CLICK written by David Enos
Gui, font, s15
Gui, Add, DropDownList, x20 y410 w475 vList1 gOnselect, REPORTS |Regenerate DPOLL|Weekly Business Summary|Daily business summary|Build-to forecast report|Variance trend report|Product transfer report|Cross reference vendor sheet|Inventory count sheet|Daily report card|Posting activity report|Period end inventory|Weekly variance report|Weekly purchase journal|Off-premise sales activity report|Daily TMU flash report| |SHIFT REPORTS |Shift performance report|Daily banking report| |SOS REPORTS |Daily tracking form|Drive-thru performance report|Drive-thru trend report|Front Counter SOS Performance Report| |SMART REPORTS |Team availability|Prep guide|In-store labor variance| |TAS REPORTS|Call-in summary report|Paycheck verification report|Allowed hours report|Employee average hours worked report|Employee break summary|Labor dollars report|Hours worked report|Out of period adjustment summary|Employee overtime hours report| |MISC COMMANDS|Mirror Check|Test Print|Database Error Check|Daily Password|Inventory Restore|General Poll|Off-Premise DB and TacoDB are not in sync|Latest TACO release|Force Sales *MUST RUN TEST POLL FIRST|Sync POS|Gift Card Check|TACO Hard Disk Size Check| |WineFix |WineFix tacodb|WineFix cmsdb|WineFix sosdb|WineFix shift| |POS|CHKDSK DFRAG|Iris Suspect|POSLIVE Suspect|Mobile Query for NRT SQL|Mobile Cashier SQL Query1|Mobile Cashier SQL Query2|POS Remote Reboot|
Gui, Add, Text, x20 y360 w400, Select a date, a Taco report and then paste into PuTTY!
Gui, Add, MonthCal,x500 y190 gDatum vAdat Multi
Gui, show, w725 h450
return



OnSelect:
Gui, Submit, nohide

if (List1 = "Regenerate DPOLL")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = for t in Sales Inventory TAS; do dppeod %date% $t debug; done; dparf -m 0; cd /usr/BOSS/dpoll/dpstage &&cd /usr/BOSS/dpoll/dpsend

}
if (List1 = "Weekly Business Summary")
{	SetPeriod()
    SetWeek()
	clipboard = cd /usr/BOSS/reports/ &&cmsrwbs x 15 %Period% %Week% &&tacolp cmsrwbs.prt
}
if (List1 = "Daily business summary")
{   
	FormatTime, date,%Adat%, MM/dd/yy
	clipboard = cd /usr/BOSS/reports/ &&cmsrdbs x %date% &&tacolp cmsrdbs.prt
}
if (List1 = "Build-to forecast report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/reports/ &&icsbpmain x %date% &&tacolp icbpmain.prt
}
if (List1 = "Variance trend report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/reports/ &&icostrnd x %date% &&tacolp icostrnd.prt
}
if (List1 = "Product transfer report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/reports/ &&icsptran x %date% &&tacolp icsptran.prt
}
if (List1 = "Cross reference vendor sheet")
{
	FormatTime, date,%Adat%, MM/dd/yy		
	clipboard = icsrbitm x %date%
}
if (List1 = "Inventory count sheet")
{	SetDayEnd()
	SetWeek()
	clipboard = cd /usr/BOSS/reports/ &&icsrclst x %DayEnd% %Week% &&tacolp icsrclst.prt
}
if (List1 = "Daily report card")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/reports/ &&icsrdrc x %date% &&tacolp icsrdrc.prt
}
if (List1 = "Posting activity report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/reports/ &&icsrlog x %date% &&tacolp icsrlog.prt
}
if (List1 = "Period end inventory")
{	SetPeriod()
	SetWeek()
	clipboard = cd /usr/BOSS/reports/ &&icsrpei x 2015 %Period% %Week% &&tacolp icsrpei.prt
}
if (List1 = "Weekly variance report")
{	
	setPeriod()
	SetWeek()
	SetFinalPre()
	clipboard = icsrwkl x 15 %Period% %Week% %FinalPre% 
}
if (List1 = "Weekly purchase journal")
{
	setPeriod()
	setWeek()
	clipboard = cd /usr/BOSS/reports/ &&icsrwpj x 15 %Period% %Week% &&tacolp icsrwpj.prt
}
if (List1 = "Off-premise sales activity report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/reports/ &&oprsar x %date% &&tacolp oprsar.prt
}
if (List1 = "Daily TMU flash report")
{
	clipboard = cd /usr/BOSS/reports/ &&tmuflash x &&tacolp tmuflash.prt
}
if (List1 = "Shift performance report")
{	SetShift()
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/shift/reports/%date% &&sftrsp x %date% %shift% &&tacolp sftrsp.ps
}
if (List1 = "Daily banking report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/shift/reports/%date% &&sftrbr x %date% on-Demand &&tacolp sftrbr.ps
}
if (List1 = "Daily tracking form")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard =  cd /usr/BOSS/sosdb/reports/ &&sosrdtf x %date% &&tacolp sosrdtf.rpt
}
if (List1 = "Drive-thru performance report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/sosdb/reports/ &&sosrdtpr x %date% &&tacolp sosrdtpr.rpt
}
if (List1 = "Drive-thru trend report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/sosdb/reports/ &&sosrdttr x %date% &&tacolp sosrdttr.rpt
}
if (List1 = "Front Counter SOS Performance Report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard =  cd /usr/BOSS/sosdb/reports/ &&sosrfcpr x %date% &&tacolp sosrfcpr.rpt
}
if (List1 = "Team availability schedule")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = smtravl %date%
}
if (List1 = "Prep guide")
{
	FormatTime, date,%Adat%, yyyyMMdd		
	clipboard = smtrptb x %date% 1
}
if (List1 = "In-store labor variance")
{
	clipboard =  smtrlbr 42
}
if (List1 = "Call-in summary report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrack x %date% S &&tacolp callsum.rpt
}
if (List1 = "Store profile information")
{
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tacoinfo x &&tacolp tacoinfo.rpt
}
if (List1 = "Paycheck verification report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrack x %date% &&tacolp tasrack.rpt
}
if (List1 = "Allowed hours report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrahrs %date% &&tacolp tasrahrs.rpt
}
if (List1 = "Employee average hours worked report")
{
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasravg x &&tasravg.rpt
}
if (List1 = "Employee break summary")
{
	FormatTime, date,%Adat%, MMddyy	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrbrk x %date% &&tacolp tasrbrk.rpt
}
if (List1 = "Labor dollars report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard =  cd /usr/BOSS/.tasdir/reports/ &&tasrdlrs x %date% &&tacolp tasrdlrs.rpt
}
if (List1 = "Employee status summary")
{
	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrempd x &&tacolp tasrempd.rpt
}
if (List1 = "Hours worked report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrhrwk x %date% &&tacolp tasrhrwk.rpt
}
if (List1 = "Out of period adjustment summary")
{
	FormatTime, date,%Adat%, MMddyy
	clipboard =  cd /usr/BOSS/.tasdir/reports/ &&tasropa x %date% &&tacolp tasropa.rpt
}
if (List1 = "Employee overtime hours report")
{
	FormatTime, date,%Adat%, MMddyy	
	clipboard =cd /usr/BOSS/.tasdir/reports/ &&tasrot x %date% &&tasrot.prt
}
if (List1 = "Mirror Check")

{
	clipboard = tail /tmp/tbmirror.log
}

if (List1 = "Test Print")
{
	clipboard = tacolp TEST
}
if (List1 = "Database Error Check")
{
	clipboard = dbcheck -a -k -s /usr/BOSS/proddb/tacodb;dbcheck -a -k -s /usr/BOSS/cmsdb/cmsdb;dbcheck -a -k -s /usr/BOSS/.tasdir/tasdb;dbcheck -a -k -s /usr/BOSS/sosdb/sosdb;dbcheck -a -k -s /usr/BOSS/shift/sftdb;
}
if (List1 = "Daily Password")
{
	clipboard = sftpconfig -p
}
if (List1 = "Inventory Restore")
{	
	FormatTime, date,%Adat%, yyyyMMdd
	clipboard = restore.sh /usr/BOSS %date% inv
}
if (List1 = "General Poll")
{
	clipboard = cd /usr/BOSS/pollecr &&sh -x PosPoll.sh GENERAL
}
if (List1 = "Off-Premise DB and TacoDB are not in sync")
{
	clipboard = sh cmssyncdb.sh
}
if (List1 = "Latest TACO release" )
{
	clipboard = cd /usr/BOSS/bin;grep TACO releases
}
if (List1 = "Force Sales")
{
	clipboard = l ecrdata* &&cp ecrdata.dat /usr/BOSS/proddb/ecrdata &&cd /usr/BOSS/proddb &&slsupos < ecrdata &&echo "FORCE" > SALES.PENDING &&auditsls
}
if (List1 = "Sync POS")
{
	clipboard = cd /usr/BOSS/pollecr &&sh -x /usr/BOSS/bin/SendEmployeeXMLFile.sh
}
if (List1 = "Gift Card Check")
{
	clipboard = icspmeth AUTO
}
if (List1 = "WineFix tacodb")
{
	clipboard = cd /tmp;mkdir tacodb;cd /usr/BOSS/proddb/;keybuild tacodb;dchain tacodb;tacosudo.sh cp *.dbd *.dbf /tmp/tacodb;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/tacodb;cd /tmp/tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/proddb/;cd /usr/BOSS/proddb/;dbcheck -s tacodb;
}
if (List1 = "TACO Hard Disk Size Check")
{
	clipboard = df -h
}
if (List1 = "WineFix cmsdb")
{
	clipboard = cd /tmp;mkdir cmsdb;cd /usr/BOSS/cmsdb/;keybuild cmsdb;dchain cmsdb;tacosudo.sh cp *.dbd *.dbf /tmp/cmsdb;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/cmsdb;cd /tmp/cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/cmsdb;cd /usr/BOSS/cmsdb;dbcheck -s cmsdb;
}
if (List1 = "WineFix sosdb")
{
	clipboard = cd /tmp;mkdir sosdb;cd /usr/BOSS/sosdb/;keybuild sosdb;dchain sosdb;tacosudo.sh cp *.dbd *.dbf /tmp/sosdb;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/sosdb;cd /tmp/sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/sosdb;cd /usr/BOSS/sosdb;dbcheck -s sosdb;
}
if (List1 = "WineFix shift")
{
	clipboard = cd /tmp;mkdir shift;cd /usr/BOSS/shift/;keybuild sftdb;dchain sftdb;tacosudo.sh cp *.dbd *.dbf /tmp/shift;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/shift;cd /tmp/shift;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/shift;cd /usr/BOSS/shift;dbcheck -s sftdb;
}
if (List1 = "CHKDSK DFRAG")
{
	clipboard = echo y|chkdsk /f & shutdown –r –t 2700 & defrag c: -f -v & shutdown -r -t 0
}

if (List1 = "Iris Suspect")
{
	clipboard = EXEC sp_resetstatus Iris; ALTER DATABASE Iris SET EMERGENCY DBCC checkdb(Iris) ALTER DATABASE Iris SET SINGLE_USER WITH ROLLBACK IMMEDIATE DBCC CheckDB (Iris, REPAIR_ALLOW_DATA_LOSS) ALTER DATABASE Iris SET MULTI_USER
}
if (List1 = "POSLIVE Suspect")
{
	clipboard = EXEC sp_resetstatus PosLive; ALTER DATABASE PosLive SET EMERGENCY DBCC checkdb(PosLive) ALTER DATABASE PosLive SET SINGLE_USER WITH ROLLBACK IMMEDIATE DBCC CheckDB (PosLive, REPAIR_ALLOW_DATA_LOSS) ALTER DATABASE PosLive SET MULTI_USER
}
if (List1 = "Mobile Query for NRT SQL")
{
	clipboard = use iris select * from tblApplicationStrings where StringID = 5411
}
if (List1 = "Mobile Cashier SQL Query1")
{
	clipboard = Select * from tblcustomemployeeinfoxref where xrefnum = 54321
}
if (List1 = "Mobile Cashier SQL Query2")
{
	clipboard = insert into tblCustomEmployeeInfoXref (XrefName,XrefNum,ExternalNum) values ('MobileEmployeeID','54321','1')
}
if (List1 = "POS Remote Reboot")
{
	clipboard = shutdown.exe -r -t 0 -m \\pos1
}


return


Datum:
if A_GuiEvent=Normal
{
StringSplit, VonBis, ADat,-
FormatTime, ADat1, %VonBis1%, %F%
FormatTime, ADat2, %VonBis2%, %F%
if (ADat1=ADat2)
ADat=%ADat1%
else
ADat=%ADat1% - %ADat2%
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