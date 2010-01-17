import org.gwoptics.graphics.*;
import org.gwoptics.graphics.camera.*;
import org.gwoptics.gaussbeams.*;
import org.gwoptics.graphics.graph3D.*;
import org.gwoptics.graphics.colourmap.presets.*;
import processing.core.PApplet;
import processing.core.PConstants;

Camera3D cam;
SurfaceGraph3D g3d;

class standingWave implements IGraph3DCallback{
	float t;
	float k;
	float w;
	public float computePoint(float X, float Z) {
		return (float) (Math.cos(w*t) * Math.sin(k*X) * Math.sin(k*Z));
	}
}

standingWave gcb = new standingWave();

void setup() {
  size(800, 800, P3D); //Use P3D for now, openGl seems to have some issues
  
  cam = new Camera3D(this);
  
  //constructor arguments are:
  //(PApplet parent, float xLength, float yLength, float zLength)
  g3d = new SurfaceGraph3D(this, 500, 500,100);		
  g3d.setXAxisMin(-2);		
  g3d.setXAxisMax(2);
  g3d.setZAxisMin(-1);
  g3d.setZAxisMax(1);		
  g3d.setYAxisMin(-2);		
  g3d.setYAxisMax(2);		
  gcb.k = 6; //wave number
  gcb.w = 10; //frequency
  //There are several colourmap presets to try:
  //HotColourmap
  //WarmColourmap
  //GrayScaleColourmap
  g3d.addSurfaceTrace(gcb, 100, 100, new CoolColourmap(true));
}

void draw() {
  gcb.t += 1e-2; //increment time for wave
  g3d.plotSurfaceTrace(0);
  background(204);
  pushMatrix();
  //centre the graph for rotating
  translate(-250,0,-250);
  g3d.draw();
  popMatrix();
}
