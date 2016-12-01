
Spaceship bob = new Spaceship();
Outside light = new Outside();
Stars[] sky = new Stars[400];

ArrayList <Bullet> pow = new ArrayList <Bullet>();
ArrayList <Asteroid> rocks = new ArrayList <Asteroid>();

 int points = 0;
 int lives = 5;
 PImage b;

  boolean check = true;
    int countDown = 0;
//your variable declarations here
public void setup()
{
  size(750,750);
  for (int i= 0; i < sky.length; i++)
  {
    sky[i] = new Stars();
  }
  for (int i=0; i< 20; i++){
      rocks.add(new Asteroid());
   }
   b = loadImage("heart.png");
  //your code here
}
public void draw()
{

    background(0);
     for (int i= 0; i < sky.length; i++)
     {
      sky[i].show();
     }
     for (int i=0; i< rocks.size(); i++){
        rocks.get(i).show();
        rocks.get(i).move();
     }
    
    for (int i=0; i< pow.size(); i++){
      pow.get(i).show();
      pow.get(i).move();

   }
   
     for (int j=0; j< pow.size(); j++){


    for (int i=0; i< rocks.size(); i++){
      if (dist(pow.get(j).getX(),pow.get(j).getY(), rocks.get(i).getX(),rocks.get(i).getY()) <= 6){

        stroke(#AD70EF);
        textSize(80);
        text("ow",323,325);
        pow.remove(j);
        j--;

        rocks.remove(i);
        i--; 
        
        points++;
        break; 

      }
  }
}


   
    for (int i=0; i< rocks.size(); i++){
      if (dist(bob.getX(), bob.getY(), rocks.get(i).getX(),rocks.get(i).getY()) <= 20 && check == true){

       lives--; 
       check = false; 
       countDown = 360; 
       /*if (lives <= 0){
          text( "GAME OVER", 375,375);

       }*/
      }

      if (countDown > 0){
        countDown--; 
      }
      else{
        check = true; 
      }
  }

   
   bob.show();
    bob.move();
    
    fill(185, 150, 34);
    textSize(20);
    text("Points: " + points ,650, 60);

    text("Lives: " , 660, 100 ); 
    image(b, 670, 110, 30,30 );
    text("x"+ lives, 700, 130);

    if (pow.size() == 0){
      System.out.println ("hi");
    }
  
}

public void keyTyped() {
  if (key == 'h'){ //hyperspace
    int hyperX = ((int)(Math.random()*750));
    int hyperY = ((int)(Math.random()*750));
    int hyperR = ((int)(Math.random()*360));

      bob.setX(hyperX);
      bob.setY(hyperY);
       bob.setDirectionX(0);
      bob.setDirectionY(0);
     bob.rotate(hyperR);
  
       
      light.setX(hyperX);
      light.setY(hyperY);
      light.setDirectionX(0);
      light.setDirectionY(0);
      light.rotate(hyperR);
  }
if (key == 'g'){ //stop 
    bob.setDirectionX(0);
    bob.setDirectionY(0);

    light.setDirectionX(0); 
    light.setDirectionY(0);
  }

 /*if (key == 'b'){ //accelerate
      light.show();
      light.move();
    
 }*/
}
public void keyPressed()
{
  if (keyCode == RIGHT){
    bob.rotate(30);
     light.rotate(30);
     for (int i=0; i< pow.size(); i++){
        pow.get(i).rotate(30);
   }

 }
 if (keyCode == LEFT){
    bob.rotate(-30);
     light.rotate(-30);
     for (int i=0; i< pow.size(); i++){
        pow.get(i).rotate(-30);
   }

}
if (key == 'b'){
  bob.accelerate(1);
  //light.accelerate(1);
}
if (keyCode == ' '){
   
      pow.add(new Bullet(bob));
    

}
}


class Stars {
  protected int starX, starY;
  protected int starColor;
  public Stars(){
    starX = ((int)(Math.random()*950));
    starY = ((int)(Math.random()*950));
    starColor = ((int)(Math.random()*200));
  }
  public void show(){
    noStroke();
    fill(starColor);
    ellipse(starX,starY,7,7);
  }
}

class Bullet extends Floater {
  
  public Bullet(Spaceship theShip){
    myColor = #FC5F05;
    myStroke = #FC5F05;
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY(); 
  }
  public void setX(int x){
      myCenterX = x;
   }
   public int getX(){
    return (int)myCenterX;
   }
   public void setY(int y)
   {
      myCenterY = y;
   }
    public int getY(){
      return (int)myCenterY;
    }
     public void setPointDirection(int dRadians)
  {
     myPointDirection = dRadians;
  }
  public double getPointDirection()
  {
    return (double)myPointDirection;
  }
   public void setDirectionX(double x){
      myDirectionX = x;
   }
   public double getDirectionX(){
      return (double)myDirectionX;
   }
   public void setDirectionY(double y)
   {
     myDirectionY = y;
   }
   public double getDirectionY()
   {
      return (double)myDirectionY;
   }

   public void show ()  //Draws circle bullets
  {
    fill(myColor);
    stroke(myStroke);
    ellipse( (float)myCenterX, (float)myCenterY, 6, 6);
   
  }
   public void move ()   //move the floater in the current direction of travel
  {
    //change the x and y coordinates by myDirectionX and myDirectionY
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
    if(myCenterX < 0)
      pow.remove(this);
    if(myCenterX > 750)
      pow.remove(this);
    if (myCenterY < 0)
      pow.remove(this);  
    if (myCenterY >750)
     pow.remove(this);
  }
}
class Asteroid extends Floater{
   protected int spin;
  public Asteroid(){
      corners = 6;  //the number of corners, a triangular floater has 3
      int[] allX = {-12,-8,8,12,8,-8};
      int[] allY = {0,8,8,0,-8,-8};
      xCorners  = allX;
      yCorners = allY;
      myColor = #CFCFAD;
      myStroke =  #CFCFAD;
      myCenterX = ((int)(Math.random()*900));
      myCenterY = ((int)(Math.random()*900)); 
      myDirectionX = 0;
      myDirectionY = 0; //holds x and y coordinates of the vector for direction of travel   
      myPointDirection = ((Math.random()*10)-10); 
      myCenterY = ((int)(Math.random()*900));
      myDirectionX = ((int)(Math.random()*2)-2);
      myDirectionY = ((int)(Math.random()*2-2)); //holds x and y coordinates of the vector for direction of travel
      myPointDirection = ((Math.random()*10)-10);
      spin = ((int)(Math.random()*9)-2);
  }
  public void setX(int x){
      myCenterX = x;
   }
   public int getX(){
    return (int)myCenterX;
   }
   public void setY(int y)
   {
      myCenterY = y;
   }
    public int getY(){
      return (int)myCenterY;
    }
   public void setDirectionX(double x){
      myDirectionX = x;
   }
   public double getDirectionX(){
      return (double)myDirectionX;
   }
   public void setDirectionY(double y)
   {
     myDirectionY = y;
   }
   public double getDirectionY()
   {
      return (double)myDirectionY;
   }
  public void setPointDirection(int degrees)
  {
    myPointDirection = degrees;
  }
  public double getPointDirection()
  {
    return (double)myPointDirection;
  }



  public void move() {
    rotate(spin);
    if (spin == 0){
      spin = 1;
    }
    super.move();
    if (myDirectionX == 0 || myDirectionY == 0){
      myDirectionX = 1;
      myDirectionY = 1;
    }

  }
}

class Outside extends Floater {
  public Outside()
  {
      corners = 3;  //the number of corners, a triangular floater has 3
      int[] allX = {-6, -30, -8};
      int[] allY = {6, 0, -6};
      xCorners  = allX;
      yCorners = allY;
      myColor = #506BAA;
      myStroke = #00FFF5;
      myCenterX = 375;
      myCenterY = 375;
      myDirectionX =0;
      myDirectionY = 0; //holds x and y coordinates of the vector for direction of travel
      myPointDirection = 0;
       //holds current direction the ship is pointing in degrees
  }
   public void setX(int x){
      myCenterX = x;
   }
   public int getX(){
    return (int)myCenterX;
   }
   public void setY(int y)
   {
      myCenterY = y;
   }
    public int getY(){
      return (int)myCenterY;
    }
   public void setDirectionX(double x){
      myDirectionX = x;
   }
   public double getDirectionX(){
      return (double)myDirectionX;
   }
   public void setDirectionY(double y)
   {
     myDirectionY = y;
   }
   public double getDirectionY()
   {
      return (double)myDirectionY;
   }
  public void setPointDirection(int degrees)
  {
    myPointDirection = degrees;
  }
  public double getPointDirection()
  {
    return (double)myPointDirection;
  }
 
}

class Spaceship extends Floater
{

  public Spaceship()
  {
      corners = 4;  //the number of corners, a triangular floater has 3
      int[] allX = {-8,16,-8,-2};
      int[] allY = {-8,0,8,0};
      xCorners  = allX;
      yCorners = allY;
      myColor = #506BAA;
      myStroke = #6C85BE;
      myCenterX = 375;
      myCenterY = 375;
      myDirectionX = 0;
      myDirectionY = 0; //holds x and y coordinates of the vector for direction of travel
      myPointDirection = 0;
       //holds current direction the ship is pointing in degrees
  }
   public void setX(int x){
      myCenterX = x;
   }
   public int getX(){
    return (int)myCenterX;
   }
   public void setY(int y)
   {
      myCenterY = y;
   }
    public int getY(){
      return (int)myCenterY;
    }
   public void setDirectionX(double x){
      myDirectionX = x;
   }
   public double getDirectionX(){
      return (double)myDirectionX;
   }
   public void setDirectionY(double y)
   {
     myDirectionY = y;
   }
   public double getDirectionY()
   {
      return (double)myDirectionY;
   }
  public void setPointDirection(int degrees)
  {
    myPointDirection = degrees;
  }
  public double getPointDirection()
  {
    return (double)myPointDirection;
  }
  public void show ()  //Draws the floater at the current position
  {
    fill(myColor);
    stroke(myStroke);
    //convert degrees to radians for sin and cos
    double dRadians = myPointDirection*(Math.PI/180);
    int xRotatedTranslated, yRotatedTranslated;
    beginShape();
    for(int nI = 0; nI < corners; nI++)
    {
      //rotate and translate the coordinates of the floater using current direction
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated,yRotatedTranslated);

    }

    endShape(CLOSE);
  }

}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class
{
  protected int corners;  //the number of corners, a triangular floater has 3
  protected int[] xCorners;
  protected int[] yCorners;
  protected int myColor;
  protected int myStroke;
  protected double myCenterX, myCenterY; //holds center coordinates
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel
  protected double myPointDirection; //holds current direction the ship is pointing in degrees
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)
  public void accelerate (double dAmount)
  {
    //convert the current direction the floater is pointing to radians
    double dRadians =myPointDirection*(Math.PI/180);
    //change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }
  public void rotate (int nDegreesOfRotation)
  {
    //rotates the floater by a given number of degrees
    myPointDirection+=nDegreesOfRotation;
  }
  public void move ()   //move the floater in the current direction of travel
  {
    //change the x and y coordinates by myDirectionX and myDirectionY
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;

    //wrap around screen
    if(myCenterX >width)
    {
      myCenterX = 0;
    }
    else if (myCenterX<0)
    {
      myCenterX = width;
    }
    if(myCenterY >height)
    {
      myCenterY = 0;
    }
    else if (myCenterY < 0)
    {
      myCenterY = height;
    }
  }
  public void show ()  //Draws the floater at the current position
  {
    fill(myColor);
    stroke(myStroke);
    //convert degrees to radians for sin and cos
    double dRadians = myPointDirection*(Math.PI/180);
    int xRotatedTranslated, yRotatedTranslated;
    beginShape();
    for(int nI = 0; nI < corners; nI++)
    {
      //rotate and translate the coordinates of the floater using current direction
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated,yRotatedTranslated);
    }
    endShape(CLOSE);
  }


}
