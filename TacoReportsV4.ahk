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

Gui, font, s20
Gui, Add, Text, +Wrap x15 y20 w680, TACO REPORTS v4
Gui, font, s12
Gui, Add, Text, +Wrap x60 y55 w680, written by 
Gui, Add, Text, +Wrap x80 y75 w680, David Enos
Gui, Add, Text, +Wrap x80 y95 w680, Mark Laxmeter

Gui, font, s15
Gui, Add, Text, +Wrap x20 y125 w400, Select from the dropdowns to copy a command to the clipboard

Gui, font, s13

Gui, Add, Text, x20 y200 w400, TACO Commands
Gui, Add, DropDownList, x20 y230 w475 vListMISCCOMMANDS gOnselect, Mirror Check|Test Print|Database Error Check|Daily Password|Inventory Restore|General Poll|Off-Premise DB and TacoDB are not in sync|Latest TACO release|Force Sales *MUST RUN TEST POLL FIRST|Sync POS|Gift Card Check|TACO Hard Disk Size Check| |WineFix |WineFix tacodb|WineFix cmsdb|WineFix sosdb|WineFix shift|

Gui, Add, Text, x20 y270 w400, TACO Shift Reports
Gui, Add, DropDownList, x20 y300 w475 vListSHIFTREPORTS gOnselect, Shift performance report|Daily banking report|

Gui, Add, Text, x20 y340 w400, TACO SOS Reports
Gui, Add, DropDownList, x20 y370 w475 vListSOSREPORTS gOnselect, Daily tracking form|Drive-thru performance report|Drive-thru trend report|Front Counter SOS Performance Report|

Gui, Add, Text, x20 y410 w400, TACO SMART Reports
Gui, Add, DropDownList, x20 y440 w475 vListSMARTREPORTS gOnselect, Team availability|Prep guide|In-store labor variance|

Gui, Add, Text, x20 y480 w400, TACO TAS Reports
Gui, Add, DropDownList, x20 y510 w475 vListTASREPORTS gOnselect, Call-in summary report|Paycheck verification report|Allowed hours report|Employee average hours worked report|Employee break summary|Labor dollars report|Hours worked report|Out of period adjustment summary|Employee overtime hours report|

Gui, Add, Text, x20 y550 w400, Other TACO Reports
Gui, Add, DropDownList, x20 y580 w475 vListREPORTS gOnselect, Regenerate DPOLL|Weekly Business Summary|Daily business summary|Build-to forecast report|Variance trend report|Product transfer report|Cross reference vendor sheet|Inventory count sheet|Daily report card|Posting activity report|Period end inventory|Weekly variance report|Weekly purchase journal|Off-premise sales activity report|Daily TMU flash report|

Gui, Add, Text, x20 y620 w400, POS Task Manager Commands
Gui, Add, DropDownList, x20 y650 w475 vListPOScmd gOnselect, Runas|Runas CMD|Runas Explorer|CHKDSK DEFRAG|POS Remote Reboot|Remote List Tasks|Remote Kill Task|Device Manager|SQL Server Mgmt Studio|UpdateLinks|RegMerge

Gui, Add, Text, x20 y690 w400, POS SQL Commands
Gui, Add, DropDownList, x20 y720 w475 vListPOSsql gOnselect, IRIS Suspect|POSLIVE Suspect|IRIS DB Errors|POSLIVE DB Errors|Mobile Cashier SQL Query1|Mobile Cashier QSL Query2|Find Joe Manager Password|Query for Reg9 NRT|Check for POSLive Errors|Check for IRIS Errors

Gui, Add, Text, x20 y760 w400, eRestaurant Commands
Gui, Add, DropDownList, x20 y790 w475 vListER gOnselect, Password Reset Hash|Bypass HME timer for No data received error|


Gui, Add, MonthCal,x480 y20 gDatum vAdat Multi
Gui, show, w725 h850
return



OnSelect:
Gui, Submit, nohide

