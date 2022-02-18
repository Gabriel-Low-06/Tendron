void setup() {
  size(1100, 700, P3D);
}
int timekeep=0;
void draw() {
  if (mousePressed) {
    timekeep=millis(); //refresh tree
  }
  background(50, 150, 255);
  translate(550, 350, 0);
  rotateY(-(float)mouseX/110); //rotate based on mouse position
  rotateZ(-(float)mouseY/70 + PI);
  rotateX(1.5); //rotate to face up at start
  translate(-550, -350);
  tendron(550, 350, -300, 60, 0, false, true); //draw the actual tendron, randomly generated
}
void line3D(float x, float y, float z, float x1, float y1, float z1, float howBig) {
  for (int i=0; i<howBig; i++) {
    line(x+i, y, z, x1+i, y1, z1);
    line(x, y+i, z, x1, y1+i, z1);
  }
}
void tendron(int x, int y, int z, float howLong, float rot, boolean started, boolean trunk) {
  strokeWeight(howLong/7);
  if (trunk && howLong>15)tendron(x, y, (int)(z+howLong), howLong*.93, rot, false, true);
  if (trunk && (millis()-timekeep)*howLong>100000) {
    stroke(100, 50, 0);
    line3D(x, y, z, x, y, z+howLong, howLong/7);
  }
  stroke((howLong)*3, (60-howLong)*2, 0);
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
      line3D(x, y, z, newX, newY, newZ, howLong/7);
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
