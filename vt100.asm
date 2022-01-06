; DEC VT100 firmware disassembly
;
; VT100 was introduced by Digital Equipment Corporation in 1978.
;
; ROM part names:   23-061E2, 23-032E2, 23-033E2, 23-034E2
; Reference:        VT100 Series Video Terminal Technical Manual
; Instruction set:  Intel 8080
; Assembler:        asmx-8085, vasm
; Annotations by:
;  - Martin Åberg
;

; Standard ASCII control codes
ASCII_BS                        = $08 ; Backspace
ASCII_HT                        = $09 ; Horizontal Tab
ASCII_LF                        = $0a ; Line Feed
ASCII_CR                        = $0d ; Carriage Return
ASCII_DC1                       = $11 ; XON
ASCII_DC3                       = $13 ; XOFF
ASCII_CAN                       = $18 ; Cancel
ASCII_SUB                       = $1a ; Substitute
ASCII_ESC                       = $1b ; Escape
ASCII_DEL                       = $7f
CHAR_XON                        = ASCII_DC1
CHAR_XOFF                       = ASCII_DC3

ASCII_SINGLE_QUOTE              = $27
ASCII_DOUBLE_QUOTE              = $22
ASCII_BACKSLASH                 = $5c

; Application definitions
KEYBOARD_AUTO_REPEAT_RELOAD     = 225
; Attribute blink is a hardware blink.
CFG_BLINK_ATTR_COUNTER_RELOAD   = 53
; Cursor blink is soft.
CFG_BLINK_CURS_RELOAD_VISIBLE   = $0212 ; keyboard_rx_check
CFG_BLINK_CURS_RELOAD_INVISIBLE = $0109 ; keyboard_rx_check
CFG_BLINK_CURS_RELOAD_REDRAW    = $000d ; redraw_cursor
SWITCHPACK1_SCROLL              = $80   ; 0: jump scroll, 1: smooth scroll
SWITCHPACK1_AUTO_REPEAT         = $40
SWITCHPACK1_SCREEN              = $20
SWITCHPACK1_CURSOR              = $10
SWITCHPACK2_MARGIN_BELL         = $80
SWITCHPACK2_KEYCLICK            = $40
SWITCHPACK2_ANSI                = $20
SWITCHPACK2_AUTO_XON_XOFF       = $10
SWITCHPACK3_UK                  = $80
SWITCHPACK3_WRAP                = $40
SWITCHPACK3_NEW_LINE            = $20
SWITCHPACK3_INTERLACE           = $10
SWITCHPACK4_PARITY_SENSE        = $80
SWITCHPACK4_PARITY              = $40
SWITCHPACK4_BITS                = $20
SWITCHPACK4_POWER               = $10
ONLINE_FLAGS_LOCAL              = $20
SETUP_BAUD_9600                 = $e0
VT105_GRAPHICS_OPTION_IS_ON     = $80
VT105_GRAPHICS_OPTION_IS_INSTALLED              = $01
VT105_GRAPHICS_OPTION_IS_INSTALLED_AND_ON       = $81

CHARSET_UK                      = $48
CHARSET_US                      = $08
CHARSET_SPECIAL                 = $88
CHARSET_ALT                     = $00
CHARSET_ALT_SPECIAL             = $80

FUTURE_TX_BIT5                          = $20
FUTURE_TX_ANSWERBACK                    = $10
FUTURE_TX_PLEASE_REPORT_ACTIVE_POSITION = $08
FUTURE_TX_IDENTIFY_TERMINAL             = $04
FUTURE_TX_REQUEST_TERMINAL_PARAMETERS   = $02
FUTURE_TX_PLEASE_REPORT_STATUS          = $01

KEYS_FLAG_COUNTER               = $07
KEYS_FLAG_OVERFLOW              = $04
KEYS_FLAG_CONTROL               = $10
KEYS_FLAG_SHIFT                 = $20
KEYS_FLAG_CAPS_LOCK             = $40
KEYS_FLAG_LAST_KEY              = $80

; Hardware definitions
IN_PUSART_DATA                  = $00
IN_PUSART_STATUS                = $01
OUT_PUSART_DATA                 = $00
OUT_PUSART_COMMAND              = $01
OUT_BAUD_RATE_GENERATOR         = $02
OUT_BRIGHTNESS_DA_LATCH         = $42
OUT_NVR_LATCH                   = $62
OUT_KEYBOARD_UART_DATA_INPUT    = $82
OUT_VIDEO_PROCESSOR_DC012       = $a2
OUT_VIDEO_PROCESSOR_DC011       = $c2
OUT_GRAPHICS_PORT               = $e2
IN_MODEM_BUFFER                 = $22
IN_FLAG_BUFFER                  = $42
IN_KEYBOARD_UART_DATA_OUTPUT    = $82

; EK-VT100-TM-003, Table 4-6-2
DC012_LOAD_LOW_SCROLL           = %0000
DC012_LOAD_HIGH_SCROLL          = %0100
DC012_TOGGLE_BLINK              = %1000
DC012_CLEAR_VFREQ_INT           = %1001
DC012_SET_REVERSE_FIELD_ON      = %1010
DC012_SET_REVERSE_FIELD_OFF     = %1011
DC012_BASIC_ATTR_UNDERLINE      = %1100 ; Base attribute selection.
DC012_BASIC_ATTR_REVERSE        = %1101 ; --''--

; EK-VT100-TM-003, Table 4-6-1
DC011_SET_80_COLUMN_MODE        = %000000 ; Sets interlaced mode
DC011_SET_132_COLUMN_MODE       = %010000 ; --''--
DC011_SET_60_HERTZ_MODE         = %100000 ; Sets noninterlaced mode
DC011_SET_50_HERTZ_MODE         = %110000 ; --''--

; AVO attributes
CHAR_ATTR_BLINK_L               = $01
CHAR_ATTR_UNDERLINE_L           = $02
CHAR_ATTR_BOLD_L                = $04
CHAR_ATTR_ALT_CHAR_L            = $08

; Underline or reverse, for each screen character
BASE_ATTRIBUTE_MASK             = $80

CHARGEN_CHECKERBOARD            = $02

; See schematic BV3, E41. The bits are not in EK-VT100-TM-003.
MODEM_BUFFER_nCD                = $10
MODEM_BUFFER_nRI                = $20
MODEM_BUFFER_nSPDI              = $40
MODEM_BUFFER_nCTS               = $80

; See schematic BV6, E42. The bits are not in EK-VT100-TM-003.
FLAG_BUFFER_XMIT_FLAG_H         = $01 ; 1 iff TX empty (TxRDY at PUSART)
FLAG_BUFFER_ADVANCED_VIDEO_L    = $02 ; 0 iff AVO installed (J1)
FLAG_BUFFER_GRAPHICS_FLAG_L     = $04 ; 0 iff graphics option installed (J2)
FLAG_BUFFER_OPTION_PRESENT_H    = $08 ; 1 iff STP is installed (J3)
FLAG_BUFFER_OPTION_EVEN_FIELD_L = $10 ; From DC011
FLAG_BUFFER_NVR_DATA_H          = $20
FLAG_BUFFER_NVR_CLOCK_H         = $40 ; NVR clock, from DC011 timing chip
FLAG_BUFFER_KBD_TBMT_H          = $80 ; from UART KBD XRDY (TX buffer empty)

PUSART_STATUS_PE                = $08 ; Parity error
PUSART_STATUS_OE                = $10 ; Overrun error
PUSART_STATUS_FE                = $20 ; Framing error
PUSART_STATUS_DSR               = $80 ; DATA SET READY
PUSART_STATUS_ERROR             = $38

PUSART_COMMAND_TxEN             = $01 ; Transmit enable
PUSART_COMMAND_DTR              = $02 ; Data terminal ready
PUSART_COMMAND_RxEN             = $04 ; Receive enable
PUSART_COMMAND_SBRK             = $08 ; Send break character
PUSART_COMMAND_ER               = $10 ; Error reset
PUSART_COMMAND_RTS              = $20 ; Request to send
PUSART_COMMAND_IR               = $40 ; Internal reset
PUSART_COMMAND_EH               = $80 ; Enter hunt mode
PUSART_COMMAND_INIT             = $27 ; RTS | RxEN | DTR | TxEN

NVR_LATCH_STANDBY               = %001110 ; Standby. The device output floats.
NVR_LATCH_ACCEPT_ADDRESS        = %000010 ; Accept Address
NVR_LATCH_ERASE                 = %001010 ; Erase
NVR_LATCH_ACCEPT_DATA           = %000000 ; Accept Data
NVR_LATCH_WRITE                 = %001000 ; Write
NVR_LATCH_READ                  = %001100 ; Read
NVR_LATCH_SHIFT_DATA_OUT        = %000100 ; Shift Data Out
NVR_LATCH_BIT4                  = %010000
NVR_LATCH_nSPDS                 = %100000

; Bit 5..0 are LEDs
KEYBOARD_STATUS_SPKR_CLICK      = $80 ; SPKR. CLICK
KEYBOARD_STATUS_START_SCAN      = $40 ; START SCAN
KEYBOARD_STATUS_LOCAL           = $20 ; ON LINE/LOCAL
KEYBOARD_STATUS_KEYBD_LOCKED    = $10 ; KEYBD. LOCKED
KEYBOARD_STATUS_LED1            = $08 ; LED 1
KEYBOARD_STATUS_LED2            = $04 ; LED 2
KEYBOARD_STATUS_LED3            = $02 ; LED 3
KEYBOARD_STATUS_LED4            = $01 ; LED 4
KEYBOARD_STATUS_LED             = $0f

; Codes for the keyboard switch array, EK-VT100-TM-003, Figure 4.4.4.
KEY_ESC                         = $2a ; ESC
KEY_TAB                         = $3a ; TAB
KEY_RETURN                      = $64 ; RETURN
KEY_NO_SCROLL                   = $6a ; NO SCROLL
KEY_SETUP                       = $7b ; SET-UP


; ROM starts with interrupt vectors at address i*8 for i=0..8.
; The interrupt controller presents an RST instruction on the data
; bus at interrupt time. That instruction is executed. RST disables
; interrupts, pushdes PC on stack and jumps to the address encoded
; in the RST instruction.

; Power-up
rst0:
        di
        lxi     sp,top_of_stack
        jmp     reset_handler
        nop

; Keyboard interrupt
rst1:
        call    keyboard_handler
        ei
        ret
        nop
        nop
        nop

; Receiver interrupt
rst2:
        call    receiver_enter
        ei
        ret
        nop
        nop
        nop

; Receiver and keyboard interrupt
rst3:
        call    receiver_enter
        call    keyboard_handler
        ei
        ret

; Vertical frequency interrupt
rst4:
        call    vfreq_handler
        ret
        nop
        nop
        nop
        nop

; Vertical frequency and keyboard interrupt
rst5:
        call    vfreq_handler
        ret
        nop
        nop
        nop
        nop

; Vertical frequency and receiver interrupt
rst6:
        call    receiver_enter
        call    vfreq_handler
        ei
        ret

; Vertical frequency, receiver and receiver interrupt
rst7:
        jmp     rst6

reset_handler:
        mvi     e,$01
power_up_and_test_in_e:
        di
        mvi     a,NVR_LATCH_STANDBY | 1
        out     OUT_NVR_LATCH           ; $f0
        cma
        out     OUT_BRIGHTNESS_DA_LATCH ; $0f
        xra     a                       ; Clear a, d, h, l.
        mov     d,a
        mov     l,a
        mov     h,a

.checksum_for_one_rom:
        inr     a               ; Keyboard LED Error Codes, Table 5-1.
        mov     b,a
        out     OUT_KEYBOARD_UART_DATA_INPUT
        mvi     c,$08           ; Loop over 256 * 8 bytes = 2048 bytes (1 ROM)
.loop:
        rlc
        xra     m
        inr     l
        jnz     .loop           ; inner loop 256 iterations
        inr     h
        dcr     c
        jnz     .loop           ; outer loop 8 iterations
        ora     a
.checksum_error:
        jnz     .checksum_error ; Seek help.
        mov     a,b
        cpi     $04             ; There are 4 ROMs
        jnz     .checksum_for_one_rom
        inr     a
        out     OUT_KEYBOARD_UART_DATA_INPUT
        mvi     c,$aa
        mvi     b,$2c
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_ADVANCED_VIDEO_L
        jnz     reset_no_avo    ; Jump if AVO is not installed
        mvi     b,$40           ; AVO is installed.
reset_no_avo:
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
        jc      reset_no_avo
        push    d
        call    initialize_variables0
        call    initialize_variables1
        call    recall_setup_features
        pop     d
        jz      L00CB
        mov     a,d
        ori     $02
        mov     d,a

L00CB:
        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_STANDBY | 1
        sta     nvr_latch_for_standby
        out     OUT_NVR_LATCH
        lxi     b,$0fff
        ei
.loop:
        mvi     a,$08
        ana     e
        mvi     a,$7f
        jnz     .1
        mvi     a,$ff
.1:
        out     OUT_KEYBOARD_UART_DATA_INPUT
        dcx     b               ; bc := bc - 1
        mov     a,b
        ora     c
        jnz     .loop
        out     OUT_KEYBOARD_UART_DATA_INPUT
        lda     keys_flag
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

keyboard_handler:
        push    psw
        in      IN_KEYBOARD_UART_DATA_OUTPUT
        push    h
        push    b
        mov     b,a
        sui     $7c
        jm      .not_qualifier  ; Jump if not CTRL, SHIFT, CAPS LOCK

        ; Parse qualifier
        mov     h,a             ; 0, 1, 2, 3 (ctrl, shift, caps, always)
        inr     h               ; 1, 2, 3, 4 (ctrl, shift, caps, always)
        mvi     a,$10
        rrc                     ; a := $08, carry cleared
.loop:
        rlc                     ; Create mask for this key.
        dcr     h
        jnz     .loop
        lxi     h,keys_flag
        ora     m               ; Add in $10, $20 or $40.
        mov     m,a
        jmp     .ret            ; That's it.

.not_qualifier:
        lxi     h,keys_flag
        mvi     a,KEYS_FLAG_COUNTER
        ana     m
        cpi     KEYS_FLAG_OVERFLOW
        jp      .ret
        inr     m
        lxi     h,new_key_buffer
        call    add_a_to_hl
        mov     m,b
.ret:
        pop     b
        pop     h
        pop     psw
        ret

handle_special_key:
        ani     $7f             ; Clear the $80 flag from switch_array.
        mov     c,a

        lda     is_in_setup
        ora     a
        jnz     reset_parameter

        ; The BREAK key is independent of ANSI/VT52 mode.
        mov     a,c
        cpi     $01             ; BREAK
        jz      handle_special_key_break

        lda     switchpack2
        ani     SWITCHPACK2_ANSI
        jnz     handle_special_key_in_ansi

        ; We are in VT52 mode.
        lda     application_keypad_mode
        ora     a
        jnz     handle_special_key_in_vt52_keypad_application_mode

        ; We are in VT52 keypad numeric mode.
handle_special_key_in_vt52_keypad_numeric_mode:
        mov     a,c
        cpi     'A'             ; Check if in keypad 0..9 - . , ENTER
        jm      handle_keypad_ascii
        mvi     a,ASCII_ESC
        call    uart_putc
handle_keypad_ascii:
        mov     a,c
        jmp     uart_putc_urgent

handle_special_key_in_vt52_keypad_application_mode:
        mvi     a,ASCII_ESC
        call    uart_putc
        mov     a,c
        cpi     'A'             ; up arrow
        jp      handle_keypad_ascii
        mvi     a,'?'
handle_special_key_put_a_translate_p_to_0:
        call    uart_putc
        mov     a,c
        adi     'p' - '0'       ; translate 0.. -> p..
        jmp     uart_putc_urgent

handle_special_key_in_ansi:
        lda     application_keypad_mode
        ora     a
        jnz     handle_special_key_in_ansi_keypad_application_mode
        mov     a,c
        cpi     'A'             ; up arrow
        jm      handle_keypad_ascii
        cpi     'P'             ; jump if arrows
        jm      handle_special_key_in_ansi_keypad_application_mode
handle_special_key_put_esc_o_ascii:
        mvi     a,ASCII_ESC
        call    uart_putc
        mvi     a,'O'
handle_special_key_put_a_ascii:
        call    uart_putc
        jmp     handle_keypad_ascii

handle_special_key_put_csi_ascii:
        mvi     a,ASCII_ESC
        call    uart_putc
        mvi     a,'['
        jmp     handle_special_key_put_a_ascii

handle_special_key_in_ansi_keypad_application_mode:
        lda     cursor_key_mode
        ora     a
        jz      .cursor_key_mode_reset
        mov     a,c
        cpi     'A'             ; Jump if arrow or PF1..PF4
        jp      handle_special_key_put_esc_o_ascii
.put_esc_o_translated_ascii:
        mvi     a,ASCII_ESC
        call    uart_putc
        mvi     a,'O'
        jmp     handle_special_key_put_a_translate_p_to_0

.cursor_key_mode_reset:
        mov     a,c
        cpi     'A'             ; Jump if numbers - . , ENTER.
        jm      .put_esc_o_translated_ascii
        cpi     'P'             ; Jump if arrow.
        jm      handle_special_key_put_csi_ascii
        jmp     handle_special_key_put_esc_o_ascii

; BREAK - Pressing BREAK forces the transmission line to its space
; state for 0.2333 seconds +- 10 percent. If either SHIFT key is
; down, the time increases to 3.5 seconds +- 10 percent.
handle_special_key_break:
        lxi     h,L0815
        push    h               ; Return address.
        lda     online_flags
        ora     a
        rnz                     ; Return if local.

        call    click_the_keyclick

        lxi     b,(PUSART_COMMAND_DTR << 8) | $0e       ; BREAK without SHIFT
        lxi     h,keys_flag
        mov     a,m
        ani     KEYS_FLAG_CONTROL
        jnz     cc_enq          ; If CTRL+BREAK then transmit answerback msg.

        mov     a,m
        ani     KEYS_FLAG_SHIFT
        jz      .has_count              ; Jump if SHIFT key is not active.
        lxi     b,($00 << 8) | $d2      ; BREAK with SHIFT

        ; b:  additional PUSART_COMMAND bits.
        ; c:  BREAK duration
.has_count:
        mvi     a,PUSART_COMMAND_RTS | PUSART_COMMAND_RxEN | PUSART_COMMAND_TxEN
        ori     PUSART_COMMAND_SBRK
        ora     b               ; Maybe bring in the DTR bit.
        out     OUT_PUSART_COMMAND
        lda     incremented_in_vfreq
        add     c
        mov     c,a             ; Then: c + incremented_in_vfreq.
.loop:
        push    b
        call    keyboard_rx_check
        pop     b
        lda     incremented_in_vfreq
        cmp     c
        jnz     .loop           ; While incremented_in_vfreq (now) is not then.
        jmp     L0394

; c:  character to parse
reset_parameter:
        lxi     h,L0812
        push    h
        xra     a
        sta     cs_parameter_array      ; Clear first entry.
        sta     question_for_lh         ; Clear it.
        lxi     h,setup_intensity
        mov     a,c
        sui     $41
        mov     b,a
        mov     a,m
        jz      L0222
        dcr     b
        jz      L0226
        dcr     b
        jz      cs_cursor_right
        dcr     b
        jz      cs_cursor_left
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

handle_key_no_scroll:
        lda     switchpack2
        cma
        ani     SWITCHPACK2_AUTO_XON_XOFF
        lxi     h,online_flags
        ora     m
        jnz     L0841           ; Jump if machine is in local mode.
        lda     L21BF
        lxi     b,$0200 | CHAR_XON
        ana     b
        jnz     L0245
        mvi     c,CHAR_XOFF

L0245:
        mov     a,c
        sui     CHAR_XON
        sta     silo_getc_disable
        call    L0F7E
        jmp     L0812

; This is part of the confidence test.
L0251:
        di
        lxi     sp,top_of_stack
        lxi     h,ram_begin
        push    h
        mov     a,m             ; Fill line 0.
        rar
        jc      .ram_begin_has_1
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_ADVANCED_VIDEO_L
        jz      .avo_check_done

.ram_begin_has_1:
        inr     a
        sta     avo_is_not_installed

.avo_check_done:
        call    L03A2
        lda     number_of_columns
        dcr     a
        sta     cursposx_max
        pop     h
        mov     a,m
        mvi     m,$7f
        ora     a
        jz      .4
        jp      .vt100_is_malfunctioning
        lxi     h,blink_attr_reverse_field
        mvi     m,DC012_SET_REVERSE_FIELD_ON
        ani     $7f

.vt100_is_malfunctioning:
        sta     device_status_malfunction
        adi     '0'
        lhld    screen_ram_cursor_pos
        mov     m,a             ; Show the digit.
        cpi     '4'
        jz      .4
        mvi     a,ONLINE_FLAGS_LOCAL
        sta     online_flags

.4:
        call    L0BF2
        lxi     b,$0000 | CHAR_XON
        call    L0F7E
        jmp     main_loop

initialize_variables0:
        lxi     h,variables_begin
        lxi     d,variables_end-variables_begin
        mvi     b,$00
        call    memset
        cma
        sta     L2104           ; TODO: Store into cursor save area (?).
        lxi     h,line0ptr
        shld    L2052
        lxi     h,screen_22d0_user_lines_begin
        shld    screen_ram_cursor_pos
        ret

L02C0:
        call    set_parser_state_to_idle_and_return
        lxi     h,ram_begin
        lxi     d,initdata_for_screen
        mvi     b,18            ; Copy 18 characters to buffer.
        call    memcpy

        ; Initialize attribute RAM (AVO) to 0xff
        lxi     h,attribute_ram_begin
        lxi     d,$1000
        mvi     b,$ff
        jmp     memset

