L0000:
        di
        lxi     sp,L204E
        jmp     L003B
        nop
L0008:
        call    L00FD
        ei
        ret
L000D:
        nop
        nop
        nop
        call    L03CC
        ei
L0014:
        ret
        nop
        nop
        nop
        call    L03CC
        call    L00FD
        ei
        ret
        call    L04CF
        ret
        nop
        nop
        nop
        nop
        call    L04CF
        ret
        nop
        nop
        nop
        nop
L0030:
        call    L03CC
        call    L04CF
        ei
        ret
        jmp     L0030
L003B:
        mvi     e,$01
L003D:
        di
        mvi     a,$0f
        out     $62
        cma
        out     $42
        xra     a
        mov     d,a
        mov     l,a
        mov     h,a
L0049:
        inr     a
        mov     b,a
        out     $82
        mvi     c,$08
L004F:
        rlc
        xra     m
        inr     l
        jnz     L004F
        inr     h
        dcr     c
        jnz     L004F
        ora     a
L005B:
        jnz     L005B
        mov     a,b
        cpi     $04
        jnz     L0049
        inr     a
        out     $82
        mvi     c,$aa
        mvi     b,$2c
        in      $42
        ani     $02
        jnz     L0074
        mvi     b,$40
L0074:
        mov     h,b
        dcx     h
L0076:
        mvi     m,$00
        dcx     h
        mov     a,h
        cpi     $1f
        jnz     L0076
        inx     h
L0080:
        mov     a,m
        ora     a
        jz      L0090
        ani     $0f
        mov     a,h
        jnz     L00A1
        cpi     $30
        jc      L00A1
L0090:
        mov     m,c
        mov     a,m
        xra     c
        jz      L00A8
        ani     $0f
        mov     a,h
        jnz     L00A1
        cpi     $30
        jnc     L00A8
L00A1:
        mvi     d,$01
        cpi     $2c
L00A5:
        jc      L00A5
L00A8:
        xra     a
        inx     h
        ora     l
        jnz     L0080
        ora     h
        cmp     b
        jnz     L0080
        mov     a,c
        rlc
        mov     c,a
        jc      L0074
        push    d
        call    L02A4
        call    L02EB
        call    L175B
        pop     d
        jz      L00CB
        mov     a,d
        ori     $02
        mov     d,a
L00CB:
        mvi     a,$2f
        sta     L21C9
        out     $62
L00D2:
        lxi     b,L0FFF
        ei
L00D6:
        mvi     a,$08
        ana     e
        mvi     a,$7f
        jnz     L00E0
        mvi     a,$ff
L00E0:
        out     $82
        dcx     b
        mov     a,b
        ora     c
        jnz     L00D6
        out     $82
        lda     L2068
        ora     a
        jm      L00F5
        mov     a,d
        ori     $04
        mov     d,a
L00F5:
        push    d
        call    L03A2
        pop     d
        jmp     L0875
L00FD:
        push    psw
        in      $82
        push    h
        push    b
        mov     b,a
        sui     $7c
        jm      L011A
        mov     h,a
L0109:
        inr     h
        mvi     a,$10
        rrc
L010D:
        rlc
        dcr     h
        jnz     L010D
        lxi     h,L2068
        ora     m
        mov     m,a
        jmp     L012D
L011A:
        lxi     h,L2068
        mvi     a,$07
        ana     m
        cpi     $04
        jp      L012D
        inr     m
        lxi     h,L206A
        call    L13DE
        mov     m,b
L012D:
        pop     b
        pop     h
        pop     psw
        ret
L0131:
        ani     $7f
        mov     c,a
        lda     L207B
        ora     a
        jnz     L01FF
L013B:
        mov     a,c
        cpi     $01
        jz      L01C3
        lda     L21A7
        ani     $20
        jnz     L0175
        lda     L2178
        ora     a
        jnz     L015F
        mov     a,c
        cpi     $41
        jm      L015B
        mvi     a,$1b
        call    L0F18
L015B:
        mov     a,c
        jmp     L080D
L015F:
        mvi     a,$1b
        call    L0F18
        mov     a,c
        cpi     $41
        jp      L015B
        mvi     a,$3f
L016C:
        call    L0F18
        mov     a,c
        adi     $40
        jmp     L080D
L0175:
        lda     L2178
        ora     a
        jnz     L019E
        mov     a,c
        cpi     $41
        jm      L015B
        cpi     $50
        jm      L019E
L0187:
        mvi     a,$1b
        call    L0F18
        mvi     a,$4f
L018E:
        call    L0F18
        jmp     L015B
L0194:
        mvi     a,$1b
        call    L0F18
        mvi     a,$5b
        jmp     L018E
L019E:
        lda     L21BC
        ora     a
        jz      L01B5
        mov     a,c
        cpi     $41
        jp      L0187
L01AB:
        mvi     a,$1b
        call    L0F18
        mvi     a,$4f
        jmp     L016C
L01B5:
        mov     a,c
        cpi     $41
        jm      L01AB
        cpi     $50
        jm      L0194
        jmp     L0187
L01C3:
        lxi     h,L0815
        push    h
        lda     L21A5
        ora     a
        rnz
        call    L0853
        lxi     b,L020E
        lxi     h,L2068
        mov     a,m
        ani     $10
        jnz     L0900
        mov     a,m
        ani     $20
        jz      L01E4
        lxi     b,L00D2
L01E4:
        mvi     a,$25
        ori     $08
        ora     b
        out     $01
        lda     L207F
        add     c
        mov     c,a
L01F0:
        push    b
        call    L1493
        pop     b
        lda     L207F
        cmp     c
        jnz     L01F0
        jmp     L0394
L01FF:
        lxi     h,L0812
        push    h
        xra     a
        sta     L2130
        sta     L21B8
        lxi     h,L21A3
        mov     a,c
L020E:
        sui     $41
        mov     b,a
L0211:
        mov     a,m
L0212:
        jz      L0222
        dcr     b
        jz      L0226
        dcr     b
        jz      L1815
        dcr     b
        jz      L181E
        ret
L0222:
        dcr     a
        rm
        mov     m,a
        ret
L0226:
        inr     a
        cpi     $20
        rz
        mov     m,a
        ret
L022C:
        lda     L21A7
        cma
        ani     $10
        lxi     h,L21A5
        ora     m
        jnz     L0841
        lda     L21BF
        lxi     b,L0211
        ana     b
        jnz     L0245
        mvi     c,$13
L0245:
        mov     a,c
        sui     $11
        sta     L21C4
        call    L0F7E
        jmp     L0812
L0251:
        di
        lxi     sp,L204E
        lxi     h,L2000
        push    h
        mov     a,m
        rar
        jc      L0265
        in      $42
        ani     $02
        jz      L0269
L0265:
        inr     a
        sta     L21C8
L0269:
        call    L03A2
        lda     L2050
        dcr     a
        sta     L2153
        pop     h
        mov     a,m
        mvi     m,$7f
        ora     a
        jz      L0298
        jp      L0285
        lxi     h,L21CB
        mvi     m,$0a
        ani     $7f
L0285:
        sta     L21BD
        adi     $30
        lhld    L20F6
        mov     m,a
        cpi     $34
        jz      L0298
        mvi     a,$20
        sta     L21A5
L0298:
        call    L0BF2
        lxi     b,L0011
        call    L0F7E
        jmp     L03AE
L02A4:
        lxi     h,L204E
        lxi     d,L0FB2
        mvi     b,$00
        call    L1083
        cma
        sta     L2104
        lxi     h,L2004
        shld    L2052
        lxi     h,L22D0
        shld    L20F6
        ret
L02C0:
        call    L0A15
        lxi     h,L2000
        lxi     d,L02D9
        mvi     b,$12
        call    L038B
        lxi     h,L3000
        lxi     d,L1000
        mvi     b,$ff
        jmp     L1083
L02D9:
        db      $7f
        db      $70             ; 'p'
        db      $03
        db      $7f
        db      $f2
        db      $d0
        db      $7f
        db      $70             ; 'p'
        db      $06
        db      $7f
        db      $70             ; 'p'
        db      $0c
        db      $7f
        db      $70             ; 'p'
        db      $0f
        db      $7f
        db      $70             ; 'p'
        db      $03
L02EB:
        lxi     h,L0212
        shld    L212D
        mvi     a,$35
        sta     L212C
        mvi     a,$01
        sta     L205B
        sta     L2176
        lxi     h,L07FF
        shld    L2149
        mvi     a,$02
        sta     L2073
        mvi     a,$f7
        sta     L20FA
        in      $42
        ani     $04
        mvi     a,$01
        jnz     L031A
        sta     L2079
L031A:
        mvi     a,$ff
        sta     L210E
        sta     L21BA
        mvi     h,$80
        mov     l,h
        shld    L20C0
        ret
L0329:
        mvi     a,$40
        out     $01
        lda     L2158
        out     $02
        lda     L21A4
        out     $01
        call    L0394
        mvi     a,$10
        sta     L21C9
        out     $62
        ret
L0342:
        lda     L21A2
        ora     a
        jz      L034B
        mvi     a,$10
L034B:
        mov     b,a
        out     $c2
        lda     L207C
        out     $c2
        cpi     $20
        lxi     h,L0970
        jnz     L035E
        lxi     h,L0370
L035E:
        shld    L2001
        lda     L21A8
        ani     $10
        rz
        mov     a,b
        out     $c2
        ret
L036B:
        lda     L21A6
        ani     $20
L0370:
        jnz     L0375
        mvi     a,$01
L0375:
        ori     $0a
        out     $a2
        lda     L215B
        ori     $0c
        out     $a2
        ret
L0381:
        lda     L21A2
        ora     a
        jz      L0B63
        jmp     L0B77
L038B:
        ldax    d
        mov     m,a
        inx     h
        inx     d
        dcr     b
        jnz     L038B
        ret
L0394:
        lda     L21A5
        ora     a
        mvi     a,$01
        jnz     L039F
        mvi     a,$05
L039F:
        jmp     L1F7B
L03A2:
        call    L0381
        call    L1DDB
        call    L036B
        jmp     L0342
L03AE:
        call    L1488
        call    L0587
        lxi     h,L2177
        mov     a,m
        ora     a
        mvi     m,$00
        cnz     L1A20
        lda     L21A5
        ora     a
        jz      L03AE
        xra     a
        sta     L2144
        jmp     L03AE
L03CC:
        push    psw
        push    b
        push    h
        in      $00
        ani     $7f
        jz      L043A
        mov     c,a
        lda     L21A5
        ora     a
        jnz     L043A
        in      $01
        ani     $38
        jz      L03ED
        mvi     c,$1a
        mvi     a,$27
        ori     $10
        out     $01
L03ED:
        mov     a,c
        cpi     $7f
        jz      L0437
        lda     L21A7
        ani     $10
        mov     a,c
        jz      L0409
        lxi     h,L21C2
        cpi     $11
        jz      L043E
        cpi     $13
        jz      L0444
L0409:
        lxi     h,L20C0
        mov     c,m
        mov     b,h
        stax    b
        mov     a,c
        inr     a
        ani     $bf
        mov     m,a
        mov     b,a
        lda     L20C1
        sub     b
        jnz     L0427
        mov     m,c
        mov     a,b
        inr     a
        ani     $bf
        mov     l,a
        mvi     m,$1a
        jmp     L0431
L0427:
        jp      L042C
        adi     $40
L042C:
        cpi     $20
        jnz     L0437
L0431:
        lxi     b,L0113
        call    L0F7E
L0437:
        call    L0E47
L043A:
        pop     h
        pop     b
        pop     psw
        ret
L043E:
        mvi     a,$fe
        ana     m
        jmp     L0447
L0444:
        mvi     a,$01
        ora     m
L0447:
        mov     m,a
        jmp     L0437
