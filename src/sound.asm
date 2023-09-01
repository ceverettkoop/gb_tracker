SECTION "Audio"

;loop middle c on channel 1
Tone:
    ;NR10 = sweep, we are ignoring

    ;NR11 = length timer and duty cycle
    ldh a, 
    
    ;NR12 = vol and envelope
    ldh a, %11110000 ;max volume no envelope
    ldh [rNR12], a