; * The last bytes in each line are a terminator character and two
;   address bytes.
; * The terminator blanks the display until end of line. Output
;   depends on normal or reverse screen.  Horizontal blanking takes
;   over at some point.
; * DMA ends with the terminator.
; * The high three bits of the high order byte go to the line
;   attribute inputs to the DC012.

; EK-VT100-TM-003, Figure 4.7.2
LINE_TERM               = %01111111
LINE_ATTR_SCROLL        = %10000000 ; Part of scrolling region
LINE_ATTR_NORMAL        = %01100000 ; Normal line 80/132
LINE_ATTR_DW            = %01000000 ; Double width 40/66
LINE_ATTR_DH_TOP        = %00100000 ; Top half, double height
LINE_ATTR_DH_BOTTOM     = %00000000 ; Bottom half, double height
LINE_ADDR_2000          = %00010000 ; Fetch line from RAM at 2000.
LINE_ADDR_4000          = %00000000 ; --''--                 4000.

initdata_for_screen:
; See EK-VT100-TM-003, Section 4.7, Figure 4-7-{5,6,7}
;               TERM       HIGH  LOW  ADDR  ATTRIBUTES     NEXT
;              ----------------------------------------------------------------
        db      LINE_TERM, $70,  $03; 2000  NORMAL         2003 (2009 @ 50 Hz)
        db      LINE_TERM, $f2,  $d0; 2003  NORMAL SCROLL  22d0
        db      LINE_TERM, $70,  $06; 2006  NORMAL         2006
        db      LINE_TERM, $70,  $0c; 2009  NORMAL         200c
        db      LINE_TERM, $70,  $0f; 200c  NORMAL         200f
        db      LINE_TERM, $70,  $03; 200f  NORMAL         2003
;              ----------------------------------------------------------------

initialize_variables1:
        lxi     h,CFG_BLINK_CURS_RELOAD_VISIBLE
        shld    blink_curs_counter
        mvi     a,CFG_BLINK_ATTR_COUNTER_RELOAD
        sta     blink_attr_counter
        mvi     a,$01
        sta     smooth_scroll_term_b
        sta     terminal_parameters_request_type
        lxi     h,$07ff
        shld    L2149
        mvi     a,$02
        sta     keyboard_rx_free
        mvi     a,~CHAR_ATTR_ALT_CHAR_L
        sta     character_attribute_avo
        ; On initializing the VT105, the M7071 forces the GRAPHICS FLAG low
        ; so the VT100 terminal controller module recognizes that the
        ; graphics option is installed.
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_GRAPHICS_FLAG_L
        mvi     a,VT105_GRAPHICS_OPTION_IS_INSTALLED
        jnz     .graphics_option_is_not_installed
        sta     vt105_graphics_option
.graphics_option_is_not_installed:
        mvi     a,$ff
        sta     cursposy_prev
        sta     blink_curs_is_visible   ; blink_curs_is_visible := $ff
        mvi     h,$80
        mov     l,h
        shld    silo_rx_wr
        ret

write_pusart_registers:
        mvi     a,PUSART_COMMAND_IR     ; Internal reset
        out     OUT_PUSART_COMMAND
        lda     baud_rage_tenerator
        out     OUT_BAUD_RATE_GENERATOR
        lda     mode_byte_for_pusart
        out     OUT_PUSART_COMMAND
        call    L0394
        mvi     a,NVR_LATCH_BIT4
        sta     nvr_latch_for_standby
        out     OUT_NVR_LATCH
        ret

reconfigure_display:
        lda     setup_132columns                ; Number of columns in setup.
        ora     a
        jz      .hascol                         ; Use 80 columns.
        mvi     a,DC011_SET_132_COLUMN_MODE
.hascol:
        mov     b,a                             ; Save the column command.
        out     OUT_VIDEO_PROCESSOR_DC011
        lda     dc011_freq_command
        out     OUT_VIDEO_PROCESSOR_DC011       ; Set noninterlaced mode.

        ; This is where the number of fill lines is configured. If the
        ; machine runs 60 Hz vertical frequency, then fill line at $2000 is
        ; followed by fill line at $2003. If not, then it runs 50 Hz and the
        ; second fill line is at $2009.  EK-VT100-TM-003, Section 4.7.
        cpi     DC011_SET_60_HERTZ_MODE
        lxi     h,(9<<8) | LINE_ATTR_NORMAL | LINE_ADDR_2000
        jnz     .hasnext ; Jump if 50 Hz
        lxi     h,(3<<8) | LINE_ATTR_NORMAL | LINE_ADDR_2000
.hasnext:
        shld    $2001           ; Install fill line 0 next pointer.

        ; Interlace configuration is interesting. The command for setting
        ; column mode also sets interlaced mode, and the command for setting
        ; vertical frequency also sets noninterlaced mode. So, if the user
        ; has requested interlaced mode, we need to do the column command
        ; again. EK-VT100-TM-003, Section 4.6.2.1.
        lda     switchpack3
        ani     SWITCHPACK3_INTERLACE
        rz
        mov     a,b             ; Do the column command to set interlaced mode.
        out     OUT_VIDEO_PROCESSOR_DC011
        ret

L036B:
        lda     switchpack1
        ani     SWITCHPACK1_SCREEN
        jnz     L0375
        mvi     a,%0001         ; SET_REVERSE_FIELD_OFF
L0375:
        ori     DC012_SET_REVERSE_FIELD_ON
        out     OUT_VIDEO_PROCESSOR_DC012
        lda     screen_attr_underline
        ori     DC012_BASIC_ATTR_UNDERLINE
        out     OUT_VIDEO_PROCESSOR_DC012
        ret

fill_the_entire_screen_area:
        lda     setup_132columns
        ora     a
        jz      L0B63           ; Jump on 80 columns.
        jmp     L0B77           ; Stay when 132.

; b:  number of bytes
; de: source
; hl: destination
; scratch: a, b, de, hl
memcpy:
        ldax    d               ; Load one byte from memory.
        mov     m,a             ; Store one byte to memory.
        inx     h               ; Next destination location.
        inx     d               ; Next source location.
        dcr     b               ; Decrement character counter.
        jnz     memcpy          ; Loop until everything has been copied.
        ret

L0394:
        lda     online_flags
        ora     a
        mvi     a,$01
        jnz     .local
        mvi     a,$05
.local:
        jmp     L1F7B

L03A2:
        call    fill_the_entire_screen_area
        call    configure_the_pusart
        call    L036B
        jmp     reconfigure_display

main_loop:
        call    something_with_uart_and_keyboard
        call    receive_character_processor
        lxi     h,setup_pend
        mov     a,m
        ora     a
        mvi     m,$00           ; Clear setup pending indication.
        cnz     setup_begin     ; Jump if setup was pending.
        lda     online_flags
        ora     a
        jz      main_loop       ; Jump if online.
        xra     a
        sta     keyboard_is_locked
        jmp     main_loop

; handler for PUSART RX interrupt
; There is no check of UART status before reading the data.
receiver_enter:
        ; Save program state.
        push    psw
        push    b
        push    h
        in      IN_PUSART_DATA  ; Read UART receieve data buffer.
        ani     $7f             ; 7 bits is enough.
        jz      receiver_return ; Return if RX data is ASCII NUL (Null).
        mov     c,a
        lda     online_flags
        ora     a
        jnz     receiver_return ; Return because we are not online.
        in      IN_PUSART_STATUS
        ani     PUSART_STATUS_ERROR
        jz      receiver_without_error

        ; We end up here if there was a UART receive error indication. In
        ; that case, force the received character to ASCII SUB
        ; (Substitute). The UART will also be reset.
        mvi     c,ASCII_SUB
        mvi     a,PUSART_COMMAND_INIT
        ori     PUSART_COMMAND_ER     ; error reset
        out     OUT_PUSART_COMMAND    ; outputs "RTS | RxEN | DTR | TxEN | ER"

receiver_without_error:
        mov     a,c
        cpi     ASCII_DEL
        jz      L0437           ; Jump if RX data is ASCII DEL (Delete)

        lda     switchpack2
        ani     SWITCHPACK2_AUTO_XON_XOFF
        mov     a,c
        jz      receiver_flowdone
        lxi     h,received_xoff
        cpi     CHAR_XON
        jz      receiver_got_xon
        cpi     CHAR_XOFF
        jz      receiver_got_xoff

; UART SILO RX enqueue.
receiver_flowdone:
        lxi     h,silo_rx_wr    ; Get SILO RX write pointer.
        mov     c,m             ; index in c
        mov     b,h             ; bc = 20xy
        stax    b               ; Install in SILO, (bc) := a
        mov     a,c             ; a := index
        inr     a               ; a++
        ani     $bf
        mov     m,a
        mov     b,a
        lda     silo_rx_rd      ; Get SILO RX read pointer
        sub     b
        jnz     L0427

        ; Error path for RX SW buffer overflow.
        mov     m,c
        mov     a,b
        inr     a
        ani     $bf
        mov     l,a
        mvi     m,ASCII_SUB
        jmp     L0431

; There is logic around here which sends XOFF if RX buffer contains
; more than 32 characters and then again if more than 112.
L0427:
        jp      L042C
        adi     $40

L042C:
        cpi     $20
        jnz     L0437

L0431:
        lxi     b,$0100 | CHAR_XOFF
        call    L0F7E

L0437:
        call    L0E47

receiver_return:
        ; Restore program state.
        pop     h
        pop     b
        pop     psw
        ret

; If we received XON or XOFF and the feature is enabled, then
; update the XON/XOFF state variable.
receiver_got_xon:
        mvi     a,$fe           ; Clear bit 0, which is the only one defined.
        ana     m
        jmp     L0447

receiver_got_xoff:
        mvi     a,$01           ; Set bit 0.
        ora     m

L0447:
        mov     m,a             ; Write back new XOFF state variable.
        jmp     L0437

; These are pairs of (non-shifted,shifted) ASCII values.
; The table is used by the routine at process_keyboard_item.
transform_when_pressing_shift:
        db      '0)', '1!', '2@', '3#', '4$', '5%', '6^', '7&'
        db      '8*', '9(', '-_', '=+', '`~', '[{', ']}'
        db      ';:'
        db      '/?'
        db      ASCII_SINGLE_QUOTE, ASCII_DOUBLE_QUOTE
        db      ',<'
        db      '.>'
        db      ASCII_BACKSLASH, '|'

        db      ' ' ; This entry is never used.

keyboard_switch_array:
        ; COLUMN 0
        db      $20             ; ALWAYS OPEN
        db      $7f
        db      $7f
        db      $7f             ; DELETE
        db      $00             ; RETURN
        db      'p'
        db      'o'
        db      'y'
        db      't'
        db      'w'
        db      'q'

        ; COLUMN 1
        db      $80 | 'C'       ; right arrow
        db      $00
        db      $00
        db      $00
        db      ']'
        db      '['
        db      'i'
        db      'u'
        db      'r'
        db      'e'
        db      '1'

        ; COLUMN 2
        db      $80 | 'D'       ; left arrow
        db      $00
        db      $80 | 'B'       ; down arrow
        db      $80 | $01       ; BREAK
        db      '`'
        db      '-'
        db      '9'
        db      '7'
        db      '4'
        db      '3'
        db      ASCII_ESC       ; ESC

        ; COLUMN 3
        db      $80 | 'A'       ; up arrow
        db      $80 | 'R'       ; PF3
        db      $80 | 'P'       ; PF1
        db      ASCII_BS        ; BACK SPACE
        db      '='
        db      '0'
        db      '8'
        db      '6'
        db      '5'
        db      '2'
        db      ASCII_HT        ; TAB

        ; COLUMN 4
        db      $80 | '7'       ; keypad 7
        db      $80 | 'S'       ; PF4
        db      $80 | 'Q'       ; PF2
        db      $80 | '0'       ; keypad 0
        db      ASCII_LF        ; LINE FEED
        db      ASCII_BACKSLASH
        db      'l'
        db      'k'
        db      'g'
        db      'f'
        db      'a'

        ; COLUMN 5
        db      $80 | '8'       ; keypad 8
        db      $80 | ASCII_CR  ; keypad ENTER
        db      $80 | '2'       ; keypad 2
        db      $80 | '1'       ; keypad 1
        db      $00
        db      ASCII_SINGLE_QUOTE
        db      ';'
        db      'j'
        db      'h'
        db      'd'
        db      's'

        ; COLUMN 6
        db      $80 | '.'       ; keypad .
        db      $80 | ','       ; keypad ,
        db      $80 | '5'       ; keypad 5
        db      $80 | '4'       ; keypad 4
        db      ASCII_CR        ; RETURN
        db      '.'
        db      ','
        db      'n'
        db      'b'
        db      'x'
        db      $80 | $02       ; NO SCROLL

        ; COLUMN 7
        db      $80 | '9'       ; keypad 9
        db      $80 | '3'       ; keypad 3
        db      $80 | '6'       ; keypad 6
        db      $80 | '-'       ; keypad -
        db      $00
        db      '/'
        db      'm'
        db      ' '             ; SPACE BAR
        db      'v'
        db      'c'
        db      'z'
        db      $80 | $7f       ; SETUP

vfreq_handler:
        push    psw
        push    h
        push    d
        call    L104E
        push    b
        mvi     a,DC012_CLEAR_VFREQ_INT
        out     OUT_VIDEO_PROCESSOR_DC012       ; Acknowledge the interrupt.
        ei                                      ; Global interrupt enable.
        lda     poll_scroll_pend1
        ora     a
        jnz     .smooth_scroll
        lxi     h,poll_scroll_pend0
        ora     m
        jz      .maybe_sound_the_bell
        mvi     a,$01
        sta     poll_scroll_pend1
        ora     m
        mvi     m,$00
        mvi     a,$01
        sta     smooth_scroll_term_b
        lda     scroll_region_bottom
        jp      .1
        mvi     a,$99
        sta     smooth_scroll_term_b
        lda     scroll_region_top
        dcr     a
.1:
        call    L122F
        sta     L207A
.smooth_scroll:
        lxi     b,smooth_scroll_term_b
        ldax    b               ; Get scroll index.
        lxi     h,smooth_scroll_term_a
        add     m
        daa
        ani     $0f             ; Keep low nibble
        mov     m,a
        mov     d,a
        ani     $03             ; Load low order scroll latch.
        out     OUT_VIDEO_PROCESSOR_DC012
        mov     a,d
        rar                     ; Two bit right shift
        ana     a               ; Clear the carry so 0 is shifted in.
        rar
        ori     $04             ; Load high order scroll latch.
        out     OUT_VIDEO_PROCESSOR_DC012
        mov     a,d
        ora     a
        jnz     .maybe_sound_the_bell
        sta     poll_scroll_pend1
        ldax    b
        ora     a
        lda     scroll_region_bottom
        jm      .2
        lda     scroll_region_top
        dcr     a
.2:
        call    L11CE
        sta     L207A

.maybe_sound_the_bell:
        lxi     h,bell_indicator
        mov     a,m
        ora     a
        jz      .blink_attr     ; Go on if bell is not requested.
        dcr     m               ; Decrement 1 from bell_indicator in memory.
        ani     $04             ; rotate bit 2 to bit 7
        rrc
        rrc
        rrc
        ; "If the bit is sent approximately two hundred times in a row, for
        ; about a quarter second, it sounds a bell."
        sta     state_for_bell  ; KEYBOARD_STATUS_SPKR_CLICK

; Hardware blink via DC012. Attributes data is in AVO attribute RAM.
; IF blink_attr_counter elapsed THEN
;   Store reload value to blink_attr_counter.
;   Toggle blink in hardware.
;   IF blink_attr_reverse_field requested THEN
;     Set reverse field on or off.
;   ENDIF
; ELSE
;   Store decremented blink_attr_counter.
; ENDIF
.blink_attr:
        lxi     h,blink_attr_counter    ; Get blink counter and decrement.
        mov     a,m
        dcr     a
        jnz     .update                 ; Skip blink if not elapsed.
        mvi     m,CFG_BLINK_ATTR_COUNTER_RELOAD ; Store reload value.
        mvi     a,DC012_TOGGLE_BLINK    ; Tell DC012 hardware to toggle blink.
        out     OUT_VIDEO_PROCESSOR_DC012
        lxi     h,blink_attr_reverse_field ; DC012_SET_REVERSE_FIELD_{ON,OFF}
        mov     a,m
        ora     a
        jz      .done                   ; Skip if no attribute.
        out     OUT_VIDEO_PROCESSOR_DC012
        xri     %0001                   ; Toggle reverse field.

.update:
        ; This stores the updated blink counter, OR the updated attribute.
        mov     m,a

.done:
        ; "The seventh bit is sent only once in a vertical interval and
        ; initiates the scanning process in the keyboard."
        mvi     a,KEYBOARD_STATUS_START_SCAN
        sta     state_for_keyboard_scan
        lxi     h,incremented_in_vfreq
        inr     m
        lda     setup_intensity
        out     OUT_BRIGHTNESS_DA_LATCH
        lda     baud_rage_tenerator
        out     OUT_BAUD_RATE_GENERATOR         ; Installed every vblank.
        lda     nvr_latch_for_standby
        out     OUT_NVR_LATCH
        pop     b
        pop     d
        pop     h
        pop     psw
        ret

receive_character_processor:
        lda     online_flags
        lxi     h,is_in_setup
        ora     m
        rnz                     ; Return if local or in setup.
        call    silo_getc
        rz                      ; Return if the SILO had nothing for us.
L0593:
        ; If the machine is in setup or if the graphics processor is on,
        ; then jump into the parser without considering control characters.
        ; Else process control character or go into the current parser
        ; state.
        mov     b,a
        lda     is_in_setup
        ora     a
        mov     a,b
        jnz     .run_the_parser ; Jump if machine in setup.

        lda     vt105_graphics_option
        rlc                     ; High bit set when graphics option is on.
        mov     a,b
        jc      .run_the_parser ; Jump if graphics option is on.

        cpi     $20
        jc      process_control_character       ; a is in CC range (00..1f)

; Jump into a running state machine.
; The entry is stored at many places, but only really used here.
.run_the_parser:
        lhld    parser_state
        pchl

parse_graphics_processor_on_fsm0:
        cpi     ASCII_ESC
        jnz     parse_graphics_processor_on_fsm0_restart
        lxi     h,parse_graphics_processor_on_fsm1
        jmp     set_parser_state_and_return

parse_graphics_processor_on_fsm1:
        cpi     '2'
        jnz     parse_graphics_processor_on_fsm1_restart      ; not done
        ; Got the "Graphics processor off" command, so leave.
        mvi     a,VT105_GRAPHICS_OPTION_IS_INSTALLED
        sta     vt105_graphics_option
        jmp     set_parser_state_to_idle_and_return

parse_graphics_processor_on_fsm1_restart:
        mov     b,a
        mvi     a,ASCII_ESC
        call    parse_graphics_processor_wait_not_busy
        mov     a,b
parse_graphics_processor_on_fsm0_restart:
        call    parse_graphics_processor_wait_not_busy
        jmp     graphics_processor_on_remain

parse_graphics_processor_wait_not_busy:
        mov     c,a             ; Save the received character.
.loop:
        push    b
        call    something_with_uart_and_keyboard
        pop     b
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_GRAPHICS_FLAG_L
        ; A high GRAPHIC FLAG indicates the option is busy.
        jnz     .loop
        mov     a,c                     ; Restore the received character.
        out     OUT_GRAPHICS_PORT       ; Send command to graphics option.
        ret

display_character_with_single_shift:
        call    esc_single_shift_2

; This is the routine which puts a character on the screen. It
; takes character attributes, cursor, etc into account and writes to
; screen RAM.
; a:  character to display
parse_idle:
display_character:
        push    psw
        cpi     ASCII_DEL
        jz      .ret            ; Return if DEL.
        push    h
        push    d
        push    b
        mov     c,a

        ; A possible MYSTERY corner of the VT100 implementation follows.
        ;
        ; The program now parses the "charset_state" to determine which
        ; character set (G0 or G1) which is currently invoked. A character
        ; set is invoked with the control codes "SI" (G0) and "SO" (G1). "G0"
        ; and "G1" are labels for machine character sets. G0 and G1 each gets
        ; machine character set designated with the "SCS" sequence.
        ;
        ; In addition to the above, a character set (label G0, G1, G2, G3)
        ; can be temporarily invoked for a single character. This is called
        ; "single shift" and is documented as SS2 and SS3 on the VT101 and
        ; VT102. The VT100 does NOT document SS2 and SS3. Anyhow, there is
        ; code below which indicates that something similar to SS2 and SS3 is
        ; attempted also in the VT100, but it looks incomplete and potential
        ; broken. Consider for example what happens if the SS2 command is
        ; issued multiple times by an application. Then charset_state can
        ; have any value and indirection via charset_for_g0 will pick up a
        ; random value, etc. In particular, the SS2 and SS3 as implemented
        ; here does not match the VT101 and VT102 documentation.

        ;  charset_state  invoked character set  single character shift
        ; --------------------------------------------------------------
        ;  0              G0                     none
        ;  1              G1                     none
        ;  2              G0                     G2 or G3
        ;  3              G1                     G2 or G3
        ; --------------------------------------------------------------

        lxi     h,charset_state
        mov     d,m             ; Load charset_state
        inx     h               ; h: &charset_for_g0
        mov     a,d             ; a: charset_state

        ; charset_for_g0 is at $20FD, so l will overflow when charset_state
        ; is 3 or more. 3 is a valid state and it may be greater if multiple
        ; SS2 or SS3 have been commanded. The consequence is that hl may now
        ; be anywhere in the range 2000..20ff.
        add     l               ; a := charset_state + &charset_for_g0(7:0)
        mov     l,a             ; l := charset_state + &charset_for_g0(7:0)
        mov     a,d             ; a := charset_state
        sui     2               ; a := charset_state-2
        jp      .has_new_state  ; Jump if there was single character shift.
        mov     a,d             ; a := charset_state