L044B:
        db      $30             ; '0'
        db      $29             ; ')'
        db      $31             ; '1'
        db      $21             ; '!'
        db      $32             ; '2'
        db      $40             ; '@'
        db      $33             ; '3'
        db      $23             ; '#'
        db      $34             ; '4'
        db      $24             ; '$'
        db      $35             ; '5'
        db      $25             ; '%'
        db      $36             ; '6'
        db      $5e             ; '^'
        db      $37             ; '7'
        db      $26             ; '&'
        db      $38             ; '8'
        db      $2a             ; '*'
        db      $39             ; '9'
        db      $28             ; '('
        db      $2d             ; '-'
        db      $5f             ; '_'
        db      $3d             ; '='
        db      $2b             ; '+'
        db      $60             ; '`'
        db      $7e             ; '~'
        db      $5b             ; '['
        db      $7b             ; '{'
        db      $5d             ; ']'
        db      $7d             ; '}'
        db      $3b             ; ';'
        db      $3a             ; ':'
        db      $2f             ; '/'
        db      $3f             ; '?'
        db      $27             ; '''
        db      $22             ; '"'
        db      $2c             ; ','
        db      $3c             ; '<'
        db      $2e             ; '.'
        db      $3e             ; '>'
        db      $5c             ; '\'
        db      $7c             ; '|'
        db      $20             ; ' '
L0476:
        db      $20             ; ' '
        db      $7f
        db      $7f
        db      $7f
        db      $00
        db      $70             ; 'p'
        db      $6f             ; 'o'
        db      $79             ; 'y'
        db      $74             ; 't'
        db      $77             ; 'w'
        db      $71             ; 'q'
        db      $c3
        db      $00
        db      $00
        db      $00
        db      $5d             ; ']'
        db      $5b             ; '['
        db      $69             ; 'i'
        db      $75             ; 'u'
        db      $72             ; 'r'
        db      $65             ; 'e'
        db      $31             ; '1'
        db      $c4
        db      $00
        db      $c2
        db      $81
        db      $60             ; '`'
        db      $2d             ; '-'
        db      $39             ; '9'
        db      $37             ; '7'
        db      $34             ; '4'
        db      $33             ; '3'
        db      $1b
        db      $c1
        db      $d2
        db      $d0
        db      $08
        db      $3d             ; '='
        db      $30             ; '0'
        db      $38             ; '8'
        db      $36             ; '6'
        db      $35             ; '5'
        db      $32             ; '2'
        db      $09
        db      $b7
        db      $d3
        db      $d1
        db      $b0
        db      $0a
        db      $5c             ; '\'
        db      $6c             ; 'l'
        db      $6b             ; 'k'
        db      $67             ; 'g'
        db      $66             ; 'f'
        db      $61             ; 'a'
        db      $b8
        db      $8d
        db      $b2
        db      $b1
        db      $00
        db      $27             ; '''
        db      $3b             ; ';'
        db      $6a             ; 'j'
        db      $68             ; 'h'
        db      $64             ; 'd'
        db      $73             ; 's'
        db      $ae
        db      $ac
        db      $b5
        db      $b4
        db      $0d
        db      $2e             ; '.'
        db      $2c             ; ','
        db      $6e             ; 'n'
        db      $62             ; 'b'
        db      $78             ; 'x'
        db      $82
        db      $b9
        db      $b3
        db      $b6
        db      $ad
        db      $00
        db      $2f             ; '/'
        db      $6d             ; 'm'
        db      $20             ; ' '
        db      $76             ; 'v'
        db      $63             ; 'c'
        db      $7a             ; 'z'
        db      $ff
L04CF:
        push    psw
        push    h
        push    d
        call    L104E
        push    b
        mvi     a,$09
        out     $a2
        ei
        lda     L2065
        ora     a
        jnz     L050B
        lxi     h,L2051
        ora     m
        jz      L053E
        mvi     a,$01
        sta     L2065
        ora     m
        mvi     m,$00
        mvi     a,$01
        sta     L205B
        lda     L2156
        jp      L0505
        mvi     a,$99
        sta     L205B
        lda     L2155
        dcr     a
L0505:
        call    L122F
        sta     L207A
L050B:
        lxi     b,L205B
        ldax    b
        lxi     h,L205A
        add     m
        daa
        ani     $0f
        mov     m,a
        mov     d,a
        ani     $03
        out     $a2
        mov     a,d
        rar
        ana     a
        rar
        ori     $04
        out     $a2
        mov     a,d
        ora     a
        jnz     L053E
        sta     L2065
        ldax    b
        ora     a
        lda     L2156
        jm      L0538
        lda     L2155
        dcr     a
L0538:
        call    L11CE
        sta     L207A
L053E:
        lxi     h,L2078
        mov     a,m
        ora     a
        jz      L054F
        dcr     m
        ani     $04
        rrc
        rrc
        rrc
        sta     L2146
L054F:
        lxi     h,L212C
        mov     a,m
        dcr     a
        jnz     L0569
        mvi     m,$35
        mvi     a,$08
        out     $a2
        lxi     h,L21CB
        mov     a,m
        ora     a
        jz      L056A
        out     $a2
        xri     $01
L0569:
        mov     m,a
L056A:
        mvi     a,$40
        sta     L2148
        lxi     h,L207F
        inr     m
        lda     L21A3
        out     $42
        lda     L2158
        out     $02
        lda     L21C9
        out     $62
        pop     b
        pop     d
        pop     h
        pop     psw
        ret
L0587:
        lda     L21A5
        lxi     h,L207B
        ora     m
        rnz
        call    L0675
        rz
L0593:
        mov     b,a
        lda     L207B
        ora     a
        mov     a,b
        jnz     L05A9
        lda     L2079
        rlc
        mov     a,b
        jc      L05A9
        cpi     $20
        jc      L08B2
L05A9:
        lhld    L2140
        pchl
L05AD:
        cpi     $1b
        jnz     L05CC
        lxi     h,L05B8
        jmp     L0A18
L05B8:
        cpi     $32
        jnz     L05C5
        mvi     a,$01
        sta     L2079
        jmp     L0A15
L05C5:
        mov     b,a
        mvi     a,$1b
        call    L05D2
        mov     a,b
L05CC:
        call    L05D2
        jmp     L0C62
L05D2:
        mov     c,a
L05D3:
        push    b
        call    L1488
        pop     b
        in      $42
        ani     $04
        jnz     L05D3
        mov     a,c
        out     $e2
        ret
L05E3:
        call    L0C46
L05E6:
        push    psw
        cpi     $7f
        jz      L0673
        push    h
        push    d
        push    b
        mov     c,a
        lxi     h,L20FC
        mov     d,m
        inx     h
        mov     a,d
        add     l
        mov     l,a
        mov     a,d
        sui     $02
        jp      L05FF
        mov     a,d
L05FF:
        sta     L20FC
        mov     d,m
        lda     L20FA
        ora     d
        mov     b,a
        mov     a,d
        rlc
        mov     a,c
        jnc     L0616
        sui     $5f
        cpi     $20
        jnc     L0616
        mov     c,a
L0616:
        mov     a,d
        ani     $40
        mov     a,c
        jz      L0624
        cpi     $23
        jnz     L0624
        mvi     c,$1e
L0624:
        lda     L20FB
        ora     c
        mov     c,a
        lda     L2142
        ora     a
        jz      L0641
        lxi     h,L20F8
        lda     L2153
        cmp     m
        jnz     L0641
        mvi     m,$00
        push    b
        call    L0955
        pop     b
L0641:
        lhld    L20F6
        mov     m,c
        mov     a,h
        adi     $10
        mov     h,a
        mov     m,b
        mov     a,b
        sta     L20F5
        lxi     h,L20F4
        mov     m,c
        lxi     h,L20F8
        lda     L2153
        cmp     m
        jnz     L0668
        mov     a,c
        sta     L20F4
        lda     L21A8
        ani     $40
        jmp     L066D
L0668:
        inr     m
        call    L1636
        xra     a
L066D:
        sta     L2142
L0670:
        pop     b
        pop     d
        pop     h
L0673:
        pop     psw
        ret
L0675:
        lda     L21C4
        ora     a
        jnz     L0685
        lxi     h,L20C0
        mov     a,m
        inx     h
        sub     m
        jnz     L0687
L0685:
        xra     a
        ret
L0687:
        mov     l,m
        mvi     h,$20
        mov     d,m
        lxi     h,L20C1
        mov     a,m
        inr     a
        ani     $bf
        ori     $80
        mov     m,a
        dcx     h
        sub     m
        jp      L069C
        adi     $40
L069C:
        cpi     $30
        jnz     L06A7
        lxi     b,L0111
        call    L0F7E
L06A7:
        mov     a,d
        ora     a
        ret
L06AA:
        lda     L2068
        mov     e,a
        ani     $80
        rz
        lxi     h,L0841
        push    h
        mov     a,e
        ani     $07
        cpi     $04
        jm      L06C2
        xra     a
        sta     L2067
        ret
L06C2:
        mov     d,a
        mvi     c,$00
        mvi     b,$04
        lxi     h,L206E
L06CA:
        mov     a,m
        ora     a
        jz      L06E8
        push    h
        push    b
        mvi     b,$03
        lxi     h,L206A
L06D6:
        cmp     m
        jz      L06DF
        inx     h
        dcr     b
        jp      L06D6
L06DF:
        pop     b
        pop     h
        jz      L06E7
        mvi     m,$00
        dcr     c
L06E7:
        inr     c
L06E8:
        inx     h
        dcr     b
        jnz     L06CA
        mov     a,e
        ani     $08
        rnz
        ora     d
        jnz     L06FB
        mvi     a,$e1
        sta     L2072
        ret
L06FB:
        lxi     h,L0747
        push    h
        lda     L2072
        inr     a
        jz      L0709
        sta     L2072
L0709:
        lda     L21A6
        ani     $40
        rz
        mov     a,e
        ani     $10
        rnz
        lda     L2150
        lxi     h,L085F
        mvi     b,$05
L071B:
        cmp     m
        rz
        inx     h
        dcr     b
        jnz     L071B
        lxi     h,L2073
        dcr     m
        rnz
        mvi     m,$02
        lda     L2072
        cpi     $ff
        rnz
        mov     a,c
        cpi     $01
        rnz
        mvi     b,$04
        lxi     h,L206E
L0738:
        mov     a,m
        ora     a
        jnz     L0743
        inx     h
        dcr     b
        jnz     L0738
        ret
L0743:
        pop     h
        jmp     L0776
L0747:
        mov     a,c
        cpi     $04
        rp
        lxi     b,L206A
L074E:
        lxi     h,L206E
L0751:
        mov     a,m
        ora     a
        jz      L075B
        ldax    b
        cmp     m
        jz      L0766
L075B:
        inx     h
        mov     a,l
        cpi     $72
        jnz     L0751
        ldax    b
        jmp     L076C
L0766:
        inx     b
        dcr     d
        jnz     L074E
        ret
L076C:
        mov     b,a
        lda     L2067
        cmp     b
        mov     a,b
        sta     L2067
        rnz
L0776:
        pop     h
        sta     L2150
        cpi     $7b
        jz      L1A1A
        cpi     $6a
        jz      L022C
        mov     b,e
        mov     e,a
        lda     L2144
        ora     a
        jnz     L0841
        mov     a,e
        ani     $f0
        rrc
        rrc
        mov     d,a
        rrc
        rrc
        add     d
        mov     d,a
        mov     a,e
        sub     d
        lxi     h,L0476
        mov     e,a
        mvi     d,$00
        dad     d
        mov     c,m
        mov     a,c
        ora     a
        jm      L0131
        cpi     $20
        jc      L07FF
        mov     a,b
        ani     $70
        jz      L07FF
        mov     a,c
        cpi     $7b
        jnc     L07C2
        cpi     $61
        jc      L07C2
        ani     $df
        mov     c,a
        jmp     L07D7
L07C2:
        mov     a,b
        ani     $30
        jz      L07D7
        lxi     h,L044B
L07CB:
        mov     a,m
        cmp     c
        jz      L07D5
        inx     h
        inx     h
        jmp     L07CB
L07D5:
        inx     h
        mov     c,m
L07D7:
        mov     a,b
        ani     $10
        jz      L07FF
        mov     a,c
        cpi     $41
        jc      L07E8
        cpi     $5b
        jc      L07FC
L07E8:
        cpi     $3f
        jz      L07FC
        cpi     $20
        jz      L07FC
        cpi     $7b
        jc      L0841
        cpi     $7f
        jnc     L0841
L07FC:
        ani     $9f
        mov     c,a
L07FF:
        ora     c
        push    psw
        lda     L21A7
        ani     $80
        jz      L080C
        sta     L2154
L080C:
        pop     psw
L080D:
        ori     $80
        call    L0F18
L0812:
        call    L0853
L0815:
        lda     L2150
        mvi     d,$04
        lxi     h,L206E
L081D:
        cmp     m
        jz      L0841
        inx     h
        dcr     d
        jnz     L081D
        mvi     d,$04
        lxi     h,L206E
L082B:
        mov     a,m
        ora     a
        jz      L0838
        inx     h
        dcr     d
        jnz     L082B
        jmp     L0841
L0838:
        lda     L2150
        mov     m,a
        mvi     a,$e1
        sta     L2072
L0841:
        xra     a
        lxi     h,L2068
        mov     d,m
        mov     m,a
        inx     h
        mov     m,d
        inx     h
        mvi     d,$04
