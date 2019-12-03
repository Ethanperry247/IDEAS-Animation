import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer music;

float angle = 0;
float angleFac = .03;

ArrayList<PVector> vectors = new ArrayList<PVector>();
// r(beta) = 0.8 + 1.6 * sin(6 * beta)
// theta(beta) = 2 * beta
// phi(beta) = 0.6 * pi * sin(12 * beta)

// x = r * cos(phi) * cos(theta)
// y = r * cos(phi) * sin(theta)
// z = r * sin(phi)

float beta = 0;
float speedX;
float speedY;

void setup() {
  //size(600, 400, P3D);
  fullScreen(P3D,2);
  
  minim = new Minim(this);
  
  music = minim.loadFile("song.wav");
  
  //music.play(0);
}

void cameraS()
{
  if ((keyPressed && key == 'w') || (keyPressed && keyCode == UP) || (keyPressed && key == 'W'))
  {
    speedY = speedY-.010;
  } else if (keyPressed && key == 's' || keyPressed && keyCode == DOWN || keyPressed && key == 'S')
  {
    speedY = speedY+.010;
  } else if (keyPressed && key == 'a' || keyPressed && keyCode == LEFT || keyPressed && key == 'A')
  {
    speedX = speedX-.010;
  } else if (keyPressed && key == 'd' || keyPressed && keyCode == RIGHT || keyPressed && key == 'D')
  {
    speedX = speedX+.010;
  } else if (keyPressed && key == 'e')
  {
    angleFac = angleFac+.001;
  } else if (keyPressed && key == 'q')
  {
    angleFac = angleFac-.001;
  } else if (keyPressed && key == 'x')
  {
    rotateX(-speedX);
    speedX=0;
  } else if (keyPressed && key == 'y')
  {
    angleFac = 0;
  } else if (keyPressed && key == 'z')
  {
    rotateZ(-speedY);
    speedY = 0;
  }

  rotateZ(speedY);
  rotateX(speedX);
}
void draw() {
  
  if(!(keyPressed && key == 'p')){
  background(0);
  translate(width/2, height/2);
  rotateY(angle);
  angle += .3*angleFac;
  cameraS();


  float r = 100*(0.8 + 1.6 * sin(6 * beta));
  float theta = 2 * beta;
  float phi = 0.6 * PI * sin(12 * beta);
  float x = r * cos(phi) * cos(theta) * 5 * sin(phi) * cos(phi);
  float y = r * cos(phi) * tan(theta)*5 * sin(phi)* cos(theta);
  float z = r * sin(phi) * 1.5;
  if (keyPressed && key == 'r')
  {
   r = 0;
   x = 0;
   y = 0;
   z = 0; 
   theta = 0;
   phi = 0;
   beta = 0;
   angle = 0;
   angleFac = 0.003;
  }
  
  stroke(255, r, 255);
  beta += 0.0009;

  vectors.add(new PVector(x, y, z));

  noFill();
  stroke(255);
  strokeWeight(3);
  beginShape();
  for (PVector v : vectors) {
    float d = v.mag();
    stroke(255, d, 255);
    vertex(v.x, v.y, v.z);
  }
  endShape();
  }
  
  saveFrame("output1/frame_####.png");
}
