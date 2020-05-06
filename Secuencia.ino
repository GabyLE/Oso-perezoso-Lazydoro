/* Proyecto final mecatrónica. Soluciones de ingeniería mecánica.
    Ingenieros: Denis López, Julio Largo, Camilo Rivera, Sebastian Rivera y Carlos Soto.
    Universidad del Valle. Profesor José I. García.
 */

//DEFINICIONES
//Pines en el Arduino botones y parlante
#define   BUZZER   7
#define   ENTRADA_A  12 
#define   ENTRADA_B  11
#define   ENTRADA_C  10
#define   ENTRADA_D  9
#define   ENTRADA_E  8
//Asigna un valor a cada led
#define   SALIDA_A   6
#define   SALIDA_B   5
#define   SALIDA_C   4
#define   SALIDA_D   3
#define   SALIDA_E   2

//VARIABLES GLOBALES
int melodia[ ] = {262, 196, 196, 220, 196, 0, 247, 262}; //sonido de cada boton
int duracionNotas[] = {4, 8, 8, 4, 4, 4, 4, 4}; //tiempo sonido
int nivelActual = 1; //
int velocidad = 500; //velocidad del juego
const int NIVEL_MAX = 100; //nivel máximo 
int secuencia[NIVEL_MAX]; //Arreglo donde se guarda la secuencia a seguir
int secuenciaUsuario[NIVEL_MAX];//Arreglo donde se guarda la secuencia del jugador

//CONFIGURACIÓN
void setup(){
  Serial.begin(9600);
  //Asigna los botones como entradas
   pinMode(ENTRADA_E, INPUT);
   pinMode(ENTRADA_D, INPUT);
   pinMode(ENTRADA_C, INPUT);
   pinMode(ENTRADA_B, INPUT);
   pinMode(ENTRADA_A, INPUT);
   //Asigna los LEDs como salidas
   pinMode(SALIDA_A, OUTPUT);
   pinMode(SALIDA_B, OUTPUT);
   pinMode(SALIDA_C, OUTPUT);
   pinMode(SALIDA_D, OUTPUT);
   pinMode(SALIDA_E, OUTPUT);
   //Inicia los LEDs en bajo, apagados
   digitalWrite(SALIDA_A, LOW);
   digitalWrite(SALIDA_B, LOW);
   digitalWrite(SALIDA_C, LOW);
   digitalWrite(SALIDA_D, LOW);
   digitalWrite(SALIDA_E, LOW);
}
//CICLO INFINITO
void loop(){
   if(nivelActual == 1){
      generaSecuencia();
      muestraSecuencia();
      leeSecuencia();
   }
   //Cuando avanza de nivel
   if(nivelActual != 1){
      muestraSecuencia();
      leeSecuencia();
   }
}
//Genera la secuencia a seguir por el usuario
void generaSecuencia(){
   randomSeed(millis());//???
   for(int i = 0; i < NIVEL_MAX; i++){ //El ciclo se ejecuta 100 veces
      secuencia[i] = random(2,7); //asigna 100 valores alatorios entre 2 y 7 a cada casilla del arreglo
      delay (10); //espera de 10 ms
   }
}

//Ilumina los LEDs de acuerdo con la secuencia anterior
void muestraSecuencia(){ 
  //Establece todos los LEDs apagados
   digitalWrite(SALIDA_A, LOW);
   digitalWrite(SALIDA_B, LOW);
   digitalWrite(SALIDA_C, LOW);
   digitalWrite(SALIDA_D, LOW);
   digitalWrite(SALIDA_E, LOW);
   Serial.print("H");
   Serial.print(",");
   //Corre el ciclo el valor de nivelActual número de veces
   for(int i = 0; i < nivelActual; i++){
      if( secuencia[i] == SALIDA_A ){ //Si el valor en la posición i de secuencia[] es igual a 6, entonces
         tone(BUZZER, 200); //suena el sonido asignado
         delay(200);//mantiene el sondo 200ms
         noTone(BUZZER);//apaga el sonido
         Serial.print(SALIDA_A);
         Serial.print(",");
      }
      if( secuencia[i] == SALIDA_B ){//Si el valor en la posición i de secuencia[] es igual a 5, entonces
         tone(BUZZER, 274);
         delay(200);
         noTone(BUZZER);
         Serial.print(SALIDA_B);
         Serial.print(",");
      }
      if( secuencia[i] == SALIDA_C ){//Si el valor en la posición i de secuencia[] es igual a 4, entonces
         tone(BUZZER, 348);
         delay(200);
         noTone(BUZZER);
         Serial.print(SALIDA_C);
         Serial.print(",");
      }
      if( secuencia[i] == SALIDA_D ){//Si el valor en la posición i de secuencia[] es igual a 3, entonces
         tone(BUZZER, 422);
         delay(200);
         noTone(BUZZER);
         Serial.print(SALIDA_D);
         Serial.print(",");
      }
       if( secuencia[i] == SALIDA_E ){//Si el valor en la posición i de secuencia[] es igual a 2, entonces
         tone(BUZZER, 496);
         delay(200);
         noTone(BUZZER);
         Serial.print(SALIDA_E);
         Serial.print(",");
      }
      Serial.println();
      digitalWrite(secuencia[i], HIGH); //Enciende el LED correspondiente a la secuencia
      delay(velocidad); //lo mantiene de acuerdo con la velocidad del nivel actual
      digitalWrite(secuencia[i], LOW);//Apaga el LED correspondiente
      delay(200);//lo mantiene apagado 200ms
   }
}

