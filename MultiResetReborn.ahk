; A Multi-Instance macro for Minecraft
; By Specnr, reworked by Ravalle
; v0.1.1

SetWorkingDir, %A_ScriptDir%
#NoEnv
#WinActivateForce
#SingleInstance Force
#Include Settings.ahk
#Include scripts/MultiFunctions.ahk

SetKeyDelay, 0
SetWinDelay, 1
SetTitleMatchMode, 2

global currentInstance := 0

if (performanceMethod == "F") {
    UnsuspendAll()
    sleep, %restartDelay%
}
GetAllPIDs(McDirectories, PIDs, instances)

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
Sleep, 500
SetTitles()

if (!disableTTS)
    ComObjCreate("SAPI.SpVoice").Speak("Ready")

if (performanceMethod == "F")
    SetTimer, FreezeInstances, 20

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