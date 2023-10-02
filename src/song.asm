INCLUDE "defines.asm"
INCLUDE "constants.asm"

SECTION "Songs", ROMX 
Test_song_notes:
    ; song data that will be iterated through here
    ; todo implement variable length
    db 20
    db 22
    db 24
    db 72 ; 72 = flag to stop

SECTION "Song", ROMX
Advance_song:
    ld a, [note_len]
    ld b, a
    ld a, [note_timer]
    inc a
    ld [note_timer], a
    cp b ;if note_timer == note_len advance note
    jr z, Next_note
    ei
    ret ;else done
;advance note position and play note at note_pos
Next_note:
    xor a
    ld [note_timer], a
    ld a, [note_pos]
    inc a 
    ld [note_pos], a
    ld c, a
    xor a
    ld b, a ;zero b so bc = note_pos one byte
    ld hl, Test_song_notes ;get note byte int from the song
    add hl, bc
    ld c, [hl]
    call Tone ; should play until called again
    ei
    ret
