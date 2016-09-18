
import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;

Scene scene;
Trackable lastAvatar;
//flock bounding box
int flockWidth = 1280;
int flockHeight = 720;
int flockDepth = 600;
int initBoidNum = 300; // amount of boids to start the program with
ArrayList<Boid> flock;
boolean avoidWalls = true;
float hue = 255;
boolean triggered;
boolean inThirdPerson;
boolean changedMode;

void setup() {
  size(640, 360, P3D);
  scene = new Scene(this);
  scene.mouseAgent().setPickingMode(MouseAgent.PickingMode.CLICK);
  scene.setAxesVisualHint(false);
  scene.setGridVisualHint(false);
  scene.setBoundingBox(new Vec(0, 0, 0), new Vec(flockWidth, flockHeight, flockDepth));
  scene.showAll();
  // create and fill the list of boids
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(scene, new PVector(flockWidth/2, flockHeight/2, flockDepth/2 )));
  scene.startAnimation();
}

void draw() {
  background(0);
  if (inThirdPerson && scene.avatar()==null) {
    inThirdPerson = false;
    adjustFrameRate();
  } else if (!inThirdPerson && scene.avatar()!=null) {
    inThirdPerson = true;
    adjustFrameRate();
  }
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  noFill();
  stroke(255);

  line(0, 0, 0, 0, flockHeight, 0);
  line(0, 0, flockDepth, 0, flockHeight, flockDepth);
  line(0, 0, 0, flockWidth, 0, 0);
  line(0, 0, flockDepth, flockWidth, 0, flockDepth);

  line(flockWidth, 0, 0, flockWidth, flockHeight, 0);
  line(flockWidth, 0, flockDepth, flockWidth, flockHeight, flockDepth);
  line(0, flockHeight, 0, flockWidth, flockHeight, 0);
  line(0, flockHeight, flockDepth, flockWidth, flockHeight, flockDepth);

  line(0, 0, 0, 0, 0, flockDepth);
  line(0, flockHeight, 0, 0, flockHeight, flockDepth);
  line(flockWidth, 0, 0, flockWidth, 0, flockDepth);
  line(flockWidth, flockHeight, 0, flockWidth, flockHeight, flockDepth);

  triggered = scene.timer().trigggered();
  for (Boid boid : flock) {
    if (triggered)
      boid.run(flock);
    boid.render();
  }
}

void adjustFrameRate() {
  if (scene.avatar() != null)
    frameRate(1000/scene.animationPeriod());
  else
    frameRate(60);
  if (scene.animationStarted())
    scene.restartAnimation();
}