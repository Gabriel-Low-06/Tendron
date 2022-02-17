void setup() {
  size(1100, 700, P3D);
}
int timekeep=0;
void draw() {
  if (mousePressed) {
    timekeep=millis();
  }
  //if (millis()-timekeep<9000) {
    translate(550, 350, 0);
    rotateY(-(float)mouseX/110);
    rotateZ(-(float)mouseY/70 + PI);
    translate(-550, -350);
    //delay(100) ;
    pushMatrix();
    translate(0, 700, 0);
    rotateX(1.5);
    translate(0, -500, 0);
    background(0);

    tendron(550, 350, 0, 60, 0, false, true);
    popMatrix();
    //}
  //}
}
void line3D(float x, float y, float z, float x1, float y1, float z1) {
  stroke(100, 50, 0);
  for (int i=0; i<7; i++) {
    line(x, y, z, x1, y1, z1);
    x+=1;
    x1+=1;
    line(x, y, z, x1, y1, z1);
    y+=1;
    y1+=1;
    line(x, y, z, x1, y1, z1);
  }
}
void tendron(int x, int y, int z, float howLong, float rot, boolean started, boolean trunk) {
  //delay(20);
  strokeWeight(howLong/7);
  stroke((howLong)*3, (60-howLong)*2, 0);
  if (trunk && howLong>15)tendron(x, y, (int)(z+howLong), howLong*.93, rot, false, true);
  if (trunk && (millis()-timekeep)*howLong>100000)line3D(x, y, z, x, y, z+howLong);
  if (started && (millis()-timekeep)*howLong>60000) {
    int numSegs = (int)random(howLong-5, howLong+5);
    float theta=rot;
    float theta2=0;
    for (int i=0; i<numSegs; i++) {
      int segLength=int(random(5, 12));
      theta+=random(-.4, .4);
      theta2+=random(-.2, .2);
      int newX=(int)(x+segLength*cos(theta));
      int newY=(int)(y+segLength*sin(theta));
      int newZ=(int)(z+segLength*sin(theta2));
      line(x, y, z, newX, newY, newZ);
      x=newX;
      y=newY;
      z=newZ;
    }
  }
  if (howLong>10) {
    for (int i=0; i<7; i++) {
      tendron(x, y, z, howLong/2, rot+(i*360/random(6.5, 7.5)), true, false);
    }
  }
}

