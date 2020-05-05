class Image {
 
 PImage []logoAnimado = new PImage[3];
 PImage logoUV;
 int idImg;
 float sizeX;
 float sizeY;
 PFont titulo;

 
  Image(int tidimg, float tsizeX, float tsizeY) {
    idImg = tidimg;
    sizeX = tsizeX;
    sizeY = tsizeY;

    
    
    logoAnimado[0] = loadImage("SIM_1.png");
    logoAnimado[1] = loadImage("SIM_2.png");
    logoAnimado[2] = loadImage("SIM_3.png");
    logoUV = loadImage("Univalle.jpg");
      
  //Ajuste tamaño imagenes
  logoAnimado[0].resize(100,0);
  logoAnimado[1].resize(100,0);
  logoAnimado[2].resize(100,0);
  logoUV.resize(75,0);

  }
  
  void mostrar(PImage imgFondo){
    
    logoAnimado(100);
    image(logoAnimado[i],-2,5);
    image(logoUV,sizeX-88,5);
    image(imgFondo,0,112);
  }
  
  void cabezote(){
    background(255);
    //Titulo
    titulo = createFont("big_noodle_titling.ttf",74);
    textFont(titulo);
    fill(#030303);
    text("SOLUCIONES DE INGENIERÍA MECÁNICA",120,85);
  //
  }
}
int tiempo1 = 0, i = 0;

void logoAnimado(int velocidad){
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
