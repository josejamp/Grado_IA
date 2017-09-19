package practica2;

import jess.JessException;
import jess.Rete;
import jess.Value;

public class Carga {

	public Rete miRete;
	// Nombre del fichero que almacena el programa Jess
	public String programaFuente;
	
	public Carga(String fuente){
		programaFuente = fuente;
		miRete = new Rete();
	}
	
	public void cargaPrograma() {
		System.out.println("Cargando programa " + this.programaFuente + " ");
		try {
			Value v = this.miRete.batch(this.programaFuente);

			System.out.println("Value " + v);
			System.out.println("");
		} catch (JessException je0) {
			System.out.println("Error de lectura en " + this.programaFuente);
			je0.printStackTrace();
		}
	}
	
	public void carga_ent_sal(Entrada ent, Salida sal){
		ent.initRete(this.miRete);
		sal.initRete(this.miRete);
	}
	
}
