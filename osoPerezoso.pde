/*Aplicación: Presentación demostrativa del juego "OSO PEREZOSO" y componentes (control interactivo) 
  Autor: S.I.M. Soluciones de Ingeniería Mecánica
  Integrantes: Julio Largo, Gabriela López, Camilo Rivera, Sebastian Rivera, Carlos Soto
  Fecha última modificación: 14/05/2020
*/
//DIRECTIVAS
import javafx.stage.Screen; //se importa recurso para la animación del logo
//variables
int timeOut = 0; //controla el tiempo de 
int posicionEnSecuencia = 0;//registra la posicion en la secuencia actual del usuario
int avanza = 0; //controla cada cuanto avanza el juguete
int [] secuencia = new int[100]; //arreglo que guarda la secuencia de luz
boolean incorrecto = false; //controla cuando la secuencia ingresada por el usuario es correcta o no
int tamActualSecuencia = 0; //tamaño de la secuencia actual del juego
boolean turnoSimon = true; //controla los turnos entre simon y el usuario
//Botones
Boton [] botones = new Boton[5];

//Sonido
SimonTonoGenerador simonTonos;

//Fuentes usadas
PFont stamp;
PFont dispositivo;

//Imagenes
PImage logo_stamp;
PImage estrellaEncendido;
PImage circuloEncendido;
PImage trianguloEncendido;
PImage cuadradoEncendido;
PImage corazonEncendido;
PImage parlantes;
//Animacion juguete
PImage jugueteEstatico;
float imgX=109;
int numCuadros = 20;
int cuadroActual = 0;
PImage [] jugueteCamina = new PImage[numCuadros];

//Diseño basico ventana
Image [] banner = new Image[5];
Image titulo;
PImage fondo;

//CONFIGURACIÓN
void setup(){
  size(1000,700);
  //Cargar imagenes y ajustar tamaño
  imagenes();
  //Cargar fuentes texto
  fuentesLetras();
  //Diseño basico ventana
  banner[0] = new Image(0,1000,700);//logo SIM
  banner[1] = new Image(1,1000,700);//logo SIM
  banner[2] = new Image(2,1000,700);//logo SIM
  banner[3] = new Image(3,1000,700);//logo UV
  banner[4] = new Image(4,0,0);//fondo
  titulo = new Image(0,0,0);
  //carga imagen de fondo
  fondo = loadImage("fondo-arbol.jpg");
  //Botones
  botones[0] = new Boton(0,estrellaEncendido,110,522,125,540,125,115);
  botones[1] = new Boton(1,circuloEncendido,263,522,276,536,117,117);
  botones[2] = new Boton(2,trianguloEncendido,415,522,428,536,117,117);
  botones[3] = new Boton(3,cuadradoEncendido,591,522,601,536,117,117);
  botones[4] = new Boton(4,corazonEncendido,758,522,766,536,117,117);
  
  simonTonos = new SimonTonoGenerador(this); //inicia el sonido
  simonIniciaJuego(); //comienza un nuevo juego

}

//DIBUJO-CICLO INFINITO
void draw(){
  //muestra el diseño de la ventana
  disenoVentana();
  //muestra el dispositivo
  disenoDispositivo();
  
  //sonidos botones
  simonTonos.checkSuenaTiempo(); //controla el tiempo de duración del sonido de los botones
    
  if(simonTonos.estaSonando == false)apagaBoton(); //apaga la luz del boton cuando se cumple el tiempo de duración de los botones
  
  if (turnoSimon) {
    muestraSecuencia();//si el turno es de Simon muestra la secuencia que el usuario debe repetir
     //controla cuando avanza el juguete 
      if((tamActualSecuencia % 4)== 0 && tamActualSecuencia != 0){ //el juguete avanza cada cuatro niveles
             imgX = imgX + 1;
             caminaJuguete();
      }
      else{image(jugueteEstatico,imgX,308);}     
   }
  
  else{image(jugueteEstatico,imgX,308);}
}//Fin draw


//FUNCIONES
//Inicia un nuevo juego
void simonIniciaJuego(){
  nuevaSecuencia(); //genera una nueva secuencia
  timeOut = millis() +1000; //genera el periodo en el que se enciende cada boton 
  turnoSimon = true; //asigna el turno a Simon
}
//Muestra secuencia
void muestraSecuencia(){
    if(millis() >= timeOut){ //si los milisegundos desde que inicia el programa es mayor al periodo de tiempo establecida
      
      int palabra = secuencia[posicionEnSecuencia];//palabra corresponde al valor del arreglo en la posición posicionEnSecuencia
      simonTonos.suenaTono(palabra,420); //suena el tono correspondiente al boton asignado a la palabra
      botones[palabra].estadoON = true; //enciende el boton correspondiente a la palabra
      
      if(posicionEnSecuencia < tamActualSecuencia){ //si la posicion en el arreglo es menor al tamaño actual o nivel entonces
        posicionEnSecuencia++; //avanza una posicion
        
      }
      else{ //sino
        turnoSimon = false; //turno del usuario
        posicionEnSecuencia = 0; //la posicion en la secuencia regresa a cero
      }
      
      timeOut = millis() + 420 + 50; //actualiza el periodo de tiempo entre boton encendido
  } 
}

