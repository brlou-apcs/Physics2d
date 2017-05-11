public class Box implements Shape {

  private Body body;
  private float x, y, w, h;
  private color c;

  public Box(float x, float y, float w, float h) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = color(random(0, 256), random(0, 256), random(0, 256));

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = box2d.coordPixelsToWorld(x, y);
    body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;

    body.createFixture(fd);
    body.setAngularVelocity(spin);
  }

  public void render() {

    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(c);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();

  }

  public boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+h) {
      killBody();
      return true;
    }
    return false;
  }

  public void killBody() {
    box2d.destroyBody(body);
  }

}
