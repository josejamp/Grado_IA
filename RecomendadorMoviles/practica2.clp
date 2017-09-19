
/*  Grupo 5
	Cristina Valentina Espinosa Victoria
	Jose Javier Martinez Pages
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module MAIN

(deftemplate terminal
  (slot nombre (default ""))
  (slot tam_pantalla (default 0.0))
  (slot sistema_operativo (default ""))
  (slot bateria (default 0)) /* Duracion media en horas */
  (slot camara (default 0))  /* En MegaPixels (Mp) */
  (slot procesador (default 0)) /* En GHz */
  (slot largo (default 0.0))
  (slot ancho (default 0.0))
  (slot grosor (default 0.0))
  (slot teclado_fisico (default FALSE))
  (slot teclado_virtual (default FALSE))
  (slot capacidad_memoria (default 0))
  (slot Wi_Fi (default FALSE))
  (slot comunicaciones (default FALSE)) /* sin punto de acceso, 3G, 4G, etc */
  (slot precio (default 0.0))
  (slot tam_pantalla_abs (default "Peque"))
  (slot bateria_abs (default "Corta"))
  (slot tam_terminal_abs (default "Peque"))
  (slot mem_abs (default "Peque"))
  (slot camara_abs (default "Mala"))
  (slot procesador_abs (default "Debil")))

(deftemplate terminal_necesitado
  (slot tam_pantalla (default "Media"))
  (slot sistema_operativo (default ""))
  (slot bateria (default "Media")) /* Larga, media, corta */
  (slot camara (default "Media")) 
  (slot tam_terminal (default "Medio"))
  (slot teclado_fisico (default FALSE))
  (slot teclado_virtual (default FALSE))
  (slot capacidad_memoria (default "Media"))
  (slot Wi_Fi (default FALSE))
  (slot comunicaciones (default FALSE))
  (slot procesador (default "Debil"))
  (slot precio (default 0))
  (slot cliente_asociado (default "")))

(deftemplate cliente
  (slot nombre (default ""))
  (slot edad (default 0))
  (slot presupuesto (default 0))
  (slot ocupacion (allowed-values "estudiante" "trabajo" "jubilado" "otros")(default "otros"))
  (slot deportista (default FALSE))
  (slot jugar (default FALSE))
  (slot disenio (default FALSE))
  (slot desarrollador (default FALSE))
  (slot chatear (default FALSE))
  (slot fotografia (default FALSE))
  (slot musica (default FALSE))
  (slot leer (default FALSE)))

(deftemplate recomendacion_terminal
    (declare (slot-specific TRUE))
    (slot nombre_terminal (default ""))
    (slot puntuacion (default 0))
    (slot cliente_recom (default "")))

