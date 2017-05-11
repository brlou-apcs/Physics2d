import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

public Box2DProcessing box2d;
public ArrayList<Shape> shapes;
public Surface surface;

public String currentShape;
public int size, spin;

/* todo: switch between click and hold */

public void setup() {

  fullScreen();
  //size(800, 600);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);

  shapes = new ArrayList<Shape>();
  surface = new Surface();

  currentShape = "box";
  size = 30;
  spin = 0;

}

public void draw() {

  background(255);

  fill(0);
  textSize(20);
  text("fps: " + (int)frameRate, 10, 20);
  text(currentShape, 10, 42);
  text("size: " + size, 10, 64);
  text("w: " + spin, 10, 86);

  if(mousePressed) {
    if(currentShape.equals("box")) shapes.add(new Box(mouseX, mouseY, size, size));
    else shapes.add(new Circle(mouseX, mouseY, size/2));
  }

  removeShapes();

  surface.render();
  for(Shape s : shapes) s.render();

  box2d.step();
}

public void keyReleased() {
  switch (key) {
    case '1': currentShape = "circle";
              break;
    case '2': currentShape = "box";
              break;
    case 'w': size += 2;
              break;
    case 's': size -= 2;
              if(size <= 0) size = 2;
              break;
    case 'a': spin -= 2;
              break;
    case 'd': spin += 2;
              break;
    case 'q': removeAll();
              break;
    case 'e': regenerate();
              break;
  }
}

public void regenerate() {
  surface.killBody();
  surface = new Surface();
}

public void removeShapes() {
  for(int i = shapes.size() - 1; i >= 0; i--) {
    if(shapes.get(i).done()) shapes.remove(i);
  }
}

public void removeAll() {
  for(int i = shapes.size()-1; i >= 0; i--) {
    shapes.get(i).killBody();
    shapes.remove(i);
  }
}

public interface Shape {
  public void render();
  public boolean done();
  public void killBody();
}