L084C:
        mov     m,a
        inx     h
        dcr     d
        jnz     L084C
        ret
L0853:
        lda     L21A7
        ani     $40
        rz
        mvi     a,$80
        sta     L2147
        ret
L085F:
        db      $7b             ; '{'
        db      $2a             ; '*'
        db      $6a             ; 'j'
        db      $3a             ; ':'
        db      $64             ; 'd'
L0864:
        lda     L2130
        sui     $02
        rnz
        mov     d,a
        lda     L2131
        mov     e,a
L086F:
        mvi     a,$01
        ana     e
        jnz     L003D
L0875:
        mov     a,d
        ora     a
        cnz     L08A7
        push    d
        call    L17BE
        pop     d
        mvi     a,$02
        ana     e
        cnz     L1F11
        mvi     a,$08
        cc      L08A7
        mvi     a,$04
        ana     e
        cnz     L1F62
        mvi     a,$10
        cc      L08A7
        mov     a,d
        ora     a
        jnz     L08A0
        mvi     a,$08
        ana     e
        jnz     L086F
L08A0:
        mov     a,d
        sta     L2000
        jmp     L0251
L08A7:
        ora     d
        mov     d,a
        mvi     a,$08
        ana     e
        rz
        mvi     a,$80
        ora     d
        mov     d,a
        ret
L08B2:
        cpi     $1b
        jz      L099E
        cpi     $10
        jc      L08D4
        mov     e,a
        sui     $18
        ani     $fd
        rnz
        mov     a,e
        cpi     $1a
        jz      L08CB
        cpi     $18
        rnz
L08CB:
        call    L0A15
        mvi     a,$02
        jmp     L05E6
        ret
L08D4:
        sui     $05
        rm
        lxi     h,L08E5
        add     a
        mov     e,a
        mvi     d,$00
        dad     d
        mov     e,m
        inx     h
        mov     d,m
        xchg
        xra     a
        pchl
L08E5:
        db      $00
        db      $09
        db      $97
        db      $09
        db      $38             ; '8'
        db      $09
        db      $41             ; 'A'
        db      $09
        db      $f9
        db      $0d
        db      $55             ; 'U'
        db      $09
        db      $55             ; 'U'
        db      $09
        db      $55             ; 'U'
        db      $09
        db      $4b             ; 'K'
        db      $09
        db      $fb
        db      $08
        db      $fc
        db      $08
L08FB:
        inr     a
        sta     L20FC
        ret
L0900:
        lda     L21A5
        ora     a
        rnz
        lhld    L217B
        mov     a,h
        cmp     l
        rz
        lxi     h,L2172
        mvi     a,$10
        ora     m
        mov     m,a
        ret
        lxi     h,L2172
        mov     a,m
        ani     $ef
        mov     m,a
        lxi     h,L217B
        mov     b,m
        inx     h
        mvi     c,$14
        lxi     d,L215C
L0924:
        mov     a,m
        cmp     b
        jz      L0930
        stax    d
        inx     d
        inx     h
        dcr     c
        jnz     L0924
L0930:
        dcx     d
        ldax    d
        ori     $80
        stax    d
        jmp     L0EF3
L0938:
        lxi     h,L2078
        mov     a,m
        adi     $08
        rc
        mov     m,a
        ret
        lxi     h,L20F8
        mov     a,m
        ora     a
        rz
        dcr     m
        jmp     L1636
L094B:
        xra     a
        sta     L20F8
        jmp     L1636
        call    L094B
L0955:
        lda     L21A8
        ani     $20
        cnz     L094B
        lxi     h,L20F9
        mov     d,m
        lda     L2156
        cmp     d
        jz      L0973
        call    L11BF
        mov     a,b
        cmp     d
        rz
        inr     d
        mov     m,d
L0970:
        jmp     L1636
L0973:
        lda     L21A6
        ani     $80
        jz      L0998
        mvi     c,$01
        call    L108E
        mvi     a,$ff
        sta     L21C3
        inr     m
        call    L0FE6
L0989:
        lda     L21C3
        ora     a
        jnz     L0989
        sta     L20F4
        dcr     a
        sta     L20F5
        ret
L0998:
        call    L101A
        jmp     L1012
L099E:
        xra     a
        sta     L207D
        sta     L21B8
        lxi     h,L09AB
        jmp     L0A18
L09AB:
        cpi     $30
        jnc     L09BD
        lxi     h,L207D
        mov     c,a
        mov     a,m
        ora     a
        jz      L09BB
        mvi     c,$ff
L09BB:
        mov     m,c
        ret
L09BD:
        sta     L207E
        lxi     h,L0A15
        push    h
        lda     L207D
        ora     a
        jnz     L09DC
        lda     L21A7
        ani     $20
        lxi     h,L0A50
        jnz     L09D9
        lxi     h,L0A1C
L09D9:
        jmp     L09F7
L09DC:
        mov     b,a
        lda     L21A7
        ani     $20
        mov     a,b
        rz
        cpi     $28
        lxi     d,L20FD
        jz      L0C32
        cpi     $29
        jz      L0C31
        cpi     $23
        lxi     h,L0A7B
        rnz
L09F7:
        lxi     d,L21B9
        xra     a
        stax    d
        lda     L207E
L09FF:
        mov     c,a
L0A00:
        xra     a
        add     m
        rz
        inx     h
        cmp     c
        jz      L0A0D
        inx     h
        inx     h
        jmp     L0A00
L0A0D:
        stax    d
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        xra     a
        pchl
L0A14:
        pop     h
L0A15:
        lxi     h,L05E6
L0A18:
        shld    L2140
        ret
L0A1C:
        db      $41             ; 'A'
        db      $9b
        db      $0a
        db      $42             ; 'B'
        db      $9b
        db      $0a
        db      $43             ; 'C'
        db      $9b
        db      $0a
        db      $44             ; 'D'
        db      $9b
        db      $0a
        db      $46             ; 'F'
        db      $0a
        db      $0c
        db      $47             ; 'G'
        db      $0f
        db      $0c
        db      $48             ; 'H'
        db      $96
        db      $0a
        db      $49             ; 'I'
        db      $a3
        db      $0b
        db      $4a             ; 'J'
        db      $9b
        db      $0a
        db      $4b             ; 'K'
        db      $9b
        db      $0a
        db      $59             ; 'Y'
        db      $11
        db      $0b
        db      $5a             ; 'Z'
        db      $c6
        db      $0c
        db      $3d             ; '='
        db      $df
        db      $0b
        db      $3e             ; '>'
        db      $e5
        db      $0b
        db      $31             ; '1'
        db      $57             ; 'W'
        db      $0c
        db      $3c             ; '<'
        db      $eb
        db      $0b
        db      $5d             ; ']'
        db      $60             ; '`'
        db      $0d
        db      $00
L0A50:
        db      $63             ; 'c'
        db      $00
        db      $00
        db      $45             ; 'E'
        db      $52             ; 'R'
        db      $09
        db      $4d             ; 'M'
        db      $a3
        db      $0b
        db      $31             ; '1'
        db      $57             ; 'W'
        db      $0c
        db      $5b             ; '['
        db      $8e
        db      $0a
        db      $48             ; 'H'
        db      $df
        db      $0d
        db      $44             ; 'D'
        db      $55             ; 'U'
        db      $09
        db      $37             ; '7'
        db      $68             ; 'h'
        db      $0c
        db      $38             ; '8'
        db      $71             ; 'q'
        db      $0c
        db      $3d             ; '='
        db      $df
        db      $0b
        db      $3e             ; '>'
        db      $e5
        db      $0b
        db      $5a             ; 'Z'
        db      $c6
        db      $0c
        db      $4e             ; 'N'
        db      $46             ; 'F'
        db      $0c
        db      $4f             ; 'O'
        db      $46             ; 'F'
        db      $0c
        db      $00
L0A7B:
        db      $33             ; '3'
        db      $a8
        db      $12
        db      $34             ; '4'
        db      $ac
        db      $12
        db      $35             ; '5'
        db      $4a             ; 'J'
        db      $13
        db      $36             ; '6'
        db      $a4
        db      $12
        db      $37             ; '7'
        db      $60             ; '`'
        db      $0d
        db      $38             ; '8'
        db      $a7
        db      $0d
        db      $00
L0A8E:
        lxi     h,L16C2
        shld    L2140
        pop     h
        ret
        mvi     a,$48
        sta     L207E
        lxi     h,L0000
        shld    L2130
        pop     h
L0AA2:
        lxi     h,L0A15
        push    h
        lda     L207D
        ora     a
        rnz
        lxi     h,L0AD9
        call    L09F7
        lda     L21B9
        ora     a
        rnz
        lxi     h,L2130
        lda     L214B
        ora     a
        mov     e,a
        jnz     L0AC2
        inr     e
L0AC2:
        mov     a,m
        push    h
        push    d
        lxi     h,L0AF5
        mov     b,a
        call    L09F7
        pop     d
        pop     h
        lda     L21B9
        ora     a
        rz
        inx     h
        dcr     e
        jnz     L0AC2
        ret
L0AD9:
        db      $44             ; 'D'
        db      $1e
        db      $18
        db      $42             ; 'B'
        db      $07
        db      $18
        db      $43             ; 'C'
        db      $15
        db      $18
        db      $48             ; 'H'
        db      $53             ; 'S'
        db      $18
        db      $41             ; 'A'
        db      $fe
        db      $17
        db      $72             ; 'r'
        db      $a6
        db      $15
        db      $66             ; 'f'
        db      $53             ; 'S'
        db      $18
        db      $78             ; 'x'
        db      $df
        db      $12
        db      $79             ; 'y'
        db      $64             ; 'd'
        db      $08
        db      $00
L0AF5:
        db      $63             ; 'c'
        db      $c1
        db      $0c
        db      $71             ; 'q'
        db      $16
        db      $0c
        db      $6e             ; 'n'
        db      $03
        db      $0d
        db      $4a             ; 'J'
        db      $41             ; 'A'
        db      $15
        db      $4b             ; 'K'
        db      $fc
        db      $14
        db      $6c             ; 'l'
        db      $ed
        db      $13
        db      $6d             ; 'm'
        db      $7f
        db      $0c
        db      $68             ; 'h'
        db      $f2
        db      $13
        db      $67             ; 'g'
        db      $cf
        db      $0d
        db      $00
L0B11:
        lxi     h,L0B19
        shld    L2140
        pop     h
        ret
L0B19:
        mov     b,a
        cpi     $20
        jc      L08B2
        cpi     $1b
        lxi     h,L2151
        jnz     L0B2E
        lxi     h,L09AB
        shld    L2140
        ret
L0B2E:
        mov     a,m
        ora     a
        jnz     L0B42
        mvi     m,$01
        mov     a,b
        sui     $20
        sta     L2152
        lxi     h,L0B19
        shld    L2140
        ret
L0B42:
        mvi     m,$00
        mov     a,b
        sui     $20
        cpi     $50
        jnc     L0B4F
        sta     L20F8
L0B4F:
        call    L11BF
        lda     L2152
        inr     b
        cmp     b
        jnc     L0B5D
        sta     L20F9
L0B5D:
        call    L0A15
        jmp     L1636
L0B63:
        xra     a
        sta     L21A2
        call    L10AD
        mvi     c,$50
        call    L10F9
        call    L114C
        mvi     c,$50
        jmp     L0B89
L0B77:
        mvi     a,$01
        sta     L21A2
        call    L10AD
        mvi     c,$84
        call    L10F9
        call    L114C
        mvi     c,$84
L0B89:
        xra     a
        sta     L2155
        call    L11BF
        mov     a,b
        sta     L2156
        mov     a,c
        sta     L2050
        call    L0342
        call    L1848
        mvi     a,$01
        jmp     L0FAA
        lxi     h,L20F9
        lda     L2155
        mov     b,a
        mov     a,m
        cmp     b
        jz      L0BB8
        ora     a
        rz
        lxi     h,L20F9
        dcr     m
        jmp     L1636
L0BB8:
        lda     L21A6
        ani     $80
        jz      L0BD9
        mvi     c,$01
        call    L108E
        mvi     a,$ff
        sta     L21C3
        dcr     m
        call    L0FEB
L0BCE:
        lda     L21C3
        ora     a
        jnz     L0BCE
        sta     L20F4
        ret
L0BD9:
        call    L102D
        jmp     L1012
        lxi     h,L2178
        mvi     m,$01
        ret
        lxi     h,L2178
        mvi     m,$00
        ret
        lxi     h,L21A7
        mov     a,m
        ori     $20
        mov     m,a
