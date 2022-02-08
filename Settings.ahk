; v0.1.1

; General Settings
global fullscreen := False ; Enable to use fullscreen (as in F11)
global borderless := True ; Enable to use borderless windowed (like fullscreen, may have more input lag, but nicer otherwise)
; Fullscreen and borderless can both be set to True, it won't break anything, but there's little point in using both
global disableTTS := False ; Disables "ready" TTS notification
global countAttempts := True ; Counts attempts...
global coopResets := False ; Use forceport and some method of forwarding port 25565
global autoBop := False ; Automatically deletes old worlds when you open the macro

; Set to 0 if you don't want the specific setting to be reset
; Sensitivity and FOV may be off by 1, mess around with +-1 if you care about specifics
global renderDistance := 18
global FOV := 110 ; For quake pro put 110
global mouseSensitivity := 0


; Multi Config
global resetSounds := True ; :)
global wideResets := False ; Wide resets for more vision when background resetting (makes switching between instances kinda ugly though)
global unpauseOnSwitch := True ; Unpause or stay paused when you get switched to an instance


; Advanced settings
; General
global fullScreenDelay := 270 ; increase if fullscreening issues
global restartDelay := 200 ; increase if saying missing instanceNumber in .minecraft (and you ran setup)
global maxLoops := 50 ; increase if instance isnt resetting (or have to press reset twice)

; OBS settings
global obsDelay := 50 ; increase if not changing scenes in obs (only relevant if not using websocket)
global useObsWebsocket := False ; Allows for >9 instances (additional setup required)

; Performance related settings
global performanceMethod := "S" ; F = Instance Freezing, S = Settings Changing RD, N = Nothing
global affinity := True ; A funky performance addition, enable for performance boost
global lowBitmaskMultiplier := 0.75 ; for affinity; the lower it is, the less your active instance lags, but the slower the background ones generate. Keep it as high as you can
; Instance freezing
global resumeDelay := 50 ; increase if instance isnt resetting (or have to press reset twice)
global beforeFreezeDelay := 500 ; increase if doesnt join world
global scriptBootDelay := 6000 ; increase if instance freezes before world gen
; Settings changes
global settingsDelay := 10 ; increase if settings arent changing
global beforePauseDelay := 500 ; basically the delay before dynamic FPS does its thing
global lowRender := 5 ; For settings change performance method