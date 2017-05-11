public class Circle implements Shape {

  private Body body;
  private float x, y, r;
  private color c;

  public Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    c = color(random(0, 255), random(0, 255), random(0, 255));

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = box2d.coordPixelsToWorld(x, y);
    body = box2d.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1; // mass / volume
    fd.friction = 0; // you should know what this is
    fd.restitution = 1; // aka bounciness

    body.createFixture(fd);
    body.setAngularVelocity(spin);

  }

  public void render() {

    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(c);
    stroke(0);
    strokeWeight(1);
    ellipse(0,0,r*2,r*2);
    line(0,0,r,0);
    popMatrix();

  }

  public boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  public void killBody() {
    box2d.destroyBody(body);
  }

}
