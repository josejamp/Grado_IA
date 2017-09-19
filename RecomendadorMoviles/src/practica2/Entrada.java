package practica2;

import jess.Deffacts;
import jess.Fact;
import jess.JessException;
import jess.RU;
import jess.Rete;
import jess.Value;
import java.util.Scanner;

import utils.CompruebaDatos;

public class Entrada {
	
	private Rete miRete;
	
	public Entrada(){
		this.miRete = null;
	}
	
	public void initRete(Rete nuevoRete){
		this.miRete = nuevoRete;
	}

	public void leeDatos() throws JessException {
		String cad = "";
		Scanner sc = new Scanner(System.in);
		Deffacts deffacts = new Deffacts("cargaClientes", null, this.miRete);
		Fact f = new Fact("cliente", this.miRete);
		
		System.out.println("Introduzca su nombre: ");
		cad = sc.nextLine();
		f.setSlotValue("nombre", new Value(cad, RU.STRING));
		
		System.out.println("Introduzca su edad: ");
		cad = sc.nextLine();
		f.setSlotValue("edad", new Value(this.edadValida(cad), RU.INTEGER));
		
		System.out.println("Presupuesto disponible para el movil: ");
		cad = sc.nextLine();
		f.setSlotValue("presupuesto", new Value(this.presupuestoValido(cad), RU.FLOAT));
		
		System.out.println("Ocupacion (estudiante|trabajo|jubilado|otros):");
		cad = sc.nextLine();
		f.setSlotValue("ocupacion", new Value(this.ocupacionValida(cad), RU.STRING));
		
		System.out.println("Las siguientes preguntas hacen referencia al uso que desea hacer de su movil.");
		System.out.println("");
		
		System.out.println("¿Le gusta hacer deporte? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("deportista", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Quiere utilizar videojuegos en su movil? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("jugar", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Se dedica al disenio? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("disenio", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Se dedica a desarrollar aplicaciones moviles? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("desarrollador", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Le gusta chatear? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("chatear", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Quiere utilizar su movil para hacer fotos? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("fotografia", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Quiere escuchar musica en su movil? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("musica", new Value(this.respuestaValida(cad)));
		
		System.out.println("¿Le gustaria leer en su movil? (S/N)");
		cad = sc.nextLine();
		f.setSlotValue("leer", new Value(this.respuestaValida(cad)));

		deffacts.addFact(f);
		this.miRete.addDeffacts(deffacts);
		reset();
		// A continuaci�n, ejecuta el motor jess y lista los hechos
		// Si el programa jess no tiene m�dulos basta con hacer run()
		this.miRete.setFocus("carga_terminales");
		run();
		this.miRete.setFocus("identificacion_necesidades");
		run();
		this.miRete.setFocus("arreglo_terminal");
		run();
		this.miRete.setFocus("recomendacion_terminal");
		run();
		this.miRete.setFocus("puntuar");
		run();
		
		/* Si el programa jess tiene m�dulos hay que poner el foco sucesivamente en cada uno de ellos, 
		 * en el orden adecuado, y a continuaci�n un run() por cada m�dulo
		 * miRete.setFocus("m�dulo1");
		 * run();
		 * miRete.setFocus("m�dulo2");
		 * run();
		 * miRete.setFocus("m�dulo3");
		 * run();
		 * miRete.setFocus("m�dulo4");
		 * run(); */
		
	}
	

	private void reset() {
		try {
			this.miRete.reset();
		} catch (JessException je2) {
			System.out.println("Error de reseteo ");

			je2.printStackTrace();
		}
	}

	private void run() {
		try {
			this.miRete.run();
		} catch (JessException je4) {
			System.out.println("Error de ejecucion ");

			je4.printStackTrace();
		}
	}
	
	public boolean respuestaValida(String cad){
		Scanner sc = new Scanner(System.in);
		while (!cad.equalsIgnoreCase("S") && !cad.equalsIgnoreCase("N")){
			System.out.println("Por favor, responda S (si) o N (no)");
			cad = sc.nextLine();		
		}
			if(cad.equalsIgnoreCase("S")) return true;
			else return false;
			
	}
	
	private String ocupacionValida(String cad){
		Scanner sc = new Scanner(System.in);
		while (!cad.equalsIgnoreCase("ESTUDIANTE") && !cad.equalsIgnoreCase("TRABAJO") &&
				!cad.equalsIgnoreCase("JUBILADO") && !cad.equalsIgnoreCase("OTROS")){
			System.out.println("Por favor, responda con un dato valido (estudiante|trabajo|jubilado|otro)");
			cad = sc.nextLine();		
		}
			return cad;
	}
	
	private Float presupuestoValido(String cad){
		Scanner sc = new Scanner(System.in);
		while (!CompruebaDatos.isFloat(cad)){
			System.out.println("Por favor, introduzca el dato solicitado con numeros");
			cad = sc.nextLine();		
		}
			return Float.parseFloat(cad);
	}
	
	private Integer edadValida(String cad){
		Scanner sc = new Scanner(System.in);
		while (!CompruebaDatos.isInteger(cad)){
			System.out.println("Por favor, introduzca el dato solicitado con numeros");
			cad = sc.nextLine();		
		}
			return Integer.parseInt(cad);
	}
	

}
