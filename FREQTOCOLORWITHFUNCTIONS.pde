static private double Gamma = 0.80;
static private double IntensityMax = 255;

// change soundfreq to the frequency you wish to convert to a color
float soundfreq = 440;

float visiblelight = 400000000000000L;
float speedoflight = 299792458L;
float wavelength;
float wavecolor;
int[] rgb = new int[3];

void setup () 
{
  size(400, 400);
  frameRate(30);
}



void draw()
{

  multiplylight(soundfreq);


  background(rgb[0], rgb[1], rgb[2]);
}


void multiplylight (float freq)
{

  float lightoctave;
  lightoctave = freq;
  while (lightoctave < visiblelight)
  {
    lightoctave = lightoctave*2;
  }
  if (lightoctave >= visiblelight)
  {

    wavelength = (speedoflight/lightoctave);
    println(wavelength);
    wavecolor = wavelength * 1000000000;
    waveLengthToRGB(wavecolor);
  }
}


public  int[] waveLengthToRGB(float lol) {
  float factor;
  float Red, Green, Blue;



  if ((lol >= 380) && (lol<440)) {
    Red = -(lol - 440) / (440 - 380); 
    Green = 0.0;
    Blue = 1.0;
  }
  else if ((lol >= 440) && (lol<490)) {
    Red = 0.0;
    Green = (lol - 440) / (490 - 440);
    Blue = 1.0;
  }
  else if ((lol >= 490) && (lol<510)) {
    Red = 0.0;
    Green = 1.0;
    Blue = -(lol - 510) / (510 - 490);
  }
  else if ((lol >= 510) && (lol<580)) {
    Red = (lol - 510) / (580 - 510);
    Green = 1.0;
    Blue = 0.0;
  }
  else if ((lol >= 580) && (lol<645)) {
    Red = 1.0;
    Green = -(lol - 645) / (645 - 580);
    Blue = 0.0;
  }
  else if ((lol >= 645) && (lol<781)) {
    Red = 1.0;  
    Green = 0.0;
    Blue = 0.0;
  }
  else {
    Red = 0.0;
    Green = 0.0;
    Blue = 0.0;
  };

  // Let the intensity fall off near the vision limits

  if ((lol >= 380) && (lol<420)) {
    factor = 0.3 + 0.7*(lol - 380) / (420 - 380);
  }
  else if ((lol >= 420) && (lol<701)) {
    factor = 1.0;
  }
  else if ((lol >= 701) && (lol<781)) {
    factor = 0.3 + 0.7*(780 - lol) / (780 - 700);
  }
  else {
    factor = 0.0;
  };


  rgb[0] = Red==0.0 ? 0 : (int) Math.round(IntensityMax * Math.pow(Red * factor, Gamma));
  rgb[1] = Green==0.0 ? 0 : (int) Math.round(IntensityMax * Math.pow(Green * factor, Gamma));
  rgb[2] = Blue==0.0 ? 0 : (int) Math.round(IntensityMax * Math.pow(Blue * factor, Gamma));


  return rgb;
}
