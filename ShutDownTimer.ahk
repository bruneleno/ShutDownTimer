;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
Menu, Tray, Icon
Menu, Tray, NoIcon




;Language variables
if lang = PT
{
;Portuguese Translation
 WinWidth = 380
 HWidth = 60
 MainTitle = Programar para desligar
 ShutDownIn = Desligar em:
 HrSing = hora e
 MinPlu = minutos
 ShowTimer = E mostrar contador
 CancelSch = Cancelar última programação
 MainButton = Iniciar
 Copy = <a href=""> © Copyright 2020 Bruno Heleno.</a> Veja meu <a href="https://www.vimeo.com/bruneleno">portifólio</a> ou entre em <a href="mailto:brunohelenob@gmail.com">contato</a>.
 HrPlu = horas e
 MinSing = minuto
 TimerTitle = Desligando em
 TimerCancel = Cancelar
 NotiTitle = Seu PC ainda vai desligar...
 NotiText = Para cancelar a programação`, abra o app novamente e clique em "Cancelar última programação"
;;;;;
}

else
{
;English
 WinWidth = 410
 HWidth = 75
 MainTitle = Schedule shut down
 ShutDownIn = Shut down in:
 HrSing = hour and
 MinPlu = minutes
 ShowTimer = And show timer
 CancelSch = Cancel last schedule
 MainButton = Start
 Copy = <a href=""> © Copyright 2020 Bruno Heleno.</a> Check my <a href="https://www.vimeo.com/bruneleno">portfolio</a> or <a href="mailto:brunohelenob@gmail.com">e-mail me</a>.
 HrPlu = hours and
 MinSing = minute
 TimerTitle = Time until shut down
 TimerCancel = Cancel
 NotiTitle = Your PC is still going to shut down...
 NotiText = To cancel this schedule`, launch the app again and click "Cancel last schedule"
 ;;;;;
}
;;;;;;


FormatSeconds(NumberOfSeconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    time := 19990101  ; *Midnight* of an arbitrary date.
    time += NumberOfSeconds, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss
    /*
    ; Unlike the method used above, this would not support more than 24 hours worth of seconds:
    FormatTime, hmmss, %time%, h:mm:ss
    return hmmss
    */
}


MinsV = 0


Gui, Setter:New
Gui, Setter:Color , FFFFFF
Gui, Setter:Show,% "w"WinWidth "h"170,% MainTitle
Gui, Setter:-MaximizeBox -MinimizeBox
Gui, Setter:Font, s12 q5
Gui, Setter:Add, Text, y20 x20,% ShutDownIn
Gui, Setter:Font, s11 q5
Gui, Setter:Add, Edit, vHrse y21 w40 h25,
Gui, Setter:Add, UpDown, vHrs gHrsL Wrap Range0-24, 1
Gui, Setter:Font, s12 q5
Gui, Setter:Add, Text,vHrsT y20 w%HWidth%,% HrSing
Gui, Setter:Font, s11 q5
Gui, Setter:Add, Edit, vMinsE y21 w40 h25,
Gui, Setter:Add, UpDown, vMins gMinsL Wrap Range0-60, 0
Gui, Setter:Font, s12 q5
Gui, Setter:Add, Text, vMinsT y20,% MinPlu
Gui, Setter:Font, s11 q5
Gui, Setter:Add, Checkbox, Checked y65 x20 w400 vCount,% ShowTimer
Gui, Setter:Add, Button, y100 x20 gCancel,% CancelSch
Gui, Setter:Add, Button, Default y100 x275 w80 gButtonOK vButtonOK,% MainButton
Gui, Setter:Font, s9 q5 c8A8A8A
Gui, Setter:Add, Link, vcreditos gLicense -Tabstop +Right x20 y140,% Copy
Gui, Setter:Font, s11 q5
return


HrsL:
Gui, Submit, NoHide
if HrsE = 1
GuiControl, Text, HrsT,% HrSing
else
GuiControl, Text, HrsT,% HrPlu
return


MinsL:
Gui, Submit, NoHide
if Mins != 1
{
GuiControl, Text, MinsT,% MinPlu
}
else 
{
GuiControl, Text, MinsT,% MinSing
}
If Mins = 60
{
	if MinsV != 0
	{
		HrsVP := HrsE + 1
		GuiControl, Text, MinsE, 0
		GuiControl, Text, HrsE, %HrsVP%
	}
	else
	{
		HrsVN := HrsE - 1
		if HrsVN < 0
		HrsVN = 0
		GuiControl, Text, MinsE, 59
		GuiControl, Text, HrsE, %HrsVN%
	}
}
MinsV := Mins
return

ButtonOK:
Gui, Submit, NoHide
T :=(Hrse * 3600) + (MinsE * 60)
Run, %Comspec% /c shutdown /s /t %T%
if Count = 1
Goto Timer
Gui, Setter:Submit
Return

Timer:
Gui, Setter:Submit
Gui, Timer:New
Gui, Timer:Color , FFFFFF
Gui, Timer:+AlwaysOnTop +ToolWindow
Gui, Timer:Show, w135 h90,% TimerTitle
Gui, Timer:Font, s20 q5
Gui, Timer:Add, Text, vCtDn y10 x20 w200, 
Gui, Timer:Font, s11 q5
Gui, Timer:Add, Button, y50 x20 gTCancel w95,% TimerCancel
WinSet, Transparent , 180,% TimerTitle
T :=(Hrse * 3600) + (MinsE * 60)
CountDown := T
Loop, %T%
{
CountDown := CountDown - 1
HMS := FormatSeconds(CountDown)
GuiControl, Text, CtDn, %HMS%
sleep, 1000
}
return

SetterGuiSize:
GuiControl, Move, ButtonOK, % "x" (A_GuiWidth - 100)
Return


License:
	Gui, License:New
	Gui, License:Color , FFFFFF
	Gui, License:Show, w375 h170, License
	Gui, License:+ToolWindow
	Gui, License:Add, Link, w360,`n    Free Software Utilization`n    ---------------------------------------------`n`nThis program uses AutoHotkey. AutoHotkey is free software licenced under the GPL license. More information can be found at <a href="https://www.autohotkey.com/docs/license.htm">autohotkey.com/docs/license.htm</a>.`n`n`n    GNU GPL information`n    -----------------------------------`n`nThis program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.`nThis program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.`nYou should have received a copy of the GNU General Public License along with this program.  If not, see <a href="https://www.gnu.org/licenses/">gnu.org/licenses</a>.`n
	Gui, Show, AutoSize
Return

Cancel:
Run, %Comspec% /c shutdown /a
Return

TimerGuiClose:
Menu, Tray, Icon
TrayTip,%NotiTitle%, %NotiText%, , 34
ExitApp
return

TCancel:
Run, %Comspec% /c shutdown /a
SetterGuiClose:
ExitApp  ; All of the above labels will do this.
return