
int inPin=A1;

void setup() 
{
  Serial.begin(9600);  
}

void loop() 
{
  int readval=analogRead(inPin);
  delay(1000);
  Serial.println(readval);
}
