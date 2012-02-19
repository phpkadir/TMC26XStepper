Slider constantOffSlider;
Slider blankTimeSlider;
Toggle randomOffTimeToggle;
RadioButton ChopperModeButtons;
//for constant off time chopeer
Slider fastDecaySlider;
Slider sineWaveOffsetSlider;
Toggle currentComparatorToggle;
//for spread chopper
Slider hysteresisStartSlider;
Slider hysteresisEndSlider;
Numberbox motorVoltageBox;
Numberbox motorCurrentBox;
Numberbox motorResistanceBox;
Numberbox motorInductanceBox;

RadioButton hysteresisDecrementButtons;

PImage spreadChopperImage;

void setupChooperConfig() {
  //add input fields for the various motor parameters
  motorVoltageBox = controlP5.addNumberbox("motorvoltage",12.0,20,40,100,20);
  motorVoltageBox.setCaptionLabel("Motor Voltage (V)");
  motorVoltageBox.setMultiplier(0.025);
  motorVoltageBox.setMin(0);
  motorVoltageBox.setMax(40.0);
  motorVoltageBox.moveTo(configureTab);
  
  motorCurrentBox = controlP5.addNumberbox("motorcurrent",0.5,140,40,100,20);
  motorCurrentBox.setCaptionLabel("Motor Current (A)");
  motorCurrentBox.setMultiplier(0.025);
  motorCurrentBox.setMin(0.46);
  motorCurrentBox.setMax(1.7);
  motorCurrentBox.moveTo(configureTab);
  
  motorResistanceBox = controlP5.addNumberbox("motorresistance",2,260,40,100,20);
  motorResistanceBox.setCaptionLabel("Motor Resistance (Ohm)");
  motorResistanceBox.setMultiplier(0.1);
  motorResistanceBox.setMin(0);
  motorResistanceBox.setMax(250);
  motorResistanceBox.moveTo(configureTab);
  
  motorInductanceBox = controlP5.addNumberbox("motorinductance",2,380,40,100,20);
  motorInductanceBox.setMultiplier(0.1);
  motorInductanceBox.setMin(0);
  motorInductanceBox.setMax(250);
  motorInductanceBox.setCaptionLabel("Motor Inductance (mH)");
  motorInductanceBox.moveTo(configureTab);
  // add a vertical slider for speed  
  constantOffSlider = controlP5.addSlider("constantoff", 1, 15, 1, 20, 80, 400, 20);
  constantOffSlider.setCaptionLabel("Constant Off Time");
  constantOffSlider.setSliderMode(Slider.FIX);
  constantOffSlider.moveTo(configureTab);

  blankTimeSlider =  controlP5.addSlider("blanktime", 0, 3, 2, 20, 120, 400, 20);
  blankTimeSlider.setCaptionLabel("Blank Time");
  blankTimeSlider.moveTo(configureTab);

  hysteresisStartSlider =  controlP5.addSlider("hysteresisstart", 0, 8, 2, 20, 160, 400, 20);
  hysteresisStartSlider.setCaptionLabel("Hysteresis Start");
  hysteresisStartSlider.moveTo(configureTab);

  hysteresisEndSlider =  controlP5.addSlider("hysteresisend", -3, 12, 2, 20, 200, 400, 20);
  hysteresisEndSlider.setCaptionLabel("Hysteresis End");
  hysteresisEndSlider.moveTo(configureTab);

  hysteresisDecrementButtons =controlP5.addRadioButton("decrement", 20, 240);
  hysteresisDecrementButtons.addItem("fastest", 0);
  hysteresisDecrementButtons.addItem("fast", 1);
  hysteresisDecrementButtons.addItem("medium", 2);
  hysteresisDecrementButtons.addItem("slow", 3);
  hysteresisDecrementButtons.showBar();
  hysteresisDecrementButtons.moveTo(configureTab);

  spreadChopperImage = loadImage("hysteresis.png");
}

void drawChopper() {
  if (activeTab!=null && "default".equals(activeTab.name())) {
    image(spreadChopperImage, 200, 400);
  }
}

void constantoff(int theValue) {
  if (!settingStatus) {
    if (theValue>0 && theValue<16) {
      println("Constant off "+theValue);
      arduinoPort.write("cO"+theValue+"\n");
    } 
    else {
      println("invalid blank time of "+theValue);
    }
  }
}

void blanktime(int theValue) {
  if (!settingStatus) {
    if (theValue>=0 && theValue<=3) {
      println("blank time "+theValue);
      arduinoPort.write("Cb"+theValue+"\n");
    }
  }
}

void hysteresisstart(int start) {
  if (!settingStatus) {
    if (start>=1 && start<=8) {
      println("hystereis start "+start);
      arduinoPort.write("Cs"+start+"\n");
    }
  }
}

void hysteresisend(int end) {
  if (!settingStatus) {
    if (end>=-3 && end<=12) {
      println("hystereis end "+end);
      arduinoPort.write("Ce"+end+"\n");
    }
  }
}

void setHysteresisDecrement(int theValue) {
  if (!settingStatus) {
    if (theValue>=0 && theValue<=3) {
      println("Hysteresis decrement "+theValue);
      arduinoPort.write("Cd"+theValue+"\n");
    } 
    else {
      println("cannot set decrement to "+theValue);
    }
  }
}

void setHystDecrement(int value) {
  if (value>=0 && value<=3) {
    hysteresisDecrementButtons.activate(value);
  } 
  else {
    println("this is no proper hysteresis decerement value: "+value);
  }
}

void motorcurrent(float value) {
  if (activeTab!=null && "default".equals(activeTab.name())) {
    currentSlider.setValue(value);
  }
}

