boolean debugLines = false;
FlowField flowField;
ArrayList<Vehicle> vehicles;

public void settings() 
{
  size(1600, 800);
}

public void setup() 
{
  flowField = new FlowField(40);
  flowField.createPerlinNoiseField();
  vehicles = new ArrayList<Vehicle>();
  for(int i=0; i<100; ++i)
    vehicles.add(
      new Vehicle(new PVector(random(width), random(height)),
        random(2, 6),
        random(0.1, 0.3)));
}

public void draw() 
{
  background(173, 216, 230);
  
  if (debugLines)
    flowField.displayField();
   
  
  for (Vehicle vehicle : vehicles)
  {
    vehicle.followByFlowField(flowField);
    vehicle.run();
  }
}

void keyPressed() 
{
  if (key == ' ')
    debugLines = !debugLines;
}

// Make a new flowfield
void mousePressed() 
{
  flowField.createPerlinNoiseField();
}
