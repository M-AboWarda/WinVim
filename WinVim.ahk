; ---------- WinVIM -------------
isCurrentStateNormalMode := true



StatusBar := Gui("-Caption -ToolWindow +AlwaysOnTop +Disabled +Owner")
StatusBar.BackColor := "EEAA99"
StatusBar.SetFont("s13 q5", "Arial")
WinSetTransColor("EEAA99", StatusBar)

taskbarHeight := SysGet(15)
ContentControl := StatusBar.Add("Text", "c0x55ddff w1000", "Abo Warda [N]")
ContentControl.SetFont("s13 q5")
StatusBar.Show("x5 y" . A_ScreenHeight - taskbarHeight - 27. " NoActivate")

SBLine := Gui("-Caption -ToolWindow +AlwaysOnTop +Disabled +Owner")
SBLine.BackColor := "0x55ddff"
SBLine.add("Text", "x10 y10 h5 ")
SBLine.show("NoActivate x0 y" . A_ScreenHeight - 63 . " w" . A_ScreenWidth . " h2")



setTimer(PutAlwaysOnTop, 1000)
PutAlwaysOnTop(){
    WinSetAlwaysOnTop(1, StatusBar)
}



CapsLock::
{
    global isCurrentStateNormalMode
    if(!isCurrentStateNormalMode){
        ToNormalMode()
    }else{
        ; send("{ESC}")
    }
    return
}

i::
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        ToInsertMode()
    }else{
        send("{Blind}{Text}i")
    }
    return
}

::gg::
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        suspend
        send("^{Home}")
    }else{
        send("{Blind}{Text}gg")
    }
    return
}


; hide the statusbar
q::
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        global StatusBar
        StatusBar.hide
    }else{
        send("{Blind}{Text}q")
    }
    return
}

; free the memory and destroy the gui element
x::
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        global StatusBar, SBLine
        StatusBar.Destroy()
        SBLine.Destroy()
    }else{
        send("{Blind}{Text}x")
    }
    return
}


k:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("{Up}")
    }else{
        send("{Blind}{Text}k")
    }
    return
}

j:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("{Down}")
    }else{
        send("{Blind}{Text}j")
    }
    return
}
h:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("{Left}")
    }else{
        send("{Blind}{Text}h")
    }
    return
}

l:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("{Right}")
    }else{
        send("{Blind}{Text}l")
    }
    return
}
o:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("{Enter}")
        ToInsertMode()
    }else{
        suspend
        send("o")
        suspend
    }
    return
}

^u:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
    send("{PgUp}")
    }else{
        Suspend
        send("^{u}")
        Suspend
    }
    return
}
^d:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("{PgDn}")
    }else{
        Suspend
        send("^{d}")
        Suspend
    }

    return
}
+g:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        send("^{End}")
    }else{
        Suspend
        send("+g")
        Suspend
    }

    return
}


+a:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
    send("{End}")
    ToInsertMode()
    }else{
        send("{Blind}{Text}A")
    }
    return
}
+i:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
    send("{Home}")
    ToInsertMode()
    }else{
        send("{Blind}{Text}I")
    }
    return
}

ToNormalMode(){
    global isCurrentStateNormalMode,SBLine, StatusBar
    isCurrentStateNormalMode := true

    ; color the statusline blue
    SBLine.BackColor := "0x55ddff"

    ; sytle the status bar text
    ContentControl.SetFont("s13 q5 c0x55ddff")
    ContentControl.Text := "Abo Warda [N]"
    WinSetAlwaysOnTop(1, StatusBar)
    StatusBar.Show("x10 y" . A_ScreenHeight - taskbarHeight -27 . " NoActivate")
    ; ToolTipThread := new Thread("DisplayToolTip")
    ; ToolTipThread.start("Normal Mode")
    ToolTip "Normal Mode"

    Sleep 1000
    ToolTip  ; Clear the tooltip
    return
}
ToInsertMode(){
    global isCurrentStateNormalMode,SBLine, StatusBar
    isCurrentStateNormalMode := false
    SBLine.BackColor := "0xff3355"
    ContentControl.SetFont("s13 q5 c0xff3355")
    ContentControl.Text := "Abo Warda [I]"
    WinSetAlwaysOnTop(1, StatusBar)
    StatusBar.Show("x10 y" . A_ScreenHeight - taskbarHeight -27 . " NoActivate")
    ; ToolTipThread := new Thread("DisplayToolTip")
    ; ToolTipThread.start("Normal Mode")
    ToolTip "Insert Mode"
    Sleep 1000
    ToolTip  ; Clear the tooltip
    return
}
DisplayToolTip(Text){

    ToolTip Text
    Sleep 1000
    ToolTip  ; Clear the tooltip
    return
}



+w:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
    send("^{Right}")
    }else{
        send("{Blind}{Text}W")
    }
    return
}
+b:: 
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
    send("^{Left}")
    }else{
        send("{Blind}{Text}B")
    }
    return
}
e::
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
        Run "explorer"
    }else{
        send("{Blind}{Text}e")
    }
    return
}
/::
{
    global isCurrentStateNormalMode
    if(isCurrentStateNormalMode){
    send("^{f}")
    }else{
        send("{Blind}{Text}/")
    }
    return
}


FlipFlop := true
#SuspendExempt
#CapsLock::  ;Win + CapsLock
{
    Suspend
    global FlipFlop, isCurrentStateNormalMode
    if(FlipFlop){

        FlipFlop := !FlipFlop
        SBLine.BackColor := "0x999999"
        ContentControl.SetFont("s13 q5 c0x999999")
    }else{
        FlipFlop := !FlipFlop
        if(isCurrentStateNormalMode){
            ContentControl.SetFont("s13 q5 c0x55ddff")
            SBLine.BackColor := "0x55ddff"
        }else{
            ContentControl.SetFont("s13 q5 c0xff3355")
            SBLine.BackColor := "0xff3355"
        }

    }
}

#SuspendExempt False

