
Button []buttons = new Button[4];

//int [] simonSentence = new int [4];
int [] simonSentence;
int positionInSentence = 0;
int timeOut = 0;
int simonsWord;

boolean encendido = false;
  int tiempoApagaLuz;
  int luz;

void setup(){
  size(600,600);
  buttons[0] = new Button(0,0,0,300,#00ff00);
  buttons[1] = new Button(1,300,0,300,#ff0000);
  buttons[2] = new Button(2,0,300,300,#ffff00);
  buttons[3] = new Button(3,300,300,300,#0000ff);
  
}

void draw(){  //<>//
  
  if(millis() >= tiempoApagaLuz){
    setButtonLightsOff();
  }
  simonSays();
  
  for(Button currentButton : buttons) {
    currentButton.display();
  }
} 
void simonSays() {
  if(millis() >= timeOut) {
  
    simonsWord = simonSentence[positionInSentence];
    buttons[simonsWord].isLightOn = true;
    
    positionInSentence++;
    
    if(positionInSentence>=simonSentence.length) {
      positionInSentence = 0;    
    }
    
    //println(positionInSentence);
    
    timeOut = millis() + 420 + 55; //<>//
    tiempoApagaLuz = millis() + 420;
  }  
  
}

 
  
  
void mousePressed() {
    //println("pressed!");
    
    for(Button currentButton : buttons) {
      if(currentButton.isMouseOver() == true) {
        //simonTones.playTone(currentButton.myId, 420);
        currentButton.isLightOn = true;
      }
    }
    
}

void mouseReleased() {
    //println("released!");
    
    //simonTones.stopTone();
    setButtonLightsOff();
    
}

void setButtonLightsOff() {
  
  for(Button currentButton : buttons) {
    currentButton.isLightOn = false;
  }  
  
}
