		OUTPUT	"rh.rom"

;;=====================================================
;;DEFINICIÓN DE CABECERA DE ARCHIVO BIN
;;=====================================================		
		include "cabecerasyfijos/cabecerarom.asm"

		
START:		
		include "cabecerasyfijos/iniciorom32.asm"

		di
		im	1
		ld	a, 0C3h
		ld	(H_TIMI), a
		ld	hl, tickMain
		ld	(H_TIMI+1), hl	; Pone la rutina de interrupcion que lleva la logica del juego

		ld	a, 1
		ld	(tickInProgress), a ; Evita que	se ejecute la logica del juego mientras	se inicializa el hardware
		call	initHardware	; Inicializa el	modo de	video y	el PSG

		xor	a
		ld	(tickInProgress), a ; Permite que se ejecute la	logica del juego en la proxima interrupcion
		call	RDVDP		; Borra	el flag	de interrupcion
		ei

dummyLoop:
		jr	$
END:



;-------------------------------------------------------------------------------
;
; TICKMAIN
;
; Funcion principal llamada desde el gancho de interrupcion (50	o 60 Hz)
; Actualiza el reproductor de sonido
; Evita	que se ejecute la logica al producirse una interrupcion	si no ha
; terminado la iteracion anterior
;-------------------------------------------------------------------------------

tickMain:
		di
		call	updateSound	; Actualiza el driver de sonido

		ld	hl, tickInProgress ; Si	el bit0	esta a 1 no se ejecuta la logica del juego
		bit	0, (hl)
		ret	nz			

		inc	(hl)		; Indica que se	va a realizar una iteracion
		ei
		call	chkControls	; Actualiza el estado de los controles
		call	runGame		; Ejecuta la logica del	juego

		xor	a
		ld	(tickInProgress), a ; Indica que ha terminado la iteracion actual
		ret


;;
;;INICIO ZONA DATOS (BANCO DE MEMORIA 3)
;;
DS				#8000-$			;;;;;;;;;;;;;;;;;;;;;;;;FER:  hay que hacer bloques completos de 8/16/etc KB

