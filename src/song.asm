INCLUDE "defines.asm"

SECTION "Song_var", WRAMX
    song_pos db 0 ; ticks up to match note length and advance note on match
    note_len db 64;


SECTION "Song", ROMX
Advance_song:
    ld a, note_len
    ld b, a
    ld a, song_pos
    inc a
    ld song_pos, a
    cp b

;scale stuff
Init_Scale:
    xor a ;init loop counter to 0
    ld b, a
    ld c, a

;loop through scale, 36 notes, increments b by two bc note is 16 bit
Scale_Note:
    ld a, c
    inc c
    inc c ;up two now
    ;check if a is 72 i.e. next note would be beyond the end
    cp a, 72
    call nz, Tone ;if a != 72 play tone based on value on stack (two less than a)
    jr nz, Wait;flag should still be nz so now we can skip else branch below
    ;ELSE set a to zero and int on stack to zero
    xor a
    ld c, a;set note int back to zero
    call Tone
    jr Scale_Note