(defglobal ?*crlf* = "
")

(defglobal ?*v_tam_grande* = 100)
(defglobal ?*v_tam_medio* = 70)
(defglobal ?*v_pant_grande* = 5)
(defglobal ?*v_pant_media* = 4)
(defglobal ?*v_bat_larga* = 9)
(defglobal ?*v_bat_media* = 6)
(defglobal ?*v_mem_grande* = 16)
(defglobal ?*v_mem_media* = 8)
(defglobal ?*v_cam_buena* = 8)
(defglobal ?*v_cam_normal* = 6)
(defglobal ?*v_pro_potente* = 1.3)
(defglobal ?*v_pro_medio* = 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; funciones


(deffunction superficie (?largo ?ancho )
						(return (* ?largo ?ancho)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module Identificacion necesidades

(defmodule identificacion_necesidades)

(defrule cliente
    (declare (salience 10))
    (cliente (nombre ?n))
    =>
    (assert (terminal_necesitado (cliente_asociado ?n))))

(defrule precio
    (cliente (presupuesto ?p)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (precio ?p)))

(defrule pantalla_grande1
    (cliente (disenio TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_pantalla "Grande")))

(defrule pantalla_grande2
    (cliente (jugar TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_pantalla "Grande")))

(defrule pantalla_grande3
    (cliente (edad ?d&:(>= ?d 60))
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_pantalla "Grande")))

(defrule pantalla_grande4
    (cliente (desarrollador TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_pantalla "Grande")))

(defrule pantalla_grande5
    (cliente (fotografia TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_pantalla "Grande")))

(defrule pantalla_grande6
    (cliente (leer TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_pantalla "Grande")))

(defrule terminal_peque
    (cliente (deportista TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (tam_terminal "Peque")))

(defrule bateria_larga1
    (cliente (deportista TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (bateria "Larga")))

(defrule bateria_larga2
    (cliente (ocupacion "trabajo")
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (bateria "Larga")))

(defrule bateria_larga3
    (cliente (leer TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (bateria "Larga")))

(defrule camara_buena
    (cliente (fotografia TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (camara "Buena")))

(defrule camara_normal
    (cliente (disenio TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n)
        					   (camara ?cam))
    (test (not eq ?cam "Buena"))
    =>
    (modify ?r1 (camara "Media")))

(defrule teclado_fisico1
    (cliente (desarrollador TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (teclado_fisico TRUE)))

(defrule teclado_fisico2
    (cliente (edad ?d&:(>= ?d 60))
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (teclado_fisico TRUE)))

(defrule memoria_grande1
    (cliente (jugar TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (capacidad_memoria "Grande")))

(defrule memoria_grande2
    (cliente (disenio TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (capacidad_memoria "Grande")))

(defrule memoria_grande3
    (cliente (ocupacion "trabajo")
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (capacidad_memoria "Grande")))

(defrule memoria_grande4
    (cliente (fotografia TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (capacidad_memoria "Grande")))

(defrule memoria_media1
    (cliente (musica TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n)
        					   (capacidad_memoria ?cm))
    (test (not eq ?cm "Grande"))
    =>
    (modify ?r1 (capacidad_memoria "Media")))

(defrule memoria_media2
    (cliente (leer TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n)
        					   (capacidad_memoria ?cm))
    (test (not eq ?cm "Grande"))
    =>
    (modify ?r1 (capacidad_memoria "Media")))

(defrule Wi-Fi1
    (cliente (ocupacion "trabajo")
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (Wi_Fi TRUE)))

(defrule Wi-Fi2
    (cliente (ocupacion "estudiante")
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (Wi_Fi TRUE)))

(defrule comunicaciones1
    (cliente (ocupacion "trabajo")
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (comunicaciones TRUE)))

(defrule comunicaciones2
    (cliente (chatear TRUE)
        	 (nombre ?n))
	?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (comunicaciones TRUE)))

(defrule iOS
    (cliente (disenio TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (sistema_operativo "iOS")))

(defrule Android1
    (cliente (jugar TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n)
        					   (sistema_operativo ?so))
    (test (not eq ?so "iOS"))
    =>
    (modify ?r1 (sistema_operativo "Android")))

(defrule Android2
    (cliente (desarrollador TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n)
        					   (sistema_operativo ?so))
    (test (not eq ?so "iOS"))
    =>
    (modify ?r1 (sistema_operativo "Android")))

(defrule procesador_potente1
    (cliente (jugar TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (procesador "Potente")))

(defrule procesador_potente2
    (cliente (desarrollador TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n))
    =>
    (modify ?r1 (procesador "Potente")))

(defrule procesador_medio
    (cliente (disenio TRUE)
        	 (nombre ?n))
    ?r1 <-(terminal_necesitado (cliente_asociado ?n)
        	                   (procesador ?p))
    (test (not eq ?p "Grande"))
    =>
    (modify ?r1 (procesador "Medio")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module Arreglo terminal ideal

(defmodule arreglo_terminal)

(defrule terminal_pantalla_medios1
    ?r1 <-(terminal_necesitado (tam_terminal "Grande")
        					   (tam_pantalla "Peque"))
    =>
    (modify ?r1 (tam_terminal "Medio")
                (tam_pantalla "Media")))

(defrule terminal_pantalla_medios2
    ?r1 <-(terminal_necesitado (tam_terminal "Peque")
        					   (tam_pantalla "Grande"))
    =>
    (modify ?r1 (tam_terminal "Medio")
                (tam_pantalla "Media")))

(defrule teclado_virtual
    ?r1 <-(terminal_necesitado (teclado_fisico FALSE)
        					   (teclado_virtual FALSE))
    =>
    (modify ?r1 (teclado_virtual TRUE)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module Recomendacion terminal

(defmodule recomendacion_terminal)

(deffacts tabla_valores
    (bat "Larga" ?*v_bat_larga*)
    (bat "Media" ?*v_bat_media*)
    (bat "Corta" 0)
    (mem "Grande" ?*v_mem_grande*)
    (mem "Media" ?*v_mem_media*)
    (mem "Peque" 0)
    (cam "Buena" ?*v_cam_buena*)
    (cam "Media" ?*v_cam_normal*)
    (cam "Mala" 0)
    (pro "Potente" ?*v_pro_potente*)
    (pro "Media" ?*v_pro_medio*)
    (pro "Debil" 0))

(defrule terminal_es_grande
     ?r1 <-(terminal (largo ?l)
        			 (ancho ?a))
    (test (>= (superficie ?l ?a) ?*v_tam_grande*))
     =>
    (modify ?r1 (tam_terminal_abs "Grande")))

(defrule terminal_es_mediano
     ?r1 <-(terminal (largo ?l)
        			 (ancho ?a))
    (test (>= (superficie ?l ?a) ?*v_tam_medio*))
    (test (<  (superficie ?l ?a) ?*v_tam_grande*))
     =>
    (modify ?r1(tam_terminal_abs "Medio")))

(defrule terminal_es_peque
     ?r1 <-(terminal (largo ?l)
        			 (ancho ?a))
    (test (>= (superficie ?l ?a) 0))
    (test (<  (superficie ?l ?a) ?*v_tam_medio*))
     =>
    (modify ?r1(tam_terminal_abs "Peque")))

(defrule terminales_compatibles_tam
      ?r1 <-(terminal_necesitado (tam_terminal ?tam))
      ?r2 <-(terminal (tam_terminal_abs ?tam))
     =>
    (assert (terminales_compatibles_tam ?r1 ?r2)))

(defrule pantalla_es_grande
      ?r1 <-(terminal (tam_pantalla ?p))
    (test (>= ?p ?*v_pant_grande*))
     =>
    (modify ?r1 (tam_pantalla_abs "Grande")))

(defrule pantalla_es_mediana
     ?r1 <-(terminal (tam_pantalla ?p))
    (test (> ?p ?*v_pant_media*))
    (test (< ?p ?*v_pant_grande*))
     =>
    (modify ?r1 (tam_pantalla_abs "Media")))

(defrule pantalla_es_peque
     ?r1 <-(terminal (tam_pantalla ?p))
    (test (<= ?p ?*v_pant_media*))
     =>
    (modify ?r1 (tam_pantalla_abs "Peque")))

(defrule terminales_compatibles_pant
      ?r1 <-(terminal_necesitado (tam_pantalla ?tam))
      ?r2 <-(terminal (tam_pantalla_abs ?tam))
     =>
    (assert (terminales_compatibles_pant ?r1 ?r2)))

(defrule bateria_es_larga
     ?r1 <-(terminal (bateria ?b))
    (test (>= ?b ?*v_bat_larga*))
     =>
    (modify ?r1 (bateria_abs "Larga")))

(defrule bateria_es_media
     ?r1 <-(terminal (bateria ?b))
    (test (>= ?b ?*v_bat_media*))
    (test (< ?b ?*v_bat_larga*))
     =>
    (modify ?r1 (bateria_abs "Media")))

(defrule bateria_es_corta
     ?r1 <-(terminal (bateria ?b))
    (test (>= ?b 0))
    (test (< ?b ?*v_bat_media*))
     =>
    (modify ?r1 (bateria_abs "Corta")))

(defrule terminales_compatibles_bat
      ?r1 <-(terminal_necesitado (bateria ?bat1))
      ?r2 <-(terminal (bateria_abs ?bat2))
      (bat ?bat1 ?val1)
      (bat ?bat2 ?val2)
      (test (>= ?val2 ?val1))
     =>
    (assert (terminales_compatibles_bat ?r1 ?r2)))

(defrule memoria_es_grande
     ?r1 <-(terminal (capacidad_memoria ?b))
    (test (>= ?b ?*v_mem_grande*))
     =>
    (modify ?r1 (mem_abs "Grande")))

(defrule memoria_es_media
     ?r1 <-(terminal (capacidad_memoria ?b))
    (test (>= ?b ?*v_mem_media*))
    (test (< ?b ?*v_mem_grande*))
     =>
    (modify ?r1 (mem_abs "Media")))

(defrule memoria_es_corta
     ?r1 <-(terminal (capacidad_memoria ?b))
    (test (>= ?b 0))
    (test (< ?b ?*v_mem_media*))
     =>
    (modify ?r1 (mem_abs "Peque")))

(defrule terminales_compatibles_mem
      ?r1 <-(terminal_necesitado (capacidad_memoria ?mem1))
      ?r2 <-(terminal (mem_abs ?mem2))
      (mem ?mem1 ?val1)
      (mem ?mem2 ?val2)
      (test (>= ?val2 ?val1))
     =>
    (assert (terminales_compatibles_mem ?r1 ?r2)))

(defrule camara_es_buena
     ?r1 <-(terminal (camara ?b))
    (test (>= ?b ?*v_cam_buena*))
     =>
    (modify ?r1 (camara_abs "Buena")))

(defrule camara_es_normal
     ?r1 <-(terminal (camara ?b))
    (test (>= ?b ?*v_cam_normal*))
    (test (< ?b ?*v_cam_buena*))
     =>
    (modify ?r1 (camara_abs "Media")))

(defrule camara_es_mala
     ?r1 <-(terminal (camara ?b))
    (test (>= ?b 0))
    (test (< ?b ?*v_cam_normal*))
     =>
    (modify ?r1 (camara_abs "Mala")))

(defrule terminales_compatibles_cam
      ?r1 <-(terminal_necesitado (camara ?cam1))
      ?r2 <-(terminal (camara_abs ?cam2))
      (cam ?cam1 ?val1)
      (cam ?cam2 ?val2)
      (test (>= ?val2 ?val1))
     =>
    (assert (terminales_compatibles_cam ?r1 ?r2)))

(defrule procesador_es_potente
    ?r1 <-(terminal (procesador ?b))
    (test (>= ?b ?*v_pro_potente*))
     =>
    (modify ?r1 (procesador_abs "Potente")))

(defrule procesador_es_medio
    ?r1 <-(terminal (procesador ?b))
    (test (>= ?b ?*v_pro_medio*))
    (test (< ?b ?*v_pro_potente*))
     =>
    (modify ?r1 (procesador_abs "Medio")))

(defrule procesador_es_debil
    ?r1 <-(terminal (procesador ?b))
    (test (>= ?b 0))
    (test (< ?b ?*v_pro_medio*))
     =>
    (modify ?r1 (procesador_abs "Debil")))

(defrule procesadores_compatibles
      ?r1 <-(terminal_necesitado (procesador ?pro1))
      ?r2 <-(terminal (procesador_abs ?pro2))
      (pro ?pro1 ?val1)
      (pro ?pro2 ?val2)
      (test (>= ?val2 ?val1))
     =>
    (assert (terminales_compatibles_pro ?r1 ?r2)))

(defrule init_terminal_necesitado
    (declare (salience 10))
    (terminal (nombre ?nt)
              (precio ?pr))
    (cliente (nombre ?nc)
        	 (presupuesto ?din))
    (test (>= ?din ?pr))
    =>
    (assert (recomendacion_terminal (cliente_recom ?nc)
            						(nombre_terminal ?nt))))

;;;;;;;;;;;;;;;;;
;; Module Puntuar

(defmodule puntuar)

(defrule puntuar_tam_terminal
    ?tn1 <-(terminal_necesitado (cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt))
    (recomendacion_terminal::terminales_compatibles_tam ?tn1 ?t1)
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 3))))

(defrule puntuar_tam_pantalla
    ?tn1 <-(terminal_necesitado (cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt))
    (recomendacion_terminal::terminales_compatibles_pant ?tn1 ?t1)
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 1))))

(defrule puntuar_bateria
    ?tn1 <-(terminal_necesitado (cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt))
    (recomendacion_terminal::terminales_compatibles_bat ?tn1 ?t1)
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 3))))

(defrule puntuar_memoria
    ?tn1 <-(terminal_necesitado (cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt))
    (recomendacion_terminal::terminales_compatibles_mem ?tn1 ?t1)
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 3))))

(defrule puntuar_camara
    ?tn1 <-(terminal_necesitado (cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt))
    (recomendacion_terminal::terminales_compatibles_cam ?tn1 ?t1)
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 1))))

(defrule puntuar_teclado_fisico
    ?tn1 <-(terminal_necesitado (teclado_fisico ?tf)
        						(cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt)
        			(teclado_fisico ?tf))
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 1))))

