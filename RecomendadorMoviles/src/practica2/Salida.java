package practica2;

import jess.JessException;
import jess.Rete;
import jess.Value;

public class Salida {

	private Rete miRete;
	
	public Salida(){
		this.miRete = null;
	}
	
	public void muestraDatos() throws JessException{
		listaHechos();
		/*
		 * Esto es un ejemplo de c�mo se recuperar�a de la tabla hash la
		 * informaci�n sobre el primer plato que se ha grabado desde jess con
		 * store. En una aplicaci�n real se podr�an almacenar los resultados de jess en
		 * la tabla y desde java cogerlos con fetch y procesarlos o imprimirlos*/
		Value v = this.miRete.fetch("cliente_recom");
		if(v == null) System.out.println("Lo sentimos, no hay ningún móvil que se adapte a sus necesidades");
		else{
			System.out.print(v);
			v = this.miRete.fetch("nombre_terminal");
			System.out.print(" , le recomendamos el movil " + v);
			v = this.miRete.fetch("puntuacion");
			System.out.println(" con puntuacion " + v);
		}
	
			
		// Para parar el motor de reglas
		halt();
	}
	
	public void initRete(Rete nuevoRete){
		this.miRete = nuevoRete;
	}
	
	private void listaHechos() {
		// Obtiene e imprime la lista de hechos
		java.util.Iterator iterador; 
		iterador = this.miRete.listFacts();
		while (iterador.hasNext()) {
			System.out.println(iterador.next());
		}
	}

	private void halt() {
		try {
			this.miRete.halt();
		} catch (JessException je3) {
			System.out.println("Error de parada ");
		}
	}
	
	
}