L0BF2:
        lda     L21A8
        ani     $80
        mvi     h,$08
        jz      L0BFE
        mvi     h,$48
L0BFE:
        mov     l,h
        shld    L20FD
        shld    L20FF
        xra     a
        sta     L20FC
        ret
        mvi     h,$88
        jmp     L0C11
        mvi     h,$08
L0C11:
        mov     l,h
        shld    L20FD
        ret
        lxi     h,L2145
        mov     a,b
        ora     a
        jnz     L0C23
        mov     a,m
        ani     $f0
        mov     m,a
        ret
L0C23:
        sui     $05
        rp
        mov     b,a
        xra     a
        stc
L0C29:
        ral
        inr     b
        jnz     L0C29
        ora     m
        mov     m,a
        ret
L0C31:
        inx     d
L0C32:
        lda     L207E
        mov     b,a
        lxi     h,L0C4A
L0C39:
        inx     h
        inx     h
        mov     a,m
        ora     a
        rz
        cmp     b
        jnz     L0C39
        inx     h
        mov     a,m
        stax    d
        ret
L0C46:
        lxi     h,L20FC
        inr     m
L0C4A:
        inr     m
        ret
        db      $41             ; 'A'
        db      $48             ; 'H'
        db      $42             ; 'B'
        db      $08
        db      $30             ; '0'
        db      $88
        db      $31             ; '1'
        db      $00
        db      $32             ; '2'
        db      $80
        db      $00
L0C57:
        lxi     h,L2079
        mov     a,m
        ora     a
        jz      L0A14
        mvi     m,$81
        pop     h
L0C62:
        lxi     h,L05AD
        jmp     L0A18
        lxi     h,L2102
        lxi     d,L20F8
        jmp     L0C77
        lxi     h,L20F8
        lxi     d,L2102
L0C77:
        mvi     b,$0b
        call    L038B
        jmp     L1636
        lxi     h,L0C8A
        mov     a,b
        ora     a
        jz      L0C97
        jmp     L09FF
L0C8A:
        db      $01
        db      $a2
        db      $0c
        db      $04
        db      $a7
        db      $0c
        db      $05
        db      $b3
        db      $0c
        db      $07
        db      $bb
        db      $0c
        db      $00
L0C97:
        sta     L20FB
        lxi     h,L20FA
        mov     a,m
        ori     $f7
        mov     m,a
        ret
        mvi     a,$fb
        jmp     L0CB5
        lda     L21C8
        ora     a
        jnz     L0CBB
        mvi     a,$fd
        jmp     L0CB5
        mvi     a,$fe
L0CB5:
        lxi     h,L20FA
        ana     m
        mov     m,a
        ret
L0CBB:
        mvi     a,$80
        sta     L20FB
        ret
        lda     L2130
        ora     a
        rnz
        lxi     h,L2172
        mov     a,m
        ori     $04
        mov     m,a
        ret
        mvi     a,$fb
        call    L0DBF
        lda     L21A7
        ani     $20
        jnz     L0CE3
        mvi     m,$da
        dcx     h
        mvi     m,$2f
        jmp     L0EF3
L0CE3:
        mvi     m,$3f
        inx     h
        mvi     a,$31
        call    L0DB9
        in      $42
        mov     b,a
        cma
        ani     $06
        mov     c,a
        mov     a,b
        ani     $08
        jz      L0CF9
        inr     c
L0CF9:
        mov     a,c
        ori     $30
        mov     m,a
        inx     h
        mvi     m,$e3
        jmp     L0EF3
        lda     L21B8
        ora     a
        rnz
        mov     a,b
        lxi     h,L2172
        cpi     $06
        jz      L0D32
        cpi     $05
        rnz
        mov     a,m
        ori     $08
        mov     m,a
        ret
        mvi     a,$f7
        call    L0DBF
        mvi     b,$03
        lda     L21BD
        ora     a
        mov     a,b
        jnz     L0D29
        xra     a
L0D29:
        ori     $30
        mov     m,a
        inx     h
        mvi     m,$ee
L0D2F:
        jmp     L0EF3
L0D32:
        mov     a,m
        ori     $01
        mov     m,a
        ret
        mvi     a,$fe
        call    L0DBF
        lda     L20F9
        mov     b,a
        lda     L2101
        ora     a
        jz      L0D4A
        lda     L2155
L0D4A:
        mov     c,a
        mov     a,b
        sub     c
        inr     a
        call    L0D7A
        call    L0DBB
        lda     L20F8
        inr     a
        call    L0D7A
        mvi     m,$d2
        jmp     L0EF3
        in      $42
        ani     $04
        rnz
        mvi     c,$81
        call    L108E
        mvi     a,$ff
        out     $e2
        nop
L0D6F:
        call    L1488
        in      $42
        ani     $04
        jnz     L0D6F
        ret
L0D7A:
        mov     e,a
        mvi     d,$30
        mvi     c,$64
        call    L0D99
        jz      L0D88
        mov     m,a
        inx     h
        dcr     d
L0D88:
        mvi     c,$0a
        call    L0D99
        jz      L0D93
        dcr     d
        mov     m,a
        inx     h
L0D93:
        mov     a,e
        ori     $30
        mov     m,a
        inx     h
        ret
L0D99:
        mov     a,e
        mvi     b,$30
L0D9C:
        inr     b
        sub     c
        jp      L0D9C
        add     c
        dcr     b
        mov     e,a
        mov     a,b
        cmp     d
        ret
        mvi     a,$45
        sta     L21C7
        call    L0381
        mvi     a,$45
        sta     L20F4
        xra     a
        sta     L21C7
        ret
L0DB9:
        mov     m,a
        inx     h
L0DBB:
        mvi     m,$3b
        inx     h
        ret
L0DBF:
        lxi     h,L2172
        ana     m
        mov     m,a
        lxi     h,L215C
        mvi     m,$1b
        inx     h
        mvi     m,$5b
        inx     h
        ret
        mov     b,d
        mov     a,b
        ora     a
        jnz     L0DD8
        call    L0DE5
        ret
L0DD8:
        cpi     $03
        rnz
        call    L0DEC
        ret
        call    L0E23
        ora     m
        mov     m,a
        ret
L0DE5:
        call    L0E23
        cma
        ana     m
        mov     m,a
        ret
L0DEC:
        lxi     h,L2191
L0DEF:
        xra     a
        mov     m,a
        inx     h
        mov     a,l
        cpi     $a2
        jnz     L0DEF
        ret
L0DF9:
        call    L0E23
L0DFC:
        inr     c
        ora     a
        rar
        jc      L0E0B
L0E02:
        mov     d,a
        ana     m
        mov     a,d
        jz      L0DFC
        jmp     L0E15
L0E0B:
        inx     h
        mov     a,l
        cpi     $a2
        mvi     a,$80
        jnz     L0E02
        dcr     c
L0E15:
        lda     L2153
        cmp     c
        jc      L0E1D
        mov     a,c
L0E1D:
        sta     L20F8
        jmp     L1636
L0E23:
        lda     L20F8
        mov     c,a
L0E27:
        mov     d,a
        lxi     h,L2191
L0E2B:
        rrc
        rrc
        rrc
        ani     $1f
        add     l
        mov     l,a
        mov     a,d
        ani     $07
        mov     d,a
        mvi     a,$80
L0E38:
        dcr     d
        rm
        rrc
        jmp     L0E38
L0E3E:
        lda     L21A5
        lxi     h,L207B
        ora     m
        mov     b,a
        rnz
L0E47:
        in      $42
        ani     $01
        rz
        lxi     h,L21C1
        mov     a,m
        ora     a
        mvi     m,$00
        dcx     h
        rz
        mov     a,m
        out     $00
        ret
L0E59:
        di
        call    L0E3E
        ei
        mov     a,b
        ora     a
        jnz     L0E6D
        in      $42
        ani     $01
        rz
        lda     L21C2
        ora     a
        rnz
L0E6D:
        lxi     h,L2173
        mov     a,m
        ora     a
        jz      L0E79
        lhld    L2174
        pchl
L0E79:
        lda     L2172
        ora     a
        rz
        mvi     e,$00
L0E80:
        rar
        jc      L0E89
        inr     e
        inr     e
        jmp     L0E80
L0E89:
        mvi     d,$00
        lxi     h,L0E94
        dad     d
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        pchl
L0E94:
        db      $37             ; '7'
        db      $0d
        db      $f0
        db      $12
        db      $ce
        db      $0c
        db      $19
        db      $0d
        db      $13
        db      $09
        db      $a0
        db      $0e
L0EA0:
        lxi     h,L205C
        mov     b,m
        mov     d,h
        mov     e,l
        inx     d
        mvi     c,$08
L0EA9:
        ldax    d
        mov     m,a
        inx     h
        inx     d
        dcr     c
        jnz     L0EA9
        lxi     h,L2143
        dcr     m
        mov     a,m
        mov     c,a
        jnz     L0EC1
        lxi     h,L2172
        mov     a,m
        ani     $df
        mov     m,a
L0EC1:
        lda     L21A5
        ora     a
        jnz     L0ECF
        mov     a,c
        cpi     $05
        jnc     L0ED2
        xra     a
L0ECF:
        sta     L2144
L0ED2:
        mov     a,b
        ani     $80
        ral
        cmc
        rar
        sta     L2173
        lxi     h,L0EA0
        shld    L2174
L0EE1:
        mov     a,b
        ani     $7f
        mov     b,a
        lda     L21A5
        lxi     h,L207B
        ora     m
        mov     a,b
        jnz     L0593
        out     $00
        ret
L0EF3:
        lxi     h,L0F01
        shld    L2174
        xra     a
        sta     L2171
        inr     a
        sta     L2173
L0F01:
        lxi     h,L2171
        mov     a,m
        inr     m
        lxi     h,L215C
        add     l
        mov     l,a
        mov     b,m
        mov     a,b
        ora     a
        jp      L0EE1
        xra     a
        sta     L2173
        jmp     L0EE1
L0F18:
        push    h
        push    d
        mov     d,a
        lda     L21A7
        ani     $10
        jz      L0F2B
        mov     a,d
        sui     $91
        ani     $fd
        jz      L0F61
L0F2B:
        lxi     h,L2172
        mov     a,m
        ori     $20
        mov     m,a
L0F32:
        lxi     h,L2143
        mov     a,m
        inr     m
        lxi     h,L205C
        mov     e,a
        add     l
        mov     l,a
        mov     m,d
        mvi     a,$8d
        cmp     d
        jnz     L0F4E
        lda     L21A8
        ani     $20
        mvi     d,$8a
        jnz     L0F32
L0F4E:
        lda     L21A5
        ora     a
        jnz     L0F5B
        mvi     a,$05
        cmp     e
        mvi     a,$00
        rar
L0F5B:
        sta     L2144
L0F5E:
        pop     d
        pop     h
        ret
L0F61:
        mov     a,d
        ani     $7f
        mov     d,a
        lxi     h,L21C1
        mov     a,m
        ora     a
        jnz     L0F75
        dcx     h
        mov     a,m
        cmp     d
        jnz     L0F75
        inx     h
        mov     m,d
L0F75:
        mov     c,d
        mvi     b,$02
        call    L0F7E
        jmp     L0F5E
L0F7E:
        lda     L21A7
        ani     $10
        rz
        lda     L21A5
        ora     a
        rnz
        mov     a,c
        lxi     h,L21BF
        cpi     $13
        mov     a,b
        jz      L0F9E
        cma
        ana     m
        mov     m,a
        push    psw
        ani     $02
        sta     L21C4
        pop     psw
        rnz
L0F9E:
        ora     m
        mov     m,a
        mov     a,c
        lxi     h,L21C0
        cmp     m
        rz
        mov     m,a
        inx     h
        mov     m,a
        ret
L0FAA:
        lxi     h,L207F
        add     m
L0FAE:
        cmp     m
        rz
        push    h
        push    psw
L0FB2:
        lda     L207B
        ora     a
        cz      L1488
        pop     psw
        pop     h
        jmp     L0FAE
L0FBE:
        lhld    L204E
        mov     a,h
        ori     $f0
        mov     h,a
        shld    L204E
L0FC8:
        lda     L2050
L0FCB:
        mov     b,a
        mov     a,h
        ani     $0f
        ori     $20
        mov     h,a
        adi     $10
        mov     d,a
        mov     e,l
        mvi     a,$ff
L0FD8:
        mvi     m,$00
        stax    d
        inx     d
        inx     h
        dcr     b
        jnz     L0FD8
        inr     a
        sta     L21C3
        ret
L0FE6:
        mvi     b,$ff
        jmp     L0FED