(defrule puntuar_teclado_virtual
    ?tn1 <-(terminal_necesitado (teclado_virtual ?tv)
        						(cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt)
        			(teclado_virtual ?tv))
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 1))))

(defrule puntuar_sistema_operativo
    ?tn1 <-(terminal_necesitado (sistema_operativo ?so)
        						(cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt)
        			(sistema_operativo ?so))
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 1))))

(defrule puntuar_wifi
    ?tn1 <-(terminal_necesitado (Wi_Fi ?wf)
        						(cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt)
        			(Wi_Fi ?wf))
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 3))))

(defrule puntuar_comunicaciones
    ?tn1 <-(terminal_necesitado (comunicaciones ?3g)
        						(cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt)
        			(comunicaciones ?3g))
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 3))))

(defrule puntuar_procesador
    ?tn1 <-(terminal_necesitado (cliente_asociado ?nc))
    ?t1 <-(terminal (nombre  ?nt))
    (recomendacion_terminal::terminales_compatibles_pro ?tn1 ?t1)
    ?rt <-(recomendacion_terminal (nombre_terminal ?nt)
        						  (cliente_recom ?nc))
    =>
    (modify ?rt (puntuacion  (+ ?rt.puntuacion 2))))

(defrule recomendacion (declare (salience -1))
    ?r1 <-(recomendacion_terminal (cliente_recom ?r)
        						  (nombre_terminal ?t)
        						  (puntuacion ?punt))
    (test (>= ?punt 11))
    (not (recomendacion ?r1 ?r))
    =>
    (assert (recomendacion ?r1 ?r))
    (store cliente_recom ?r)
    (store puntuacion ?punt)
    (store nombre_terminal ?t))

