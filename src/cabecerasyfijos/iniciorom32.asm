;;
;;INTRODUCCIÓN DE CÓDIGO PARA PODER USAR 32K
;;
		DI	
	
		IM 		 	 1
		LD			SP, #F380
	
;preparando para 32K
		CALL 		#0138 ;RSLREG
[2]		RRCA
		AND 		#03

; Secondary Slot
		LD 			 C, A
		LD 			HL, #FCC1
		ADD 		 A, L
		LD 			 L, A
		LD 			 A, [HL]
		AND 		#80
		OR 			 C
		LD 			 C, A
[4]		INC 		 L
		LD 			 A, [HL]

; Define slot ID
		AND 		#0C
		OR 			 C
		LD 			 H, #80

; Enable
		CALL 		#0024 ;ENASLT

		EI
;;
;;FIN INTRODUCCIÓN DE CÓDIGO PARA PODER USAR 32K
;;		