if (ListREPORTS = "Regenerate DPOLL")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = for t in Sales Inventory TAS; do dppeod %date% $t debug; done; dparf -m 0; cd /usr/BOSS/dpoll/dpstage &&cd /usr/BOSS/dpoll/dpsend

}
if (ListREPORTS = "Weekly Business Summary")
{	SetPeriod()
    SetWeek()
	clipboard = cd /usr/BOSS/reports/ &&cmsrwbs x 15 %Period% %Week% &&tacolp cmsrwbs.prt
}
if (ListREPORTS = "Daily business summary")
{   
	FormatTime, date,%Adat%, MM/dd/yy
	clipboard = cd /usr/BOSS/reports/ &&cmsrdbs x %date% &&tacolp cmsrdbs.prt
}
if (ListREPORTS = "Build-to forecast report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/reports/ &&icsbpmain x %date% &&tacolp icbpmain.prt
}
if (ListREPORTS = "Variance trend report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/reports/ &&icostrnd x %date% &&tacolp icostrnd.prt
}
if (ListREPORTS = "Product transfer report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/reports/ &&icsptran x %date% &&tacolp icsptran.prt
}
if (ListREPORTS = "Cross reference vendor sheet")
{
	FormatTime, date,%Adat%, MM/dd/yy		
	clipboard = icsrbitm x %date%
}
if (ListREPORTS = "Inventory count sheet")
{	SetDayEnd()
	SetWeek()
	clipboard = cd /usr/BOSS/reports/ &&icsrclst x %DayEnd% %Week% &&tacolp icsrclst.prt
}
if (ListREPORTS = "Daily report card")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/reports/ &&icsrdrc x %date% &&tacolp icsrdrc.prt
}
if (ListREPORTS = "Posting activity report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/reports/ &&icsrlog x %date% &&tacolp icsrlog.prt
}
if (ListREPORTS = "Period end inventory")
{	SetPeriod()
	SetWeek()
	clipboard = cd /usr/BOSS/reports/ &&icsrpei x 2015 %Period% %Week% &&tacolp icsrpei.prt
}
if (ListREPORTS = "Weekly variance report")
{	
	setPeriod()
	SetWeek()
	SetFinalPre()
	clipboard = icsrwkl x 15 %Period% %Week% %FinalPre% 
}
if (ListREPORTS = "Weekly purchase journal")
{
	setPeriod()
	setWeek()
	clipboard = cd /usr/BOSS/reports/ &&icsrwpj x 15 %Period% %Week% &&tacolp icsrwpj.prt
}
if (ListREPORTS = "Off-premise sales activity report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/reports/ &&oprsar x %date% &&tacolp oprsar.prt
}
if (ListREPORTS = "Daily TMU flash report")
{
	clipboard = cd /usr/BOSS/reports/ &&tmuflash x &&tacolp tmuflash.prt
}
if (ListSHIFTREPORTS = "Shift performance report")
{	SetShift()
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/shift/reports/%date% &&sftrsp x %date% %shift% &&tacolp sftrsp.ps
}
if (ListSHIFTREPORTS = "Daily banking report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/shift/reports/%date% &&sftrbr x %date% on-Demand &&tacolp sftrbr.ps
}
if (ListSOSREPORTS = "Daily tracking form")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard =  cd /usr/BOSS/sosdb/reports/ &&sosrdtf x %date% &&tacolp sosrdtf.rpt
}
if (ListSOSREPORTS = "Drive-thru performance report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/sosdb/reports/ &&sosrdtpr x %date% &&tacolp sosrdtpr.rpt
}
if (ListSOSREPORTS = "Drive-thru trend report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard = cd /usr/BOSS/sosdb/reports/ &&sosrdttr x %date% &&tacolp sosrdttr.rpt
}
if (ListSOSREPORTS = "Front Counter SOS Performance Report")
{
	FormatTime, date,%Adat%, MM/dd/yy	
	clipboard =  cd /usr/BOSS/sosdb/reports/ &&sosrfcpr x %date% &&tacolp sosrfcpr.rpt
}
if (ListSMARTREPORTS = "Team availability schedule")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = smtravl %date%
}
if (ListSMARTREPORTS = "Prep guide")
{
	FormatTime, date,%Adat%, yyyyMMdd		
	clipboard = smtrptb x %date% 1
}
if (ListSMARTREPORTS = "In-store labor variance")
{
	clipboard =  smtrlbr 42
}
if (ListTASREPORTS = "Call-in summary report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrack x %date% S &&tacolp callsum.rpt
}
if (ListTASREPORTS = "Store profile information")
{
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tacoinfo x &&tacolp tacoinfo.rpt
}
if (ListTASREPORTS = "Paycheck verification report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrack x %date% &&tacolp tasrack.rpt
}
if (ListTASREPORTS = "Allowed hours report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrahrs %date% &&tacolp tasrahrs.rpt
}
if (ListTASREPORTS = "Employee average hours worked report")
{
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasravg x &&tasravg.rpt
}
if (ListTASREPORTS = "Employee break summary")
{
	FormatTime, date,%Adat%, MMddyy	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrbrk x %date% &&tacolp tasrbrk.rpt
}
if (ListTASREPORTS = "Labor dollars report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard =  cd /usr/BOSS/.tasdir/reports/ &&tasrdlrs x %date% &&tacolp tasrdlrs.rpt
}
if (ListTASREPORTS = "Employee status summary")
{
	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrempd x &&tacolp tasrempd.rpt
}
if (ListTASREPORTS = "Hours worked report")
{
	FormatTime, date,%Adat%, yyyyMMdd	
	clipboard = cd /usr/BOSS/.tasdir/reports/ &&tasrhrwk x %date% &&tacolp tasrhrwk.rpt
}
if (ListTASREPORTS = "Out of period adjustment summary")
{
	FormatTime, date,%Adat%, MMddyy
	clipboard =  cd /usr/BOSS/.tasdir/reports/ &&tasropa x %date% &&tacolp tasropa.rpt
}
if (ListTASREPORTS = "Employee overtime hours report")
{
	FormatTime, date,%Adat%, MMddyy	
	clipboard =cd /usr/BOSS/.tasdir/reports/ &&tasrot x %date% &&tasrot.prt
}
if (ListMISCCOMMANDS = "Mirror Check")

