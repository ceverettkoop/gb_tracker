INCLUDE "defines.asm"
INCLUDE "constants.asm"

SECTION "Songs", ROMX 
Test_song_notes:
    ; song data that will be iterated through here
    ; todo implement variable length
    db 20 ; tone
    db 32 ; len
    db 22 ; tone
    db 12 ; len
    db 24 ; tone
    db 32 ; len
    db END_PLAYBACK

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
    ld [note_timer], a ; zero timer
    ld a, [note_pos]
    inc a 
    ld [note_pos], a
    ld c, a
    xor a
    ld b, a ;zero b so bc = note_pos one byte
    ld hl, Test_song_notes ;get note byte int from the song
    add hl, bc
    ld c, [hl]
    ld a, c
    cp END_PLAYBACK
    error z ;hard crash on end of song
    call Tone ; should play until called again
    ;now set note_len and advance note_pos again
    inc hl
    ld a, [hl]
    ld [note_len], a
    ld a, [note_pos]
    inc a
    ld [note_pos], a
    ei
    ret
