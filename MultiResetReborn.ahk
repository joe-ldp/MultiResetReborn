; A Multi-Instance macro for Minecraft
; By Specnr, reworked by Ravalle
; v0.1.0

#NoEnv
#SingleInstance Force
#Include Settings.ahk
#Include %A_ScriptDir%\scripts\MultiFunctions.ahk

SetKeyDelay, 0
SetWinDelay, 1
SetTitleMatchMode, 2

; Don't configure these

global currentInstance := 0

if (performanceMethod == "F") {
    UnsuspendAll()
    sleep, %restartDelay%
}
GetAllPIDs(McDirectories, PIDs, instances)
SetTitles()

for i, mcdir in McDirectories {
    if (autoBop) {
        cmd := Format("python.exe " . A_ScriptDir . "\scripts\worldBopper9000.py {1}", mcdir)
        Run, %cmd%,, Hide
    }

    idle := mcdir . "idle.tmp"
    if (!FileExist(idle))
        FileAppend,,%idle%
    
    pid := PIDs[i]
    if (borderless) {
        WinSet, Style, -0xC40000, ahk_pid %pid%
        WinMaximize, ahk_pid %pid%
    }
    if (wideResets) {
        WinRestore, ahk_pid %pid%
        WinMove, ahk_pid %pid%,,0,0,%A_ScreenWidth%,%A_ScreenHeight%
        newHeight := Floor(A_ScreenHeight / 2.5)
        WinMove, ahk_pid %pid%,,0,0,%A_ScreenWidth%,%newHeight%
    }
    if (affinity) {
        SetAffinity(pid, highBitMask)
    }

    WinSet, AlwaysOnTop, Off, ahk_pid %pid%
}

NextInstance()

if (!disableTTS)
    ComObjCreate("SAPI.SpVoice").Speak("Ready")

#Persistent
    SetTimer, FreezeInstances, 20
return

FreezeInstances:
    Critical
        if (performanceMethod == "F") {
            Loop, %instances% {
                rIdx := A_Index
                idleCheck := McDirectories[rIdx] . "idle.tmp"
                if (rIdx != currentInstance && resetIdx[rIdx] && FileExist(idleCheck) && (A_TickCount - resetScriptTime[i]) > scriptBootDelay) {
                    SuspendInstance(PIDs[rIdx])
                    resetScriptTime[i] := 0
                    resetIdx[rIdx] := False
                }
            }
        }
return

Reset() {
    ExitWorld()
    NextInstance()
}

NextInstance() {
    idle := False
    while (idle == False) {
        ; increment
        currentInstance++
        if (currentInstance > instances)
            currentInstance := 1

        ; check if instance idle (fully reset)
        idleCheck := McDirectories[currentInstance] . "idle.tmp"
        if (FileExist(idleCheck))
            idle := True
    }
    
    SwitchInstance(currentInstance)
}

GoToActiveInstance() {
    pid := PIDs[currentInstance]
    WinSet, AlwaysOnTop, On, ahk_pid %pid%
    WinSet, AlwaysOnTop, Off, ahk_pid %pid%
}

BackgroundReset(idx) {
    ResetInstance(idx, True)
}

#Include Hotkeys.ahk