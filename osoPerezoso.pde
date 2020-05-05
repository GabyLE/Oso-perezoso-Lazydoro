/*Aplicación: Presentación demostrativa del juego "OSO PEREZOSO" y componentes (control interactivo) 
  Autor: S.I.M. Soluciones de Ingeniería Mecánica
  Integrantes: Julio Largo, Gabriela López, Camilo Rivera, Sebastian Rivera, Carlos Soto
  Fecha última modificación: 24/04/2020
*/
//DIRECTIVAS
import processing.serial.*; //se importa la librería Serial para comunicación con Arduino
import javafx.stage.Screen; //se importa recurso para la animación del logo

//Botones
Boton estrellaOFF;
Boton circuloOFF;
Boton trianguloOFF;
Boton cuadradoOFF;
Boton corazonOFF;
Boton estrellaON;
Boton circuloON;
Boton trianguloON;
Boton cuadradoON;
Boton corazonON;

boolean estadoBotonE = true;
boolean estadoBotonCir = true;
boolean estadoBotonT = true;
boolean estadoBotonCuad = true;
boolean estadoBotonCor = true;


//Fuentes usadas
PFont titulo;
PFont stamp;
PFont dispositivo;

//Imagenes
PImage[] Animacion_logo= new PImage[3];  // secuencia de imagenes
int i=0, tiempo1=0;
PImage Logo_univalle;
PImage logo_stamp;
PImage arbol;
PImage estrellaApagado;
PImage circuloApagado;
PImage cuadradoApagado;
PImage trianguloApagado;
PImage corazonApagado;
PImage estrellaEncendido;
PImage circuloEncendido;
PImage trianguloEncendido;
PImage cuadradoEncendido;
PImage corazonEncendido;
PImage parlantes;

//CONFIGURACIÓN
void setup(){
  size(1000,700);
  //Cargar imagenes y ajustar tamaño
  imagenes();
  //Cargar fuentes texto
  fuentesLetras();
  //Botones
  estrellaOFF = new Boton(estrellaApagado,110,522);
  circuloOFF = new Boton(circuloApagado,263,522);
  trianguloOFF = new Boton(trianguloApagado,415,522);
  cuadradoOFF = new Boton(cuadradoApagado,591,522);
  corazonOFF = new Boton(corazonApagado,758,522);
  
  estrellaON = new Boton(estrellaEncendido,110,522);
  circuloON = new Boton(circuloEncendido,263,522);
  trianguloON = new Boton(trianguloEncendido,415,522);
  cuadradoON = new Boton(cuadradoEncendido,591,522);
  corazonON = new Boton(corazonEncendido,758,522);
}

//DIBUJO-CICLO INFINITO
void draw(){
  background(255);//fondo blanco
  image(arbol,0,112); //fondo imagen arbol
  image(Logo_univalle,912,5,84,105);//muestra la imagen "Logo_univalle", la ubica en una posición x y y, cambia el tamaño
  Animacion_logo(40); //llama la función Animacion_logo y asigna una velocidad para la secuencia
  image(Animacion_logo[i],-2,5,112,105);
  //Titulo
  textFont(titulo);
  fill(#030303);
  text("SOLUCIONES DE INGENIERÍA MECÁNICA",120,85);
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
  if(estadoBotonE){
    estrellaOFF.mostrar();
    
  }
  else{
    estrellaON.mostrar();
  }
  
  if(estadoBotonCir){
    circuloOFF.mostrar();
  }
  else{
    circuloON.mostrar();
  } 
  if(estadoBotonT){
    trianguloOFF.mostrar();
  }
  else{
    trianguloON.mostrar();
  } 
  if(estadoBotonCuad){
    cuadradoOFF.mostrar();
  }
  else{
    cuadradoON.mostrar();
  }
  if(estadoBotonCor){
    corazonOFF.mostrar();
  }
  else{
    corazonON.mostrar();
  }
  
}//Fin draw
//FUNCIONES
//Cargar imagenes y ajustar tamaño
void imagenes(){
  Animacion_logo[0] = loadImage("SIM_1.png");
  Animacion_logo[1] = loadImage("SIM_2.png");
  Animacion_logo[2] = loadImage("SIM_3.png");
  arbol = loadImage("fondo-arbol.jpg");
  parlantes = loadImage("parlantes.png");
  Logo_univalle = loadImage("Univalle.jpg");
  logo_stamp=loadImage("SIM_stamp.png");
  estrellaApagado = loadImage("estrella1.png");
  circuloApagado = loadImage("circulo1.png");
  trianguloApagado = loadImage("triangulo1.png");
  cuadradoApagado = loadImage("cuadrado1.png");
  corazonApagado = loadImage("corazon1.png");
  estrellaEncendido = loadImage("estrella3.png");
  circuloEncendido = loadImage("circulo3.png");
  trianguloEncendido = loadImage("triangulo3.png");
  cuadradoEncendido = loadImage("cuadrado3.png");
  corazonEncendido = loadImage("corazon3.png");
  
  //Ajuste tamaño imagenes
  estrellaEncendido.resize(151,0);
  estrellaApagado.resize(151,0);
  circuloEncendido.resize(144,0);
  circuloApagado.resize(144,0);
  trianguloEncendido.resize(146,0);
  trianguloApagado.resize(146,0);
  cuadradoEncendido.resize(139,0);
  cuadradoApagado.resize(139,0);
  corazonEncendido.resize(133,0);
  corazonApagado.resize(133,0);
  logo_stamp.resize(37,0);
  parlantes.resize(50,0);
}

//Fuentes de letras
void fuentesLetras(){
  titulo = createFont("big_noodle_titling.ttf",74);
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
 //rect(276,536,117,117);
//Botones presionados
void mousePressed(){
  if(mouseX > 125 && mouseX < (122+125) && 
     mouseY > 540 && mouseY < (540+115)){
      estadoBotonE = false;
    }
  if(mouseX > 276 && mouseX < (276+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonCir = false;
    } 
  if(mouseX > 428 && mouseX < (428+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonT = false;
    } 
  if(mouseX > 601 && mouseX < (601+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonCuad = false;
    }
   if(mouseX > 766 && mouseX < (766+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonCor = false;
    } 
}

//Soltar botones
void mouseReleased(){
  if(mouseX > 125 && mouseX < (122+125) && 
     mouseY > 540 && mouseY < (540+115)){
      estadoBotonE = true;
    }
  if(mouseX > 276 && mouseX < (276+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonCir = true;
    } 
  if(mouseX > 428 && mouseX < (428+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonT = true;
    }
  if(mouseX > 601 && mouseX < (601+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonCuad = true;
    }
  if(mouseX > 766 && mouseX < (766+117) && 
     mouseY > 536 && mouseY < (536+117)){
      estadoBotonCor = true;
    }
}
