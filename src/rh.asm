		OUTPUT	"rh.rom"

;;=====================================================
;;DEFINICIÓN DE VARIABLES Y ESTRUCTURAS
;;=====================================================				
		include "constantesyvariables/variablesyestructuras.asm"
	
;;=====================================================
;;DEFINICIÓN DE CONSTANTES
;;=====================================================	
;	include "constantesyvariables/constantes.asm"
;	include "constantesyvariables/constantesenemigos.asm"


;;=====================================================
;;DEFINICIÓN DE CABECERA DE ARCHIVO BIN
;;=====================================================		
		include "cabecerasyfijos/cabecerarom.asm"

		
START:		
		include "cabecerasyfijos/iniciorom.asm"

			;cargando banco 0
			;cargamos los patrones
			LD				HL, tiles_patrones
			LD				DE, CHRTBL
			LD				BC, 2048
			CALL			LDIRVM
			;cargamos los colores de los patrones
			LD				HL, tiles_color
			LD				DE, CLRTBL
			LD				BC, 2048
			CALL			LDIRVM
			;cargando banco 1
			;cargamos los patrones
			LD				HL, tiles_patrones
			LD				DE, CHRTBL + #0800
			LD				BC, 2048
			CALL			LDIRVM
			;cargamos los colores de los patrones
			LD				HL, tiles_color
			LD				DE, CLRTBL + #0800
			LD				BC, 2048
			CALL			LDIRVM
			;cargando banco 2
			;cargamos los patrones
			LD				HL, tiles_patrones
			LD				DE, CHRTBL + #1000
			LD				BC, 2048
			CALL			LDIRVM
			;cargamos los colores de los patrones
			LD				HL, tiles_color
			LD				DE, CLRTBL + #1000
			LD				BC, 2048
			CALL			LDIRVM
			
			;CARGAMOS MAPA (EN ESTE CASO EN LOS 3 BANCOS)
			LD				HL, tiles_mapa
			LD				DE, TILMAP			;destino en vram
			LD				BC, 768				;nº posiciones a pintar
			CALL			LDIRVM
			
			;ESPERA A QUE SE PULSE UNA TECLA
			CALL			CHGET
			
			;RETORNA AL BASIC
			RET	

;END:	
		
		
;dejo esto por si me interesa cambiar color de fondo para que parezca más
;al resultado final
color_pantalla:
			XOR		 		 A					;color negro
			LD				(FORCLR), A
			LD				(BAKCLR), A
			LD				(BDRCLR), A
			JP				CHGCLR
;fin_color_pantalla_negro:
	

tiles_patrones:				incbin "prueba.til.bin"
tiles_color:				incbin "prueba.col.bin"
tiles_mapa:					incbin "prueba.map.todo.bin"


DS				#8000-$			;;;;;;;;;;;;;;;;;;;;;;;;FER:  hay que hacer bloques completos de 8/16/etc KB

