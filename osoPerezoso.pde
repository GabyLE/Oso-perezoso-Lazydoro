/*Aplicación: Presentación demostrativa del juego "OSO PEREZOSO" y componentes (control interactivo) 
  Autor: S.I.M. Soluciones de Ingeniería Mecánica
  Integrantes: Julio Largo, Gabriela López, Camilo Rivera, Sebastian Rivera, Carlos Soto
  Fecha última modificación: 03/05/2020
*/
//DIRECTIVAS
import javafx.stage.Screen; //se importa recurso para la animación del logo
//variables
int timeOut = 0;
int posicionEnSecuencia = 0;
int [] secuencia = new int[100];
boolean incorrecto = false;
int tamActualSecuencia = 0;
boolean turnoSimon = true;
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

//Diseño basico ventana
Image [] imagen = new Image[5];
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
  imagen[0] = new Image(0,1000,700);//logo SIM
  imagen[1] = new Image(1,1000,700);//logo SIM
  imagen[2] = new Image(2,1000,700);//logo SIM
  imagen[3] = new Image(3,1000,700);//logo UV
  imagen[4] = new Image(4,0,0);//fondo
  titulo = new Image(0,0,0);
  //carga imagen de fondo
  fondo = loadImage("fondo-arbol.jpg");
  //Botones
  botones[0] = new Boton(0,estrellaEncendido,110,522,125,540,125,115);
  botones[1] = new Boton(1,circuloEncendido,263,522,276,536,117,117);
  botones[2] = new Boton(2,trianguloEncendido,415,522,428,536,117,117);
  botones[3] = new Boton(3,cuadradoEncendido,591,522,601,536,117,117);
  botones[4] = new Boton(4,corazonEncendido,758,522,766,536,117,117);
  
  simonTonos = new SimonTonoGenerador(this);
  simonIniciaJuego();
}

//DIBUJO-CICLO INFINITO
void draw(){
  //muestra el diseño de la ventana
  disenoVentana();
  //muestra el dispositivo
  disenoDispositivo();
  
  //sonidos botones
  simonTonos.checkSuenaTiempo();
    
  if(simonTonos.estaSonando == false)apagaBoton();
  
  if (turnoSimon) muestraSecuencia();
  
}//Fin draw


//FUNCIONES
//Inicia un nuevo juego
void simonIniciaJuego(){
  nuevaSecuencia();
  timeOut = millis() +1000;
  turnoSimon = true;
}
//Muestra secuencia
void muestraSecuencia(){
    if(millis() >= timeOut){
      
      int palabra = secuencia[posicionEnSecuencia];
      simonTonos.suenaTono(palabra,420);
      botones[palabra].estadoON = true;
      
      if(posicionEnSecuencia < tamActualSecuencia){
        posicionEnSecuencia++;
      }
      else{
        turnoSimon = false;
        posicionEnSecuencia = 0;
      }
      //if(posicionEnSecuencia>=secuencia.length){
      //  posicionEnSecuencia = 0;
      ////}
      timeOut = millis() + 420 + 50;
  } 
}

//Botones presionados
void mousePressed(){
  if(turnoSimon == false){
    for(Boton botonActual : botones){
      if(botonActual.mouseSobre() == true){
        botonActual.estadoON = true;
        if(secuencia[posicionEnSecuencia] != botonActual.Id){
          simonTonos.suenaTono(5,420);
          incorrecto = true;
        }
        
        else{
          simonTonos.suenaTono(botonActual.Id,420);
        }
      }
    }
  }
}

//Soltar botones
void mouseReleased(){
  
  if(turnoSimon == false){
    
    simonTonos.paraTono(); 
    apagaBoton();
    
    if(incorrecto){
      simonIniciaJuego();
      incorrecto = false;
    }
    else{
      if(posicionEnSecuencia < tamActualSecuencia){
        posicionEnSecuencia++;
        //println(posicionEnSecuencia);
      }
      else{
        if(tamActualSecuencia == secuencia.length-1){
          simonIniciaJuego();
        }
        else{
          tamActualSecuencia++;
          posicionEnSecuencia = 0;
        
          timeOut = millis() + 1000;
          turnoSimon = true;
        }
        
        
      }
      
    }
  }
  
}
void apagaBoton(){
  for(Boton botonActual : botones){
    botonActual.estadoON = false;
  } 
}

void nuevaSecuencia(){
  for(int i = 0; i < secuencia.length;i++ ){
    secuencia[i] = int(random(0,5));
  }
  tamActualSecuencia = 0;
  posicionEnSecuencia = 0;
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
  
  //Ajuste tamaño imagenes
  estrellaEncendido.resize(151,0);
  circuloEncendido.resize(144,0);
  trianguloEncendido.resize(146,0);
  cuadradoEncendido.resize(139,0);
  corazonEncendido.resize(133,0);
  logo_stamp.resize(37,0);
  parlantes.resize(50,0);
}
void fuentesLetras(){
  stamp = createFont("big_noodle_titling.ttf",20);
  dispositivo = createFont("KurriIslandCapsPERSONAL-Med.ttf",55);
}
void disenoVentana(){
  titulo.cabezote();
  for(int i=0;i<imagen.length;i++){
    imagen[i].mostrar(fondo);
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
  text("OSO PEREZOSO",305,514);
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
