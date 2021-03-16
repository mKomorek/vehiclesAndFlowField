class Vehicle 
{  
  private PVector position_;
  private PVector velocity_;
  private PVector acceleration_;
  private float r_;
  private float maxVelocity_;
  private float maxAcceleration_;

  public Vehicle(PVector position, float maxVelocity, float maxAcceleration) 
  {
    acceleration_ = new PVector(0,0);
    velocity_ = new PVector(0,0);
    velocity_.limit(maxVelocity);
    position_ = position;
    r_ = 10;
    maxVelocity_ = maxVelocity;
    maxAcceleration_ = maxAcceleration;
  }
  
  public void run()
  {
    updateVehicleProperties();
    correctPositionAgainstBorders();
    display();
  }
  
  public void followByFlowField(FlowField flowField)
  {
    PVector direction = flowField.getVectorByPosition(position_);
    direction.mult(maxVelocity_);
    PVector steeringForce = PVector.sub(direction, velocity_);
    applyForce(steeringForce.limit(maxAcceleration_));
  }
  
  private void updateVehicleProperties() 
  {
    velocity_.add(acceleration_);
    position_.add(velocity_);
    acceleration_.mult(0);
  }
  
  private void correctPositionAgainstBorders()
  {
    if (position_.x < -r_) 
      position_.x = width+r_;
    if (position_.y < -r_) 
      position_.y = height+r_;
    if (position_.x > width+r_) 
      position_.x = -r_;
    if (position_.y > height+r_) 
      position_.y = -r_;
  }
  
  private void display() 
  {  
    fill(255);
    stroke(50);
    strokeWeight(1);
    
    translate(position_.x, position_.y);
    rotate(velocity_.heading() + PI/2);
  
    pushMatrix();
    beginShape();
    vertex(0, -r_*2);
    vertex(-r_, r_*2);
    vertex(r_, r_*2);
    endShape(CLOSE);
    popMatrix();
  }
  
  private void applyForce(PVector force) 
  {
    acceleration_.add(force);
  }
}
