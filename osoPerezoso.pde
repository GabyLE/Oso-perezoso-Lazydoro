/*Aplicación: Presentación demostrativa del juego "OSO PEREZOSO" y componentes (control interactivo) 
  Autor: S.I.M. Soluciones de Ingeniería Mecánica
  Integrantes: Julio Largo, Gabriela López, Camilo Rivera, Sebastian Rivera, Carlos Soto
  Fecha última modificación: 24/04/2020
*/
//DIRECTIVAS
import processing.serial.*; //se importa la librería Serial para comunicación con Arduino
import javafx.stage.Screen; //se importa recurso para la animación del logo

//Botones
Boton [] botones = new Boton[5];

//Fuentes usadas
//PFont titulo;
PFont stamp;
PFont dispositivo;

//Imagenes
//PImage[] Animacion_logo= new PImage[3];  // secuencia de imagenes
//int i=0, tiempo1=0;
//PImage Logo_univalle;
PImage logo_stamp;
//PImage arbol;
PImage estrellaEncendido;
PImage circuloEncendido;
PImage trianguloEncendido;
PImage cuadradoEncendido;
PImage corazonEncendido;
PImage parlantes;

//Diseño básico ventana
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
  //Botones
  botones[0] = new Boton(estrellaEncendido,110,522,125,540,125,115);
  botones[1] = new Boton(circuloEncendido,263,522,276,536,117,117);
  botones[2] = new Boton(trianguloEncendido,415,522,428,536,117,117);
  botones[3] = new Boton(cuadradoEncendido,591,522,601,536,117,117);
  botones[4] = new Boton(corazonEncendido,758,522,766,536,117,117);
  //Diseño basico ventana
  imagen[0] = new Image(0,1000,700);//logo SIM
  imagen[1] = new Image(1,1000,700);//logo SIM
  imagen[2] = new Image(2,1000,700);//logo SIM
  imagen[3] = new Image(3,1000,700);//logo UV
  imagen[4] = new Image(4,0,0);//fondo
  titulo = new Image(0,0,0);
  //carga imagen de fondo
  fondo = loadImage("fondo-arbol.jpg");
}

//DIBUJO-CICLO INFINITO
void draw(){
  disenoVentana();
  disenoDispositivo();

  //BOTONES
  for(Boton botonActual : botones){
    botonActual.mostrar();
  }

}//Fin draw
//FUNCIONES
//Cargar imagenes y ajustar tamaño
void imagenes(){
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

//Fuentes de letras
void fuentesLetras(){
  stamp = createFont("big_noodle_titling.ttf",20);
  dispositivo = createFont("KurriIslandCapsPERSONAL-Med.ttf",55);
}
//Funcion logo animado
void Animacion_logo(int velocidad)
 {
   if (tiempo1==velocidad)
   {
    i++;
    tiempo1=0;
   if (i==3)
   {
     i=0;
   }
   }
   tiempo1++; 
 }

//Botones presionados
void mousePressed(){
  for(Boton botonActual : botones){
    if(botonActual.mouseSobre() == true){
      botonActual.estadoON = true;
    }
  }
}

//Soltar botones
void mouseReleased(){
  for(Boton botonActual : botones){
    botonActual.estadoON = false;
  }  

}

//diseño basico ventana
void disenoVentana(){
  titulo.cabezote();
  for(int i=0;i<imagen.length;i++){
    imagen[i].mostrar(fondo);
  }
}

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
}