;;;;;;;;;;;;;;;;;
;; Module Informa

(defmodule informa)

(defrule print5
    ?r1 <-(recomendacion_terminal (puntuacion ?punt)
        						  (cliente_recom ?r)
        						  (nombre_terminal ?nt))
    (puntuar::recomendacion ?r1 ?r)
    (test (>= ?punt 11))
    (test (<= ?punt 12))
    =>
   (printout t "** Al cliente " ?r " le recomendamos comprar " ?nt ", es un terminal aceptable para el de acuerdo con su perfil, el mejor que hemos podido encontrar." crlf))

(defrule print6
    ?r1 <-(recomendacion_terminal (puntuacion ?punt)
        						  (cliente_recom ?r)
        						  (nombre_terminal ?nt))
    (puntuar::recomendacion ?r1 ?r)
    (test (>= ?punt 13))
    (test (<= ?punt 14))
    =>
   (printout t "** Al cliente " ?r " le recomendamos comprar " ?nt ", es un terminal bueno para el de acuerdo con su perfil, el mejor que hemos podido encontrar." crlf))

(defrule print78
    ?r1 <-(recomendacion_terminal (puntuacion ?punt)
        						  (cliente_recom ?r)
        						  (nombre_terminal ?nt))
    (puntuar::recomendacion ?r1 ?r)
    (test (>= ?punt 15))
    (test (<= ?punt 19))
    =>
   (printout t "** Al cliente " ?r " le recomendamos comprar " ?nt ", es un terminal notable para el de acuerdo con su perfil, el mejor que hemos podido encontrar." crlf))

