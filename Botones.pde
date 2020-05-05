class Boton{
  
  float posX;
  float posY;
  float cuadX;
  float cuadY;
  float widthCuad;
  float heightCuad;
  
  PImage boton;
 
  boolean estadoON = false;
  
  Boton(PImage tempBoton, float tempX, float tempY,float TcuadX, float TcuadY, float TwidthCuad, float TheightCuad) {
    boton = tempBoton;
    posX = tempX;
    posY = tempY;
    cuadX = TcuadX;
    cuadY = TcuadY;
    widthCuad = TwidthCuad;
    heightCuad = TheightCuad;
  }
  
  void mostrar() {
    if(estadoON){
      image(boton,posX,posY);
    }
    else{
      tint(165,167,147);
      image(boton,posX,posY);
      noTint();
    }  
  }
  
  boolean mouseSobre() {
    if(mouseX > cuadX && mouseX < (cuadX+widthCuad) && mouseY > cuadY && mouseY <(cuadY+heightCuad)){
       return true;
    }
    else{
      return false;
    }
  }
}