.has_new_state:
        sta     charset_state   ; Reset single character shift.
        ; hl may be any value in the range 2000..20ff.
        mov     d,m             ; d: Load charset_for_g0[charset_state]

        lda     character_attribute_avo
        ora     d
        ; Bit 3 of CHARSET_nn selects the ALT_CHAR_L character attribute.
        mov     b,a             ; b := charset | character_attribute_avo
        mov     a,d             ; a := charset
        rlc                     ; Detect charset "special" bit.
        mov     a,c             ; a := character to display
        jnc     .mapped         ; Jump if machine character set is not special.

        ; A "special character and line drawing set" is invoked for the
        ; current character. Therefore, map character codes 60..$7e to
        ; character generator ROM index 1..$1f.
        ; See EK-VT100-TM-003, Table A-5 and Figure 4-6-18.
        sui     $5f             ; This is the first special character.
        cpi     $20             ; Check range.
        jnc     .mapped         ; Skip if target character is not special.
        mov     c,a             ; If special then update character to display.
.mapped:
        mov     a,d
        ani     $40             ; Check if it is a UK charset.
        mov     a,c             ; a: character to display
        jz      .pound_complete
        cpi     '#'             ; It is a UK charset. Are we shopping?
        jnz     .pound_complete
        mvi     c,$1e           ; Yes. Use character generator pound symbol.

.pound_complete:
        lda     character_attribute_base
        ora     c               ; Add in the base attribute ($00 or $80)
        mov     c,a             ; c: ROM index | base attribute

        ; Active position is at effective margin.
        lda     last_column_flag
        ora     a
        jz      .to_screen_ram

        ; A wrap request is pending.
        lxi     h,cursposx      ; Check if cursor is at the right margin.
        lda     cursposx_max
        cmp     m
        jnz     .to_screen_ram  ; Jump if not at right margin.

        mvi     m,$00           ; Move cursor from right margin to column 0.
        push    b
        call    cc_lf           ; Line feed: maybe scroll, stay in column 0.
        pop     b

        ; Store chargen index to screen RAM and character attribute to
        ; attribute RAM.
.to_screen_ram:
        lhld    screen_ram_cursor_pos
        mov     m,c             ; Store chargenindex.
        mov     a,h             ; Index into attribute RAM by doing
        adi     $10             ; hl := hl + $1000
        mov     h,a
        mov     m,b             ; Store attribute.
        mov     a,b
        sta     cursor_attr     ; Remember attribute
        lxi     h,cursor_code   ; and chargen.
        mov     m,c

        lxi     h,cursposx
        lda     cursposx_max
        cmp     m
        jnz     .inc_and_draw_cursor    ; Not at right margin.

        ; Cursor is at right margin. Keep it there.
        ; Note that redraw_cursor is not called in this branch.
        ; Store chargen code again for some reason.
        mov     a,c
        sta     cursor_code
        lda     switchpack3
        ani     SWITCHPACK3_WRAP
        jmp     .update_wrapstate

.inc_and_draw_cursor:
        inr     m               ; cursposx++
        call    redraw_cursor
        xra     a               ; Do not wrap.
.update_wrapstate:
        sta     last_column_flag
        pop     b
        pop     d
        pop     h
.ret:
        pop     psw
        ret

silo_getc:
        lda     silo_getc_disable
        ora     a
        jnz     .ret0
        lxi     h,silo_rx_wr
        mov     a,m             ; Load write pointer.
        inx     h               ; h := silo_rx_rd
        sub     m
        jnz     .data_available ; If rd = wr then return.
.ret0:
        xra     a
        ret
.data_available:
        mov     l,m             ; Load read pointer.
        mvi     h,$20
        mov     d,m             ; Load read data.
        lxi     h,silo_rx_rd
        mov     a,m             ; Load read pointer
        inr     a               ; Increment read pointer.
        ani     $bf             ; Massage it.
        ori     $80
        mov     m,a             ; Store read pointer.
        dcx     h               ; h := silo_rx_wr
        sub     m               ; a := rd - wr
        jp      .pos
        adi     $40
.pos:
        cpi     $30
        jnz     .ret

        ; (rd - wr) = $30
        lxi     b,$0100 | CHAR_XON
        call    L0F7E
.ret:
        mov     a,d
        ora     a
        ret

; Keyboard routines start here
; a:  key code
keyboard_enter:
        lda     keys_flag
        mov     e,a
        ani     KEYS_FLAG_LAST_KEY
        rz                      ; Return if keyboard is not connected (?).
        lxi     h,L0841
        push    h
        mov     a,e
        ani     KEYS_FLAG_COUNTER
        cpi     KEYS_FLAG_OVERFLOW
        jm      .1              ; Jump when not overflow.

        xra     a
        sta     some_key_state  ; Store zero.
        ret

.1:
        mov     d,a
        mvi     c,$00
        mvi     b,$04           ; Number of entries in another_key_buffer.
        lxi     h,another_key_buffer
.loop0:
        mov     a,m             ; Load key from another_key_buffer.
        ora     a
        jz      .loop0next

        ; Save state for the outer loop (another_key_buffer).
        push    h
        push    b
        ; Try find the entry from another_key_buffer in new_key_buffer[0..3].
        mvi     b,$03
        lxi     h,new_key_buffer
.loop1:
        cmp     m
        jz      .loop1end
        inx     h               ; Next in new_key_buffer.
        dcr     b               ; Decrement loop index.
        jp      .loop1          ; End loop.
.loop1end:
        ; Restore state for the outer loop (another_key_buffer).
        pop     b
        pop     h

        jz      .hit0           ; Jump if there was a hit.
        mvi     m,0             ; Else clear entry at another_key_buffer[i].
        dcr     c
.hit0:
        inr     c
.loop0next:
        inx     h
        dcr     b
        jnz     .loop0

.loop0end:
        mov     a,e
        ani     $08
        rnz
        ora     d
        jnz     keyboard_auto_repeat
        mvi     a,KEYBOARD_AUTO_REPEAT_RELOAD
        sta     keyboard_auto_repeat_count
        ret

keyboard_auto_repeat:
        lxi     h,keyboard_auto_repeat_return
        push    h               ; Push return PC on stack.
        lda     keyboard_auto_repeat_count
        inr     a
        jz      .2
        sta     keyboard_auto_repeat_count
.2:
        lda     switchpack1
        ani     SWITCHPACK1_AUTO_REPEAT
        rz                      ; Return if auto repeat is disabled.
        mov     a,e
        ani     $10
        rnz
        lda     some_key_code
        lxi     h,keyboard_auto_repeat_ignore
        mvi     b,keyboard_auto_repeat_ignore_sizeof
.loop2:
        cmp     m
        rz                      ; Return on key ignored by auto repeat.
        inx     h
        dcr     b
        jnz     .loop2

        lxi     h,keyboard_rx_free
        dcr     m
        rnz                     ; Return if not zero.
        mvi     m,$02           ; keyboard_rx_free := 2
        lda     keyboard_auto_repeat_count
        cpi     $ff
        rnz
        mov     a,c             ; c was calculated earlier in keyboard_enter.
        cpi     $01
        rnz

        ; Loop over entries in another_key_buffer.
        mvi     b,4
        lxi     h,another_key_buffer
.loop3:
        mov     a,m             ; Load item and check for zero.
        ora     a
        jnz     .found_nonzero_item
        inx     h               ; Next.
        dcr     b
        jnz     .loop3
        ret

.found_nonzero_item:
        pop     h
        jmp     process_keyboard_item

keyboard_auto_repeat_return:
        mov     a,c
        cpi     $04
        rp
        lxi     b,new_key_buffer

L074E:
        lxi     h,another_key_buffer

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
        lda     some_key_state
        cmp     b
        mov     a,b
        sta     some_key_state
        rnz

process_keyboard_item:
        pop     h
        sta     some_key_code
        cpi     KEY_SETUP
        jz      handle_key_setup
        cpi     KEY_NO_SCROLL
        jz      handle_key_no_scroll
        mov     b,e
        mov     e,a             ; Save a.
        lda     keyboard_is_locked
        ora     a
        jnz     L0841           ; Jump if keyboard is locked.
        mov     a,e             ; Restore a.
        ; Transformation is used to compress the key array. This works
        ; because there are codes which will never show up.
        ; The transformation is "a := a - a/16 - (a&0xf0)/4"
        ; EK-VT100-TM-003, Figure 4-4-4 shows the Keyboard switch array.
        ; The keyboard switch array code in range 0..$f is mapped to lookup
        ; index 0..$a.
        ani     $f0             ; a := a & 0xf0
        rrc
        rrc
        mov     d,a
        rrc
        rrc
        add     d
        mov     d,a
        mov     a,e
        sub     d
        lxi     h,keyboard_switch_array
        mov     e,a
        mvi     d,$00
        dad     d
        mov     c,m             ; c := keyboard_switch_array[transformed code]

        mov     a,c
        ora     a
        jm      handle_special_key      ; Jump if bit 7 is set ($80).

        cpi     ' '
        jc      .put_the_c      ; Jump if 00..1f

        mov     a,b             ; Get keys_flag.
        ani     KEYS_FLAG_CONTROL | KEYS_FLAG_SHIFT | KEYS_FLAG_CAPS_LOCK
        jz      .put_the_c      ; Jump if no modifier.

        ; At least one of {CTRL,SHIFT,CAPS LOCK} active.
        mov     a,c
        cpi     'z' + 1
        jnc     .is_not_letter  ; Jump if it is greater than z.
        cpi     'a'
        jc      .is_not_letter  ; Jump if it is less than 'a'.
        ani     $df             ; Translate a..z -> A..Z.
        mov     c,a
        jmp     .transformed    ; It is a letter.

.is_not_letter:
        mov     a,b             ; Get keys_flag.
        ani     KEYS_FLAG_CONTROL | KEYS_FLAG_SHIFT
        jz      .transformed    ; Jump if no modifier.

        ; At least one of {CTRL,SHIFT} active. Now translate to modified
        ; value, such as "1" -> "!", "2" -> "@", etc.
        lxi     h,transform_when_pressing_shift
.loop:
        mov     a,m
        cmp     c
        jz      .hit    ; Jump on hit.
        inx     h
        inx     h
        jmp     .loop

.hit:
        inx     h
        mov     c,m

; c has now been transformed for SHIFT and CAPS LOCK.
.transformed:
        mov     a,b             ; Get keys_flag.
        ani     KEYS_FLAG_CONTROL
        jz      .put_the_c
        ; CONTROL is a modifier, so transform into a CC (00..1f).
        mov     a,c
        cpi     'A'
        jc      .less_than_A    ; Jump if less than 'A'.
        cpi     '['
        jc      .less_than_sqb  ; Jump if less than '['.
.less_than_A:
        cpi     '?'
        jz      .less_than_sqb
        cpi     ' '
        jz      .less_than_sqb
        cpi     '{'
        jc      L0841
        cpi     $7f
        jnc     L0841

.less_than_sqb:
        ani     $9f
        mov     c,a

.put_the_c:
        ora     c
        push    psw
        lda     switchpack2
        ani     SWITCHPACK2_MARGIN_BELL
        jz      .bell_pended
        sta     margin_bell_pending
.bell_pended:
        pop     psw

uart_putc_urgent:
        ori     $80
        call    uart_putc

L0812:
        call    click_the_keyclick

; Try find some_key_code in array at another_key_buffer.
; If found, then clear out lots of keyboard state.
L0815:
        lda     some_key_code
        mvi     d,4
        lxi     h,another_key_buffer
.loop0:
        cmp     m
        jz      L0841
        inx     h
        dcr     d
        jnz     .loop0

; Try find a zero byte in array at another_key_buffer.
; If found, then fill in with some_key_code, clear out lots of keyboard state.
        mvi     d,4
        lxi     h,another_key_buffer
.loop1:
        mov     a,m
        ora     a
        jz      L0838
        inx     h
        dcr     d
        jnz     .loop1

        jmp     L0841

L0838:
        lda     some_key_code
        mov     m,a
        mvi     a,KEYBOARD_AUTO_REPEAT_RELOAD
        sta     keyboard_auto_repeat_count

L0841:
        xra     a
        lxi     h,keys_flag
        mov     d,m             ; Save keys_flag.
        mov     m,a             ; Clear keys_flag.
        inx     h
        mov     m,d             ; keys_flag_prev := old keys_flag

        ; Clear 4 bytes starting at new_key_buffer.
        inx     h
        mvi     d,4
.loop:
        mov     m,a
        inx     h
        dcr     d
        jnz     .loop
        ret

click_the_keyclick:
        lda     switchpack2
        ani     SWITCHPACK2_KEYCLICK
        rz
        mvi     a,KEYBOARD_STATUS_SPKR_CLICK
        sta     state_for_keyclick
        ret

keyboard_auto_repeat_ignore:
        db      KEY_SETUP
        db      KEY_ESC
        db      KEY_NO_SCROLL
        db      KEY_TAB
        db      KEY_RETURN
keyboard_auto_repeat_ignore_sizeof = $ - keyboard_auto_repeat_ignore

cs_invoke_confidence_test:
        lda     cs_parameter_array
        sui     $02
        rnz                     ; Return if parameter[0] is not 2
        ; parameter[0] is 2. Now have a look at parameter[1].
        mov     d,a             ; d := 0
        lda     cs_parameter_array+1
        mov     e,a             ; e := parameter[1]
L086F:
        mvi     a,$01
        ana     e
        jnz     power_up_and_test_in_e  ; Jump if e has bit 0 set.
L0875:
        mov     a,d
        ora     a
        cnz     L08A7
        push    d
        call    L17BE
        pop     d
        mvi     a,$02
        ana     e
        cnz     data_loopback_test
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
        sta     ram_begin
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

; This may run in the middle of an escape sequence.
process_control_character:
        cpi     ASCII_ESC
        jz      prepare_for_escape_sequence     ; Jump if a is ESC.

        cpi     $10
        jc      parse_cc_0tof   ; Jump if a is the range 0..f.

        ; Now a is in the range 10..1f and it is not ESC. The thing left to
        ; do is to recognize SUB and CAN. For some reason this is done twice.

        ; Return if a is not SUB or CAN.
        mov     e,a
        sui     $18     ; a is in range f8..07 (CAN=0, SUB=2)
        ani     ~$02    ; Mask a with %11111101.
        rnz             ; Only bit patterns %00000000 and %00000010 survive.
        mov     a,e

        ; Return if a is not SUB or CAN.
        cpi     ASCII_SUB
        jz      .sub_or_can
        cpi     ASCII_CAN
        rnz

.sub_or_can:
        call    set_parser_state_to_idle_and_return
        mvi     a,CHARGEN_CHECKERBOARD  ; The checkerboard character.
        jmp     display_character

; MYSTERY: Who enters here?
        ret

; Look up handler for cc 5..15 in a table and jump to it.
; a is in 0..f at entry.
parse_cc_0tof:
        sui     $05
        rm                      ; Eliminate 0, 1, 2, 3, 4.
        ; Generate address pointing in jump table.
        lxi     h,jumptable_for_control_character
        add     a
        mov     e,a             ; hl := jump(a*2)
        mvi     d,0
        dad     d               ; hl := hl + de

        ; Load from jump table to registers. And jump.
        mov     e,m             ; e := (hl)
        inx     h               ; hl++
        mov     d,m             ; d := (hl)
        xchg                    ; Exchange hl and de.
        xra     a               ; Clear a.
        pchl                    ; pc := hl

; For cc in range 5..15.
; These are called with a = 0.
jumptable_for_control_character:
        dw      cc_enq
        dw      cc_ack
        dw      cc_bel
        dw      cc_bs
        dw      cc_ht
        dw      cc_lf
        dw      cc_lf
        dw      cc_lf
        dw      cc_cr
        dw      cc_so
        dw      cc_si

; Shift Out/In: Select (invoke) G1/G0 character set, as designated
; by a select character set (SCS) sequence.
cc_so:
        inr     a                       ; SO: Store 1 (G1).
cc_si:
        sta     charset_state           ; SI: Store 0 (G0).
        ret


; Enquire: Transmit answerback message.
;
; The first two bytes of the answerback_message RAM array are
; loaded. The first one is the delimiter character. If the second
; character equals the delimiter, then it is interpreted as an
; answerback message of length 0 and the routine returns no action.
; If the length is not 0, then set a flag in future_tx and return.
cc_enq:
        lda     online_flags
        ora     a
        rnz                             ; Return if local.
        lhld    answerback_message      ; First 2 bytes of message.
        mov     a,h
        cmp     l
        rz                              ; Return if msg[0]==msg[1].
        lxi     h,future_tx
        mvi     a,FUTURE_TX_ANSWERBACK  ; Request operation and return.
        ora     m
        mov     m,a
        ret

respond_with_the_answerback:
        lxi     h,future_tx
        mov     a,m
        ani     ~FUTURE_TX_ANSWERBACK
        mov     m,a             ; Clear the command.
        lxi     h,answerback_message
        mov     b,m             ; Load delimiter character from answerback[0].
        inx     h
        mvi     c,20            ; Number of characters without delimiters.
        lxi     d,uart_tx_buf
.loop:
        mov     a,m
        cmp     b
        jz      .delimiter      ; Return if answerback[i] = delimiter.
        stax    d               ; Store in the UART TX buffer (uart_tx_buf).
        inx     d
        inx     h
        dcr     c               ; Loop until message max length is reached.
        jnz     .loop
.delimiter:
        dcx     d               ; Address last byte stored.
        ldax    d               ; Load it.
        ori     $80             ; Mark it the last valid character.
        stax    d               ; Store it back.
        jmp     uart_put_string

; Bell: Generate a bell tone.
cc_bel:
        lxi     h,bell_indicator
        mov     a,m             ; Add 8 to bell_indicator but saturate at 255.
        adi     $08
        rc
        mov     m,a             ; The bell_indicator is used in the Vertical
        ret                     ; frequency interrupt handler.

; Backspace: Moves cursor to the left one column position, unless
; it is at the left margin in which case no action occurs.
cc_bs:
        lxi     h,cursposx
        mov     a,m
        ora     a
        rz                      ; If already at left margin then return.
        dcr     m               ; Move cursor left one character position.
        jmp     redraw_cursor

; Carriage Return: Moves cursor to left margin on the current line.
cc_cr:
        xra     a               ; Clear horizontal position and redraw.
        sta     cursposx
        jmp     redraw_cursor

esc_next_line:
        call    cc_cr

; Line Feed - Causes a line feed or a new line operation.
cc_lf:
        lda     switchpack3
        ani     SWITCHPACK3_NEW_LINE
        cnz     cc_cr
        lxi     h,cursposy
        mov     d,m
        lda     scroll_region_bottom
        cmp     d
        jz      .scroll_up              ; Jump if at bottom of scroll region.
        call    get_lines_and_columns
        mov     a,b
        cmp     d
        rz
        inr     d
        mov     m,d
        jmp     redraw_cursor

.scroll_up:
        lda     switchpack1             ; Check for smooth scroll.
        ani     SWITCHPACK1_SCROLL
        jz      cc_lf_jump_scroll       ; Jump if jump scroll.
        ; Scroll is smooth.
        mvi     c,$01
        call    wait_for_the_current_scroll_to_end
        mvi     a,$ff
        sta     clear_line_pending
        inr     m                       ; cursposy++
        call    L0FE6

        ; Wait for someone to set clear_line_pending := $00.
.wait_for_clear_line:
        lda     clear_line_pending
        ora     a
        jnz     .wait_for_clear_line

        sta     cursor_code             ; Store $00.
        dcr     a
        sta     cursor_attr             ; Store $ff.
cc_ack:
        ret

cc_lf_jump_scroll:
        call    L101A
        jmp     redraw_cursor2

prepare_for_escape_sequence:
        xra     a
        sta     esc_intermediate_character      ; Clear it.
        sta     question_for_lh
        lxi     h,parse_escape_sequence
        jmp     set_parser_state_and_return

; If it is a final character (>= '0'), then look up what to do in a
; table. Else, it is an intermediate which we store and come back later.
parse_escape_sequence:
        cpi     '0'
        jnc     .final_character                ; Jump if not intermediate.
        ; An intermediate character arrived. If this was the first
        ; intermediate, then store it as is. Else store an invalid character
        ; value (ff) instead. The observation is that the machine is specied
        ; for ANSI escape sequences with 0 or 1 intermediate characters only.
        lxi     h,esc_intermediate_character    ; Prepare for storing it.
        mov     c,a
        mov     a,m             ; See if we have already got an intermedite
        ora     a               ; character.
        jz      .store          ; Jump and store it if it was the first.
        mvi     c,$ff           ; Else store an invalid value.
.store:
        mov     m,c
        ret                     ; Come back at next input.

; We have previously got ESC and now come here to process the final
; character of the escape sequence. A handling routine is looked up
; in a table. The table is selected based on whether ANSI mode or
; VT52 mode is currently active, and if an intermediate character has
; been seen.
.final_character:
        sta     ascii_jump_value_to_find        ; Lookup routine will use this.
        ; Since this is the final character, the default next state is to
        ; put characters.  The next state can be overridden by the looked up
        ; handler, which happens with CSI for example.
        lxi     h,set_parser_state_to_idle_and_return
        push    h

        ; Sequences with intermediate characters have dedicated handling.
        lda     esc_intermediate_character
        ora     a
        jnz     .final_after_intermediate_character

        ; Select jump table based on ANSI/VT52 mode.
        lda     switchpack2
        ani     SWITCHPACK2_ANSI
        lxi     h,jumptable_escape_sequence_ansi
        jnz     .jump_table_in_h
        lxi     h,jumptable_escape_sequence_vt52
