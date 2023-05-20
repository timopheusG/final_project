
float birdX, birdY;
float birdSize = 20;
float birdVelocity = 0;
float gravity = 0.3; // gravity fall
float jumpForce = -7;

float pipeWidth = 60; 
float pipeHeight; // calculated pipe height
float pipeGapPercentage = 100; // gap as a percentage of screen height
float pipeVelocity = 3;
ArrayList<Pipe> pipes;
boolean gameover;

void setup() {
  size(800, 800);  
  birdX = width / 4;
  birdY = height / 2;
  
  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe());
  
  gameover = false;
}

void draw() {
  background(0);
  
  if (!gameover) {
    // Update birds position
    birdVelocity += gravity;
    birdY += birdVelocity;
    
    // Update pipe positions
    for (int i = pipes.size() - 1; i >= 0; i--) {
      Pipe pipe = pipes.get(i);
      pipe.update();
      
    }
    
    // Add new pipe every 100 frames
    if (frameCount % 100 == 0) {
      pipes.add(new Pipe());
    }
  }
  
  // Draw bird
  fill(255);
  ellipse(birdX, birdY, birdSize, birdSize);
  
  // Draw pipes
  for (Pipe pipe : pipes) {
    pipe.display();
  }
  
  
}

void keyPressed() {
  if (keyCode == UP && !gameover) {
    birdVelocity = jumpForce;
  }
}

class Pipe {
  float x, y;
  float gapHeight;
  
  Pipe() {
    x = width;
    gapHeight = height * pipeGapPercentage; // Gap height as a percentage of screen height
    y = 0;
  }
  
  void update() {
    x -= pipeVelocity;
  }
  
  void display() {
    fill(0, 255, 0); // Green color
    
    rect(x, 0, pipeWidth, (height/2)*random(0.5,1));
    rect(x, height, pipeWidth, -(height/2)*random(0.5,1));
  }
  


}