(defrule print9
    ?r1 <-(recomendacion_terminal (puntuacion ?punt)
        						  (cliente_recom ?r)
        						  (nombre_terminal ?nt))
    (puntuar::recomendacion ?r1 ?r)
    (test (>= ?punt 20))
    (test (<= ?punt 21))
    =>
   (printout t "** Al cliente " ?r " le recomendamos comprar " ?nt ", es un terminal sobresaliente para el de acuerdo con su perfil, el mejor que hemos podido encontrar." crlf))

(defrule print10
    ?r1 <-(recomendacion_terminal (puntuacion ?punt)
        						  (cliente_recom ?r)
        						  (nombre_terminal ?nt))
    (puntuar::recomendacion ?r1 ?r)
    (test (= ?punt 22))
    =>
   (printout t "** Al cliente " ?r " le recomendamos comprar " ?nt ", es un terminal perfecto para el de acuerdo con su perfil, no hay mejor." crlf))
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module Carga datos clientes

/*

(defmodule carga_clientes)

(deffacts clientes
    (cc "Pepe Luis Robles" 18 500 "estudiante" FALSE TRUE FALSE FALSE FALSE TRUE FALSE FALSE)
    (cc "Juan Ramirez de Prado" 20 600 "trabajo" FALSE FALSE TRUE FALSE FALSE FALSE FALSE TRUE)
    (cc "Pepita Feliz" 21 400 "estudiante" TRUE FALSE TRUE FALSE FALSE FALSE TRUE FALSE)
    (cc "Jaime Martinez Perol" 20 400 "estudiante" FALSE TRUE FALSE FALSE TRUE FALSE TRUE FALSE)
    (cc "Jesus Jimenez Lancero" 37 700 "trabajo" FALSE FALSE TRUE TRUE FALSE TRUE FALSE FALSE)
    (cc "Valentina Espinosa Victoria" 20 500 "estudiante" FALSE FALSE FALSE TRUE FALSE FALSE TRUE TRUE))



(defrule crear_cliente
    (cc ?nom ?edad ?pres ?oc ?dep ?jug ?dis ?prg ?chat ?foto ?music ?leer)
    =>
    (assert (cliente (nombre ?nom)
                     (edad ?edad)
                     (presupuesto ?pres)
            		 (ocupacion ?oc)
                     (deportista ?dep)
            		 (jugar ?jug)
            		 (disenio ?dis)
            		 (desarrollador ?prg)
    				 (chatear ?chat)
            		 (fotografia ?foto)
            		 (musica ?music)
            		 (leer ?leer))))


*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module Carga datos terminales

(defmodule carga_terminales)

(deffacts terminales
    (ct "Samsung Galaxy S2" 4.3 "Android" 8 8 1.2 6.6 0.8 12.5 FALSE TRUE 16 TRUE TRUE 299.90)
    (ct "iPhone 5" 5.0 "iOS" 9 8 1.3 6.4 1.3 11.4 FALSE TRUE 16 TRUE TRUE 695.50)
    (ct "Samsung Galaxy S III mini" 4.0 "Android" 7 5 1 6.3 1.0 12.2 FALSE TRUE 8 TRUE TRUE 187.55)
    (ct "Samsung Galaxy Note II" 5.5 "Android" 16 8 1.6 8.1 0.9 15.1 FALSE TRUE 16 TRUE TRUE 284.78)
    (ct "Motorola Moto G" 4.5 "Android" 9 5 1.2 6.6 1.2 13 FALSE TRUE 16 TRUE TRUE 197.01)
    (ct "Sony Xperia L" 4.3 "Android" 12 8 1 6.5 1 12 FALSE TRUE  8 TRUE TRUE 187.11)
    (ct "ZTC SP42" 1.77 "iOS" 6 0 0.2 11.8 7.8 11.8 TRUE FALSE 1 FALSE FALSE 40.00)
    (ct "Blackberry 8520 Gemini" 2.46 "BlackBerryOS" 4.5 2 0.6 6 1.4 10.9 TRUE FALSE 0.25 TRUE FALSE 155.00)
    (ct "iPhone 5s" 4.0 "iOS" 10 8 1.3 5.86 0.76 12.38 FALSE TRUE 16 TRUE TRUE 629.99))

(defrule crear_terminal
    (ct ?nom ?tp ?so ?b ?c ?proc ?a ?p ?l ?tf ?tv ?cm ?wifi ?tresg ?pr)
    =>
    (assert (terminal (nombre ?nom)
                      (tam_pantalla ?tp)
                      (sistema_operativo ?so)
                      (bateria ?b)
            		  (camara ?c)
					  (procesador ?proc)
					  (largo ?l)
            		  (ancho ?a)
            		  (grosor ?p)
					  (teclado_fisico ?tf)
					  (teclado_virtual ?tv)
					  (capacidad_memoria ?cm)
					  (Wi_Fi ?wifi)
					  (comunicaciones ?tresg)
                      (precio ?pr))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test data
	
 /*
  (reset)
  (focus carga_clientes
    	 carga_terminales
         identificacion_necesidades
    	 arreglo_terminal
         recomendacion_terminal
    	 puntuar
         informa)
  (run)
*/






