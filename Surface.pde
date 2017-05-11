public class Surface {

  private ArrayList<Vec2> surface;
  private Body body;

  public Surface() {
    this.surface = new ArrayList<Vec2>();

    ChainShape chain = new ChainShape();

    float y = random(height*0.75, height);
    surface.add(new Vec2(0,y));
    surface.add(new Vec2(width/2,y));
    for(int x = width/2+1; x < width; x += 10) {
      surface.add(new Vec2(x, y));
      y += random(-10, 10);
    }

    Vec2[] verticies = new Vec2[surface.size()];
    for(int i = 0; i < verticies.length; i++) {
      verticies[i] = box2d.coordPixelsToWorld(surface.get(i));
    }

    chain.createChain(verticies, verticies.length);

    BodyDef bd = new BodyDef();
    body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
  }

  public void render() {
    strokeWeight(1);
    stroke(0);
    noFill();
    beginShape();
    for(Vec2 v : surface) vertex(v.x, v.y);
    endShape();
  }

  public void killBody() {
    box2d.destroyBody(body);
  }
}