.jump_table_in_h:
        jmp     ascii_jump

.final_after_intermediate_character:
        ; Return if the machine is in VT52 mode.
        mov     b,a
        lda     switchpack2
        ani     SWITCHPACK2_ANSI
        mov     a,b
        rz

        ; We are in ANSI mode and will process: ( ) #
        cpi     '('             ; SCS: Designate ASCII character set as G0.
        lxi     d,charset_for_g0
        jz      designate_a_character_set_as_g0
        cpi     ')'             ; SCS: Designate ASCII character set as G1.
        jz      designate_a_character_set_as_g1
        cpi     '#'
        lxi     h,jumptable_escape_sequence_ansi_hash
        rnz     ; Return if spurious or unsupported intermediate character.

; Find ascii_jump_value_to_find.
; hl: table
; b:  parameter
ascii_jump:
        lxi     d,ascii_jump_last_hit_value     ; Clear it.
        xra     a
        stax    d
        lda     ascii_jump_value_to_find
; Find jump table matching a key and jump to it. a is 0 at jump.
; hl: table (array of key,func pairs)
; a:  character to find (key)
; b:  parameter
ascii_jump_find_a:
        mov     c,a             ; Value to find in c.
.loop:
        xra     a
        add     m
        rz                      ; Return when end of table, with a=0.
        inx     h               ; Forward to address.
        cmp     c               ; Try if character match.
        jz      .hit            ; Hit!
        inx     h               ; No hit, goto next.
        inx     h
        jmp     .loop
.hit:
        stax    d               ; Store hit value in ascii_jump_last_hit_value.
        mov     a,m             ; Load routine pointer to hl.
        inx     h
        mov     h,m
        mov     l,a
        xra     a               ; Clear a.
        pchl                    ; Jump to the thing that was looked up.

got_graphics_processor_on_but_it_is_not_installed:
        pop     h

set_parser_state_to_idle_and_return:
        lxi     h,display_character

set_parser_state_and_return:
        shld    parser_state
        ret

JUMPDEF MACRO parm1, parm2
        db      \1
        dw      \2
        ENDM

; Escape sequences in VT52 mode.
jumptable_escape_sequence_vt52:
        JUMPDEF 'A', vt52_seq_a
        JUMPDEF 'B', vt52_seq_a
        JUMPDEF 'C', vt52_seq_a
        JUMPDEF 'D', vt52_seq_a
        JUMPDEF 'F', vt52_seq_f
        JUMPDEF 'G', vt52_seq_g
        JUMPDEF 'H', vt52_seq_h
        JUMPDEF 'I', esc_reverse_index
        JUMPDEF 'J', vt52_seq_a
        JUMPDEF 'K', vt52_seq_a
        JUMPDEF 'Y', vt52_direct_cursor_address
        JUMPDEF 'Z', esc_identify_terminal
        JUMPDEF '=', esc_keypad_application_mode
        JUMPDEF '>', esc_keypad_numeric_mode
        JUMPDEF '1', esc_graphics_processor_on
        JUMPDEF '<', vt52_seq_lt
        JUMPDEF ']', esc_hard_copy      ; EK-VT102-UG-003 says "Print Screen"
        db      0

; Escape sequences in ANSI mode.
jumptable_escape_sequence_ansi:
        JUMPDEF 'c', rst0                               ; RIS
        JUMPDEF 'E', esc_next_line                      ; NEL
        JUMPDEF 'M', esc_reverse_index                  ; RI
        JUMPDEF '1', esc_graphics_processor_on          ; DECGON
        JUMPDEF '[', esc_csi
        JUMPDEF 'H', esc_horizontal_tabulation_set      ; HTS
        JUMPDEF 'D', cc_lf                              ; IND
        JUMPDEF '7', esc_save_cursor                    ; DECSC
        JUMPDEF '8', esc_restore_cursor                 ; DECRC
        JUMPDEF '=', esc_keypad_application_mode        ; DECKPAM
        JUMPDEF '>', esc_keypad_numeric_mode            ; DECKPNM
        JUMPDEF 'Z', esc_identify_terminal              ; DECDID
        JUMPDEF 'N', esc_single_shift_2                 ; SS2
        JUMPDEF 'O', esc_single_shift_3                 ; SS3
        db      0

; Escape squences beginning with '#'.
jumptable_escape_sequence_ansi_hash:
        JUMPDEF '3', esc_double_height_top              ; DECDHL
        JUMPDEF '4', esc_double_height_bottom           ; DECDHL
        JUMPDEF '5', esc_single_width                   ; DECSWL
        JUMPDEF '6', esc_double_width                   ; DECDWL
        JUMPDEF '7', esc_hard_copy                      ; DECHCP
        JUMPDEF '8', esc_screen_alignment_display       ; DECALN
        db      0

; Interpretation: in the escape sequence "ESC [", the '[' is a
; final character. The parser enters control sequence mode.
esc_csi:
        lxi     h,parse_csi
        shld    parser_state
        pop     h
        ret

; Move cursor to home position.
vt52_seq_h:
        mvi     a,'H'
        sta     ascii_jump_value_to_find
; Cursor up/down/right/left
vt52_seq_a:
        lxi     h,0
        shld    cs_parameter_array      ; Clear parameter array.
        pop     h                       ; Dump previous parser state.
cs_do_final_character:
        lxi     h,set_parser_state_to_idle_and_return
        push    h
        lda     esc_intermediate_character
        ora     a
        rnz     ; If intermediate char(s) between ESC and final then return.

        ; Run command on all parameters.
        lxi     h,jumptable_control_sequence0
        call    ascii_jump
        ; If lookup hit then return.
        lda     ascii_jump_last_hit_value
        ora     a
        rnz

        ; There was no hit in the first table.
        lxi     h,cs_parameter_array
        lda     cs_parameter_index
        ora     a                       ; If index = 0 then set index := 1.
        mov     e,a
        jnz     .index_is_1_or_more
        inr     e

; Run command for each parameter.
.index_is_1_or_more:
        mov     a,m             ; Get parameter i.
        push    h
        push    d
        lxi     h,jumptable_control_sequence1
        mov     b,a
        call    ascii_jump
        pop     d
        pop     h
        ; If lookup did NOT hit then return.
        lda     ascii_jump_last_hit_value
        ora     a
        rz
        ; Run on next parameter.
        inx     h
        dcr     e
        jnz     .index_is_1_or_more
        ret

; Control sequences which take 0 or more parameters.
jumptable_control_sequence0:
        JUMPDEF 'D', cs_cursor_left                     ; CUB
        JUMPDEF 'B', cs_cursor_down                     ; CUD
        JUMPDEF 'C', cs_cursor_right                    ; CUF
        JUMPDEF 'H', cs_cursor_position                 ; CUP
        JUMPDEF 'A', cs_cursor_up                       ; CUU
        JUMPDEF 'r', cs_set_top_and_bottom_margins      ; DECSTBM
        JUMPDEF 'f', cs_cursor_position                 ; HVP
        JUMPDEF 'x', cs_request_terminal_parameters     ; DECREQTPARM
        JUMPDEF 'y', cs_invoke_confidence_test          ; DECTST
        db      0

; Control sequences which take exactly one parameter.
jumptable_control_sequence1:
        JUMPDEF 'c', cs_device_attributes               ; DA
        JUMPDEF 'q', cs_load_leds                       ; DECLL
        JUMPDEF 'n', cs_device_status_report            ; DSR
        JUMPDEF 'J', cs_erase_in_display                ; ED
        JUMPDEF 'K', cs_erase_in_line                   ; EL
        JUMPDEF 'l', cs_reset_mode                      ; RM
        JUMPDEF 'm', cs_select_graphic_rendition        ; SGR
        JUMPDEF 'h', cs_set_mode                        ; SM
        JUMPDEF 'g', cs_tabulation_clear                ; TBC
        db      0

; Read line and column and then move there. This is the only VT52
; sequence which has more than two characters (including ESC). We
; enter here when "ESC Y" has arrived. For now install the dedicated
; parse handler.
vt52_direct_cursor_address:
        lxi     h,parse_vt52_direct_cursor_address
        shld    parser_state
        pop     h
        ret

parse_vt52_direct_cursor_address:
        mov     b,a
        cpi     $20
        jc      process_control_character ; a is in CC range (00..1f)
        cpi     ASCII_ESC
        lxi     h,state_for_direct_cursor_address
        jnz     .not_esc        ; Jump if not ASCII_ESC.
        ; Got ESC so abort and go on with the escape sequence handler.
        lxi     h,parse_escape_sequence
        shld    parser_state
        ret
.not_esc:
        mov     a,m             ; Load the state
        ora     a
        jnz     .state1
.state0:
        mvi     m,$01           ; Set state 1.
        mov     a,b
        sui     $20             ; Decode line number parameter.
        sta     line_for_direct_cursor_address
        lxi     h,parse_vt52_direct_cursor_address
        shld    parser_state
        ret
.state1:
        mvi     m,$00           ; Set state 0.
        mov     a,b
        sui     $20             ; Decode column number parameter.
        cpi     $50
        jnc     .posx_set       ; If 80 <= column then jump.
        sta     cursposx        ; Only use parameter if it is in range 0..79.
.posx_set:
        call    get_lines_and_columns
        lda     line_for_direct_cursor_address
        inr     b               ; b := number of lines
        cmp     b
        jnc     .posy_set
        sta     cursposy        ; Only use parameter if it is range 0..lines-1
.posy_set:
        call    set_parser_state_to_idle_and_return
        jmp     redraw_cursor

L0B63:
        xra     a
        sta     setup_132columns
        call    L10AD
        mvi     c,80
        call    L10F9
        call    L114C
        mvi     c,80
        jmp     L0B89

L0B77:
        mvi     a,1
        sta     setup_132columns
        call    L10AD
        mvi     c,132
        call    L10F9
        call    L114C
        mvi     c,132

L0B89:
        xra     a
        sta     scroll_region_top
        call    get_lines_and_columns
        mov     a,b
        sta     scroll_region_bottom
        mov     a,c
        sta     number_of_columns
        call    reconfigure_display
        call    use_new_origin_mode
        mvi     a,$01
        jmp     L0FAA

; This is the opposite of line feed. See cc_lf.
esc_reverse_index:
        lxi     h,cursposy
        lda     scroll_region_top
        mov     b,a
        mov     a,m
        cmp     b
        jz      .scroll_down            ; Jump if at top of scroll region.
        ora     a
        rz                              ; Return if cursposy is 0.
        lxi     h,cursposy              ; Else decrement position and redraw.
        dcr     m
        jmp     redraw_cursor

.scroll_down:
        lda     switchpack1             ; Check for smooth scroll.
        ani     SWITCHPACK1_SCROLL
        jz      .jump_scroll            ; Jump if jump scroll.
        ; Scroll is smooth.
        mvi     c,$01
        call    wait_for_the_current_scroll_to_end
        mvi     a,$ff
        sta     clear_line_pending
        dcr     m                       ; cursposy--
        call    L0FEB

        ; Wait for someone to set clear_line_pending := $00.
.wait_for_clear_line:
        lda     clear_line_pending
        ora     a
        jnz     .wait_for_clear_line

        sta     cursor_code             ; Store $00.
        ret

.jump_scroll:
        call    L102D
        jmp     redraw_cursor2

esc_keypad_application_mode:
        lxi     h,application_keypad_mode
        mvi     m,1
        ret

esc_keypad_numeric_mode:
        lxi     h,application_keypad_mode
        mvi     m,0
        ret

; This is "Set ANSI mode" invoked from VT52 mode.
vt52_seq_lt:
        lxi     h,switchpack2
        mov     a,m
        ori     SWITCHPACK2_ANSI
        mov     m,a
L0BF2:
        lda     switchpack3
        ani     SWITCHPACK3_UK
        mvi     h,CHARSET_US    ; Something with dollar symbol.
        jz      .us
        mvi     h,CHARSET_UK    ; Something with pound symbol.
.us:
        mov     l,h
        shld    charset_for_g0 ; store l and h to memory.
        shld    charset_for_something0
        xra     a
        sta     charset_state           ; Store 0.
        ret

vt52_seq_f:
        mvi     h,CHARSET_SPECIAL
        jmp     vt52_seq_gorf
vt52_seq_g:
        mvi     h,CHARSET_US
vt52_seq_gorf:
        mov     l,h
        shld    charset_for_g0
        ret

cs_load_leds:
        lxi     h,state_for_leds
        mov     a,b
        ora     a
        jnz     .setit
        mov     a,m             ; Parameter indictes clear.
        ani     ~KEYBOARD_STATUS_LED
        mov     m,a
        ret
.setit:
        sui     $05
        rp
        mov     b,a
        xra     a
        stc                     ; Set carry flag to one.
.loop:
        ral
        inr     b
        jnz     .loop
        ora     m
        mov     m,a
        ret

; a:  the machine character set to designate as the soft set g0/g1.
; d:  charset_for_g0
designate_a_character_set_as_g1:
        inx     d
designate_a_character_set_as_g0:
        lda     ascii_jump_value_to_find
        mov     b,a
        lxi     h,select_character_set_jump - 2
.loop:
        inx     h
        inx     h
        mov     a,m             ; Load key.
        ora     a
        rz                      ; Return at end of table.
        cmp     b               ; Check match.
        jnz     .loop           ; If key does not match then continue loop.

        inx     h               ; Index into the charset data byte.
        mov     a,m             ; Load the data.
        stax    d               ; Store to charset_for_g0 (or +1)
        ret

; SS2: Selects G2 (default) character set for one character.
; SS3: Selects G3 (default) character set for one character.
esc_single_shift_2:
esc_single_shift_3:
        lxi     h,charset_state
        inr     m
        inr     m
        ret

select_character_set_jump:
        db      'A', CHARSET_UK
        db      'B', CHARSET_US
        db      '0', CHARSET_SPECIAL
        db      '1', CHARSET_ALT
        db      '2', CHARSET_ALT_SPECIAL
        db      0

; For the VT105 graphics processor option. Not related to AVO.
; All subsequent characters are interpreted as commands or data to
; the VT105 graphics processor option.  The terminal remains in this
; mode until the grahics processor off command is received.
esc_graphics_processor_on:
        lxi     h,vt105_graphics_option
        mov     a,m
        ora     a
        jz      got_graphics_processor_on_but_it_is_not_installed
        ; The terminal remains in this mode until ESC 2 is received.
        mvi     m,VT105_GRAPHICS_OPTION_IS_INSTALLED_AND_ON
        pop     h       ; Undo parser_state.
graphics_processor_on_remain:
        lxi     h,parse_graphics_processor_on_fsm0
        jmp     set_parser_state_and_return

esc_save_cursor:
        lxi     h,cursposx_back ; Destination
        lxi     d,cursposx      ; Source
        jmp     esc_copy_cursor

esc_restore_cursor:
        lxi     h,cursposx      ; Destination
        lxi     d,cursposx_back ; Source

esc_copy_cursor:
        mvi     b,11            ; Copy 11 bytes (10 would be enough).
        call    memcpy          ; from de to hl
        jmp     redraw_cursor

cs_select_graphic_rendition:
        lxi     h,jumptable_cs_sgr
        mov     a,b
        ora     a
        jz      cs_sgr_off              ; Attributes off
        jmp     ascii_jump_find_a

jumptable_cs_sgr:
        JUMPDEF $01, cs_sgr_bold        ; Bold or increased intensity
        JUMPDEF $04, cs_sgr_underscore  ; Underscore
        JUMPDEF $05, cs_sgr_blink       ; Blink
        JUMPDEF $07, cs_sgr_reverse     ; Negative (reverse) image
        db      $00

cs_sgr_off:
        sta     character_attribute_base           ; Clear
        lxi     h,character_attribute_avo
        mov     a,m
        ori     ~CHAR_ATTR_ALT_CHAR_L
        mov     m,a
        ret

cs_sgr_bold:
        mvi     a,~CHAR_ATTR_BOLD_L
        jmp     cs_sgr_write_character_attribute_avo

cs_sgr_underscore:
        lda     avo_is_not_installed
        ora     a
        jnz     cs_sgr_reverse  ; Jump if no AVO.
        ; AVO is installed.
        mvi     a,~CHAR_ATTR_UNDERLINE_L
        jmp     cs_sgr_write_character_attribute_avo

cs_sgr_blink:
        mvi     a,~CHAR_ATTR_BLINK_L
cs_sgr_write_character_attribute_avo:
        lxi     h,character_attribute_avo
        ana     m               ; An attribute is enabled by clearing a bit.
        mov     m,a             ; Store back.
        ret

; Set the base attribute. If AVO is not present, then this is the
; only character attribute that can be set.
cs_sgr_reverse:
        mvi     a,BASE_ATTRIBUTE_MASK
        sta     character_attribute_base
        ret

cs_device_attributes:
        lda     cs_parameter_array
        ora     a
        rnz
esc_identify_terminal:
        lxi     h,future_tx
        mov     a,m
        ori     FUTURE_TX_IDENTIFY_TERMINAL
        mov     m,a
        ret

respond_to_identify_terminal:
        mvi     a,~FUTURE_TX_IDENTIFY_TERMINAL
        call    put_csi
        lda     switchpack2
        ani     SWITCHPACK2_ANSI
        jnz     .ansi           ; Jump if ANSI.

.vt52:
        ; Respond with "ESC / Z".
        mvi     m,'Z' | $80     ; Terminator.
        dcx     h
        mvi     m,'/'
        jmp     uart_put_string

.ansi:
        ; Respond with "ESC ? 1 ; [flags] c"
        ; flags: $04=graphics option, $02=AVO, $01=STP
        mvi     m,'?'
        inx     h
        mvi     a,'1'
        call    put_char_and_semicolon
        in      IN_FLAG_BUFFER
        mov     b,a
        cma                     ; Do the one's complement.
        ani     FLAG_BUFFER_GRAPHICS_FLAG_L | FLAG_BUFFER_ADVANCED_VIDEO_L
        mov     c,a
        mov     a,b             ; IN_FLAG_BUFFER
        ani     FLAG_BUFFER_OPTION_PRESENT_H    ; STP is installed.
        jz      .no_stp
        inr     c               ; Install the STP bit in flags.
.no_stp:
        mov     a,c
        ori     '0'
        mov     m,a             ; Store flags in UART TX buffer.
        inx     h
        mvi     m,'c' | $80
        jmp     uart_put_string

cs_device_status_report:
        lda     question_for_lh
        ora     a
        rnz
        mov     a,b
        lxi     h,future_tx
        cpi     $06
        jz      please_report_active_position
        cpi     $05
        rnz
please_report_status:
        mov     a,m
        ori     FUTURE_TX_PLEASE_REPORT_ACTIVE_POSITION
        mov     m,a
        ret

; DSR
respond_with_the_status:
        mvi     a,~FUTURE_TX_PLEASE_REPORT_ACTIVE_POSITION
        call    put_csi
        mvi     b,$03           ; "malfunction - retry"
        lda     device_status_malfunction
        ora     a
        mov     a,b
        jnz     .has_parameter
        xra     a               ; "ready, no malfunctions detected (default)"
.has_parameter:
        ori     '0'
        mov     m,a
        inx     h
        mvi     m,'n' | $80
        jmp     uart_put_string

please_report_active_position:
        mov     a,m
        ori     FUTURE_TX_PLEASE_REPORT_STATUS
        mov     m,a
        ret

; CPR
respond_with_the_active_position:
        mvi     a,~FUTURE_TX_PLEASE_REPORT_STATUS
        call    put_csi
        lda     cursposy
        mov     b,a
        lda     origin_mode_is_relative
        ora     a
        jz      .absolute
        lda     scroll_region_top
.absolute:
        mov     c,a
        mov     a,b
        sub     c
        inr     a
        call    L0D7A
        call    put_semicolon
        lda     cursposx
        inr     a
        call    L0D7A
        mvi     m,'R' | $80
        jmp     uart_put_string

esc_hard_copy:
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_GRAPHICS_FLAG_L
        rnz                     ; If option is not installed then return.
        mvi     c,$81
        call    wait_for_the_current_scroll_to_end
        mvi     a,$ff
        out     OUT_GRAPHICS_PORT
        nop

L0D6F:
        call    something_with_uart_and_keyboard
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_GRAPHICS_FLAG_L
        jnz     L0D6F           ; If option is not installed then jump.
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

; DECALN: Screen Alignment Display (DEC Private)
esc_screen_alignment_display:
        mvi     a,'E'
        sta     fill_loop_code
        call    fill_the_entire_screen_area
        mvi     a,'E'
        sta     cursor_code
        xra     a
        sta     fill_loop_code
        ret

put_char_and_semicolon:
        mov     m,a
        inx     h
put_semicolon:
        mvi     m,';'
        inx     h
        ret

put_csi:
        lxi     h,future_tx
        ana     m
        mov     m,a
        lxi     h,uart_tx_buf
        mvi     m,ASCII_ESC
        inx     h
        mvi     m,'['
        inx     h
        ret

; MYSTERY: Who enters here?
        mov     b,d
cs_tabulation_clear:
        mov     a,b
        ora     a
        jnz     .1
        call    L0DE5
        ret

.1:
        cpi     $03
        rnz
        call    L0DEC
        ret

; Set one horizontal stop at the active position.
esc_horizontal_tabulation_set:
        call    get_tab_for_active_position
        ; We now have:
        ; hl: byte address for active horizontal position.
        ; a:  bitmask (bits 7..0) for horizontal position.
        ora     m               ; Install the bitmask.
        mov     m,a             ; And store it back.
        ret

L0DE5:
        call    get_tab_for_active_position
        cma
        ana     m
        mov     m,a
        ret

L0DEC:
        lxi     h,tabs

L0DEF:
        xra     a
        mov     m,a
        inx     h
        mov     a,l
        cpi     $a2
        jnz     L0DEF
        ret

