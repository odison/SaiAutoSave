global $saveCount := 0
global $saveAsCount := 0
global $elapsedTime:= 0
global $saveInterval := (60*1000) ; 60秒间隔保存
global $saveAsInterval := 15     ; 每15次保存后，另存一次 

save(){
    ; 屏蔽键盘和鼠标输入，直到自动保存触发时。
    BlockInput, On
    ; 向程序窗口发送“保存”的按键动作 Ctrl + S。
    Send ^s
    ; 重新允许键盘和鼠标输入。
    BlockInput, Off
}

strCutR(str, cut){
    StringGetPos, cutPos, str, %cut%
    if ( cutPos > 0 ){
        StringTrimRight, str, str, (StrLen(str) - cutPos) ;从匹配处剪掉右侧字符串
    }
    return str
}

strCutL(str, cut){
    StringGetPos, cutPos, str, %cut%
    StringTrimLeft, str, str, cutPos ;从匹配处剪掉左侧字符串
    return str
}

saiFn(){
    WinGetTitle, title, ahk_exe sai.exe ;获取标题
    fn := strReplace(title, " ")
    fn := strCutL(fn, "/" )
    fn := strCutL(fn, "\" )
    StringTrimLeft, fn, fn, 1
    fn := strCutR(fn, ".sai")
    fn := strCutR(fn, "_autosave")
    return fn
}

saveAs(){
    ; 屏蔽键盘和鼠标输入，直到自动保存触发时。
    BlockInput, On

    Send ^s ; 保存当前文件（使标题里不含有 * 符号）
    fn := saiFn()
    ; clipboard := fn . "_autosave" . $saveAsCount
    FormatTime, t, ,yyyy-MM-dd_hhmmss
    clipboard := fn . "_autosave_" . t
    Send ^+s
    Send ^a
    Send ^v
    Send {Enter}
    ; 重新允许键盘和鼠标输入。
    BlockInput, Off
}

loop {
    Sleep ($saveInterval)
    elapsedTime += ($saveInterval)

    If (WinExist("ahk_exe sai.exe")) {
        WinWaitActive, ahk_exe sai.exe
        save()
        $saveCount += 1
        if ( 0 == Mod($saveCount, $saveAsInterval) ){
            saveAs()
            $saveAsCount += 1
        }
    }
}

