import processing.sound.*;

class SimonTonoGenerador {
  
  float [] simonTonos = {391.995,329.628,261.626,195.998,185.700,48.9994};
  
  SqrOsc wave;
  
  int detieneTonoTiempo;
  
  boolean estaSonando = false;
  
  SimonTonoGenerador(PApplet p) {
    wave = new SqrOsc(p);
    wave.play();
    wave.amp(0.0);
  }
  
  
  void suenaTono(int index, int duracionTono){
    wave.amp(0.1);
    wave.freq(simonTonos[index]);
    
    detieneTonoTiempo = millis() + duracionTono;
    estaSonando = true;
  }
  
  void checkSuenaTiempo() {
    if(estaSonando){
      if(millis() >= detieneTonoTiempo){
        paraTono();
      }
    } 
  }
  void paraTono(){
    if(estaSonando){
      wave.amp(0.0);
      estaSonando = false;
    }
  }
}