//Botones presionados
void mousePressed(){
  if(turnoSimon == false){ //si es el turno del usuario
    
    for(Boton botonActual : botones){//repite el ciclo la cantidad de botone
      
      if(botonActual.mouseSobre() == true){//si el cursor esta dentro del rango del boton
        
        botonActual.estadoON = true; //si se presiona el mouse enciende el boton
        //REVISA
        if(secuencia[posicionEnSecuencia] != botonActual.Id){//si el boton presionado no corresponde al de la secuencia, entonces
          simonTonos.suenaTono(5,420); //suena el tono de incorrecto
          incorrecto = true; //la respuesta es incorrecta
        }
        
        else{//sino
          simonTonos.suenaTono(botonActual.Id,420);//suena el tono del boton correspondiente
        }
      }
    }
  }
}

//Soltar botones
void mouseReleased(){
  
  if(turnoSimon == false){//si es el turno del usuario
    
    simonTonos.paraTono(); //baja el volumen a cero
    apagaBoton();//apaga luz boton
    
    if(incorrecto){//si incorrecto es verdadero, es decir, la respuesta es mala
      simonIniciaJuego();//inicia un juego nuevo
      incorrecto = false;//reinicia incorrecto
    }
    else{//sino, es correcto
      if(posicionEnSecuencia < tamActualSecuencia){//si la posicion en el arreglo es menor al nivel
        posicionEnSecuencia++;//avance una posicion
        //println(posicionEnSecuencia);
      }
      else{//sino
        if(tamActualSecuencia == secuencia.length-1){//si llega al ultimo nivel
          simonIniciaJuego();//inicia un juego nuevo
        }
        else{//sino
          tamActualSecuencia++;//suba el nivel, aumenta la secuencia mostrada
          posicionEnSecuencia = 0;//reinicia la posicion en el arreglo
          timeOut = millis() + 1000;//actualiza el periodo de tiempo del 
          turnoSimon = true;//turno de Simon
        }     
      }   
    }
  }
}
void apagaBoton(){//apaga luz
  for(Boton botonActual : botones){
    botonActual.estadoON = false;
  } 
}

void nuevaSecuencia(){//genera una secuencia nueva
  for(int i = 0; i < secuencia.length;i++ ){
    secuencia[i] = int(random(0,5));
  }
  tamActualSecuencia = 0;//inicia el contador del tamaño de la secuencia mostrada o nivel
  posicionEnSecuencia = 0;//inicia el contador de la posicion en la secuencia mostrada
  imgX = 109;
  //printArray(simonSentence);
  println(join(nf(secuencia, 0), ", "));
}
//Cargar imagenes y ajustar tamaño
void imagenes(){
  //carga las imagenes
  parlantes = loadImage("parlantes.png");
  logo_stamp=loadImage("SIM_stamp.png");
  estrellaEncendido = loadImage("estrella3.png");
  circuloEncendido = loadImage("circulo3.png");
  trianguloEncendido = loadImage("triangulo3.png");
  cuadradoEncendido = loadImage("cuadrado3.png");
  corazonEncendido = loadImage("corazon3.png");
  jugueteEstatico = loadImage("perro0.png");
  for(int i=0; i < numCuadros;i++){
    String nomImg = "perro" +nf(i)+ ".png";
    jugueteCamina[i] = loadImage(nomImg);
    jugueteCamina[i].resize(86,0);
  }
  
  //Ajuste tamaño imagenes
  estrellaEncendido.resize(151,0);
  circuloEncendido.resize(144,0);
  trianguloEncendido.resize(146,0);
  cuadradoEncendido.resize(139,0);
  corazonEncendido.resize(133,0);
  logo_stamp.resize(37,0);
  parlantes.resize(50,0);
  jugueteEstatico.resize(86,0);
}
void fuentesLetras(){
  stamp = createFont("big_noodle_titling.ttf",20);
  dispositivo = createFont("KurriIslandCapsPERSONAL-Med.ttf",55);
}
void disenoVentana(){
  titulo.cabezote();
  for(int i=0;i<banner.length;i++){
    banner[i].mostrar(fondo);
  }
}
//Diseño general ventana
void disenoDispositivo(){
  //
  noStroke(); //sin contorno 
  //Carcasa control interactivo
  fill(0,2,44); //azul
  rect(56,449,911,246,114);
  fill(1,4,64); //azul
  rect(67,446,885,240,114);
  //Logo stamp
  image(logo_stamp,376,649);
  textFont(stamp);
  fill(255);
  text("SOLUCIONES DE INGENIERÍA MECÁNICA",418,674);
  //Nombre producto
  textFont(dispositivo);
  fill(243,247,7);
  text("LAZY-DORO",354,514);
  //parlantes
  fill(0,2,44);
  ellipse(233,498,67,67);
  image(parlantes,209,473);
  fill(0,2,44);
  ellipse(764,498,67,67);
  image(parlantes,740,473);
  //BOTONES
  for(Boton botonActual : botones){
    botonActual.mostrar();
  }
}

void caminaJuguete(){
   frameRate(24);
   cuadroActual = (cuadroActual+1) % numCuadros;
   image(jugueteCamina[cuadroActual % numCuadros],imgX,308);
}