L0FEB:
        mvi     b,$01
L0FED:
        lxi     h,L2155
        mov     d,m
        inx     h
        mov     e,m
        mov     a,b
        ora     a
        mov     a,d
        jp      L0FFA
        mov     a,e
L0FFA:
        call    L13E6
        mov     a,e
        sub     d
L0FFF:
        mov     c,a
L1000:
        lda     L212B
L1003:
        mov     d,m
        mov     m,a
        mov     a,b
        add     l
        mov     l,a
        dcr     c
        mov     a,d
        jp      L1003
        ani     $7f
        sta     L212B
L1012:
        mvi     a,$ff
        sta     L210E
        jmp     L1636
L101A:
        call    L1191
        lda     L2156
        call    L122F
        call    L0FE6
        lda     L2155
        dcr     a
        jmp     L103E
L102D:
        call    L1191
        lda     L2155
        dcr     a
        call    L122F
        call    L0FEB
        lda     L2156
        dcr     a
L103E:
        call    L11CE
        ei
        sta     L207A
        lxi     h,L2156
        mov     a,m
        dcx     h
        sub     m
        cpi     $17
        rnz
L104E:
        lxi     h,L207A
        mov     a,m
        mvi     m,$00
        ora     a
        rz
        lhld    L2056
        xchg
        lhld    L2058
        mov     m,d
        inx     h
        mov     m,e
        lhld    L2179
        xchg
        lhld    L2075
        mov     m,d
        inx     h
        mov     m,e
L106A:
        lxi     h,L2056
        shld    L2058
        shld    L2075
        ret
L1074:
        call    L13E3
        ani     $80
        sta     L2157
        call    L138D
        shld    L214E
        ret
L1083:
        mov     m,b
        inx     h
        dcx     d
        mov     a,d
        ora     e
        jnz     L1083
        ret
        mvi     c,$00
L108E:
        lxi     h,L2051
        di
        lda     L2065
        ora     m
        ei
        jz      L10A7
        mov     a,c
        rar
        push    b
        cc      L1488
        call    L1493
        pop     b
        jmp     L108E
L10A7:
        mov     a,c
        ral
        rnc
        jmp     L1191
L10AD:
        lxi     h,L0670
        shld    L2004
        xra     a
        sta     L2051
        sta     L2065
        sta     L205A
        out     $a2
        mvi     a,$04
        out     $a2
        call    L106A
        ei
        mvi     a,$01
        call    L0FAA
        lxi     h,L22D0
        mov     a,h
        adi     $10
        mov     d,a
        mov     e,l
        lxi     b,L0D2F
L10D7:
        lda     L21C7
        mov     m,a
        inx     h
        mvi     a,$ff
        stax    d
        inx     d
        dcx     b
        mov     a,b
        ora     c
        jnz     L10D7
        lda     L21C7
        sta     L20F4
        xra     a
        sta     L20F9
        sta     L20F8
        mvi     a,$ff
        sta     L20F5
        ret
L10F9:
        xra     a
        sta     L2051
L10FD:
        lda     L2065
        ora     a
        jnz     L10FD
        lxi     h,L22D0
        mvi     b,$00
        dad     b
        call    L11BF
        inr     c
        call    L1136
        push    h
        mvi     b,$01
        call    L1136
        pop     h
        mvi     m,$7f
        inx     h
        shld    L2054
        mvi     m,$70
        inx     h
        mvi     m,$06
        mov     a,c
        call    L13DE
        mvi     m,$7f
        dcr     c
        mvi     a,$03
        sta     L2002
        lxi     h,LD0F2
        shld    L2004
        ret
L1136:
        mvi     m,$7f
        inx     h
        mov     d,h
        mov     e,l
        inx     d
        inx     d
        mov     a,d
        ori     $f0
        mov     m,a
        inx     h
        mov     m,e
        mov     a,c
        call    L13DE
        dcr     b
        jnz     L1136
        ret
L114C:
        lxi     h,L20C2
        inr     c
        inr     c
        inr     c
        lxi     d,L22D0
        mvi     b,$00
        mvi     a,$19
L1159:
        mov     m,e
        inx     h
        mov     m,d
        inx     h
        xchg
        dad     b
        xchg
        dcr     a
        jnz     L1159
        sta     L2155
        call    L11BF
        mov     a,b
        sta     L2156
        inr     a
        sta     L212B
        lhld    L20F2
        mvi     a,$17
        cmp     b
        jz      L117E
        lhld    L20DE
L117E:
        mov     a,h
        ori     $f0
        mov     h,a
        shld    L204E
        lxi     h,L2113
        xra     a
L1189:
        mov     m,a
        inr     l
        inr     a
        dcr     b
        jp      L1189
        ret
L1191:
        di
        lda     L207A
        ora     a
        jz      L11A0
L1199:
        ei
        call    L1488
        jmp     L1191
L11A0:
        lda     L2065
        ora     a
        jnz     L11B0
        lda     L2051
        ora     a
        ei
        rz
        jmp     L1199
L11B0:
        lda     L205B
        lxi     h,L205A
        add     m
        daa
        ani     $0f
        jz      L1199
        ei
        ret
L11BF:
        push    h
        mvi     b,$17
        lda     L21A2
        lxi     h,L21C8
        ana     m
        pop     h
        rz
        mvi     b,$0d
        ret
L11CE:
        ora     a
        jp      L11E8
        lxi     h,L2004
        push    h
        mov     a,m
        inx     h
        mov     l,m
        ori     $f0
        mov     h,a
        shld    L204E
        call    L1290
        pop     h
        mov     b,d
        mov     c,e
        jmp     L120A
L11E8:
        call    L127F
        call    L1290
        push    h
        push    d
        xchg
        call    L1290
        mov     b,d
        mov     c,e
        pop     d
        mov     a,d
        ori     $f0
        mov     h,a
        mov     l,e
        shld    L204E
        pop     h
        mov     a,h
        ori     $9f
        inr     a
        jnz     L1211
        call    L1299
L120A:
        di
        shld    L2075
        jmp     L1228
L1211:
        call    L129D
        lda     L2050
        rrc
        mov     d,a
        call    L13DE
        inx     h
        di
        shld    L2075
        mov     a,d
        call    L13DE
        mov     m,b
        inx     h
        mov     m,c
L1228:
        mov     h,b
        mov     l,c
        shld    L2179
        ei
        ret
L122F:
        push    psw
        call    L0FBE
        pop     psw
        ora     a
        lxi     h,L2004
        jm      L1248
        call    L127F
        mov     a,h
        ori     $9f
        inr     a
        jnz     L1252
        call    L1299
L1248:
        di
        shld    L2058
        mov     b,m
        inx     h
        mov     c,m
        jmp     L1271
L1252:
        call    L129D
        lda     L2050
        rrc
        mov     b,a
        call    L13DE
        inx     h
        di
        shld    L2058
        mov     a,b
        mov     b,m
        inx     h
        mov     c,m
        call    L13DE
        xchg
        lhld    L204E
        xchg
        mov     m,e
        dcx     h
        mov     m,d
L1271:
        lhld    L204E
        shld    L2056
        call    L1299
        mov     m,b
        inx     h
        mov     m,c
        ei
        ret
L127F:
        inr     a
        mov     b,a
        lxi     h,L2004
L1284:
        mov     a,m
        inx     h
        mov     l,m
        mov     h,a
        dcr     b
        rz
        call    L1299
        jmp     L1284
L1290:
        push    h
        call    L1299
        mov     d,m
        inx     h
        mov     e,m
        pop     h
        ret
L1299:
        call    L13DB
        inx     h
L129D:
        mov     a,h
        ani     $0f
        ori     $20
        mov     h,a
        ret
        call    L12B0
        mov     d,b
        call    L12B0
        db      $30             ; '0'
        call    L12B0
        db      $10
L12B0:
        call    L1191
        lxi     h,L2113
        lda     L20F9
        add     l
        mov     l,a
        mov     a,m
        ori     $80
        mov     m,a
        call    L138D
        call    L13C3
        pop     h
        mov     a,m
        call    L1395
        lda     L2153
        lxi     h,L20F8
        ora     a
        rar
        cmp     m
        jnc     L1012
        lxi     h,L20F4
        shld    L20F6
        jmp     L1012
        lda     L2130
        cpi     $02
        rnc
        sta     L2176
L12E8:
        lxi     h,L2172
        mov     a,m
        ori     $02
        mov     m,a
        ret
        mvi     a,$fd
        call    L0DBF
        lda     L2176
        ori     $32
        call    L0DB9
        lda     L21A9
        push    psw
        ani     $c0
        ori     $18
        add     a
        inr     a
        jp      L1310
        rar
        rlc
        ori     $04
        ani     $7f
L1310:
        call    L0DB9
        mvi     b,$31
        pop     psw
        ani     $20
        jnz     L131C
        inr     b
L131C:
        mov     a,b
        call    L0DB9
        lda     L21AB
        rrc
        call    L0D7A
        call    L0DBB
        lda     L21AC
        rrc
        call    L0D7A
        call    L0DBB
        mvi     a,$31
        call    L0DB9
        lda     L21AA
        ani     $f0
        rrc
        rrc
        rrc
        rrc
        call    L0D7A
        mvi     m,$f8
        jmp     L0EF3
L134A:
        lxi     h,L2157
        mov     a,m
        ora     a
        rz
        call    L1191
        lxi     h,L2113
        lda     L20F9
        add     l
        mov     l,a
        mov     a,m
        ani     $7f
        mov     m,a
        call    L138D
        lda     L2050
        rrc
        mov     b,a
        call    L13DE
        xra     a
L136B:
        mov     m,a
        inx     h
        dcr     b
        jnz     L136B
        mvi     a,$f0
        sta     L210E
        call    L1395
        xra     a
        sta     L2157
        jmp     L1636
L1380:
        lda     L20F9
        call    L13E6
L1386:
        lxi     h,L20C2
        add     a
        add     l
        mov     l,a
        ret
L138D:
        call    L1380
L1390:
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        ret
L1395:
        ani     $70
        mov     b,a
        lda     L20F9
        dcr     a
        lxi     h,L2004
        jm      L13BD
        call    L13E6
        mov     d,a
        ani     $7f
        call    L1386
        call    L1390
        lda     L2050
        rrc
        mov     e,a
        inx     h
        inr     d
        dcr     d
        mvi     d,$00
        dad     d
        cm      L13BD
        dad     d
L13BD:
        mov     a,m
        ani     $8f
        ora     b
        mov     m,a
        ret
L13C3:
        lda     L2050
        rrc
        mov     d,h
        mov     e,l
        call    L13DE
        xchg
        call    L13DB
        mvi     b,$03
L13D2:
        mov     a,m
        stax    d
        inx     d
        inx     h
        dcr     b
        jnz     L13D2
        ret
L13DB:
        lda     L2050
L13DE:
        add     l
        mov     l,a
        rnc
        inr     h
        ret
L13E3:
        lda     L20F9
L13E6:
        lxi     h,L2113
        add     l
        mov     l,a
        mov     a,m
        ret
        mvi     c,$00
        jmp     L13F4
        mvi     c,$ff
L13F4:
        lda     L21B8
        ora     a
        lxi     h,L1426
        jz      L1404
        cpi     $3f
        rnz
        lxi     h,L140A
L1404:
        mov     a,b
        mov     b,c
        call    L09FF
        ret
L140A:
        db      $01
        db      $2a             ; '*'
        db      $14
        db      $02
        db      $2f             ; '/'
        db      $14
        db      $03
        db      $57             ; 'W'
        db      $14
        db      $04
        db      $47             ; 'G'
        db      $14
        db      $05
        db      $4e             ; 'N'
        db      $14
        db      $06
        db      $3f             ; '?'
        db      $14
        db      $07
        db      $66             ; 'f'
        db      $14
        db      $08
        db      $5f             ; '_'
        db      $14
        db      $09
        db      $6d             ; 'm'
        db      $14
        db      $00
L1426:
        db      $14
        db      $38             ; '8'
        db      $14
        db      $00
L142A:
        lxi     h,L21BC
        mov     m,b
        ret
        call    L1476
        db      $a7
        db      $21             ; '!'
        db      $20             ; ' '
L1435:
        jmp     L0BF2
        call    L1476
        db      $a8
        db      $21             ; '!'
        db      $20             ; ' '
L143E:
        ret
        lxi     h,L2101
        mov     m,b
        call    L1848
        ret
        call    L1476
        db      $a6
        db      $21             ; '!'
        db      $80
L144D:
        ret
        call    L1476
        db      $a6
        db      $21             ; '!'
        db      $20             ; ' '
