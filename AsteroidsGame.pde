
Spaceship bob = new Spaceship();//your variable declarations here
public void setup() 
{
  size(950,950);
  //your code here
}
public void draw() 
{
    background(0);
    bob.show();
    bob.move();
}

public void keyTyped() {
  if (key == 'h'){
      bob.setX((int)(Math.random()*900));
     bob.setY((int)(Math.random()*900));
  }
  if (key == 'g'){
    bob.setDirectionX(0);
    bob.setDirectionY(0);
  }
 if (key == 'p'){
    bob.rotate(30);
 }
 if (key == 'o'){
    bob.rotate(-30);
 }
 if (key == 'b'){
      bob.accelerate(1);
      bob.myStroke = #00FFF5;
      bob.lines();
 }
 
}

class Stars {
  protected int starX, starY;
  protected int starColor;
  public Stars(){
    starX = ((int)(Math.random()*950)));
    starY = ((int)(Math.random()*950)));
    myColor = ((int)(Math.random()*100));
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
      myDirectionX = 3;
      myDirectionY = -3; //holds x and y coordinates of the vector for direction of travel   
      myPointDirection = ((Math.random()*10)-10); //holds current direction the ship is pointing in degrees    
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
  public void lines ()
  {
    stroke(255);
    line((int)myCenterX, (int)(myCenterY+2), (int)(myCenterX-25), (int)(myCenterY+2));
    line((int)myCenterX, (int)(myCenterY-2), (int)(myCenterX-25), (int)(myCenterY-2));
  }
} 