; Horizontal Tab: Moves cursor to the next tab stop, or to the
; right margin if there are no more tab stops.
cc_ht:
        call    get_tab_for_active_position
.1:
        inr     c
        ora     a
        rar                     ; 9-bit rotate through carry
        jc      .3              ; Jump if bit 0 was set.
.2:
        mov     d,a
        ana     m
        mov     a,d
        jz      .1
        jmp     .4
.3:
        inx     h               ; Next in tabs array.
        mov     a,l
        cpi     (tabs+17) & $ff ; Compare location after last tab byte ($a2).
        mvi     a,$80
        jnz     .2              ; Jump if not end of tabs table.
        dcr     c               ; a was $a2
.4:
        lda     cursposx_max
        cmp     c
        jc      .5
        mov     a,c
.5:
        sta     cursposx
        jmp     redraw_cursor

get_tab_for_active_position:
        lda     cursposx
        mov     c,a
get_tab_for_position_in_a_and_c:
        mov     d,a
        lxi     h,tabs          ; Tabs are encoded in bits over 17 bytes.

; tabs:         "1010101010101"
; switchpack:   "1101  2 0111  3 0000  4 1000  5 ----"
; bitpos:        0123456789abcdef...
; byte offset:   0       1       2...
; in
;   - hl: bitmap (switchpack1 or tabs)
;   - a:  bitpos ($00..$27 for switchpack, 0..131 for tabs)
;   - d:  same as a
; out:
;   - hl: byte address for bit at x
;   - a:  bitmask (bits 7..0) for bit at x
get_bitmap_bit:
        rrc
        rrc
        rrc             ; a is the byte offset.
        ani     $1f     ; Clear bits shifted in from left.
        add     l
        mov     l,a     ; hl is now byte address of the bit of interest.
        mov     a,d     ; Get original character offset.
        ani     $07     ; Extract bit index of the target byte. Move it to
        mov     d,a     ; d which is index in the loop below.
        mvi     a,$80   ; character pos 0 is MSB
get_bitmap_bit_loop:
        dcr     d       ; Now do right shifts.
        rm              ; Until bit index reaches 0.
        rrc             ; Only zero bits will be shifted in.
        jmp     get_bitmap_bit_loop

L0E3E:
        lda     online_flags
        lxi     h,is_in_setup
        ora     m
        mov     b,a
        rnz
; Send urgent (XON/XOFF) character.
L0E47:
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_XMIT_FLAG_H
        rz                      ; If TX buffer is not empty then return.
        lxi     h,transmitter_urgent_char1
        mov     a,m
        ora     a
        mvi     m,$00           ; Clear the urgent character variable.
        dcx     h
        rz
        mov     a,m
        out     OUT_PUSART_DATA
        ret

handle_some_uart:
        di
        call    L0E3E           ; Put at most one character.
        ei
        mov     a,b
        ora     a
        jnz     L0E6D
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_XMIT_FLAG_H
        rz                      ; If TX buffer is not empty then return.
        lda     received_xoff
        ora     a
        rnz                     ; Return if not allowed to send on UART TX.

L0E6D:
        lxi     h,something_has_higher_prio_than_future_tx
        mov     a,m
        ora     a
        jz      .parse_future_tx        ; Jump if no higher prio.
        lhld    this_has_higher_prio_than_future_tx
        pchl

.parse_future_tx:
        lda     future_tx
        ora     a
        rz                      ; Return if nothing to do.
        mvi     e,0             ; Clear the command.
.loop:
        rar                     ; Find lowest set bit and process it.
        jc      .do_jumptable_for_callback
        inr     e               ; e += 2
        inr     e
        jmp     .loop
.do_jumptable_for_callback:
        mvi     d,0
        lxi     h,jumptable_for_callback        ; e is the index.
        dad     d
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        pchl

jumptable_for_callback:
        dw      respond_with_the_active_position
        dw      respond_with_the_terminal_parameters
        dw      respond_to_identify_terminal
        dw      respond_with_the_status
        dw      respond_with_the_answerback
        dw      callback_for_future_tx_bit5

callback_for_future_tx_bit5:
        lxi     h,tx_fifo
        mov     b,m
        mov     d,h
        mov     e,l
        ; Shift data left to lower addresses.
        inx     d               ; de := hl + 1
        mvi     c,8             ; Loop 8 times.
.loop:
        ldax    d               ; a := (de)
        mov     m,a             ; (hl) := a
        inx     h               ; hl++
        inx     d               ; de++
        dcr     c               ; Next
        jnz     .loop

        lxi     h,tx_fifo_count
        dcr     m
        mov     a,m
        mov     c,a
        jnz     L0EC1
        lxi     h,future_tx
        mov     a,m
        ani     ~FUTURE_TX_BIT5 ; No more TX.
        mov     m,a
L0EC1:
        lda     online_flags
        ora     a
        jnz     L0ECF
        mov     a,c
        cpi     $05
        jnc     L0ED2
        xra     a
L0ECF:
        sta     keyboard_is_locked
L0ED2:
        mov     a,b
        ani     $80
        ral
        cmc
        rar
        sta     something_has_higher_prio_than_future_tx
        lxi     h,callback_for_future_tx_bit5
        shld    this_has_higher_prio_than_future_tx
uart_put_char:
        mov     a,b
        ani     $7f
        mov     b,a
        lda     online_flags
        lxi     h,is_in_setup
        ora     m
        mov     a,b
        jnz     L0593           ; If local or in setup then process as local.
        out     OUT_PUSART_DATA
        ret

uart_put_string:
        lxi     h,.uart_put_handler
        shld    this_has_higher_prio_than_future_tx
        xra     a
        sta     uart_put_string_state                           ; Store 0.
        inr     a
        sta     something_has_higher_prio_than_future_tx        ; Store 1.
.uart_put_handler:
        lxi     h,uart_put_string_state
        mov     a,m
        inr     m               ; Increment the state.
        lxi     h,uart_tx_buf
        add     l               ; Next character.
        mov     l,a
        mov     b,m             ; Load character.
        mov     a,b
        ora     a
        jp      uart_put_char   ; Jump if bit 7 is 0 (more characters).
        xra     a
        sta     something_has_higher_prio_than_future_tx        ; Store 0.
        jmp     uart_put_char

; Parameter is in a: sometimes it is ASCII_ESC, sometimes it has bit 7 set.
; TODO: What does bit 7 in a mean?
uart_putc:
        push    h
        push    d
        mov     d,a
        lda     switchpack2
        ani     SWITCHPACK2_AUTO_XON_XOFF
        jz      .auto_xon_xoff_is_off
        mov     a,d
        sui     $91                     ; Check for XON or XOFF or:ed with $80.
        ani     $fd
        jz      prepare_urgent_char     ; Jump if d=$91 or d=$93.

.auto_xon_xoff_is_off:
        lxi     h,future_tx
        mov     a,m
        ori     FUTURE_TX_BIT5
        mov     m,a
.again:
        lxi     h,tx_fifo_count
        mov     a,m
        inr     m               ; tx_fifo_count++
        lxi     h,tx_fifo
        mov     e,a
        add     l
        mov     l,a             ; hl := tx_fifo[tx_fifo_count-1]
        mov     m,d             ; tx_fifo[tx_fifo_count-1] := data
        mvi     a,$80 | ASCII_CR
        cmp     d               ; If sending CR then maybe add LF.
        jnz     .fifo_done
        lda     switchpack3
        ani     SWITCHPACK3_NEW_LINE
        mvi     d,$80 | ASCII_LF
        jnz     .again

.fifo_done:
        lda     online_flags
        ora     a
        jnz     L0F5B
        mvi     a,$05
        cmp     e
        mvi     a,$00
        rar
L0F5B:
        sta     keyboard_is_locked
L0F5E:
        pop     d
        pop     h
        ret

prepare_urgent_char:
        mov     a,d
        ani     $7f
        mov     d,a
        lxi     h,transmitter_urgent_char1
        mov     a,m             ; Load transmitter_urgent_char1.
        ora     a
        jnz     .already_has_one
        dcx     h
        mov     a,m             ; Load transmitter_urgent_char0.
        cmp     d
        jnz     .already_has_one
        inx     h
        mov     m,d             ; Store transmitter_urgent_char1.
.already_has_one:
        mov     c,d
        mvi     b,$02
        call    L0F7E
        jmp     L0F5E

; b:  0, 1 or 2
; c:  UART RX byte (sometimes called with explicit XON and XOFF)
L0F7E:
        lda     switchpack2
        ani     SWITCHPACK2_AUTO_XON_XOFF
        rz                      ; Return if "AUTO XON XOFF" is "OFF".

        lda     online_flags
        ora     a
        rnz                     ; Return if local.

        mov     a,c
        lxi     h,L21BF
        cpi     CHAR_XOFF
        mov     a,b             ; a: 0, 1 or 2
        jz      .is_xoff        ; If c = XOFF then jump.

        ; c is not XOFF
        cma                     ; Invert a.
        ana     m               ; a := L21BF AND a.
        mov     m,a             ; L21BF := a
        push    psw
        ani     $02
        sta     silo_getc_disable
        pop     psw
        rnz

.is_xoff:
        ora     m
        mov     m,a
        mov     a,c
        lxi     h,transmitter_urgent_char0
        cmp     m
        rz                      ; If transmitter_urgent_char0 = c then return.

        mov     m,a             ; transmitter_urgent_char0 := c.
        inx     h
        mov     m,a             ; transmitter_urgent_char1 := c
        ret

L0FAA:
        lxi     h,incremented_in_vfreq
        add     m
        ; While incremented_in_vfreq is not 0.
.loop:
        cmp     m
        rz
        push    h
        push    psw
        lda     is_in_setup
        ora     a
        cz      something_with_uart_and_keyboard
        pop     psw
        pop     h
        jmp     .loop

; Can be called from vfreq_handler.
L0FBE:
        lhld    screen_buffer_a_ptr
        mov     a,h
        ori     LINE_ATTR_SCROLL | LINE_ATTR_NORMAL | LINE_ADDR_2000
        mov     h,a
        shld    screen_buffer_a_ptr

; Clear one line?
L0FC8:
        lda     number_of_columns
L0FCB:
        mov     b,a

        mov     a,h
        ani     $0f             ; Clear upper nibble of address.
        ori     $20             ; Set upper nibble to $2.
        mov     h,a             ; hl = $2xyz.
        adi     $10             ; a := $3x
        mov     d,a             ; de = hl + $1000
        mov     e,l
        mvi     a,$ff
.loop:
        mvi     m,$00           ; Store $00.
        stax    d               ; Store $ff.
        inx     d               ; Next location.
        inx     h               ; --''--
        dcr     b               ; For each column to erase.
        jnz     .loop

        inr     a
        sta     clear_line_pending     ; Store $00.
        ret

L0FE6:
        mvi     b,$ff
        jmp     L0FED

L0FEB:
        mvi     b,$01

L0FED:
        lxi     h,scroll_region_top
        mov     d,m
        inx     h               ; hl: scroll_region_bottom
        mov     e,m
        mov     a,b
        ora     a
        mov     a,d
        jp      L0FFA
        mov     a,e

L0FFA:
        call    logical_line_to_physical_line
        mov     a,e
        sub     d
        mov     c,a
        lda     latofs+24

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
        sta     latofs+24

redraw_cursor2:
        mvi     a,$ff
        sta     cursposy_prev
        jmp     redraw_cursor

L101A:
        call    probably_wait_for_a_scroll
        lda     scroll_region_bottom
        call    L122F
        call    L0FE6
        lda     scroll_region_top
        dcr     a
        jmp     L103E

L102D:
        call    probably_wait_for_a_scroll
        lda     scroll_region_top
        dcr     a
        call    L122F
        call    L0FEB
        lda     scroll_region_bottom
        dcr     a

L103E:
        call    L11CE
        ei
        sta     L207A
        lxi     h,scroll_region_bottom
        mov     a,m
        dcx     h
        sub     m               ; scroll_region_top
        cpi     23
        rnz

; Called as first thing in vfreq_handler.
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
        inx     h               ; $2076
        mov     m,e

L106A:
        lxi     h,L2056
        shld    L2058
        shld    L2075
        ret

; Updates the following variables, based on cursposy:
; - cursor_is_at_double_width_line
; - screen_ram_beginning_of_line
update_cursor_variables:
        call    cursposy_to_physical_line
        ani     $80
        sta     cursor_is_at_double_width_line
        call    cursposy_to_line_data
        shld    screen_ram_beginning_of_line
        ret

; Set len bytes at dest to val
; b:  val
; hl: dest
; de: len
memset:
        mov     m,b             ; Store the value.
        inx     h               ; Next destination byte.
        dcx     d               ; Decrement len counter.
        mov     a,d             ; 16-bit zero detection
        ora     e
        jnz     memset           ; Loop when not done.
        ret

        mvi     c,$00

; c:  $01: Call something_with_uart_and_keyboard.
; c:  $80: Tail-call probably_wait_for_a_scroll.
; Loop while poll_scroll_pend0 and poll_scroll_pend1 are both non-zero.
wait_for_the_current_scroll_to_end:
.loop:
        lxi     h,poll_scroll_pend0
        di
        lda     poll_scroll_pend1
        ora     m
        ei
        jz      .got0

        mov     a,c
        rar
        push    b
        cc      something_with_uart_and_keyboard        ; Call if c(0) = 1.
        call    keyboard_rx_check
        pop     b
        jmp     .loop

.got0:
        mov     a,c
        ral
        rnc                                             ; Return if c(7) = 0.
        jmp     probably_wait_for_a_scroll              ; Do  it if c(7) = 1.

L10AD:
        ; Install line at 2006 which loops back on itself.
        lxi     h,(6<<8) | LINE_ATTR_NORMAL | LINE_ADDR_2000
        shld    line0ptr
        xra     a               ; a := 0
        sta     poll_scroll_pend0
        sta     poll_scroll_pend1
        sta     smooth_scroll_term_a
        out     OUT_VIDEO_PROCESSOR_DC012       ; Load scroll latch with 0.
        mvi     a,DC012_LOAD_HIGH_SCROLL
        out     OUT_VIDEO_PROCESSOR_DC012
        call    L106A
        ei
        mvi     a,$01
        call    L0FAA

        lxi     h,screen_22d0_user_lines_begin
        mov     a,h
        adi     $10
        mov     d,a
        mov     e,l
        lxi     b,(attribute_ram_begin-1)-screen_22d0_user_lines_begin

        ; hl: Screen RAM user lines
        ; de: Attribute RAM
.loop:
        lda     fill_loop_code
        mov     m,a             ; Install chargen index code in screen RAM.
        inx     h               ; Next screen RAM location.
        mvi     a,$ff
        stax    d               ; Clear attributes in attribute RAM.
        inx     d               ; Next screen RAM location.
        dcx     b
        mov     a,b
        ora     c
        jnz     .loop           ; Loop if de /= 0.

        lda     fill_loop_code
        sta     cursor_code
        xra     a
        sta     cursposy        ; cursposy := 0
        sta     cursposx        ; cursposx := 0
        mvi     a,$ff
        sta     cursor_attr     ; Clear cursor attribute.
        ret

L10F9:
        xra     a
        sta     poll_scroll_pend0
L10FD:
        lda     poll_scroll_pend1
        ora     a
        jnz     L10FD
        lxi     h,screen_22d0_user_lines_begin
        mvi     b,$00
        dad     b
        call    get_lines_and_columns
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
        call    add_a_to_hl
        mvi     m,$7f
        dcr     c
        mvi     a,$03           ; TODO: should be 9???
        sta     screen_ram_50hz
        ; Same as initdata_for_screen
        lxi     h,($d0<<8)|LINE_ATTR_SCROLL|LINE_ATTR_NORMAL|LINE_ADDR_2000|2
        shld    line0ptr
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
        call    add_a_to_hl
        dcr     b
        jnz     L1136
        ret

L114C:
        lxi     h,plinestart
        inr     c
        inr     c
        inr     c
        lxi     d,screen_22d0_user_lines_begin
        mvi     b,$00
        mvi     a,25

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
        sta     scroll_region_top
        call    get_lines_and_columns
        mov     a,b
        sta     scroll_region_bottom
        inr     a
        sta     latofs+24
        lhld    plinestart+(2*24)
        mvi     a,23
        cmp     b
        jz      L117E
        lhld    plinestart+(2*14)

L117E:
        mov     a,h
        ori     LINE_ATTR_SCROLL | LINE_ATTR_NORMAL | LINE_ADDR_2000
        mov     h,a
        shld    screen_buffer_a_ptr
        lxi     h,latofs
        xra     a

.clear_loop:
        mov     m,a             ; Store a
        inr     l               ; Next dest
        inr     a               ; a++
        dcr     b               ; For each line
        jp      .clear_loop
        ret

probably_wait_for_a_scroll:
        di
        lda     L207A
        ora     a
        jz      .loop1
.loop0:
        ei
        call    something_with_uart_and_keyboard
        jmp     probably_wait_for_a_scroll

.loop1:
        lda     poll_scroll_pend1
        ora     a
        jnz     .loop2
        lda     poll_scroll_pend0
        ora     a
        ei
        rz
        jmp     .loop0

.loop2:
        lda     smooth_scroll_term_b
        lxi     h,smooth_scroll_term_a
        add     m
        daa
        ani     $0f
        jz      .loop0
        ei
        ret

; a:  running 132 columns
; b:  Number of lines - 1
get_lines_and_columns:
        push    h
        mvi     b,23
        lda     setup_132columns
        lxi     h,avo_is_not_installed
        ana     m
        pop     h
        rz                      ;  80 columns or AVO installed:     24 lines
        mvi     b,13            ; 132 columns and no AVO installed: 14 lines
        ret

L11CE:
        ora     a
        jp      L11E8
        lxi     h,line0ptr
        push    h
        mov     a,m
        inx     h
        mov     l,m
        ori     $f0
        mov     h,a
        shld    screen_buffer_a_ptr
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
        shld    screen_buffer_a_ptr
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
        lda     number_of_columns
        rrc
        mov     d,a
        call    add_a_to_hl
        inx     h
        di
        shld    L2075
        mov     a,d
        call    add_a_to_hl
        mov     m,b
        inx     h
        mov     m,c

L1228:
        mov     h,b
        mov     l,c
        shld    L2179
        ei
        ret

; This can be called by vreq_handler.
L122F:
        push    psw
        call    L0FBE
        pop     psw
        ora     a
        lxi     h,line0ptr
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
        lda     number_of_columns
        rrc
        mov     b,a
        call    add_a_to_hl
        inx     h
        di
        shld    L2058
        mov     a,b
        mov     b,m
        inx     h
        mov     c,m
        call    add_a_to_hl
        xchg
        lhld    screen_buffer_a_ptr
        xchg
        mov     m,e
        dcx     h
        mov     m,d

L1271:
        lhld    screen_buffer_a_ptr
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
        lxi     h,line0ptr

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
        call    add_number_of_columns_to_hl
        inx     h

L129D:
        mov     a,h
        ani     $0f
        ori     $20
        mov     h,a
        ret

esc_double_width:
        call    install_new_line_attribute
        db      LINE_ATTR_DW | LINE_ADDR_2000

esc_double_height_top:
        call    install_new_line_attribute
        db      LINE_ATTR_DH_TOP | LINE_ADDR_2000

esc_double_height_bottom:
        call    install_new_line_attribute
        db      LINE_ATTR_DH_BOTTOM | LINE_ADDR_2000

install_new_line_attribute:
        call    probably_wait_for_a_scroll
        lxi     h,latofs
        lda     cursposy
        add     l
        mov     l,a
        mov     a,m             ; a := latofs[cursposy]
        ori     $80             ; Mark as double-width.
        mov     m,a             ; Store back in latofs[cursposy].
        call    cursposy_to_line_data
        call    L13C3
        pop     h               ; Parameter is at byte after call.
        mov     a,m             ; Read the parameter.
        call    L1395
        lda     cursposx_max
        lxi     h,cursposx
        ora     a               ; carry: 0
        rar                     ; 9-bit rotate right through carry
        cmp     m
        jnc     redraw_cursor2  ; Jump if cursposx <= cursposx_max/2
        lxi     h,cursor_code   ; TODO: Why?
        shld    screen_ram_cursor_pos
        jmp     redraw_cursor2  ; Return address already popped.

cs_request_terminal_parameters:
        lda     cs_parameter_array
        cpi     $02
        rnc                     ; Return if 2 <= parameter
        sta     terminal_parameters_request_type        ; Store request type.
L12E8:
        lxi     h,future_tx
        mov     a,m
        ori     FUTURE_TX_REQUEST_TERMINAL_PARAMETERS
        mov     m,a
        ret

respond_with_the_terminal_parameters:
        mvi     a,~FUTURE_TX_REQUEST_TERMINAL_PARAMETERS
        call    put_csi
        lda     terminal_parameters_request_type        ;  0  or  1
        ori     '2'                                     ; '2' or '3'
        call    put_char_and_semicolon
        lda     switchpack4
        push    psw
        ani     SWITCHPACK4_PARITY_SENSE | SWITCHPACK4_PARITY
        ori     $18
        add     a
        inr     a
        jp      L1310
        rar
        rlc
        ori     $04
        ani     $7f

L1310:
        call    put_char_and_semicolon
        mvi     b,$31
        pop     psw
        ani     SWITCHPACK4_BITS
        jnz     L131C
        inr     b

; This is part of "Report Terminal Parameters"
L131C:
        mov     a,b
        call    put_char_and_semicolon
        lda     tbaud_index16           ; xspeed
        rrc
        call    L0D7A
        call    put_semicolon
        lda     rbaud_index16           ; rspeed
        rrc
        call    L0D7A
        call    put_semicolon
        mvi     a,'1'
        call    put_char_and_semicolon
        lda     switchpack5
        ani     $f0
        rrc
        rrc
        rrc
        rrc
        call    L0D7A
        mvi     m,'x' | $80
        jmp     uart_put_string