L1454:
        jmp     L036B
        lxi     h,L21A2
        mov     m,b
        call    L0381
        ret
        call    L1476
        db      $a6
        db      $21             ; '!'
        db      $40             ; '@'
L1465:
        ret
        call    L1476
        db      $a8
        db      $21             ; '!'
        db      $40             ; '@'
L146C:
        ret
        call    L1476
        db      $a8
        db      $21             ; '!'
        db      $10
L1473:
        jmp     L0342
L1476:
        pop     h
        mov     e,m
        inx     h
        mov     d,m
        inx     h
        mov     a,m
        inx     h
        xchg
        mov     c,a
        cma
        ana     m
        mov     m,a
        mov     a,b
        ana     c
        ora     m
        mov     m,a
        xchg
        pchl
L1488:
        call    L1493
        ani     $10
        cz      L06AA
        jmp     L0E59
L1493:
        in      $42
        ani     $80
        rz
        lxi     h,L2144
        mov     a,m
        ora     a
        jz      L14A2
        mvi     a,$10
L14A2:
        lxi     h,L21A5
        ora     m
        lxi     h,L2145
        ora     m
        inx     h
        ora     m
        inx     h
        ora     m
        mvi     m,$00
        inx     h
        ora     m
        mvi     m,$00
        out     $82
        lxi     h,L2074
        inr     m
        lda     L2077
        ora     a
        rnz
        lda     L2065
        lxi     h,L2051
        ora     m
        rnz
        lhld    L212D
        dcx     h
        mov     a,h
        ora     l
        jz      L14D4
        shld    L212D
        ret
L14D4:
        lda     L21BA
        xri     $ff
        sta     L21BA
        lxi     h,L0212
        jnz     L14E5
        lxi     h,L0109
L14E5:
        shld    L212D
        lhld    L20F6
        mov     b,m
        lda     L2159
        xra     b
        mov     m,a
        lxi     d,L1000
        dad     d
        lda     L215A
        xra     m
        mov     m,a
        ret
        mov     m,h
        mov     a,b
        ora     a
        jz      L1515
        dcr     a
        jz      L150A
        dcr     a
        rnz
        call    L1515
L150A:
        lda     L20F8
        mov     b,a
        inr     b
        lhld    L214E
        jmp     L1529
L1515:
        lda     L20F8
        mov     b,a
        lda     L2157
        ora     a
        lda     L2050
        jz      L1524
        rrc
L1524:
        sub     b
        mov     b,a
        lhld    L20F6
L1529:
        mov     a,h
        adi     $10
        mov     d,a
        mov     e,l
        mvi     a,$ff
L1530:
        stax    d
        mvi     m,$00
        inx     h
        inx     d
        dcr     b
        jnz     L1530
        sta     L20F5
        xra     a
        sta     L20F4
        ret
        mov     a,b
        ora     a
        jz      L156A
        dcr     a
        jz      L1555
        dcr     a
        rnz
        call    L1555
        call    L156A
        jmp     L134A
L1555:
        lxi     h,L20F9
        mov     a,m
        push    psw
        mov     b,a
        xra     a
        mov     m,a
        mvi     c,$ff
        call    L1586
        pop     psw
        mov     m,a
        call    L1074
        jmp     L150A
L156A:
        lda     L20F8
        ora     a
        cz      L134A
        call    L1515
        lxi     h,L20F9
        mov     a,m
        push    psw
        mov     c,a
        mvi     a,$17
        sub     c
        mov     b,a
        call    L1586
        pop     psw
        mov     m,a
        jmp     L1074
L1586:
        dcr     b
        rm
        inr     c
        mov     m,c
        push    b
        push    h
        call    L13E3
        ani     $7f
        mov     m,a
        mvi     a,$70
        call    L1395
        call    L1074
        lda     L2050
        mov     b,a
        call    L1529
        pop     h
        pop     b
        jmp     L1586
        mvi     c,$81
        call    L108E
        call    L11BF
        lda     L2130
        ora     a
        jz      L15B6
        dcr     a
L15B6:
        mov     d,a
        lda     L2131
        ora     a
        jnz     L15C0
        mov     a,b
        inr     a
L15C0:
        dcr     a
        mov     e,a
        mov     a,b
        cmp     e
        rc
        mov     a,d
        cmp     e
        rnc
        lxi     h,L2155
        mov     m,d
        inx     h
        mov     m,e
        mov     c,e
        mov     b,d
        mov     a,c
        sub     b
        inr     a
        mov     e,a
        lxi     h,L2004
        mov     a,b
        ora     a
        jz      L15E8
        mov     d,b
L15DD:
        mov     a,m
        ani     $7f
        mov     m,a
        call    L162B
        dcr     d
        jnz     L15DD
L15E8:
        mov     a,m
        ori     $80
        mov     m,a
        call    L162B
        dcr     e
        jnz     L15E8
        mvi     a,$17
        sub     c
        jz      L1605
        mov     d,a
L15FA:
        mov     a,m
        ani     $7f
        mov     m,a
        call    L162B
        dcr     d
        jnz     L15FA
L1605:
        mov     a,b
        sta     L2155
        mov     a,c
        sta     L2156
        lxi     h,L2113
        mvi     c,$18
L1612:
        mov     a,m
        ora     a
        jp      L1623
        push    h
        call    L1386
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        call    L13C3
        pop     h
L1623:
        inx     h
        dcr     c
        jnz     L1612
        jmp     L1848
L162B:
        inx     h
        mov     l,m
        ani     $0f
        ori     $20
        mov     h,a
        inx     h
        jmp     L13DB
L1636:
        lxi     h,L000D
        shld    L212D
        xra     a
        sta     L21BA
        lhld    L20F6
        lda     L20F4
        mov     b,a
        mov     m,a
        mov     a,h
        adi     $10
        mov     h,a
        lda     L20F5
        mov     m,a
        lda     L2050
        dcr     a
        mov     e,a
        lda     L207B
        ora     a
        jnz     L167B
        lda     L20F9
        lxi     h,L210E
        cmp     m
        jz      L167F
        mov     m,a
        call    L1074
        xra     a
        sta     L2154
        lxi     h,L2157
        mov     a,m
        ora     a
        jz      L167B
        mov     a,e
        dcr     a
        ora     a
        rar
        mov     e,a
L167B:
        mov     a,e
        sta     L2153
L167F:
        lxi     h,L2153
        lxi     d,L20F8
        ldax    d
        cmp     m
        jc      L168C
        mov     a,m
        stax    d
L168C:
        lda     L21BB
        adi     $08
        sub     m
        jnz     L16A1
        inx     h
        ora     m
        jz      L16A1
        call    L0938
        xra     a
        sta     L2154
L16A1:
        lda     L20F8
        sta     L21BB
        lhld    L214E
        call    L13DE
        shld    L20F6
        mov     a,m
        sta     L20F4
        mov     b,a
        mov     a,h
        adi     $10
        mov     h,a
        mov     a,m
        sta     L20F5
        lhld    L20F6
        mov     m,b
        ret
L16C2:
        mov     b,a
        lxi     h,L16F1
        shld    L2140
        xra     a
        sta     L212F
        sta     L214B
        sta     L207D
        lxi     h,L2130
        mvi     c,$0f
        xra     a
L16D9:
        mov     m,a
        inx     h
        dcr     c
        jnz     L16D9
        lxi     h,L21B8
        mvi     m,$00
        mov     a,b
        cpi     $40
        jnc     L16F2
        cpi     $3c
        jc      L16F2
        mov     m,a
        ret
L16F1:
        mov     b,a
L16F2:
        mov     a,b
        cpi     $3a
        jnc     L1717
        sui     $30
        jm      L1717
        mov     c,a
        lxi     h,L212F
        mov     a,m
        cpi     $1a
        jnc     L1713
        rlc
        mov     b,a
        rlc
        rlc
        add     b
        jc      L1713
        add     c
        jnc     L1715
L1713:
        mvi     a,$ff
L1715:
        mov     m,a
        ret
L1717:
        lxi     d,L2130
        push    psw
        lxi     h,L214B
        mov     c,m
        mvi     b,$00
        xchg
        dad     b
        lxi     b,L212F
        ldax    b
        mov     m,a
        xra     a
        stax    b
        ldax    d
        cpi     $0f
        jz      L1732
        inr     a
        stax    d
L1732:
        pop     psw
L1733:
        mov     b,a
        cpi     $3b
        rz
        ani     $c0
        mov     a,b
        jz      L1743
        sta     L207E
        jmp     L0AA2
L1743:
        lxi     h,L207D
        add     m
        jnc     L174C
        mvi     a,$ff
L174C:
        mov     m,a
        lxi     h,L1733
        shld    L2140
        ret
L1754:
        mvi     d,$00
        mvi     b,$01
        jmp     L1762
L175B:
        call    L02C0
        mvi     b,$0a
        mvi     d,$01
L1762:
        push    b
        push    d
        call    L17BE
        pop     d
        di
        lxi     h,L217B
        mvi     e,$33
        mvi     c,$01
        xra     a
L1771:
        sta     L21AE
        mov     a,c
        sta     L21AD
        push    d
        push    h
        mov     a,d
        ora     a
        mov     a,m
        sta     L21AF
        cz      L18AE
        call    L18A3
        pop     h
        pop     d
        lda     L21AF
        dcr     e
        jz      L179E
        mov     m,a
        lda     L21AD
        rlc
        xra     m
        mov     c,a
        inx     h
        lda     L21AE
        inr     a
        jmp     L1771
L179E:
        cmp     m
        pop     b
        mvi     c,$00
        jz      L17AC
        dcr     b
        jnz     L1762
        call    L17D0
L17AC:
        mov     a,c
        ora     a
        push    psw
        mvi     c,$40
        mvi     a,$63
        call    L192B
        lxi     h,LD0F2
        shld    L2004
        pop     psw
        ret
L17BE:
        lxi     d,L17EC
        mvi     b,$07
        lxi     h,L21CC
        call    L038B
        lxi     h,LCC71
        shld    L2004
        ret
L17D0:
        lxi     h,L217B
        mvi     b,$27
L17D5:
        mvi     m,$80
        inx     h
        dcr     b
        jnz     L17D5
        lxi     d,L17F3
        mvi     b,$0b
        call    L038B
        mvi     c,$01
        mvi     a,$30
        sta     L2078
        ret
L17EC:
        db      $57             ; 'W'
        db      $61             ; 'a'
        db      $69             ; 'i'
        db      $74             ; 't'
        db      $7f
        db      $70             ; 'p'
        db      $06
L17F3:
        db      $00
        db      $08
        db      $6e             ; 'n'
        db      $20             ; ' '
        db      $d0
        db      $50             ; 'P'
        db      $00
        db      $20             ; ' '
        db      $00
        db      $e0
        db      $e0
L17FE:
        lda     L2155
        lxi     b,L00FF
        jmp     L180F
        call    L11BF
        lda     L2156
        mvi     c,$01
L180F:
        lxi     h,L20F9
        jmp     L1825
L1815:
        lda     L2153
        lxi     b,LFF01
        jmp     L1822
L181E:
        xra     a
        lxi     b,L00FF
L1822:
        lxi     h,L20F8
L1825:
        mov     d,a
        lda     L21B8
        ora     a
        jnz     L0A15
        lda     L2130
        ora     a
        jnz     L1835
        inr     a
L1835:
        mov     e,a
        mov     a,m
L1837:
        cmp     d
        jz      L1844
        cmp     b
        jz      L1844
        add     c
        dcr     e
        jnz     L1837
L1844:
        mov     m,a
        jmp     L1636
L1848:
        lxi     h,L0000
        shld    L2130
        mvi     a,$ff
        sta     L210E
        lda     L2101
        mov     c,a
        lxi     h,L2130
        mov     a,m
        ora     a
        jz      L1860
        dcr     a
L1860:
        mov     b,a
        mov     a,c
        ora     a
        jz      L1869
        lda     L2155
L1869:
        add     b
        mov     b,a
        mov     a,c
        ora     a
        lda     L2156
        jnz     L1879
        mov     c,b
        call    L11BF
        mov     a,b
        mov     b,c
L1879:
        cmp     b
        jc      L187E
        mov     a,b
L187E:
        sta     L20F9
        inx     h
        mov     a,m
        ora     a
        jz      L1888
        dcr     a
L1888:
        mov     b,a
        mov     a,c
        ora     a
        jnz     L1895
        lda     L2050
        dcr     a
        jmp     L1898
L1895:
        lda     L2153
L1898:
        cmp     b
        jc      L189D
        mov     a,b
L189D:
        sta     L20F8
        jmp     L1636
