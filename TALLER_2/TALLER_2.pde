//Se guardan las dos versiones del mapa
PImage mapaG;
PImage mapaP;

//Almacenan el tamaño del mapa real
int x;
int y;
//Almacenan las posiciones del cuadro pequeño
int posX;
int posY;
//Almacena las posiciones del mapa grande
int posXGrande;
int posYGrande;
//Almacena cuanto debe girar el mapa (factor)
float rotacion;
//Almacena el factor de escalado
float escaladoPequeno;
float escaladoGrande;

void setup() {
  size(500, 500);
  //Se cargan las imagenes de los mapas
  mapaG = loadImage("map.jpg");
  mapaP = loadImage("map.jpg");
  x = mapaG.width; //ancho del mapa
  y = mapaG.height;// alto del mapa
 
  //Se inicializa el factor de rotacion
  rotacion = 0;
  escaladoPequeno = 1.0f;
  escaladoGrande = 1.0f;

}

void draw() {
  //Borra los duplicados de los mapas y rellena espacios en blanco cuando el mapa gira 
  background(78, 152, 247);
  pushMatrix();
  //Se usan las coordenadas para colocar la posicion del mapa 
  translate(-posXGrande * 8, -posYGrande * 8);

  
  //Se traslada la imagen del mapa, luego se gira y se vuelve a trasladar a la posicion innicial
  //Esto con el fin de que la rotacion se haga en el centro de la pantalla y no en la posicion inicial
  translate((posXGrande * 8) + 250, (posYGrande * 8) + 250);
  rotate(-(rotacion / 50.0f) * PI / 4);
  translate(-(posXGrande * 8) - 250, -(posYGrande * 8) - 250);
  
  //Se escala el mapa grande, usando el mismo concepto para rotar el mapa
  translate((posXGrande * 8) + 250, (posYGrande * 8) + 250);
  //println (escaladoGrande);
  scale(escaladoGrande);
  translate(-(posXGrande * 8) - 250, -(posYGrande * 8) - 250);
  
  //Los atributos anteriores se pasan al mapa
  image(mapaG, 0, 0);
  popMatrix();
  
  //Se genera el minimapa, con su escalado, luego se hace un rectangulo para encerrarlo
  image(mapaP, 0, 0, x / 8, y / 8);
  noFill();
  stroke(0, 0, 0);
  rect(0, 0, x / 8, y /8 );

  //Se controla la posicion del mouse en el recuadro del minimapa, para que lo que esté afuera se omita 
  if (mouseX < x / 8 && mouseY < y / 8) {
    posX = mouseX;
    posY = mouseY;
    //Controla que el cuadro blanco no se salga de su posicion
    //El cuadro blanco indica una version pequeña de lo que se ve en pantalla
    if (mouseX > (x / 8) - escaladoPequeno*((((x / 8) * 500) / x) / 2)) {
      posX = (x / 8) - int (escaladoPequeno*((((x / 8) * 500) / x) / 2));
    }
    if(mouseX < escaladoPequeno*((((x / 8) * 500) / x) / 2)){
      posX = int(escaladoPequeno*((((x / 8) * 500) / x) / 2));
    }
    if (mouseY > (y / 8) - escaladoPequeno*((((y / 8) * 500) / y) / 2)) {
      posY = (y / 8) - int (escaladoPequeno*(((y / 8) * 500) / y) / 2);
    }
    if(mouseY < escaladoPequeno*((((y / 8) * 500) / y) / 2)){
      posY = int (escaladoPequeno*((((y /8) * 500) / y) / 2));
    }
    pushMatrix();
    pushStyle();
    //Se dibuja el cuadro blanco que muestra la version pequeña, con un alpha
    fill(255, 255, 255, 100);
    noStroke();
    //Se mueve en el minimapa
    translate(posX, posY);
    
    //Se colocan valores para el redibujado del mapa grande
    posXGrande = posX - (((x / 8) * 500) / x) / 2;
    posYGrande = posY - (((y / 8) * 500) / y) / 2;
    
    //Se si da clic izquierdo, se aumenta el contador, para que el movimiento sea positivo
    /*if (mousePressed && mouseButton == LEFT){
      rotacion++;
    }*/
    //Se si da clic derecho, se reduce el contador, para que el movimiento sea negativo
    if (mousePressed && mouseButton == LEFT){
      rotacion--;
    }
    
    //Se escala el recuadro blanco
    scale(escaladoPequeno);
    
    //El valor de rotacion se usa para cambiar la rotacion del cuadro blanco del minimapa
    rotate((rotacion / 50.0f) * PI / 4);
    //Ayuda a que el cuadro gire con respecto a su centro
    rectMode(CENTER);
    //Finalmente se hace el cuadro con los valores anteriores
    rect(0, 0, ((x / 8) * 500) / x, ((y / 8) * 500) / y);
    popStyle();
    popMatrix();
  } 
  //En caso de que el mouse salga del area del minimapa, se mantienen los cambios hechos cuando
  //el mouse estaba adentro
  else {
    pushMatrix();
    pushStyle();
    fill(255, 255, 255, 100);
    noStroke();
    translate(posX,posY);
    //rotate((rotacion / 50.0f) * PI / 4);
    //Se escala el recuadro blanco
    scale(escaladoPequeno);
    rectMode(CENTER);
    println (escaladoGrande);
    rect(0, 0, ((x / 8) * 500) / x, ((y / 8) * 500) / y);
    popStyle();
    popMatrix();
    
  }
}

//FUncion que captura el scrolleado del mouse
void mouseWheel(MouseEvent event){
  //Se varian los valores de escalado, segun unos limites que se definen
  //Limite inferior
  if(escaladoPequeno + (event.getCount()) / 50.0f > 0.1 && event.getCount() < 0){
    escaladoPequeno += (event.getCount()) / 50.0f;
    escaladoGrande += -(event.getCount()) / 25.0f;
  }
  //Limite superior
  if (escaladoPequeno + (event.getCount()) / 50.0f <=1 && event.getCount() > 0){
    escaladoPequeno += (event.getCount()) / 50.0f;
    escaladoGrande += -(event.getCount()) / 25.0f;
  }
  System.out.println(escaladoPequeno);
}