esc_single_width:
        ; If the current position is already single-width then return.
        lxi     h,cursor_is_at_double_width_line
        mov     a,m
        ora     a
        rz

        call    probably_wait_for_a_scroll
        lxi     h,latofs
        lda     cursposy
        add     l
        mov     l,a
        mov     a,m             ; a := latofs[cursposy]
        ani     $7f
        mov     m,a             ; Clear double-width indication.
        call    cursposy_to_line_data
        lda     number_of_columns
        rrc
        mov     b,a
        call    add_a_to_hl
        xra     a
L136B:
        mov     m,a
        inx     h
        dcr     b
        jnz     L136B
        mvi     a,$f0
        sta     cursposy_prev
        call    L1395
        xra     a
        sta     cursor_is_at_double_width_line
        jmp     redraw_cursor

cursposy_to_address_in_plinestart:
        lda     cursposy
        call    logical_line_to_physical_line

physical_line_number_to_address_in_plinestart:
        lxi     h,plinestart
        add     a               ; a := pline * 2
        add     l               ; a := pline * 2 + l
        mov     l,a             ; hl = plinestart + pline * 2
        ret

cursposy_to_line_data:
        call    cursposy_to_address_in_plinestart
        ; hl: An address to element in plinestart.

hl_dereference_pointer:
        mov     a,m     ; a := (hl)
        inx     h       ; hl++
        mov     h,m     ; h := (hl)
        mov     l,a     ; l := a
        ret

L1395:
        ani     $70
        mov     b,a
        lda     cursposy
        dcr     a
        lxi     h,line0ptr
        jm      L13BD
        call    logical_line_to_physical_line
        mov     d,a
        ani     $7f
        call    physical_line_number_to_address_in_plinestart
        call    hl_dereference_pointer
        lda     number_of_columns
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
        lda     number_of_columns
        rrc
        mov     d,h
        mov     e,l
        call    add_a_to_hl
        xchg
        call    add_number_of_columns_to_hl
        mvi     b,$03

L13D2:
        mov     a,m
        stax    d
        inx     d
        inx     h
        dcr     b
        jnz     L13D2
        ret

add_number_of_columns_to_hl:
        lda     number_of_columns
; Assign hl := hl + a
add_a_to_hl:
        add     l
        mov     l,a
        rnc
        inr     h
        ret

cursposy_to_physical_line:
        lda     cursposy

; a:  logical line
; a:  physical line return
logical_line_to_physical_line:
        lxi     h,latofs
        add     l
        mov     l,a
        mov     a,m             ; a := latofs[logical]
        ret

cs_reset_mode:
        mvi     c,$00
        jmp     cs_set_or_reset_mode
cs_set_mode:
        mvi     c,$ff
cs_set_or_reset_mode:
        lda     question_for_lh
        ora     a
        lxi     h,jumptable_for_set_or_reset_when_question_is_0
        jz      .have_a_table_for_set_or_reset

        cpi     '?'
        rnz                     ; If question is not '?' then return.
        lxi     h,jumptable_for_set_or_reset_when_question_is_question

.have_a_table_for_set_or_reset:
        mov     a,b             ; b:  decoded decimal string.
        mov     b,c
        call    ascii_jump_find_a
        ret

; ANSI-Compatible Private Modes
; Set or reset mode. Index is decoded decimal string and not ASCII character.
jumptable_for_set_or_reset_when_question_is_question:
        JUMPDEF $01, cs_set_mode_cursor_key             ; DECCKM
        JUMPDEF $02, cs_set_mode_ansi                   ; DECANM
        JUMPDEF $03, cs_set_mode_column                 ; DECCOLM
        JUMPDEF $04, cs_set_mode_scroll                 ; DECSCLM
        JUMPDEF $05, cs_set_mode_screen                 ; DECSCNM
        JUMPDEF $06, cs_set_mode_origin                 ; DECOM
        JUMPDEF $07, cs_set_mode_auto_wrap              ; DECAWM
        JUMPDEF $08, cs_set_mode_auto_repeat            ; DECARM
        JUMPDEF $09, cs_set_mode_interlace              ; DECINLM
        db      0

; ANSI-Specified Modes
jumptable_for_set_or_reset_when_question_is_0:
        JUMPDEF $14, cs_set_mode_line_feed_new_line     ; LNM
        db      0

cs_set_mode_cursor_key:
        lxi     h,cursor_key_mode
        mov     m,b
        ret

cs_set_mode_ansi:
        call    set_or_reset_bits
        dw      switchpack2
        db      SWITCHPACK2_ANSI
        jmp     L0BF2

cs_set_mode_line_feed_new_line:
        call    set_or_reset_bits
        dw      switchpack3
        db      SWITCHPACK3_NEW_LINE
        ret

cs_set_mode_origin:
        lxi     h,origin_mode_is_relative
        mov     m,b
        call    use_new_origin_mode
        ret

cs_set_mode_scroll:
        call    set_or_reset_bits
        dw      switchpack1
        db      SWITCHPACK1_SCROLL
        ret

cs_set_mode_screen:
        call    set_or_reset_bits
        dw      switchpack1
        db      SWITCHPACK1_SCREEN
        jmp     L036B

cs_set_mode_column:
        lxi     h,setup_132columns
        mov     m,b             ; Store the 0 or 1
        call    fill_the_entire_screen_area
        ret

cs_set_mode_auto_repeat:
        call    set_or_reset_bits
        dw      switchpack1
        db      SWITCHPACK1_AUTO_REPEAT
        ret

cs_set_mode_auto_wrap:
        call    set_or_reset_bits
        dw      switchpack3
        db      SWITCHPACK3_WRAP
        ret

cs_set_mode_interlace:
        call    set_or_reset_bits
        dw      switchpack3
        db      SWITCHPACK3_INTERLACE
        jmp     reconfigure_display

; b:    $ff if set, $00 if reset
; sp:   Address location to operate on.
; sp+2: Bitmask to set or reset.
set_or_reset_bits:
        pop     h
        mov     e,m             ; Address location to manipulate.
        inx     h
        mov     d,m
        inx     h
        mov     a,m             ; a: Mask to set or reset.
        inx     h               ; Forward function return address.
        xchg
        mov     c,a             ; c: Mask to set or reset.
        cma                     ; Create AND mask by one's complementing a.
        ana     m               ; Clear our bits.
        mov     m,a             ; Store target byte.
        mov     a,b
        ana     c               ; Create OR mask.
        ora     m               ; Add the OR mask to target.
        mov     m,a             ; Store target byte.
        xchg
        pchl                    ; Return

something_with_uart_and_keyboard:
        call    keyboard_rx_check
        ani     $10
        cz      keyboard_enter
        jmp     handle_some_uart

keyboard_rx_check:
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_KBD_TBMT_H
        rz                      ; If no RX data then return.
        lxi     h,keyboard_is_locked
        mov     a,m
        ora     a
        jz      .locked_done    ; Jump if not locked.
        mvi     a,KEYBOARD_STATUS_KEYBD_LOCKED
; Collect a mask to output to the keyboard UART.
.locked_done:
        lxi     h,online_flags          ; local, keep
        ora     m
        lxi     h,state_for_leds        ; state_for_leds, keep
        ora     m
        inx     h                       ; state_for_bell, keep
        ora     m
        inx     h                       ; state_for_keyclick, clear
        ora     m
        mvi     m,0
        inx     h                       ; state_for_keyboard_scan, clear
        ora     m
        mvi     m,0
        out     OUT_KEYBOARD_UART_DATA_INPUT
        lxi     h,L2074
        inr     m
        lda     L2077
        ora     a
        rnz

        lda     poll_scroll_pend1
        lxi     h,poll_scroll_pend0
        ora     m
        rnz

        ; Decrement cursor blink counter and invert attributes on underflow.
        lhld    blink_curs_counter
        dcx     h
        mov     a,h
        ora     l
        jz      .reached_zero           ; If blink_curs_counter = 0 then jump.
        shld    blink_curs_counter      ; Else store decremented value.
        ret

.reached_zero:
        lda     blink_curs_is_visible   ; Invert cursor visible flag.
        xri     $ff
        sta     blink_curs_is_visible
        lxi     h,CFG_BLINK_CURS_RELOAD_VISIBLE
        jnz     .invert_attributes_for_screen_ram_pos
        lxi     h,CFG_BLINK_CURS_RELOAD_INVISIBLE

.invert_attributes_for_screen_ram_pos:
        shld    blink_curs_counter      ; COUNTER{A,B}_RELOAD
        lhld    screen_ram_cursor_pos
        mov     b,m             ; Load from screen RAM.
        lda     cursor_attribute_base
        xra     b               ; a := code xor cursor_attribute_base
        mov     m,a             ; Store to screen RAM.
        lxi     d,$1000         ; Offset into attribute RAM.
        dad     d               ; hl := hl + $1000
        lda     cursor_attribute_avo
        xra     m               ; a := a xor cursor_attribute_avo
        mov     m,a             ; Store to screen RAM.
        ret

        mov     m,h