L18A3:
        mvi     c,$40
        call    L1928
        call    L18C1
        jmp     L18BC
L18AE:
        mvi     c,$40
        call    L1928
        call    L19A8
        call    L1977
        call    L19D6
L18BC:
        mvi     a,$30
        out     $62
        ret
L18C1:
        in      $42
        ana     c
        jz      L18C1
L18C7:
        in      $42
        ana     c
        jnz     L18C7
        mvi     a,$2d
        out     $62
L18D1:
        in      $42
        ana     c
        jz      L18D1
L18D7:
        in      $42
        ana     c
        jnz     L18D7
        mvi     a,$2f
        out     $62
        lxi     h,L21D3
        mvi     b,$0e
L18E6:
        in      $42
        ana     c
        jz      L18E6
L18EC:
        in      $42
        ana     c
        jnz     L18EC
        mvi     a,$25
        out     $62
L18F6:
        in      $42
        ana     c
        jz      L18F6
        in      $42
        mov     m,a
        inx     h
L1900:
        in      $42
        ana     c
        jnz     L1900
        dcr     b
        jnz     L18F6
        mvi     a,$2f
        out     $62
        lxi     d,L21D3
        mvi     b,$0e
        lxi     h,L0000
L1916:
        dad     h
        ldax    d
        ani     $20
        rlc
        rlc
        rlc
        ora     l
        mov     l,a
        inx     d
        dcr     b
        jnz     L1916
        shld    L21AF
        ret
L1928:
        lda     L21AE
L192B:
        mvi     b,$ff
L192D:
        inr     b
        sui     $0a
        jp      L192D
        adi     $0a
        lxi     h,L21D3
        mvi     e,$23
        mvi     d,$14
L193C:
        mov     m,e
        inx     h
        dcr     d
        jnz     L193C
        mvi     m,$2f
        lxi     h,L21D3
        mov     e,a
        mvi     d,$00
        dad     d
        mvi     m,$22
        lxi     h,L21D3
        mvi     a,$0a
        add     b
        mov     e,a
        dad     d
        mvi     m,$22
L1957:
        in      $42
        ana     c
        jnz     L1957
        lxi     h,L21D3
        mvi     b,$15
L1962:
        in      $42
        ana     c
        jz      L1962
        dcr     b
        rm
L196A:
        in      $42
        ana     c
        jnz     L196A
        mov     a,m
        out     $62
        inx     h
        jmp     L1962
L1977:
        lhld    L21AF
        dad     h
        dad     h
        lxi     d,L21D3
        mvi     b,$0e
L1981:
        mvi     a,$20
        dad     h
        ral
        stax    d
        inx     d
        dcr     b
        jnz     L1981
        mvi     a,$2f
        stax    d
        lxi     h,L21D3
        mvi     b,$0f
L1993:
        in      $42
        ana     c
        jz      L1993
L1999:
        in      $42
        ana     c
        jnz     L1999
        mov     a,m
        out     $62
        inx     h
        dcr     b
        jnz     L1993
        ret
L19A8:
        in      $42
        ana     c
        jz      L19A8
L19AE:
        in      $42
        ana     c
        jnz     L19AE
        mvi     a,$2b
        out     $62
        call    L19C0
        mvi     a,$2f
        out     $62
        ret
L19C0:
        lxi     h,L013B
L19C3:
        in      $42
        ana     c
        jz      L19C3
L19C9:
        in      $42
        ana     c
        jnz     L19C9
        dcx     h
        mov     a,h
        ora     l
        jnz     L19C3
        ret
L19D6:
        in      $42
        ana     c
        jz      L19D6
L19DC:
        in      $42
        ana     c
        jnz     L19DC
        mvi     a,$29
        out     $62
        call    L19C0
        mvi     a,$2f
        out     $62
        ret
L19EE:
        cpi     $20
        mvi     c,$43
        jz      L01FF
        lxi     h,L1BB0
        push    h
        cpi     $0d
        jz      L094B
        cpi     $09
        jz      L0DF9
        cpi     $3a
        jnc     L1B60
        sui     $30
        rm
        add     a
        lxi     h,L1AA2
        call    L13DE
        call    L1390
        mov     a,b
        lxi     d,L21AC
        pchl
L1A1A:
        sta     L2177
        jmp     L0812
L1A20:
        lda     L207B
        xri     $ff
        sta     L207B
        jz      L1A61
L1A2B:
        mvi     c,$80
        call    L108E
        lhld    L2140
        shld    L2111
        lxi     h,L19EE
        shld    L2140
        lxi     h,L0000
        shld    L2143
        shld    L2172
L1A45:
        lhld    L2004
        shld    L21C5
        lhld    L20F8
        shld    L210D
        call    L1BBA
        shld    L214E
        xra     a
        sta     L20F8
        call    L1BF9
        jmp     L1636
L1A61:
        lhld    L2111
        shld    L2140
        call    L1BBA
        lxi     d,L1000
        dad     d
        lda     L2050
L1A71:
        mvi     m,$ff
        inx     h
        dcr     a
        jnz     L1A71
        lxi     h,L210D
        mov     a,m
        sta     L20F8
        mvi     a,$ff
        inx     h
        mov     m,a
        call    L1636
        lhld    L21C5
        shld    L2004
        xra     a
        sta     L21C4
        sta     L21C2
        in      $42
        ani     $08
        jz      L1AA1
        lda     L2176
        ora     a
        cz      L12E8
L1AA1:
        ret
L1AA2:
        db      $cf
        db      $1a
        db      $09
        db      $1b
        db      $d0
        db      $1a
        db      $f2
        db      $1a
        db      $fe
        db      $1a
        db      $0a
        db      $1b
        db      $22             ; '"'
        db      $1b
        db      $40             ; '@'
        db      $1b
        db      $41             ; 'A'
        db      $1b
        db      $b6
        db      $1a
L1AB6:
        call    L1B52
        xra     a
        sta     L210E
        sta     L210D
        lda     L21A2
        ora     a
        push    psw
        cz      L0B77
        pop     psw
        cnz     L0B63
        jmp     L1A45
        rst     0
        call    L1B52
        lda     L20F8
        ora     a
        rz
        call    L0E23
        xra     m
        mov     m,a
        call    L0E23
        ana     m
        mvi     b,$54
        jnz     L1AE8
L1AE6:
        mvi     b,$00
L1AE8:
        mov     a,b
        sta     L20F4
        lda     L20F8
        jmp     L1EEA
        call    L1B52
        call    L0DEC
        call    L1CCD
        jmp     L1AE6
        lxi     h,L21A5
        mov     a,m
        xri     $20
        mov     m,a
        xra     a
        sta     L2144
        ret
        call    L094B
        lxi     h,L225A
        mov     a,m
        xri     $03
        mov     m,a
        sta     L2265
        ani     $01
        sta     L21BE
        jz      L1CD3
        jmp     L1C35
        call    L1B59
        lxi     h,L21A6
        lda     L20F8
        sui     $02
        cpi     $28
        rnc
        nop
        nop
        nop
        nop
        mov     d,a
        call    L0E2B
        xra     m
        mov     m,a
        call    L1DDB
        jmp     L1CD3
        dcx     d
        xchg
        call    L1B59
        sta     L20F8
        mov     a,m
        adi     $10
        mov     m,a
        call    L1DDB
        jmp     L1CD3
L1B52:
        lda     L21BE
        ora     a
        rnz
        pop     h
        ret
L1B59:
        lda     L21BE
        ora     a
        rz
        pop     h
        ret
L1B60:
        lda     L2069
        ani     $20
        rz
        mov     a,b
        cpi     $53
        jnz     L1B72
        call    L1754
        jmp     L1B81
L1B72:
        cpi     $52
        jnz     L1B86
        call    L175B
        ei
        call    L03A2
        call    L1A2B
L1B81:
        ei
        call    L1BF9
        ret
L1B86:
        cpi     $41
        rnz
        call    L1B59
        call    L094B
        mvi     a,$41
        call    L05E6
        mvi     a,$3d
        call    L05E6
        mvi     a,$20
        call    L05E6
        lxi     h,L1E9F
        shld    L2140
        pop     h
        ret
        sbb     b
        cpi     $61
        rm
        cpi     $7b
        rp
        ani     $df
        ret
L1BB0:
        call    L0394
        lxi     h,L19EE
        shld    L2140
        ret
L1BBA:
        lhld    L204E
        jmp     L1BC3
L1BC0:
        lxi     h,L21CC
L1BC3:
        mov     a,h
        ani     $0f
        ori     $20
        mov     h,a
        ret
L1BCA:
        call    L1BBA
        call    L0FC8
        push    h
        mvi     m,$7f
        inx     h
        xchg
        call    L1BC0
        mov     a,h
        ani     $0f
        ori     $70
        stax    d
        inx     d
        mov     a,l
        stax    d
        pop     h
        lda     L2050
        mov     e,a
        mvi     b,$54
L1BE8:
        mov     a,e
        call    L0E27
        ana     m
        jz      L1BF4
        mov     a,e
        call    L1EEA
L1BF4:
        dcr     e
        jnz     L1BE8
        ret
L1BF9:
        lxi     b,L1CAD
        lxi     h,L2253
        mvi     a,$fa
        call    L1C71
        mvi     c,$01
        mvi     b,$10
        call    L1C8A
        lxi     b,L1CAD
        mvi     a,$fa
        call    L1C71
        mvi     c,$01
        mvi     b,$50
        call    L1C8A
        lxi     b,L1CB6
        mvi     a,$fd
        call    L1C71
        mvi     c,$13
        call    L1C88
        mvi     m,$7f
        inx     h
        xchg
        call    L1BBA
        mov     a,h
        ori     $70
        stax    d
        inx     d
        mov     a,l
        stax    d
L1C35:
        call    L1BC0
        lda     L2050
        mov     b,a
        mvi     a,$31
L1C3E:
        mov     m,a
        inx     h
        mov     c,a
        ani     $0f
        mov     a,c
        jnz     L1C49
        xri     $80
L1C49:
        inr     a
        daa
        jnc     L1C50
        ori     $80
L1C50:
        ani     $8f
        ori     $30
        dcr     b
        jnz     L1C3E
        call    L1C9F
        call    L1BCA
        mvi     a,$01
L1C60:
        sta     L21BE
        lxi     h,L2253
        mov     a,h
        mov     h,l
        ani     $0f
        ori     $30
        mov     l,a
        shld    L2004
        ret
L1C71:
        push    h
        lxi     d,L1000
        dad     d
        pop     d
L1C77:
        push    psw
        ldax    b
        ora     a
        jz      L1C86
        stax    d
        pop     psw
        mov     m,a
        inx     h
        inx     d
        inx     b
        jmp     L1C77
L1C86:
        pop     psw
        ret
L1C88:
        mvi     b,$70
L1C8A:
        xchg
L1C8B:
        mvi     m,$7f
        inx     h
        mov     d,h
        mov     e,l
        inx     d
        inx     d
        mov     a,d
        ani     $0f
        ora     b
        mov     m,a
        inx     h
        mov     m,e
        inx     h
        dcr     c
        jnz     L1C8B
        ret
L1C9F:
        mvi     m,$7f
        mov     d,h
        mov     e,l
        inx     h
        mov     a,d
        ani     $0f
        ori     $70
        mov     m,a
        inx     h
        mov     m,e
        ret
L1CAD:
        db      $53             ; 'S'
        db      $45             ; 'E'
        db      $54             ; 'T'
        db      $2d             ; '-'
        db      $55             ; 'U'
        db      $50             ; 'P'
        db      $20             ; ' '
        db      $41             ; 'A'
        db      $00
L1CB6:
        db      $54             ; 'T'
        db      $4f             ; 'O'
        db      $20             ; ' '
        db      $45             ; 'E'
        db      $58             ; 'X'
        db      $49             ; 'I'
        db      $54             ; 'T'
        db      $20             ; ' '
        db      $50             ; 'P'
        db      $52             ; 'R'
        db      $45             ; 'E'
        db      $53             ; 'S'
        db      $53             ; 'S'
        db      $20             ; ' '
        db      $22             ; '"'
        db      $53             ; 'S'
        db      $45             ; 'E'
        db      $54             ; 'T'
        db      $2d             ; '-'
        db      $55             ; 'U'
        db      $50             ; 'P'
        db      $22             ; '"'
        db      $00
L1CCD:
        call    L1BBA
        jmp     L0FC8
L1CD3:
        call    L1CCD
        call    L1BC0
        push    h
        mvi     a,$4e
        call    L0FCB
        pop     h
        push    h
        inx     h
        inx     h
        mvi     e,$00
        mvi     b,$04
        in      $42
        ani     $08
        push    psw
        jz      L1CF0
        inr     b