//Lee la secuencia ingresada por el usuario
void leeSecuencia(){
   int flag = 0;
   for(int i = 0; i < nivelActual; i++){ //Repite el ciclo hasta el valor de nivelActual
      flag = 0;
      while(flag == 0){ //Mientras flag sea igual a 0
        if(digitalRead(ENTRADA_E) == LOW){ //Si el pin ENTRADA_E deja de recibir corriente
            digitalWrite(SALIDA_E, HIGH);//enciena el LED 2
            tone(BUZZER, 496); //sonido correspondiente
            delay(300); //mantiene 300 ms
            noTone(BUZZER);//apaga sonido
            secuenciaUsuario[i] = SALIDA_E;//asigna el valor de SALIDA_E (2) a la posición i en el arreglo secuenciaUsuario[]
            flag = 1; //
            delay(200);// 200 ms de espera
            if(secuenciaUsuario[i] != secuencia[i]){ //si el valor en la posición i de secuencia[] es diferente a 2
               secuenciaError(); //Ejecuta la función para gameover
               return;//??
            }
            digitalWrite(SALIDA_E, LOW);//Apaga el LED
         }
         if(digitalRead(ENTRADA_D) == LOW){
            digitalWrite(SALIDA_D, HIGH);
            tone(BUZZER, 422);
            delay(300);
            noTone(BUZZER);
            secuenciaUsuario[i] = SALIDA_D;
            flag = 1;
            delay(200);
            if(secuenciaUsuario[i] != secuencia[i]){
               secuenciaError();
               return;
            }
            digitalWrite(SALIDA_D, LOW);
         }
         if(digitalRead(ENTRADA_C) == LOW){
            digitalWrite(SALIDA_C, HIGH);
            tone(BUZZER, 348);
            delay(300);
            noTone(BUZZER);
            secuenciaUsuario[i] = SALIDA_C;
            flag = 1;
            delay(200);
            if(secuenciaUsuario[i] != secuencia[i]){
               secuenciaError();
               return;
            }
            digitalWrite(SALIDA_C, LOW);
         }
         if(digitalRead(ENTRADA_B) == LOW){
            digitalWrite(SALIDA_B, HIGH);
            tone(BUZZER, 274);
            delay(300);
            noTone(BUZZER);
            secuenciaUsuario[i] = SALIDA_B;
            flag = 1;
            delay(200);
            if(secuenciaUsuario[i] != secuencia[i]){
               secuenciaError();
               return;
            }
            digitalWrite(SALIDA_B, LOW);
         }
         if(digitalRead(ENTRADA_A) == LOW){
            digitalWrite(SALIDA_A, HIGH);
            tone(BUZZER, 200);
            delay(300);
            noTone(BUZZER);
            secuenciaUsuario[i] = SALIDA_A;
            flag = 1;
            delay(200);
            if(secuenciaUsuario[i] != secuencia[i]){
               secuenciaError(); 
               return;
            }
            digitalWrite(SALIDA_A, LOW);
         }
      }
   }
   secuenciaCorrecta(); //Aumenta el nivel de dificultad
}



void melodiaError(){
   for(int i = 0; i < 8; i++){
      int duracionNota = 1000/duracionNotas[i];
      tone(BUZZER, melodia[i],duracionNotas);
      int pausaEntreNotas = duracionNota * 1.30;
      delay(pausaEntreNotas);
      noTone(BUZZER);
   }
}
//Función para subir el nivel si la secuencia es correcta
void secuenciaCorrecta(){
   if(nivelActual < NIVEL_MAX);
      nivelActual++; //Aumenta la cantidad de cosos de la secuencia
   velocidad -= 25; //Disminuye el tiempo de espera entre cambio de valor secuencia
   delay(200);
}

// Gameover
void secuenciaError(){ //Funcion ejecutada cuando la secuencia del usuario es incorrecta
  //Enciende todos los LEDs
   digitalWrite(SALIDA_A, HIGH);
   digitalWrite(SALIDA_B, HIGH);
   digitalWrite(SALIDA_C, HIGH);
   digitalWrite(SALIDA_D, HIGH);
   digitalWrite(SALIDA_E, HIGH);
   delay(250); //Los mantiene por 250 ms
   //Apaga los LEDs
   digitalWrite(SALIDA_A, LOW);
   digitalWrite(SALIDA_B, LOW);
   digitalWrite(SALIDA_C, LOW);
   digitalWrite(SALIDA_D, LOW);
   digitalWrite(SALIDA_E, LOW);
   delay(250);
   melodiaError(); //Suena melodía gameover
   nivelActual = 1; //Reestablece el nivel al de inicio
   velocidad = 500; //Restablece la velocidad de inicio
}
