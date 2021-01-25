char inp;

int val2 = 1;

void setup() {
  // abre a conexão serial
  Serial.begin(9600);
}


String leStringSerial(){
  String conteudo = "";
  char caractere;
  
  // Enquanto receber algo pela serial
  while(Serial.available() > 0) {
    // Lê byte da serial
    caractere = Serial.read();
    // Ignora caractere de quebra de linha
    if (caractere != '\n'){
      // Concatena valores
      conteudo.concat(caractere);
    }
    // Aguarda buffer serial ler próximo caractere
    delay(10);
  }
    
  Serial.print("Recebi: ");
  Serial.println(conteudo);
    
  return conteudo;
}

void loop() {
  int val = analogRead(A0);
  
  if(Serial.available() > 0)
  {
    String rec = leStringSerial();
    val2 = rec.toInt();
  }

  Serial.println(val2*val,DEC);
  delay(100);
}

 

//void setup() {
//  Serial.begin(9600);
//
//}
//
//void loop() {
//  int val = analogRead(A0);
//
//  Serial.println(val);
//  delay(100);
//
//}