L1CF0:
        mvi     c,$04
L1CF2:
        call    L1DCC
        ori     $b0
        mov     m,a
        inr     e
        inx     h
        dcr     c
        jnz     L1CF2
        mvi     c,$04
L1D00:
        mvi     m,$00
        inr     e
        inx     h
        dcr     c
        jnz     L1D00
        dcr     b
        jnz     L1CF0
        mvi     c,$04
        pop     psw
        push    psw
        jnz     L1D17
        mov     a,c
        adi     $08
        mov     c,a
L1D17:
        mvi     m,$00
        inx     h
        dcr     c
        jnz     L1D17
        lxi     d,L1D4B
        lda     L21AB
        call    L1D61
        lxi     d,L1D56
        lda     L21AC
        call    L1D61
        call    L1C9F
        lxi     d,L0008
        mvi     c,$04
        pop     psw
        jz      L1D3D
        inr     c
L1D3D:
        mvi     a,$31
        pop     h
L1D40:
        mov     m,a
        inr     a
        dad     d
        dcr     c
        jnz     L1D40
        xra     a
        jmp     L1C60
L1D4B:
        db      $20             ; ' '
        db      $20             ; ' '
        db      $20             ; ' '
        db      $54             ; 'T'
        db      $20             ; ' '
        db      $53             ; 'S'
        db      $50             ; 'P'
        db      $45             ; 'E'
        db      $45             ; 'E'
        db      $44             ; 'D'
        db      $20             ; ' '
L1D56:
        db      $20             ; ' '
        db      $20             ; ' '
        db      $20             ; ' '
        db      $52             ; 'R'
        db      $20             ; ' '
        db      $53             ; 'S'
        db      $50             ; 'P'
        db      $45             ; 'E'
        db      $45             ; 'E'
        db      $44             ; 'D'
        db      $20             ; ' '
L1D61:
        mov     c,a
        mvi     b,$0b
        call    L038B
        mov     a,c
        rrc
        rrc
        mov     c,a
        rrc
        rrc
        add     c
        mov     c,a
        mvi     b,$00
        lxi     d,L1D7C
        xchg
        dad     b
        xchg
        mvi     b,$05
        jmp     L038B
L1D7C:
        db      $20             ; ' '
        db      $20             ; ' '
        db      $20             ; ' '
        db      $35             ; '5'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $20             ; ' '
        db      $37             ; '7'
        db      $35             ; '5'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $31             ; '1'
        db      $31             ; '1'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $31             ; '1'
        db      $33             ; '3'
        db      $34             ; '4'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $31             ; '1'
        db      $35             ; '5'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $32             ; '2'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $33             ; '3'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $20             ; ' '
        db      $36             ; '6'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $31             ; '1'
        db      $32             ; '2'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $31             ; '1'
        db      $38             ; '8'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $32             ; '2'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $32             ; '2'
        db      $34             ; '4'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $33             ; '3'
        db      $36             ; '6'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $34             ; '4'
        db      $38             ; '8'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $20             ; ' '
        db      $39             ; '9'
        db      $36             ; '6'
        db      $30             ; '0'
        db      $30             ; '0'
        db      $31             ; '1'
        db      $39             ; '9'
        db      $32             ; '2'
        db      $30             ; '0'
        db      $30             ; '0'
L1DCC:
        push    h
        lxi     h,L21A6
        mov     d,e
        mov     a,e
        call    L0E2B
        ana     m
        pop     h
        rz
        mvi     a,$01
        ret
L1DDB:
        lda     L21AC
        ani     $f0
        rrc
        rrc
        rrc
        rrc
        mov     b,a
        lda     L21AB
        ani     $f0
        ora     b
        sta     L2158
        ani     $f0
        cpi     $20
        lda     L21A4
        jz      L1DFF
        ani     $3f
        ori     $80
        jmp     L1E03
L1DFF:
        ani     $3f
        ori     $c0
L1E03:
        sta     L21A4
        in      $42
        ani     $08
        jz      L1E19
        lxi     h,L21A7
        mov     a,m
        ori     $10
        mov     m,a
        mvi     a,$6e
        jmp     L1E31
L1E19:
        lda     L21A9
        ani     $c0
        mov     b,a
        lda     L21A9
        ani     $20
        rrc
        ori     $20
        ora     b
        rrc
        rrc
        mov     b,a
        lda     L21A4
        ani     $c3
        ora     b
L1E31:
        sta     L21A4
        lda     L21A9
        ani     $10
        jz      L1E3E
        mvi     a,$10
L1E3E:
        adi     $20
        sta     L207C
        lda     L21A6
        ani     $10
        jz      L1E4D
        mvi     a,$01
L1E4D:
        call    L1E6E
        call    L0329
        lda     L20F8
        cpi     $15
        cz      L0342
        cpi     $1d
        cz      L0342
        cpi     $0c
        cz      L0BF2
        cpi     $12
        cz      L0BF2
        call    L1636
        ret
L1E6E:
        ora     a
        jz      L1E79
        sta     L215B
        xra     a
        jmp     L1E94
L1E79:
        in      $42
        ani     $02
        jnz     L1E90
        sta     L2159
        mvi     a,$01
        sta     L215B
        mvi     a,$02
        sta     L215A
        jmp     L036B
L1E90:
        xra     a
        sta     L215B
L1E94:
        sta     L215A
        mvi     a,$80
        sta     L2159
        jmp     L036B
L1E9F:
        call    L1EDD
        lxi     h,L217B
        mov     m,a
        inx     h
        shld    L21B4
        mov     b,a
        lxi     d,L0014
        call    L1083
        lxi     h,L1EB8
        shld    L2140
        ret
L1EB8:
        call    L1EDD
        lhld    L21B4
        mov     b,a
        lda     L217B
        mov     c,a
        cmp     b
        jz      L1ED3
        mov     a,l
        cpi     $90
        jz      L1ED3
        mov     m,b
        inx     h
        shld    L21B4
        ret
L1ED3:
        mov     m,c
        call    L1CCD
        call    L094B
        jmp     L1BB0
L1EDD:
        push    psw
        cpi     $20
        jnc     L1EE5
        mvi     a,$01
L1EE5:
        call    L05E3
        pop     psw
        ret
L1EEA:
        push    h
        lxi     h,L204E
        mov     c,a
        lda     L21A2
        ora     a
        jnz     L1EFC
        mov     a,c
        cpi     $50
        jp      L1F0F
L1EFC:
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        mov     a,h
        ani     $0f
        ori     $20
        mov     h,a
        mov     a,c
        add     l
        mov     l,a
        jnc     L1F0D
        inr     h
L1F0D:
        mov     m,b
        mov     a,b
L1F0F:
        pop     h
        ret
L1F11:
        push    d
        xra     a
        sta     L21A5
        mvi     b,$00
L1F18:
        mov     a,b
        sta     L2158
        out     $02
        mvi     c,$01
L1F20:
        mov     a,c
        out     $00
        lxi     h,LC000
L1F26:
        push    b
        push    h
        call    L0675
        pop     h
        pop     b
        jnz     L1F48
        inx     h
        mov     a,h
        ora     l
        jnz     L1F26
L1F36:
        mvi     a,$05
        out     $01
        lda     L2158
        out     $02
        mvi     a,$25
        sta     L21A5
        xra     a
        stc
        pop     d
        ret
L1F48:
        ani     $7f
        cmp     c
        jnz     L1F36
        mov     a,c
        rlc
        cpi     $80
        mov     c,a
        jnz     L1F20
        mov     a,b
        adi     $11
        mov     b,a
        cpi     $10
        jnz     L1F18
        xra     a
        pop     d
        ret
L1F62:
        push    d
        mvi     d,$07
L1F65:
        mov     a,d
        call    L1F7B
        call    L1FA1
        cmp     d
        jnz     L1F36
        dcr     d
        jnz     L1F65
        mvi     a,$05
        out     $01
        xra     a
        pop     d
        ret
L1F7B:
        mov     b,a
        ani     $02
        rrc
        rrc
        rrc
        rrc
        ori     $10
        sta     L21C9
        out     $62
        mvi     c,$05
        mov     a,b
        ani     $01
        jz      L1F93
        mvi     c,$25
L1F93:
        mov     a,b
        ani     $04
        jz      L1F9D
        mov     a,c
        ori     $02
        mov     c,a
L1F9D:
        mov     a,c
        out     $01
        ret
L1FA1:
        in      $22
        mov     b,a
        mvi     c,$01
        mov     a,b
        ani     $90
        jz      L1FB3
        cpi     $90
        mvi     a,$ff
        rnz
        mvi     c,$00
L1FB3:
        mov     a,b
        ani     $40
        jz      L1FBD
        mov     a,c
        ori     $02
        mov     c,a
L1FBD:
        in      $01
        rrc
        rrc
        cma
        ani     $20
        xra     b
        ani     $20
        mvi     a,$ff
        rnz
        mov     a,b
        ani     $20
        jnz     L1FD4
        mov     a,c
        ori     $04
        mov     c,a
L1FD4:
        ora     a
        mov     a,c
        ret
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

L0011   = $0011
L00FF   = $00FF
L0111   = $0111
L0113   = $0113
L2000   = $2000
L2001   = $2001
L2002   = $2002
L2004   = $2004
L204E   = $204E
L2050   = $2050
L2051   = $2051
L2052   = $2052
L2054   = $2054
L2056   = $2056
L2058   = $2058
L205A   = $205A
L205B   = $205B
L205C   = $205C
L2065   = $2065
L2067   = $2067
L2068   = $2068
L2069   = $2069
L206A   = $206A
L206E   = $206E
L2072   = $2072
L2073   = $2073
L2074   = $2074
L2075   = $2075
L2077   = $2077
L2078   = $2078
L2079   = $2079
L207A   = $207A
L207B   = $207B
L207C   = $207C
L207D   = $207D
L207E   = $207E
L207F   = $207F
L20C0   = $20C0
L20C1   = $20C1
L20C2   = $20C2
L20DE   = $20DE
L20F2   = $20F2
L20F4   = $20F4
L20F5   = $20F5
L20F6   = $20F6
L20F8   = $20F8
L20F9   = $20F9
L20FA   = $20FA
L20FB   = $20FB
L20FC   = $20FC
L20FD   = $20FD
L20FF   = $20FF
L2101   = $2101
L2102   = $2102
L2104   = $2104
L210D   = $210D
L210E   = $210E
L2111   = $2111
L2113   = $2113
L212B   = $212B
L212C   = $212C
L212D   = $212D
L212F   = $212F
L2130   = $2130
L2131   = $2131
L2140   = $2140
L2142   = $2142
L2143   = $2143
L2144   = $2144
L2145   = $2145
L2146   = $2146
L2147   = $2147
L2148   = $2148
L2149   = $2149
L214B   = $214B
L214E   = $214E
L2150   = $2150
L2151   = $2151
L2152   = $2152
L2153   = $2153
L2154   = $2154
L2155   = $2155
L2156   = $2156
L2157   = $2157
L2158   = $2158
L2159   = $2159
L215A   = $215A
L215B   = $215B
L215C   = $215C
L2171   = $2171
L2172   = $2172
L2173   = $2173
L2174   = $2174
L2176   = $2176
L2177   = $2177
L2178   = $2178
L2179   = $2179
L217B   = $217B
L2191   = $2191
L21A2   = $21A2
L21A3   = $21A3
L21A4   = $21A4
L21A5   = $21A5
L21A6   = $21A6
L21A7   = $21A7
L21A8   = $21A8
L21A9   = $21A9
L21AA   = $21AA
L21AB   = $21AB
L21AC   = $21AC
L21AD   = $21AD
L21AE   = $21AE
L21AF   = $21AF
L21B4   = $21B4
L21B8   = $21B8
L21B9   = $21B9
L21BA   = $21BA
L21BB   = $21BB
L21BC   = $21BC
L21BD   = $21BD
L21BE   = $21BE
L21BF   = $21BF
L21C0   = $21C0
L21C1   = $21C1
L21C2   = $21C2
L21C3   = $21C3
L21C4   = $21C4
L21C5   = $21C5
L21C7   = $21C7
L21C8   = $21C8
L21C9   = $21C9
L21CB   = $21CB
L21CC   = $21CC
L21D3   = $21D3
L2253   = $2253
L225A   = $225A
L2265   = $2265
L22D0   = $22D0
L3000   = $3000
LC000   = $C000
LCC71   = $CC71
LD0F2   = $D0F2
LFF01   = $FF01

end

