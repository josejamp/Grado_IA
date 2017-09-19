package practica2;

import java.util.Scanner;

import utils.CompruebaDatos;

import jess.JessException;
import jess.Rete;

public class Main {
	

	
	/**
	 * @param args
	 * @throws JessException 
	 */
	public static void main(String[] args) throws JessException {
		Entrada entrada = new Entrada();
		Salida salida = new Salida();
		Carga carga = new Carga("practica2.clp");
		boolean salir = false;
		Scanner sc = new Scanner(System.in);
		carga.cargaPrograma();
		carga.carga_ent_sal(entrada, salida);
		while(!salir){
			entrada.leeDatos();
			salida.muestraDatos();
			System.out.println("Salir de la aplicacion? (S/N)");
			salir = entrada.respuestaValida(sc.nextLine());
		}
		System.out.println("Aplicacion finalizada");
	}

}