{
	clipboard = tail /tmp/tbmirror.log
}

if (ListMISCCOMMANDS = "Test Print")
{
	clipboard = tacolp TEST
}
if (ListMISCCOMMANDS = "Database Error Check")
{
	clipboard = dbcheck -a -k -s /usr/BOSS/proddb/tacodb;dbcheck -a -k -s /usr/BOSS/cmsdb/cmsdb;dbcheck -a -k -s /usr/BOSS/.tasdir/tasdb;dbcheck -a -k -s /usr/BOSS/sosdb/sosdb;dbcheck -a -k -s /usr/BOSS/shift/sftdb;
}
if (ListMISCCOMMANDS = "Daily Password")
{
	clipboard = sftpconfig -p
}
if (ListMISCCOMMANDS = "Inventory Restore")
{	
	FormatTime, date,%Adat%, yyyyMMdd
	clipboard = restore.sh /usr/BOSS %date% inv
}
if (ListMISCCOMMANDS = "General Poll")
{
	clipboard = cd /usr/BOSS/pollecr &&sh -x PosPoll.sh GENERAL
}
if (ListMISCCOMMANDS = "Off-Premise DB and TacoDB are not in sync")
{
	clipboard = sh cmssyncdb.sh
}
if (ListMISCCOMMANDS = "Latest TACO release" )
{
	clipboard = cd /usr/BOSS/bin;grep TACO releases
}
if (ListMISCCOMMANDS = "Force Sales")
{
	clipboard = l ecrdata* &&cp ecrdata.dat /usr/BOSS/proddb/ecrdata &&cd /usr/BOSS/proddb &&slsupos < ecrdata &&echo "FORCE" > SALES.PENDING &&auditsls
}
if (ListMISCCOMMANDS = "Sync POS")
{
	clipboard = cd /usr/BOSS/pollecr &&sh -x /usr/BOSS/bin/SendEmployeeXMLFile.sh
}
if (ListMISCCOMMANDS = "Gift Card Check")
{
	clipboard = icspmeth AUTO
}
if (ListMISCCOMMANDS = "WineFix tacodb")
{
	clipboard = cd /tmp;mkdir tacodb;cd /usr/BOSS/proddb/;keybuild tacodb;dchain tacodb;tacosudo.sh cp *.dbd *.dbf /tmp/tacodb;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/tacodb;cd /tmp/tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;wine dbfix -p5000 tacodb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/proddb/;cd /usr/BOSS/proddb/;dbcheck -s tacodb;
}
if (ListMISCCOMMANDS = "TACO Hard Disk Size Check")
{
	clipboard = df -h
}
if (ListMISCCOMMANDS = "WineFix cmsdb")
{
	clipboard = cd /tmp;mkdir cmsdb;cd /usr/BOSS/cmsdb/;keybuild cmsdb;dchain cmsdb;tacosudo.sh cp *.dbd *.dbf /tmp/cmsdb;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/cmsdb;cd /tmp/cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;wine dbfix -p5000 cmsdb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/cmsdb;cd /usr/BOSS/cmsdb;dbcheck -s cmsdb;
}
if (ListMISCCOMMANDS = "WineFix sosdb")
{
	clipboard = cd /tmp;mkdir sosdb;cd /usr/BOSS/sosdb/;keybuild sosdb;dchain sosdb;tacosudo.sh cp *.dbd *.dbf /tmp/sosdb;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/sosdb;cd /tmp/sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;wine dbfix -p5000 sosdb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/sosdb;cd /usr/BOSS/sosdb;dbcheck -s sosdb;
}
if (ListMISCCOMMANDS = "WineFix shift")
{
	clipboard = cd /tmp;mkdir shift;cd /usr/BOSS/shift/;keybuild sftdb;dchain sftdb;tacosudo.sh cp *.dbd *.dbf /tmp/shift;cd /home/support/.wine/drive_c/windows;tacosudo.sh chmod 666 work*;tacosudo.sh cp work* /tmp/shift;cd /tmp/shift;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;wine dbfix -p5000 sftdb;tacosudo.sh cp *.dbd *.dbf /usr/BOSS/shift;cd /usr/BOSS/shift;dbcheck -s sftdb;
}
if (ListPOScmd = "CHKDSK DEFRAG")
{
	clipboard = echo y|chkdsk /f & shutdown –r –t 2700 & defrag c: -f -v & shutdown -r -t 0
}
if (ListPOSsql = "IRIS Suspect")
{
	clipboard = EXEC sp_resetstatus Iris; ALTER DATABASE Iris SET EMERGENCY; DBCC checkdb(Iris); ALTER DATABASE Iris SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DBCC CheckDB (Iris, REPAIR_ALLOW_DATA_LOSS); ALTER DATABASE Iris SET MULTI_USER 
}
if (ListPOSsql = "IRIS DB Errors")
{
	clipboard = DBCC checkdb(Iris); ALTER DATABASE Iris SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DBCC CheckDB (Iris, REPAIR_ALLOW_DATA_LOSS); ALTER DATABASE Iris SET MULTI_USER
}
if (ListPOSsql = "POSLIVE DB Errors")
{
	clipboard = DBCC checkdb(PosLive); ALTER DATABASE PosLive SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DBCC CheckDB (PosLive, REPAIR_ALLOW_DATA_LOSS); ALTER DATABASE PosLive SET MULTI_USER
}
if (ListPOSsql = "POSLIVE Suspect")
{
	clipboard = EXEC sp_resetstatus PosLive; ALTER DATABASE PosLive SET EMERGENCY; DBCC checkdb(PosLive); ALTER DATABASE PosLive SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DBCC CheckDB (PosLive, REPAIR_ALLOW_DATA_LOSS); ALTER DATABASE PosLive SET MULTI_USER
}
if (ListPOSsql = "Query for Reg9 NRT")
{
	clipboard = use iris select * from tblApplicationStrings where StringID = 5411
}
if (ListPOSsql = "Mobile Cashier SQL Query1")
{
	clipboard = Select * from tblcustomemployeeinfoxref where xrefnum = 54321
}
if (ListPOSsql = "Mobile Cashier SQL Query2")
{
	clipboard = insert into tblCustomEmployeeInfoXref (XrefName,XrefNum,ExternalNum) values ('MobileEmployeeID','54321','1')
}
if (ListPOScmd = "POS Remote Reboot")
{
	clipboard = shutdown.exe -r -t 0 -m \\pos1
}
if (ListPOScmd = "Runas")
{
	clipboard = runas /user:remote_support 
}
if (ListPOScmd = "Runas CMD")
{
	clipboard = runas /user:remote_support cmd
}
if (ListPOScmd = "Runas Explorer")
{
	clipboard = runas /user:remote_support explorer
}
if (ListPOScmd = "Remote List Tasks")
{
	clipboard = tasklist /s \\pos#
}
if (ListPOScmd = "Remote Kill Task")
{
	clipboard = taskkill /s \\pos# /PID #
}
if (ListPOScmd = "Device Manager")
{
	clipboard = devmgmt.msc
}
if (ListPOSsql = "Find Joe Manager Password")
{
	clipboard = use iris select EmployeeID, Password from tblEmployees where EmployeeID = 12345
}
if (ListPOScmd = "SQL Server Mgmt Studio")
{
	clipboard = ssmsee
}
if (ListPOScmd = "UpdateLinks")
{
	clipboard = C:/IRIS/Setup/updatelinks.vbs
}
if (ListPOScmd = "RegMerge")
{
	clipboard = C:/IRIS/bin/regmerge.exe
}
if (ListPOSsql = "Check for IRIS Errors")
{
	clipboard = use IRIS; DBCC checkdb
}
if (ListPOSsql = "Check for POSLive Errors")
{
	clipboard = use poslive; DBCC checkdb
}
if (ListER = "Password Reset Hash")
{
	clipboard = {SHA}WPvUTd7dyZd6nS8tgm6DuxIHTyA=
}
if (ListER = "Bypass HME timer for No data received error")
{
	clipboard = C:\Altametrics\IBOI_Handler\batchfilehme.bat
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