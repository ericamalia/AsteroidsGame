
Spaceship bob = new Spaceship();
Outside light = new Outside();
Stars[] sky = new Stars[400];
ArrayList <Asteroid> rocks = new ArrayList <Asteroid>();

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
    bob.show();
    bob.move();

    for (int i=0; i< rocks.size(); i++){
      if (dist(bob.getX(),bob.getY(), rocks.get(i).getX(),rocks.get(i).getY()) <= 10){
        bob.setDirectionX(0);
        bob.setDirectionY(0);
        stroke(#AD70EF);
        textSize(80);
        text("ow",323,325);
      }
  }
}

public void keyTyped() {
  if (key == 'h'){
      bob.setX((int)(Math.random()*900));
      bob.setY((int)(Math.random()*900));
       bob.setDirectionX(0);
      bob.setDirectionY(0);
      bob.rotate((int)(Math.random()*360));
  }
 else if (key == 'g'){
    bob.setDirectionX(0);
    bob.setDirectionY(0);
  }

 else if (key == 'b'){
      bob.accelerate(1);
      //bob.myStroke = #00FFF5;
      //bob.lines();
      light.show();
 }

}
public void keyPressed(){
  if (keyCode == RIGHT){
    bob.rotate(30);
     bob.setDirectionX(1);
     bob.setDirectionY(1);

 }
 else if (keyCode == LEFT){
    bob.rotate(-30);
     bob.setDirectionX(1);
     bob.setDirectionY(1);

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


class Asteroid extends Floater{
   protected int spin;
  public Asteroid(){
      corners = 6;  //the number of corners, a triangular floater has 3
      int[] allX = {-8,8,12,8,-8,-12};
      int[] allY = {0,0,-8,-16,-16,-8};
      xCorners  = allX;
      yCorners = allY;
      myColor = #CFCFAD;
      myStroke =  #CFCFAD;
      myCenterX = ((int)(Math.random()*900));
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

class Outside extends Spaceship {
  public Outside()
  {
      corners = 4;  //the number of corners, a triangular floater has 3
      int[] allX = {-9,17,-9,-3};
      int[] allY = {-9,-1,9,-1};
      xCorners  = allX;
      yCorners = allY;
      myColor = #506BAA;
      myStroke = #00FFF5;
      myCenterX = 450;
      myCenterY = 450;
      myDirectionX = 2;
      myDirectionY = -2; //holds x and y coordinates of the vector for direction of travel
      myPointDirection = ((Math.random()*10)-10);
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
    stroke(255);
    line((int)myCenterX, (int)(myCenterY+2), (int)(myCenterX-25), (int)(myCenterY+2));
    line((int)myCenterX, (int)(myCenterY-2), (int)(myCenterX-25), (int)(myCenterY-2));

  }

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
      myCenterX = 450;
      myCenterY = 450;
      myDirectionX = 2;
      myDirectionY = -2; //holds x and y coordinates of the vector for direction of travel
      myPointDirection = ((Math.random()*10)-10);
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