cs_erase_in_line:
        mov     a,b
        ora     a               ; ESC [ 0 K
        jz      erase_from_cursor_to_eol
        dcr     a               ; ESC [ 1 K
        jz      erase_from_beginning_of_line_to_cursor
        dcr     a               ; ESC [ 2 K
        rnz

        ; "Erase all of the line", in two steps:
        ;  1. Erase from cursor to end of line.
        ;  2. Erase from beginning of line to cursor.
        call    erase_from_cursor_to_eol
erase_from_beginning_of_line_to_cursor:
        lda     cursposx
        mov     b,a
        inr     b
        lhld    screen_ram_beginning_of_line
        jmp     L1529

erase_from_cursor_to_eol:
        lda     cursposx
        mov     b,a
        lda     cursor_is_at_double_width_line
        ora     a
        lda     number_of_columns
        jz      .1              ; Jump if not at double width line.
        rrc
.1:
        sub     b
        mov     b,a             ; b := ncolumns - cursposx
        lhld    screen_ram_cursor_pos           ; hl: screen RAM
L1529:
        mov     a,h
        adi     $10
        mov     d,a
        mov     e,l             ; de: attribute RAM
        mvi     a,$ff

; b:  count
.loop:
        stax    d               ; Store $ff to attribute RAM.
        mvi     m,$00           ; Store $00 to screen RAM.
        inx     h               ; Next location.
        inx     d               ; --''--
        dcr     b               ; For each column to erase.
        jnz     .loop
        sta     cursor_attr
        xra     a
        sta     cursor_code
        ret

cs_erase_in_display:
        mov     a,b
        ora     a
        jz      L156A
        dcr     a
        jz      L1555
        dcr     a
        rnz
        call    L1555
        call    L156A
        jmp     esc_single_width

L1555:
        lxi     h,cursposy
        mov     a,m
        push    psw
        mov     b,a
        xra     a
        mov     m,a
        mvi     c,$ff
        call    L1586
        pop     psw
        mov     m,a
        call    update_cursor_variables
        jmp     erase_from_beginning_of_line_to_cursor

L156A:
        lda     cursposx
        ora     a
        cz      esc_single_width
        call    erase_from_cursor_to_eol
        lxi     h,cursposy
        mov     a,m
        push    psw
        mov     c,a
        mvi     a,$17
        sub     c
        mov     b,a
        call    L1586
        pop     psw
        mov     m,a
        jmp     update_cursor_variables

L1586:
        dcr     b
        rm
        inr     c
        mov     m,c
        push    b
        push    h
        call    cursposy_to_physical_line
        ani     $7f
        mov     m,a
        mvi     a,$70
        call    L1395
        call    update_cursor_variables
        lda     number_of_columns
        mov     b,a
        call    L1529
        pop     h
        pop     b
        jmp     L1586

; From EK-VT100-TM-003, Section 4.7.6:
;   "A control sequence defines the region by specifying the line
;   numbers of the top and bottom of the region. When the control
;   sequence arrives, the microprocessor stops taking characters from
;   the silo and waits for the current scroll to end. It then checks
;   the parameters for legality (top less than bottom, bottom less than
;   14 or 24). If they are bad, the sequence is ignored and the next
;   character is taken from the silo. If they are good, they are stored
;   in locations labelled Top and Bottom."
cs_set_top_and_bottom_margins:
        mvi     c,$81
        call    wait_for_the_current_scroll_to_end
        call    get_lines_and_columns
        lda     cs_parameter_array      ; top parameter
        ora     a
        jz      .top_adj        ; If top parameter is 0 then use it as is.
        dcr     a               ; Else subtract 1 to make it zero indexed.
.top_adj:
        mov     d,a             ; d: top
        lda     cs_parameter_array+1    ; bottom parameter
        ora     a
        jnz     .bottom_adj     ; If bottom parameter is NOT 0 then use as is.
        mov     a,b             ; Else use bottom from get_lines_and_columns.
        inr     a               ; Bottom is now 24 or 14
.bottom_adj:
        dcr     a               ; Make bottom zero indexed.

        ; Range check top and bottom.
        mov     e,a             ; e: bottom
        mov     a,b             ; a: upper y limit
        cmp     e
        rc                      ; Return if bottom is too large.
        mov     a,d
        cmp     e
        rnc                     ; Return if bottom < top.

        lxi     h,scroll_region_top
        mov     m,d             ; Store to scroll_region_top.
        inx     h
        mov     m,e             ; Store to scroll_region_bottom.

        mov     c,e             ; c: bottom
        mov     b,d             ; b: top
        mov     a,c             ; a: bottom
        sub     b               ; a: bottom - top
        inr     a               ; a: 1 + bottom - top
        mov     e,a             ; e: 1 + bottom - top
        lxi     h,line0ptr
        mov     a,b             ; a: top
        ora     a
        jz      .loop_to_bottom ; Jump if top = 0.
        mov     d,b             ; d: top

; Not part of scroll region.
.loop_to_top:
        mov     a,m
        ani     (~LINE_ATTR_SCROLL) & $ff
        mov     m,a
        call    get_next_line
        dcr     d
        jnz     .loop_to_top

; Part of scroll region.
.loop_to_bottom:
        mov     a,m
        ori     LINE_ATTR_SCROLL
        mov     m,a
        call    get_next_line
        dcr     e
        jnz     .loop_to_bottom

        mvi     a,24-1
        sub     c
        jz      .end_of_screen_reached
        mov     d,a

; Not part of scroll region.
.loop_while_not_end_of_screen:
        mov     a,m
        ani     (~LINE_ATTR_SCROLL) & $ff
        mov     m,a
        call    get_next_line
        dcr     d
        jnz     .loop_while_not_end_of_screen

.end_of_screen_reached:
        mov     a,b
        sta     scroll_region_top
        mov     a,c
        sta     scroll_region_bottom
        lxi     h,latofs
        mvi     c,24

.loop:
        mov     a,m
        ora     a
        jp      .1
        ; Bit 7 was set.
        push    h
        call    physical_line_number_to_address_in_plinestart
        mov     a,m
        inx     h
        mov     h,m
        mov     l,a
        call    L13C3
        pop     h
.1:
        inx     h               ; Next latofs
        dcr     c               ; Loop 23 times.
        jnz     .loop

        jmp     use_new_origin_mode

get_next_line:
        inx     h
        mov     l,m             ; Load address bits 7..0.
        ani     $0f             ; Keep address bits 11..8.
        ori     $20             ; Add in constant address bit 13.
        mov     h,a             ; hl: address of next line
        inx     h
        jmp     add_number_of_columns_to_hl

redraw_cursor:
        ; Set blink_curs_counter to a reload for redraw.
        lxi     h,CFG_BLINK_CURS_RELOAD_REDRAW
        shld    blink_curs_counter

        ; Set blink_curs_visible to 0.
        xra     a
        sta     blink_curs_is_visible

        ; Store character code to screen RAM, cursor position.
        ; This un-does the cursor indication by restoring code and attribute.
        lhld    screen_ram_cursor_pos
        lda     cursor_code
        mov     b,a
        mov     m,a

        ; Store attribute to attribute RAM, cursor position.
        mov     a,h
        adi     $10
        mov     h,a             ; hl += $1000
        lda     cursor_attr
        mov     m,a

        lda     number_of_columns
        dcr     a
        mov     e,a             ; e := number_of_columns-1

        ; If program is in setup then jump forward a bit.
        lda     is_in_setup
        ora     a
        jnz     .posy_done

        lda     cursposy
        lxi     h,cursposy_prev
        cmp     m
        jz      .posy_and_posx_max_done
        mov     m,a             ; cursposy_prev := cursposy

        ; Enter a new line
        call    update_cursor_variables
        xra     a
        sta     margin_bell_pending     ; Clear indication.
        lxi     h,cursor_is_at_double_width_line
        mov     a,m
        ora     a
        jz      .posy_done

        ; Cursor is at double-width line.
        mov     a,e             ; a: number_of_columns-1
        dcr     a               ; a: number_of_columns-2
        ora     a               ; carry: 0
        rar
        mov     e,a             ; e: (number_of_columns/2)-1

.posy_done:
        mov     a,e             ; Columns of this line.
        sta     cursposx_max
.posy_and_posx_max_done:
        ; cursposx := min(cursposx, cursposx_max)
        lxi     h,cursposx_max
        lxi     d,cursposx
        ldax    d               ; a: cursposx
        cmp     m
        jc      .cursposx_ok    ; Jump if x < xmax
        mov     a,m             ; The x margin was hit, so update cursposx.
        stax    d               ; Store back.

.cursposx_ok:
        ; Margin bell generates a bell tone when the cursor moves into the
        ; eight character position from the end of the line.
        ; Not sure why cursposx is not used here.
        lda     cursposx_prev
        adi     $08
        sub     m               ; Compare with cursposx_max.
        jnz     .bell_done      ; Jump if not at the margin.

        inx     h               ; Address margin_bell_pending.
        ora     m               ; a: margin_bell_pending
        jz      .bell_done      ; Jump if margin bell is not pending.

        call    cc_bel          ; Ring the bell.
        xra     a               ; Clear indication.
        sta     margin_bell_pending

.bell_done:
        lda     cursposx
        sta     cursposx_prev   ; cursposx_prev := cursposx

        ; Install new screen_ram_cursor_pos.
        lhld    screen_ram_beginning_of_line
        call    add_a_to_hl
        shld    screen_ram_cursor_pos   ; Store start_of_line + cursposx.

        ; Wherever we ended up, backup the code and attribute.
        mov     a,m             ; Load from charmap.
        sta     cursor_code
        mov     b,a
        mov     a,h
        adi     $10
        mov     h,a             ; hl += $1000
        mov     a,m             ; Load from attribute map.
        sta     cursor_attr
        lhld    screen_ram_cursor_pos
        mov     m,b             ; Store to charmap. Why is this needed?
        ret

; Enter here once for character after CSI.
parse_csi:
        mov     b,a                     ; Keep character in b.
        lxi     h,parse_csi_parameter
        shld    parser_state          ; Install the new state handler.
        xra     a
        sta     cs_parameter_calc       ; Clear.
        sta     cs_parameter_index      ; Clear.
        sta     esc_intermediate_character ; Clear.

        lxi     h,cs_parameter_array
        mvi     c,$0f                   ; Clear 15 bytes.
        xra     a
.loop:
        mov     m,a
        inx     h
        dcr     c
        jnz     .loop

        lxi     h,question_for_lh       ; Clear.
        mvi     m,$00
        mov     a,b
        ; If parameter is any of < = > ? then return.
        cpi     $40
        jnc     parse_csi_parameterx        ; If $40 <= a then jump.
        cpi     $3c
        jc      parse_csi_parameterx        ; If a < $3c then jump.
        mov     m,a                     ; < = > ?
        ret

parse_csi_parameter:
        mov     b,a
parse_csi_parameterx:
        ; Jump away if parameter character not in '0'..'9'.
        mov     a,b
        cpi     $3a
        jnc     .not_decimal
        sui     $30
        jm      .not_decimal

        ; Parameter is decimal.
        mov     c,a             ; Save new decimal value (0..9)
        lxi     h,cs_parameter_calc  ; Load old parameter value
        mov     a,m
        ; This overflow protection will kick in for each digit until we
        ; get ';' or control sequence final character.
        cpi     26              ; Skip since 260 will overflow.
        jnc     .overflow

        rlc                     ; Multiply it by 10
        mov     b,a
        rlc
        rlc
        add     b
        jc      .overflow       ; If overflow then write back ff.
        add     c               ; Add new parameter value.
        jnc     .store_cs_parameter_calc        ; Checking the overflow again.

.overflow:
        mvi     a,$ff           ; Mark that parameter got overflow.

.store_cs_parameter_calc:
        mov     m,a             ; Write back cs_parameter_calc.
        ret

; Store the value in parameter array.
.not_decimal:
        lxi     d,cs_parameter_array         ; Address of parameter index.
        push    psw             ; Save a.
        lxi     h,cs_parameter_index
        mov     c,m
        mvi     b,$00
        xchg                    ; Exchange hl with de.
        dad     b               ; hl := hl + bc
        lxi     b,cs_parameter_calc
        ldax    b               ; Load calculated parameter.
        mov     m,a             ; Store parameter in array.
        xra     a
        stax    b               ; Clear cs_parameter_calc for next parameter.
        ; If parameter index is not 15 then increment it.
        ldax    d               ; Load parameter index.
        cpi     15
        jz      .updated
        inr     a
        stax    d

.updated:
        pop     psw             ; Restore a.

parse_csi_wait_for_final_character:
        mov     b,a
        cpi     ';'
        rz                      ; If ';' then return.
        ani     $c0             ; TODO: why is bit 7 checked?
        mov     a,b
        jz      .not_final      ; Jump if Parameter or Intermediate Character.

        ; This was a "Final Character" of a "Control Sequence".
        sta     ascii_jump_value_to_find
        jmp     cs_do_final_character

.not_final:
        lxi     h,esc_intermediate_character
        add     m
        jnc     .flush          ; TODO: What does this mean?
        mvi     a,$ff

; Ignore everything until final character.
.flush:
        mov     m,a
        lxi     h,parse_csi_wait_for_final_character
        shld    parser_state
        ret

; "Saving SET-UP Features"
save_setup_features:
        mvi     d,$00
        mvi     b,$01
        jmp     L1762

; "Recalling SET-UP Features"
recall_setup_features:
        call    L02C0
        mvi     b,$0a
        mvi     d,$01

L1762:
        push    b
        push    d
        call    L17BE
        pop     d
        di
        lxi     h,answerback_message
        mvi     e,$33
        mvi     c,$01
        xra     a

L1771:
        sta     setup_checksum_for_nvr
        mov     a,c
        sta     setup_parity
        push    d
        push    h
        mov     a,d
        ora     a
        mov     a,m
        sta     nvr_read_decoded
        cz      nvr_something1
        call    nvr_something_read
        pop     h
        pop     d
        lda     nvr_read_decoded
        dcr     e
        jz      L179E
        mov     m,a
        lda     setup_parity
        rlc
        xra     m
        mov     c,a
        inx     h
        lda     setup_checksum_for_nvr
        inr     a
        jmp     L1771

L179E:
        cmp     m
        pop     b
        mvi     c,$00
        jz      L17AC
        dcr     b
        jnz     L1762
        call    initialize_setup_area
L17AC:
        mov     a,c
        ora     a
        push    psw
        mvi     c,$40
        mvi     a,$63
        call    nvr_set_address
        ; same as initdata_for_screen
        lxi     h,($d0<<8)|LINE_ATTR_SCROLL|LINE_ATTR_NORMAL|LINE_ADDR_2000|2
        shld    line0ptr
        pop     psw
        ret

L17BE:
        lxi     d,text_wait
        mvi     b,$07
        lxi     h,screen_buffer_b
        call    memcpy
        lxi     h,($cc<<8)|LINE_ATTR_NORMAL|LINE_ADDR_2000|1
        shld    line0ptr
        ret

; answerback_message and tabs are set to $80.
; The rest is initialized from a table.
initialize_setup_area:
        lxi     h,answerback_message
        mvi     b,SIZEOF_ANSWERBACK_MESSAGE + SIZEOF_TABS
.loop:
        mvi     m,$80
        inx     h
        dcr     b
        jnz     .loop

        lxi     d,init_data_for_setup_area
        mvi     b,11
        call    memcpy
        mvi     c,$01
        mvi     a,$30
        sta     bell_indicator
        ret

text_wait:
        db      'Wait'
        ; The Line at $2006 loops back on itself.
        db      LINE_TERM, LINE_ATTR_NORMAL | LINE_ADDR_2000, $06

init_data_for_setup_area:
        db      $00             ; 80 column mode
        db      $08             ; intensity
        db      $6e             ; PUSART mode: DTR | RxEN | SBRK | RTS | IR
        db      ONLINE_FLAGS_LOCAL
        db      SWITCHPACK1_SCROLL|SWITCHPACK1_AUTO_REPEAT|SWITCHPACK1_CURSOR
        db      SWITCHPACK2_KEYCLICK|SWITCHPACK2_AUTO_XON_XOFF
        db      $00             ; switchpack3
        db      SWITCHPACK4_BITS
        db      $00             ; switchpack5
        db      SETUP_BAUD_9600 ; Transmit
        db      SETUP_BAUD_9600 ; Receive

cs_cursor_up:
        lda     scroll_region_top
        lxi     b,$00ff
        jmp     cs_cursor_up_or_down

cs_cursor_down:
        call    get_lines_and_columns
        lda     scroll_region_bottom
        mvi     c,$01           ; add

cs_cursor_up_or_down:
        lxi     h,cursposy
        jmp     cs_cursor_any_direction

cs_cursor_right:
        lda     cursposx_max           ; Right limit for cursposx.
        lxi     b,$ff01         ; b: ?  c: add
        jmp     cs_cursor_left_or_right

cs_cursor_left:
        xra     a               ; Left limit for cursposx is 0.
        lxi     b,$00ff         ; b: ?  c: add

cs_cursor_left_or_right:
        lxi     h,cursposx

; a:  limit (i)
; b:  limit (ii)
; c:  add (1 or -1)
; h:  RAM variable
cs_cursor_any_direction:
        mov     d,a
        lda     question_for_lh
        ora     a
        jnz     set_parser_state_to_idle_and_return
        lda     cs_parameter_array
        ora     a
        jnz     .index_is_1_or_more
        inr     a               ; Default parameter value is 1.
.index_is_1_or_more:
        mov     e,a
        mov     a,m
.loop:
        cmp     d
        jz      .hit_limit
        cmp     b
        jz      .hit_limit
        add     c               ; Advance in one direction.
        dcr     e               ; For i in 1..parameter.
        jnz     .loop
.hit_limit:
        mov     m,a
        jmp     redraw_cursor

use_new_origin_mode:
        lxi     h,$0000
        shld    cs_parameter_array
        mvi     a,$ff
        sta     cursposy_prev
cs_cursor_position:
        lda     origin_mode_is_relative
        mov     c,a
        lxi     h,cs_parameter_array
        mov     a,m
        ora     a
        jz      L1860
        dcr     a

L1860:
        mov     b,a
        mov     a,c
        ora     a
        jz      L1869
        lda     scroll_region_top

L1869:
        add     b
        mov     b,a
        mov     a,c
        ora     a
        lda     scroll_region_bottom
        jnz     L1879
        mov     c,b
        call    get_lines_and_columns
        mov     a,b
        mov     b,c

L1879:
        cmp     b
        jc      L187E
        mov     a,b

L187E:
        sta     cursposy
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
        lda     number_of_columns
        dcr     a
        jmp     L1898

L1895:
        lda     cursposx_max

L1898:
        cmp     b
        jc      L189D
        mov     a,b

L189D:
        sta     cursposx
        jmp     redraw_cursor

nvr_something_read:
        mvi     c,FLAG_BUFFER_NVR_CLOCK_H
        call    nvr_set_address_for_setup_checksum
        call    L18C1
        jmp     nvr_something_end

nvr_something1:
        mvi     c,FLAG_BUFFER_NVR_CLOCK_H
        call    nvr_set_address_for_setup_checksum
        call    nvr_erase_command
        call    L1977
        call    nvr_do_the_write

nvr_something_end:
        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_BIT4
        out     OUT_NVR_LATCH
        ret

L18C1:
.while_nvr_clock_is_low
        in      IN_FLAG_BUFFER
        ana     c
        jz      .while_nvr_clock_is_low

.while_nvr_clock_is_high
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .while_nvr_clock_is_high
        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_READ | 1
        out     OUT_NVR_LATCH

.while_nvr_clock_is_low2
        in      IN_FLAG_BUFFER
        ana     c
        jz      .while_nvr_clock_is_low2

.while_nvr_clock_is_high2
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .while_nvr_clock_is_high2

        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_STANDBY | 1
        out     OUT_NVR_LATCH
        lxi     h,nvr_buffer
        mvi     b,14

.while_nvr_clock_is_low3
        in      IN_FLAG_BUFFER
        ana     c
        jz      .while_nvr_clock_is_low3

.while_nvr_clock_is_high3
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .while_nvr_clock_is_high3

        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_SHIFT_DATA_OUT | 1
        out     OUT_NVR_LATCH

.loop0:
        in      IN_FLAG_BUFFER
        ana     c
        jz      .loop0
        in      IN_FLAG_BUFFER  ; Collect the read data, one bit.
        mov     m,a
        inx     h

.while_nvr_clock_is_high4
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .while_nvr_clock_is_high4
        dcr     b
        jnz     .loop0

        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_STANDBY | 1
        out     OUT_NVR_LATCH

        lxi     d,nvr_buffer
        mvi     b,14            ; NVR is 14 bit wide of which we use 8.
        lxi     h,0
.loop:
        dad     h               ; hl := hl + hl (left shift hl)
        ldax    d               ; Get collected flag buffer from history.
        ani     FLAG_BUFFER_NVR_DATA_H  ; Bit 5 is the data.
        rlc
        rlc
        rlc                     ; Data of interest is now in a bit 0.
        ora     l               ; Bring in the previous bits.
        mov     l,a
        inx     d               ; Next data.
        dcr     b
        jnz     .loop
        shld    nvr_read_decoded           ; Store as 16-bit word.
        ret

nvr_set_address_for_setup_checksum:
        lda     setup_checksum_for_nvr
; Translate from setup variable offset to NVR decade address.
nvr_set_address:
        mvi     b,$ff
.loop0:
        inr     b
        sui     10
        jp      .loop0

        adi     10
        lxi     h,nvr_buffer
        mvi     e,NVR_LATCH_nSPDS | NVR_LATCH_ACCEPT_ADDRESS | 1

        mvi     d,20
.loop1:
        mov     m,e             ; ACCEPT_ADDRESS x 20
        inx     h
        dcr     d
        jnz     .loop1

        mvi     m,NVR_LATCH_nSPDS | NVR_LATCH_STANDBY | 1
        lxi     h,nvr_buffer
        mov     e,a
        mvi     d,$00
        dad     d
        mvi     m,NVR_LATCH_nSPDS | NVR_LATCH_ACCEPT_ADDRESS

        lxi     h,nvr_buffer
        mvi     a,10
        add     b
        mov     e,a
        dad     d
        mvi     m,NVR_LATCH_nSPDS | NVR_LATCH_ACCEPT_ADDRESS

.wait_until_nvr_clock_is_low
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .wait_until_nvr_clock_is_low
        lxi     h,nvr_buffer
        mvi     b,21
.loop_while_nvr_clock_is_low:
        in      IN_FLAG_BUFFER
        ana     c
        jz      .loop_while_nvr_clock_is_low
        dcr     b
        rm
.loop_while_nvr_clock_is_high:
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .loop_while_nvr_clock_is_high
        mov     a,m             ; Load and do command.
        out     OUT_NVR_LATCH
        inx     h               ; Address next command.
        jmp     .loop_while_nvr_clock_is_low

L1977:
        lhld    nvr_read_decoded
        dad     h
        dad     h
        lxi     d,nvr_buffer
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
        lxi     h,nvr_buffer
        mvi     b,$0f

L1993:
        in      IN_FLAG_BUFFER
        ana     c
        jz      L1993

L1999:
        in      IN_FLAG_BUFFER
        ana     c
        jnz     L1999
        mov     a,m
        out     OUT_NVR_LATCH
        inx     h
        dcr     b
        jnz     L1993
        ret

nvr_erase_command:
.wait_until_nvr_clock_is_high
        in      IN_FLAG_BUFFER
        ana     c
        jz      .wait_until_nvr_clock_is_high

.wait_until_nvr_clock_is_low:
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .wait_until_nvr_clock_is_low
        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_ERASE | 1
        out     OUT_NVR_LATCH
        call    wait_315_nvr_clocks
        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_STANDBY | 1
        out     OUT_NVR_LATCH
        ret

wait_315_nvr_clocks:
        lxi     h,315           ; Loop this many times.
.loop_next_clock
.wait_until_nvr_clock_is_high
        in      IN_FLAG_BUFFER
        ana     c
        jz      .wait_until_nvr_clock_is_high
.wait_until_nvr_clock_is_low:
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .wait_until_nvr_clock_is_low

        dcx     h
        mov     a,h
        ora     l
        jnz     .loop_next_clock        ; Jump if hl /= 0.
        ret

nvr_do_the_write:
.wait_until_nvr_clock_is_high
        in      IN_FLAG_BUFFER
        ana     c
        jz      .wait_until_nvr_clock_is_high

.wait_until_nvr_clock_is_low
        in      IN_FLAG_BUFFER
        ana     c
        jnz     .wait_until_nvr_clock_is_low

        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_WRITE | 1
        out     OUT_NVR_LATCH
        call    wait_315_nvr_clocks
        mvi     a,NVR_LATCH_nSPDS | NVR_LATCH_STANDBY | 1
        out     OUT_NVR_LATCH
        ret

parse_setup:
        cpi     $20             ; ASCII SP
        mvi     c,$43
        jz      reset_parameter
        lxi     h,setup_finish  ; End up there when no known key is hit, etc..
        push    h
        cpi     ASCII_CR
        jz      cc_cr
        cpi     ASCII_HT
        jz      cc_ht
        cpi     ':'
        jnc     setup_otherkey  ; Jump if ':' or greater.
        sui     '0'
        rm                      ; Return if less than '0'.
        add     a               ; a is in the range 0..20
        lxi     h,table_for_setup
        call    add_a_to_hl
        call    hl_dereference_pointer
        mov     a,b
        lxi     d,rbaud_index16
        pchl

handle_key_setup:
        sta     setup_pend
        jmp     L0812

setup_begin:
        lda     is_in_setup
        xri     $ff
        sta     is_in_setup
        jz      L1A61

; Swap state machines.
L1A2B:
        mvi     c,$80
        call    wait_for_the_current_scroll_to_end
        lhld    parser_state
        shld    setup_backup_of_parser_state
        lxi     h,parse_setup
        shld    parser_state
        lxi     h,0
        shld    tx_fifo_count   ; Clear.
        shld    future_tx       ; Clear.
L1A45:
        ; Save stuff so we can go back to the user at setup exit.
        lhld    line0ptr
        shld    setup_saved_line0ptr
        lhld    cursposx
        shld    setup_saved_curspos
        call    setup_get_screenbuf_a
        shld    screen_ram_beginning_of_line
        xra     a
        sta     cursposx
        call    setup_print_banner
        jmp     redraw_cursor

L1A61:
        lhld    setup_backup_of_parser_state
        shld    parser_state
        call    setup_get_screenbuf_a
        lxi     d,$1000
        dad     d
        lda     number_of_columns

L1A71:
        mvi     m,$ff
        inx     h
        dcr     a
        jnz     L1A71
        lxi     h,setup_saved_curspos
        mov     a,m
        sta     cursposx
        mvi     a,$ff
        inx     h
        mov     m,a             ; cursposy_prev := $ff
        call    redraw_cursor
        lhld    setup_saved_line0ptr
        shld    line0ptr
        xra     a
        sta     silo_getc_disable
        sta     received_xoff
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_OPTION_PRESENT_H
        jz      .ret            ; Jump if STP is not installed.
        lda     terminal_parameters_request_type
        ora     a
        cz      L12E8
.ret:
        ret

; One entry for each SETUP key 0..9
table_for_setup:
        dw      setup_func_0
        dw      setup_func_1
        dw      setup_func_2
        dw      setup_func_3
        dw      setup_func_4
        dw      setup_func_5
        dw      setup_func_6
        dw      setup_func_7
        dw      setup_func_8
        dw      setup_func_9

; "80/132 COLUMNS"
setup_func_9:
        call    setup_cont_if_cant_toggle
        xra     a               ; a := 0
        sta     cursposy_prev
        sta     setup_saved_curspos
        lda     setup_132columns
        ora     a
        push    psw
        cz      L0B77           ; It was 80 columns.
        pop     psw
        cnz     L0B63           ; It was 132 columns.
        jmp     L1A45

; "RESET"
setup_func_0:
        rst     0

; "SET/CLEAR TAB"
setup_func_2:
        call    setup_cont_if_cant_toggle
        lda     cursposx
        ora     a
        rz
        call    get_tab_for_active_position
        xra     m
        mov     m,a
        call    get_tab_for_active_position
        ana     m
        mvi     b,$54
        jnz     L1AE8

L1AE6:
        mvi     b,$00

L1AE8:
        mov     a,b
        sta     cursor_code
        lda     cursposx
        jmp     L1EEA

; "CLEAR ALL TABS"
setup_func_3:
        call    setup_cont_if_cant_toggle
        call    L0DEC
        call    L1CCD
        jmp     L1AE6

; "LINE/LOCAL"
setup_func_4:
        lxi     h,online_flags  ; Toggle the On-Line/Local state.
        mov     a,m
        xri     ONLINE_FLAGS_LOCAL
        mov     m,a             ; Store toggled value.
        xra     a
        sta     keyboard_is_locked           ; Clear variable.

setup_func_1:
        ret

; "SETUP A/B"
setup_func_5:
        call    cc_cr
        lxi     h,L225A
        mov     a,m             ; L225A ^= 3
        xri     $03
        mov     m,a
        sta     L2265
        ani     $01
        sta     setup_can_toggle
        jz      L1CD3
        jmp     L1C35

; "TOGGLE 1/0"
setup_func_6:
        call    setup_cont_if_can_toggle
        lxi     h,switchpack1
        lda     cursposx        ; Get cursor position.
        sui     $02             ; Packs start on offset 2.
        cpi     $28             ; There are at most 5 packs.
        rnc
        nop
        nop
        nop
        nop
        mov     d,a
        call    get_bitmap_bit
        xra     m
        mov     m,a
        call    configure_the_pusart
        jmp     L1CD3

; "TRANSMIT SPEED"
setup_func_7:
        dcx     d

; "RECEIVE SPEED"
setup_func_8:
        xchg                    ; Swap hl and de.
        call    setup_cont_if_can_toggle
        sta     cursposx         ; Store 0.
        mov     a,m
        adi     $10
        mov     m,a
        call    configure_the_pusart
        jmp     L1CD3

setup_cont_if_cant_toggle:
        lda     setup_can_toggle
        ora     a
        rnz
        pop     h
        ret

setup_cont_if_can_toggle:
        lda     setup_can_toggle
        ora     a
        rz
        pop     h               ; Return from previous frame which should be
        ret                     ; setup_finish

setup_otherkey:
        lda     keys_flag_prev
        ani     KEYS_FLAG_SHIFT
        rz
        mov     a,b
        cpi     'S'
        jnz     setup_check_r
        call    save_setup_features
        jmp     setup_saved_or_recalled

setup_check_r:
        cpi     'R'
        jnz     setup_check_a
        call    recall_setup_features
        ei
        call    L03A2
        call    L1A2B

setup_saved_or_recalled:
        ei
        call    setup_print_banner
        ret

setup_check_a:
        cpi     'A'
        rnz
        ; Answerback message
        call    setup_cont_if_can_toggle
        call    cc_cr
        mvi     a,'A'
        call    display_character
        mvi     a,'='
        call    display_character
        mvi     a,' '
        call    display_character
        lxi     h,parse_answerback1
        shld    parser_state
        pop     h
        ret

; MYSTERY: Who enters here?
        sbb     b
        cpi     'a'
        rm
        cpi     'z' + 1
        rp
        ani     $df
        ret

setup_finish:
        call    L0394
        lxi     h,parse_setup
        shld    parser_state
        ret

setup_get_screenbuf_a:
        lhld    screen_buffer_a_ptr
        jmp     add_dh_top_to_eol_byte1

setup_get_screenbuf_b:
        lxi     h,screen_buffer_b
add_dh_top_to_eol_byte1:
        mov     a,h             ; Pick the high 8 bits of the address.
        ani     $0f             ; Keep software definable address bits.
        ori     LINE_ATTR_DH_TOP ; Combine with line attributes.
        mov     h,a             ; Put back in the hl pair.
        ret

L1BCA:
        call    setup_get_screenbuf_a
        call    L0FC8
        push    h
        mvi     m,$7f
        inx     h
        xchg
        call    setup_get_screenbuf_b
        mov     a,h
        ani     $0f
        ori     $70
        stax    d
        inx     d
        mov     a,l
        stax    d
        pop     h
        lda     number_of_columns
        mov     e,a
        mvi     b,$54

L1BE8:
        mov     a,e
        call    get_tab_for_position_in_a_and_c
        ana     m
        jz      L1BF4
        mov     a,e
        call    L1EEA

L1BF4:
        dcr     e
        jnz     L1BE8
        ret

; The setup screen looks like this:
;
;  1  SET-UP A
;  1  SET-UP A
;  2  TO EXIT PRESS "SET-UP"
;  3
;     (lines 4..21 are empty)
; 22
; 23          T       T       T       T        (etc...)
; 24  1234567890123456789012345678901234567890 (etc...)
;
setup_print_banner:
        ; 'SET-UP A', double width and double height, upper part
        lxi     b,setup_text
        lxi     h,screenbuf_setup_banner
        mvi     a,$fa           ; character attribute
        call    setup_print_bline

        ; 'SET-UP A', double width and double height, lower part
        mvi     c,1             ; Terminate one line.
        mvi     b,LINE_ATTR_DH_BOTTOM | LINE_ADDR_2000
        call    setup_install_eol
        lxi     b,setup_text
        mvi     a,$fa
        call    setup_print_bline

        ; 'TO EXIT PRESS "SET-UP"', double width
        mvi     c,1
        mvi     b,LINE_ATTR_DW | LINE_ADDR_2000
        call    setup_install_eol
        lxi     b,exit_text
        mvi     a,$fd           ; character attribute
        call    setup_print_bline

        mvi     c,19            ; Terminate 19 lines.
        call    setup_install_normal_eol

        mvi     m,LINE_TERM
        inx     h
        xchg
        call    setup_get_screenbuf_a

        mov     a,h
        ori     LINE_ATTR_NORMAL | LINE_ADDR_2000
        stax    d
        inx     d
        mov     a,l
        stax    d

L1C35:
        call    setup_get_screenbuf_b
        lda     number_of_columns
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
        call    print_some_termination
        call    L1BCA
        mvi     a,$01

finalize_setup_prints:
        sta     setup_can_toggle
        lxi     h,screenbuf_setup_banner
        mov     a,h
        mov     h,l
        ani     $0f
        ori     LINE_ATTR_DH_TOP|LINE_ADDR_2000
        mov     l,a
        shld    line0ptr
        ret

; be: NUL terminated string
; hl: screen buffer (destination)
; a:  character attributes
; return: screen buffer address point to position after the string.
setup_print_bline:
        push    h               ; de := hl
        lxi     d,$1000         ; hl := hl + 0x1000 (attribute RAM)
        dad     d
        pop     d

L1C77:
        push    psw             ; Save character attributes.
        ldax    b               ; Read one character of source text.
        ora     a
        jz      L1C86           ; Reached end of string.
        stax    d               ; Write the character to screen buffer.
        pop     psw             ; Restore character attributes.
        mov     m,a             ; Write character attributes to attribute RAM.
        inx     h
        inx     d
        inx     b
        jmp     L1C77

L1C86:
        pop     psw             ; Do a final restore to get stack in sync.
        ret

setup_install_normal_eol:
        mvi     b,LINE_ATTR_NORMAL | LINE_ADDR_2000

; This routine terminates successive display lines. It installs,
; for each line, bthe DC012 DMA terminator and two address bytes.
; Line attributes of next line are provided by the user.
;
; b:  line attribute
; c:  number of lines to terminate
; de: line to terminate
setup_install_eol:
        xchg                    ; hl: screen buffer
setup_install_eol_loop:
        mvi     m,LINE_TERM     ; Mark end of line for DC012.

        inx     h               ; Goto first address byte.
        mov     d,h             ; de := hl
        mov     e,l
        inx     d               ; de points at second address byte.
        inx     d               ; de points at first byte after the line.
        mov     a,d             ; Pick the high 8 bits of the address.
        ani     $0f             ; Keep software definable address bits.
        ora     b               ; Combine with the user attributes.
        mov     m,a             ; Write the thing as first address byte.

        inx     h               ; Goto second address byte.
        mov     m,e             ; Write low 8 bits of address of next line.
        inx     h               ; Goto first byte after the terminated line.

        dcr     c               ; Terminate one more line or return.
        jnz     setup_install_eol_loop
        ret

; hl: destination character buffer
; NOTE: 3 bytes are written, but hl is incremented 2 bytes
print_some_termination:
        mvi     m,$7f           ; Install string termination marker.
        ; Store something about the character buffer address in following two
        ; bytes.
        mov     d,h             ; de := hl
        mov     e,l
        inx     h               ; h++
        mov     a,d             ; a := d & 0x0f | 0x70
        ani     $0f
        ori     $70
        mov     m,a
        inx     h               ; h++
        mov     m,e
        ret

setup_text:
        db      'SET-UP A',0

exit_text:
        db      'TO EXIT PRESS "SET-UP"', 0

L1CCD:
        call    setup_get_screenbuf_a
        jmp     L0FC8

L1CD3:
        call    L1CCD
        call    setup_get_screenbuf_b
        push    h
        mvi     a,$4e
        call    L0FCB
        pop     h
        push    h
        inx     h
        inx     h
        mvi     e,$00
        mvi     b,$04
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_OPTION_PRESENT_H
        push    psw
        jz      L1CF0           ; Jump if STP is not installed.
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
        jnz     clear_some_text_buffer

        mov     a,c             ; c := c + 8
        adi     $08
        mov     c,a

clear_some_text_buffer:
        mvi     m,$00
        inx     h
        dcr     c
        jnz     clear_some_text_buffer

        lxi     d,tbaud_text
        lda     tbaud_index16           ; BAUD index * 16
        call    print_baud

        lxi     d,rbaud_text
        lda     rbaud_index16           ; BAUD index * 16
        call    print_baud

        call    print_some_termination

        ; Write '1', '2', '3', '4' and maybe '5' to character buffer.
        lxi     d,8
        mvi     c,4
        pop     psw
        jz      L1D3D

        ; Also print '5', because
        ;   "VT100 terminal with VT1XX-AC printer port."
        ;   "This group appears if an option is installed in the STP connector
        ;   on the terminal controller board."
        inr     c

L1D3D:
        mvi     a,$31           ; ASCII '1'
        pop     h               ; Another position character buffer.

after_baud_print_fill_with_31:
        mov     m,a             ; Write '1'..'5'
        inr     a               ; Next digit.
        dad     d               ; Next character buffer address. hl := hl + 8
        dcr     c               ; c--
        jnz     after_baud_print_fill_with_31   ; End after '4' or '5'.
        xra     a               ; a := 0
        jmp     finalize_setup_prints

tbaud_text:
        db      '   T SPEED '

rbaud_text:
        db      '   R SPEED '

; a:  hpos?
; de: baud_text ("T SPEED" or "R SPEED")
; hl: destination string buffer
print_baud:
        mov     c,a             ; Save a.
        mvi     b,$0b           ; Print 11 characters.
        call    memcpy
        mov     a,c             ; Restore a.

        ; BAUD is stored in RAM as index x 16. The following calculation
        ; translates it value appropriate for indexing into the baud_text
        ; string table: c := a/16 + a/4 = 5a/16
        rrc
        rrc
        mov     c,a
        rrc
        rrc
        add     c
        mov     c,a

        mvi     b,$00
        lxi     d,baud_text

        ; Calculate de := de + c = baud_text + c
        xchg                    ; Swap de and hl.
        dad     b               ; hl := hl + c
        xchg                    ; Swap it back.

        mvi     b,$05           ; Print 5 BAUD characters.
        jmp     memcpy

baud_text:
        db      '   50'
        db      '   75'
        db      '  110'
        db      '  134'
        db      '  150'
        db      '  200'
        db      '  300'
        db      '  600'
        db      ' 1200'
        db      ' 1800'
        db      ' 2000'
        db      ' 2400'
        db      ' 3600'
        db      ' 4800'
        db      ' 9600'
        db      '19200'

L1DCC:
        push    h
        lxi     h,switchpack1
        mov     d,e
        mov     a,e
        call    get_bitmap_bit
        ana     m
        pop     h
        rz
        mvi     a,$01
        ret

configure_the_pusart:
        ; Calculate a new value for OUT_BAUD_RATE_GENERATOR as
        ; baud_rage_tenerator := tbaud_index16 | rbaud_index16>>4.
        lda     rbaud_index16
        ani     $f0
        rrc
        rrc
        rrc
        rrc
        mov     b,a
        lda     tbaud_index16
        ani     $f0
        ora     b
        sta     baud_rage_tenerator
        ani     $f0             ; Keep TX baud
        cpi     $20             ; Compare for 110 BAUD
        lda     mode_byte_for_pusart
        jz      .baud110        ; If TX baud is 110 then jump.
        ani     $3f
        ori     $80
        jmp     .store_mode
.baud110:
        ani     $3f
        ori     $c0
.store_mode:
        sta     mode_byte_for_pusart
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_OPTION_PRESENT_H
        jz      .no_stp          ; Jump if STP is not installed.
        lxi     h,switchpack2
        mov     a,m
        ori     SWITCHPACK2_AUTO_XON_XOFF
        mov     m,a
        mvi     a,$6e
        jmp     L1E31
.no_stp:
        lda     switchpack4
        ani     SWITCHPACK4_PARITY_SENSE | SWITCHPACK4_PARITY
        mov     b,a
        lda     switchpack4
        ani     SWITCHPACK4_BITS
        rrc
        ori     $20
        ora     b
        rrc
        rrc
        mov     b,a
        lda     mode_byte_for_pusart
        ani     $c3
        ora     b
L1E31:
        sta     mode_byte_for_pusart
        lda     switchpack4
        ani     SWITCHPACK4_POWER
        jz      L1E3E
        mvi     a,DC011_SET_50_HERTZ_MODE-DC011_SET_60_HERTZ_MODE
L1E3E:
        adi     DC011_SET_60_HERTZ_MODE
        sta     dc011_freq_command
        lda     switchpack1
        ani     SWITCHPACK1_CURSOR
        jz      L1E4D
        mvi     a,$01
L1E4D:
        call    L1E6E
        call    write_pusart_registers
        lda     cursposx
        cpi     21
        cz      reconfigure_display
        cpi     29
        cz      reconfigure_display
        cpi     12
        cz      L0BF2
        cpi     18
        cz      L0BF2
        call    redraw_cursor
        ret

L1E6E:
        ora     a
        jz      L1E79
        sta     screen_attr_underline
        xra     a
        jmp     L1E94

L1E79:
        in      IN_FLAG_BUFFER
        ani     FLAG_BUFFER_ADVANCED_VIDEO_L
        jnz     .no_avo                 ; Jump if AVO is not installed.
        sta     cursor_attribute_base   ; cursor_attribute_base := 0
        mvi     a,$01
        sta     screen_attr_underline
        mvi     a,$02
        sta     cursor_attribute_avo
        jmp     L036B

.no_avo:
        xra     a
        sta     screen_attr_underline
L1E94:
        sta     cursor_attribute_avo
        mvi     a,BASE_ATTRIBUTE_MASK
        sta     cursor_attribute_base
        jmp     L036B

parse_answerback1:
        call    display_character_or_diamond
        lxi     h,answerback_message
        mov     m,a             ; Store first character.
        inx     h               ; hl++
        shld    parse_answerback_state
        mov     b,a             ; Memset the first character.
        lxi     d,20            ; Memset 20 bytes.
        call    memset          ; Memset from answerback_message+1.
        lxi     h,parse_answerback2
        shld    parser_state    ; Continue answerback at next parser round.
        ret

parse_answerback2:
        call    display_character_or_diamond
        lhld    parse_answerback_state
        mov     b,a
        lda     answerback_message
        mov     c,a
        cmp     b
        jz      .the_end        ; Jump if current character equals the first.
        mov     a,l
        cpi     (answerback_message+21) & $ff
        jz      .the_end        ; Jump if reached end of answerback buffer.
        mov     m,b
        inx     h               ; Next in buffer.
        shld    parse_answerback_state
        ret

.the_end:
        mov     m,c
        call    L1CCD
        call    cc_cr
        jmp     setup_finish

; Display character in a, or diamond if it is not printable.
display_character_or_diamond:
        push    psw
        cpi     $20
        jnc     .isprint_or_01  ; jump if $20 <= a
        mvi     a,$01           ; If a < $20 then a := $01 (diamond)

.isprint_or_01:
        call    display_character_with_single_shift
        pop     psw
        ret

L1EEA:
        push    h
        lxi     h,screen_buffer_a_ptr
        mov     c,a
        lda     setup_132columns
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

; e: test to run. See EK-VT100-TM-003, Section A-42.
data_loopback_test:
        push    d
        xra     a
        sta     online_flags        ; Store 0 which means online.
        mvi     b,$00
L1F18:
        mov     a,b
        sta     baud_rage_tenerator
        out     OUT_BAUD_RATE_GENERATOR
        mvi     c,$01
L1F20:
        mov     a,c
        out     OUT_PUSART_DATA
        lxi     h,$c000
.loop_getc:
        push    b
        push    h
        call    silo_getc
        pop     h
        pop     b
        jnz     do_next_baud
        inx     h
        mov     a,h
        ora     l
        jnz     .loop_getc      ; Jump if hl /= $0000
L1F36:
        mvi     a,PUSART_COMMAND_RxEN | PUSART_COMMAND_TxEN
        out     OUT_PUSART_COMMAND
        lda     baud_rage_tenerator
        out     OUT_BAUD_RATE_GENERATOR
        ; TODO: What does $05 mean here? Enables keyboard LED 2 and LED 4?
        mvi     a,ONLINE_FLAGS_LOCAL | $05
        sta     online_flags
        xra     a
        stc
        pop     d
        ret

do_next_baud:
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
        cpi     $10             ; Compare for "tbaud=75 and rbaud=50".
        jnz     L1F18           ; Jump if not "tbaud=75 and rbaud=50".
        xra     a
        pop     d
        ret

L1F62:
        push    d
        mvi     d,$07
L1F65:
        mov     a,d
        call    L1F7B
        call    test_involving_modem_signals
        cmp     d
        jnz     L1F36
        dcr     d
        jnz     L1F65
        mvi     a,PUSART_COMMAND_RxEN | PUSART_COMMAND_TxEN
        out     OUT_PUSART_COMMAND
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
        ori     NVR_LATCH_BIT4
        sta     nvr_latch_for_standby
        out     OUT_NVR_LATCH
        mvi     c,PUSART_COMMAND_RxEN | PUSART_COMMAND_TxEN
        mov     a,b
        ani     $01             ; The result is probably always $01,
        jz      .norts          ; so this jump is never taken.
        mvi     c,PUSART_COMMAND_RTS | PUSART_COMMAND_RxEN | PUSART_COMMAND_TxEN
.norts:
        mov     a,b
        ani     $04                     ; From ONLINE_FLAGS_LOCAL.
        jz      .local                  ; DTR is off when VT100 is off-line.
        mov     a,c
        ori     PUSART_COMMAND_DTR
        mov     c,a
.local:
        mov     a,c
        out     OUT_PUSART_COMMAND
        ret

test_involving_modem_signals:
        in      IN_MODEM_BUFFER
        mov     b,a
        mvi     c,$01
        mov     a,b
        ani     MODEM_BUFFER_nCTS | MODEM_BUFFER_nCD
        jz      L1FB3           ; Jump if nCTS=0 and nCD=0.
        cpi     MODEM_BUFFER_nCTS | MODEM_BUFFER_nCD
        mvi     a,$ff
        rnz                     ; Return if nCTS=0 or nCD=0.
        ; nCTS=nCD=1
        mvi     c,$00
L1FB3:
        mov     a,b
        ani     MODEM_BUFFER_nSPDI
        jz      L1FBD
        mov     a,c
        ori     $02
        mov     c,a
L1FBD:
        in      IN_PUSART_STATUS
        rrc
        rrc
        cma                             ; Produce the one's complement.
        ani     PUSART_STATUS_DSR>>2
        xra     b                       ; a := a XOR MODEM_BUFFER_nRI
        ani     MODEM_BUFFER_nRI        ; a := nRI & ((not DSR) ^ nRI)
        mvi     a,$ff
        rnz                             ; Return if nRI = DSR.
        mov     a,b
        ani     MODEM_BUFFER_nRI
        jnz     L1FD4                   ; Jump if nRI = 1.
        mov     a,c
        ori     $04
        mov     c,a
L1FD4:
        ora     a
        mov     a,c
        ret

; Fill ROM to 8 KiB boundary
        org     $1fff
        nop

;  Memory map
;
;  ADDRESS         DESCRIPTION                  PHYSICAL
;  (HEX)                                        LOCATION
; -------------------------------------------------------
;  0000-1FFF       BASIC ROM                    BVB
;  2000-2BFF       SCREEN AND SCRATCH RAM       BVB
;  2C00-2FFF       AVO SCREEN RAM               AVO
;  3000-3FFF       ATTRIBUTE RAM (4-bit)        AVO
; -------------------------------------------------------

; The graphics DMA starts reading line data from beginning of RAM
; at top of each frame. First are a couple of "fill
; lines" which keep the display silent until it is time for the first
; visible line.
ram_begin                       = $2000
screen_ram_50hz                 = $2002

; Hardware will pick up the address for the top-most visible line
; from this location, which is embedded in a fill line. Software
; writes this location to set line attributes and the top line
; address.
line0ptr                        = $2004
top_of_stack                    = $204E
variables_begin                 = $204E
screen_buffer_a_ptr             = $204E
number_of_columns               = $2050
poll_scroll_pend0               = $2051
L2052                           = $2052
L2054                           = $2054
L2056                           = $2056
L2058                           = $2058
smooth_scroll_term_a            = $205A
smooth_scroll_term_b            = $205B
tx_fifo                         = $205C ; The transmit buffer is 9 bytes long.
poll_scroll_pend1               = $2065
some_key_state                  = $2067
keys_flag                       = $2068
keys_flag_prev                  = $2069
new_key_buffer                  = $206A ; 4 keyboard codes are buffered.
another_key_buffer              = $206E ; 4 byte array
keyboard_auto_repeat_count      = $2072
keyboard_rx_free                = $2073
L2074                           = $2074
L2075                           = $2075
L2077                           = $2077
bell_indicator                  = $2078
vt105_graphics_option           = $2079
L207A                           = $207A
is_in_setup                     = $207B
dc011_freq_command              = $207C
esc_intermediate_character      = $207D
ascii_jump_value_to_find        = $207E
incremented_in_vfreq            = $207F
silo_rx_wr                      = $20C0
silo_rx_rd                      = $20C1
; index: physical line (0..24), value: address to line in screen RAM.
plinestart                      = $20C2
; Chargen code and attribute at cursor if it was not a cursor.
cursor_code                     = $20F4
cursor_attr                     = $20F5
screen_ram_cursor_pos           = $20F6 ; Pointer to screen RAM location.

; 10 byte here belong together and are memcpy:ed together in
; esc_save_cursor and esc_restore_cursor.
cursposx                        = $20F8
cursposy                        = $20F9
character_attribute_avo         = $20FA
character_attribute_base        = $20FB ; BASE_ATTRIBUTE_MASK or $00
charset_state                   = $20FC
charset_for_g0                  = $20FD ; Map soft character set g{0,1} to
charset_for_g1                  = $20FE ; a machine set.
charset_for_something0          = $20FF ; TODO: What is this?
charset_for_something1          = $2100
origin_mode_is_relative         = $2101

; This is the save area.
cursposx_back                   = $2102
L2104                           = $2104

setup_saved_curspos             = $210D
cursposy_prev                   = $210E
setup_backup_of_parser_state    = $2111

; EK-VT100-TM-003, Section 4.7.3.2 "Logical Screen":
;   "Each entry in LATOFS is the number of a line in the physical
;   screen. The position of an entry in LATOFS refers to the position
;   of a line on the screen. The microprocessor reads the table to
;   learn which line in RAM is available for writing as the new 25th
;   line or which line is being used at a given position on the
;   screen."
;
; latofs bit 7 indictes that line is double width.
latofs                          = $2113 ; 24+1 entries
blink_attr_counter              = $212C ;  8-bit, updated every vertical blank.
blink_curs_counter              = $212D ; 16-bit
cs_parameter_calc               = $212F
cs_parameter_array              = $2130
parser_state                    = $2140
last_column_flag                = $2142
tx_fifo_count                   = $2143
keyboard_is_locked              = $2144
state_for_leds                  = $2145 ; $0f
state_for_bell                  = $2146 ; $80
state_for_keyclick              = $2147 ; $80
state_for_keyboard_scan         = $2148 ; $40
L2149                           = $2149
cs_parameter_index              = $214B ; 16 entries
screen_ram_beginning_of_line    = $214E ; Address of the line of the cursor.
some_key_code                   = $2150 ; TODO: Keyboard repeat?
state_for_direct_cursor_address = $2151
line_for_direct_cursor_address  = $2152
; For line of cursor, taking double width and 80/132 column mode into account.
cursposx_max                    = $2153
margin_bell_pending             = $2154
scroll_region_top               = $2155
scroll_region_bottom            = $2156
cursor_is_at_double_width_line  = $2157
baud_rage_tenerator             = $2158
cursor_attribute_base           = $2159 ; BASE_ATTRIBUTE_MASK or $00
cursor_attribute_avo            = $215A
screen_attr_underline           = $215B
uart_tx_buf                     = $215C ; 21 bytes
uart_put_string_state           = $2171
future_tx                       = $2172
something_has_higher_prio_than_future_tx        = $2173
this_has_higher_prio_than_future_tx             = $2174
terminal_parameters_request_type                = $2176
setup_pend                      = $2177
application_keypad_mode         = $2178
L2179                           = $2179
; SET-UP area
SIZEOF_ANSWERBACK_MESSAGE       = 22
SIZEOF_TABS                     = 17
answerback_message              = $217B ; 22 bytes
tabs                            = $2191 ; 17 bytes of tabs encoded in bits.
setup_132columns                = $21A2 ; 80/132 column mode
setup_intensity                 = $21A3 ; Intensity
mode_byte_for_pusart            = $21A4 ; Mode byte for PUSART
online_flags                    = $21A5 ; On-Line/Local
switchpack1                     = $21A6 ; Bits are laid out similar to SET-UP
switchpack2                     = $21A7 ; screen. Each switchpack contains
switchpack3                     = $21A8 ; data in the high nibble only.
switchpack4                     = $21A9
switchpack5                     = $21AA
tbaud_index16                   = $21AB ; Transmit BAUD rate
rbaud_index16                   = $21AC ; Receive BAUD rate
setup_parity                    = $21AD ; Parity
setup_checksum_for_nvr          = $21AE ; Checksum for NVR
nvr_read_decoded                = $21AF
parse_answerback_state          = $21B4
question_for_lh                 = $21B8
ascii_jump_last_hit_value       = $21B9
blink_curs_is_visible           = $21BA
cursposx_prev                   = $21BB
cursor_key_mode                 = $21BC
device_status_malfunction       = $21BD
setup_can_toggle                = $21BE
L21BF                           = $21BF
transmitter_urgent_char0        = $21C0
transmitter_urgent_char1        = $21C1
received_xoff                   = $21c2
clear_line_pending              = $21C3
silo_getc_disable               = $21C4 ; Makes silo_getc return early.
setup_saved_line0ptr            = $21C5
fill_loop_code                  = $21C7 ; For claring screen, fill with E, etc.
avo_is_not_installed            = $21C8
nvr_latch_for_standby           = $21C9
blink_attr_reverse_field        = $21CB
screen_buffer_b                 = $21CC
nvr_buffer                      = $21D3
screenbuf_setup_banner          = $2253
L225A                           = $225A
L2265                           = $2265
screen_22d0_user_lines_begin    = $22D0
variables_end                   = $3000

attribute_ram_begin             = $3000
; Looks like locations $3000..$32cf are never referenced.

end

