class FlowField 
{
  private int fieldSize_;
  private int columnsNumber_, rowsNumber_; 
  private PVector[][] fieldsMatrix_;
  
  FlowField(int fieldSize)
  {
    fieldSize_ = fieldSize;
    columnsNumber_ = width/fieldSize_;
    rowsNumber_ = height/fieldSize_;
    fieldsMatrix_ = new PVector[columnsNumber_][rowsNumber_];
  }
  
  public void createPerlinNoiseField()
  {
    noiseSeed((int)random(50000));
    PVector offSet = new PVector(0,0);
    for(int i=0; i<columnsNumber_; ++i)
    {
      offSet.y = 0;
      for(int j=0; j<rowsNumber_; ++j)
      {
        float theta = map(noise(offSet.x, offSet.y), 0, 1, 0, TWO_PI);
        fieldsMatrix_[i][j] = new PVector(cos(theta), sin(theta));
        offSet.y += 0.1;
      }
      offSet.x += 0.1;
    }
  }
  
  public PVector getVectorByPosition(PVector vehiclePosition)
  {
    int columnNumber = int(
      constrain(vehiclePosition.x/fieldSize_, 0 , columnsNumber_-1));
    int rowNumber = int(
      constrain(vehiclePosition.y/fieldSize_, 0, rowsNumber_-1));
    return fieldsMatrix_[columnNumber][rowNumber].copy();
  }
  
  public void displayField()
  {
    for(int i=0; i<columnsNumber_; ++i)
    {
      for(int j=0; j<rowsNumber_; ++j)
      {
        drawVector(fieldsMatrix_[i][j],
          i*fieldSize_,
          j*fieldSize_,
          fieldSize_-8);
      }
    }
  }
  
  private void drawVector(PVector fieldVector, int posX, int posY, int scale)
  {
    stroke(0);
    
    pushMatrix();
    translate(posX+fieldSize_/2, posY+fieldSize_/2);
    rotate(fieldVector.heading());    
    line(0, 0, fieldVector.mag()*scale, 0);
    popMatrix();
  }
}
