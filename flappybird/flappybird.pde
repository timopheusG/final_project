int birdY;
float birdYSpeed;
int score;
int status;
float gravity = 1.2;
PImage bg;
PImage bird;
PImage tilt;
int best;
int currentTime;

int pipeX;
int pipeGap;
int pipeSpeed;
int pipeWidth;
int pipeHeight;
boolean scored;

void setup() {
  size(400, 600);
  reset();
  bg = loadImage("background.jpg");
  bird = loadImage("bird.png");
  tilt = loadImage("uptilt.png");
}

void draw() {
 background(bg);
  
 // status 1 is the play state, status 0 is the intro screen, status 2 is the game over state
 if (status == 0) {
    drawIntro();
 }
  else if (status == 1) {
    updateBird();
    addScore();
    updatePipes();
    checkCollision();
    drawBird();
    drawPipes();
    drawScore();
  } 
   else if (status == 2) {
    drawGameOver();
  }
}
void reset() {
  birdY = height/2;
  birdYSpeed = 0;
  score = 0;
  status = 0;
  pipeX = width;
  pipeGap = 150;
  pipeSpeed = 6;
  pipeWidth = 80;
  pipeHeight = height - pipeGap;
  scored = false;
}

void keyPressed() {
  if (keyCode == UP && status == 1) {
    birdYSpeed = -7;
    currentTime = millis(); //sets current time
    bird = tilt; //changes bird image to that of the up tilted state
    drawBird(); 
  } else if (key == 'a' && status == 0) {
    status = 1;
  } else if (key == 'a' && status == 2) {
    reset();
  }
}

void drawBird() {
//  fill(255, 255, 0);
  if (millis() - currentTime > 470){
  bird = loadImage("bird.png");
  image(bird, 50, birdY);
  }
  else{
    image(bird,50,birdY);
//  ellipse(50, birdY, 32, 32);
}
}
void drawPipes() {
  fill(55, 182, 0);
  rect(pipeX, 0, pipeWidth, pipeHeight );
  rect(pipeX, pipeHeight + pipeGap, pipeWidth, height - pipeHeight - pipeGap ); //pipe drawing
}
void updateBird() {
  birdYSpeed += 0.3 * gravity; //incremenetal falling of the bird, operating always under condition of status = 1, the play status
  birdY += birdYSpeed;
  

}

void updatePipes() {
  pipeX -= pipeSpeed;
  
  if (pipeX < -pipeWidth) {
    pipeX = width;
    pipeHeight = int(random(100, height - 100)); //random generation of the height of the pipe
    scored = false;
  }
  

}

void checkCollision() {
  if (birdY > height || birdY < 0) { //edge hitting gameover mechanism
    status = 2;
    if (score > best){
    best = score;
    }
  }  
  if (pipeX < 120){//checkign if the pipe has transited the x coordinate of the bird
    if(birdY < pipeHeight -5 || birdY > pipeHeight + pipeGap -50 ){ //checkign if the pipe has transited the y coordinate of the bird
      status = 2;
      if (score > best){
      best = score;

      }
    }
  }
} 
void addScore() {
  if (pipeX < 50  && pipeX > 50 - pipeSpeed){ //checkign if the pipe has transited the x coordinate of the bird, then adding score
//    if(birdY < pipeHeight - 10 || birdY > pipeHeight + pipeGap + 10){
  print("hello");
      score++;
      if (score > best) {
        best++;
      }
//    }
  }
}






void drawScore() {
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text(score, width/2, 60);
  text("Best:" + best, width /2, 100); 
}

void drawIntro() {
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Flappy Bird", width/2, height/2 - 50);
  textSize(15);
  text("Press 'a' to Play", width/2, height/2);
}

void drawGameOver() {
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Game Over", width/2, height/2 - 50);
  textSize(15);
  text("Press 'a' to Restart", width/2, height/2);
}
