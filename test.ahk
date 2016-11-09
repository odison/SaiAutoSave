
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
    StringTrimLeft, fn, fn, 1
    fn := strCutR(fn, ".sai")
    fn := strCutR(fn, "_autosave")
    return fn
}

$saveCount := 0
loop 1 {
    title := "SAI - Work (D:) / 新建图像_autosave.sai"
    fn := saiFn()
    MsgBox _%fn%
    FormatTime, t, ,yyyy-MM-dd_hh:mm
    clipboard := fn . "_autosave_" . t
    MsgBox _%clipboard%
}
