class Boton{
  
  float posX;
  float posY;
  
  PImage botonOFF;
 
  
  Boton(PImage tempBoton, float tempX, float tempY) {
    botonOFF = tempBoton;
    posX = tempX;
    posY = tempY;
    
    
  }
  
  void mostrar() {
    image(botonOFF,posX,posY);
  }
}
