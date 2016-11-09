
save(){
    ; 屏蔽键盘和鼠标输入，直到自动保存触发时。
    BlockInput, On
    ; 向程序窗口发送“保存”的按键动作 Ctrl + S。
    Send ^s
    ; 重新允许键盘和鼠标输入。
    BlockInput, Off
}

loop {
    If (WinExist("ahk_exe sai.exe")) {
        If (WinActive("ahk_exe sai.exe")) {
            save()
        }
    }
    ; 每 15 秒保存一次
    Sleep (15*1000)
}
