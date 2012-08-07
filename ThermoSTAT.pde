
void loadSettings() {
  sizeSelect = int(settings(read, "sizeSelect", ""));
  weatherService = int(settings(read, "weatherService", ""));
  TempUnits = int(settings(read, "TempUnits", ""));
  SpeedUnits = int(settings(read, "SpeedUnits", ""));
  FreezingTemp = int(settings(read, "FreezingTemp", ""));
  ColdTemp = int(settings(read, "ColdTemp", ""));
  CoolTemp = int(settings(read, "CoolTemp", ""));
  PerfectTemp = int(settings(read, "PerfectTemp", ""));
  WarmTemp = int(settings(read, "WarmTemp", ""));
  HotTemp = int(settings(read, "HotTemp", ""));
  HellTemp = int(settings(read, "HellTemp", ""));
  apiKey = settings(read, "apiKey", "");
  wundergroundWeather.date = int(settings(read, "WG_last_sample_date", ""));
  wundergroundWeather.hitCount = int(settings(read, "hitCount", ""));
  wundergroundWeather.hitCountPerMinute = int(settings(read, "hitCountPerMinute", ""));
}
void storeSettings() {
  settings(write, "apiKey", apiKey);
  settings(write, "FreezingTemp", str(FreezingTemp));
  settings(write, "ColdTemp", str(ColdTemp));
  settings(write, "CoolTemp", str(CoolTemp));
  settings(write, "PerfectTemp", str(PerfectTemp));
  settings(write, "WarmTemp", str(WarmTemp));
  settings(write, "HotTemp", str(HotTemp));
  settings(write, "HellTemp", str(HellTemp));
  settings(write, "TempUnits", str(TempUnits));
  settings(write, "SpeedUnits", str(SpeedUnits));
  settings(write, "weatherService", str(weatherService));
  settings(write, "sizeSelect", str(sizeSelect));
  settings(write, "WG_last_sample_date", str(wundergroundWeather.date));
  settings(write, "hitCount", str(wundergroundWeather.hitCount));
  settings(write, "hitCountPerMinute", str(wundergroundWeather.hitCountPerMinute));
}


void exit() {
  println("EXIT HOOK");
  storeSettings();
  super.exit();
}


public void setup() {
  googleWeather = new GoogleWeather(this, cityName, updateIntervallInSeconds);      
  wundergroundWeather = new Wunderground();
  loadSettings();

  switch (int(settings (read, "sizeSelect", ""))) {
  case 0:
    size(1280, 720);
    break;
  case 1: 
    size(1920, 1080);
    break;
  case 2:
    size(screen.width, screen.height);
    break;
  }
  if (!restartFlag) {
    frameRate(30);
    colorMode(RGB);
    frame.setLocation(1, 1);


    updateWeather(int(settings(read, "weatherService", "")));


    setupFont();
    //setupSerial();
    setupCP5();
  }
}

public void draw() {
  noStroke();
  if (!SettingsFlag) {
    drawBackground();
    drawTopInformation();
    drawWeatherNow();
    drawWeatherForecastToday();
    drawHouseInformation();
    updateInterval = millis();
  } 

  if (updateFlag && !initalSerial) {
    updateWeather(weatherService);
    myPort.write(5);
    println("Updating");
    updateFlag = !updateFlag;
  }

  if (SettingsFlag)
  {
    drawSettingsWindow(false);
  }
  if (updateInterval > updateIntervalold + 30000 && !initalSerial) {
    updateIntervalold = updateInterval;
    myPort.write(5);
    println("Updating");
  }
}



void drawBackground() {
  background(15);
  fill(30);
  //if you're using an older version of processing remove the last two parameters of the rect(...) functions
  rect(padding, padding, width-padding*2, .142875*height, 20, 20, 20, 20); //topinfo
  rect(padding, .142875*height+2*padding, .4*width-padding, .537125*height-padding, 20, 20, 20, 20); //current info
  rect(padding, .68*height+2*padding, .4*width-padding, (1-.142875-.537125)*height-3*padding, 20, 20, 20, 20); // forecast today
  rect(.4*width+padding, .142875*height+2*padding, .6*width-padding*2, height-.142875*height-3*padding, 20, 20, 20, 20); //house info
}

void drawSettingsWindow(boolean refresh) {
  float firstPosX = width/2 - 320 + padding + thickpad + 160;
  float firstPosY =  1.25*(height/2 - 180 + 3*padding + thickpad) + 2*padding+5 ;
  pushStyle();  //transparent overlay background
  if (refresh) {
    fill(225, 128);
    rect(0, 0, width, height );
  }
  //settings window
  fill(15);
  rectMode(CENTER);
  rect(width/2, height/2, 640, 360, 20, 20, 20, 20 );
  fill(30);
  rectMode(CENTER);
  rect(width/2, height/2 -150 + padding, 620, 60, 20, 20, 20, 20 );
  popStyle();

  pushStyle(); //Window Text
  textSize(30);
  fill(225);
  text("Settings", width/2 - 320 + padding + thickpad, height/2 - 172 + 4*padding ); //print heading for settings window
  textSize(20);
  text("Comm Port", width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad));
  text("Resolution", width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad)+ 2*thickpad);
  text("Service", width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad)+ 4*thickpad);
  text("Temp Ranges", width/2 - 160 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad));
  text("Temp Scale", width/2  + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad));
  text("Speed Scale", width/2  + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad) + 100);
  textSize(15);
  text("Freezing", firstPosX +55, firstPosY );
  text("Cold", firstPosX +55, firstPosY + 1*thickpad);
  text("Cool", firstPosX +55, firstPosY + 2*thickpad);
  text("Perfect", firstPosX +55, firstPosY + 3*thickpad);
  text("Warm", firstPosX +55, firstPosY + 4*thickpad);
  text("Hot", firstPosX +55, firstPosY + 5*thickpad);
  text("Hell", firstPosX +55, firstPosY + 6*thickpad);
  text("°C", firstPosX +215, firstPosY );
  text("°F", firstPosX +215, firstPosY + 1*thickpad);
  text("K", firstPosX +215, firstPosY + 2*thickpad);
  text("km/h", firstPosX +215, firstPosY + 4*thickpad);
  text("MPH", firstPosX +215, firstPosY + 5*thickpad);
  text("Knots", firstPosX +215, firstPosY + 6*thickpad);

  popStyle();
}

