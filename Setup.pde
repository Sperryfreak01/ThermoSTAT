/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */



/* Below are all of the Setup routines need to initialise the program
 the serial setup is no called at runtime unless autoconnect is 
 enabled in the settings menu.  By default auto connect is set to 
 off to prevent out of bounds error.
 */
public void init() {
  // to make a frame not displayable, you can
  // use frame.removeNotify()

  frame.removeNotify();
  frame.setUndecorated(true);

  // addNotify, here i am not sure if you have 
  // to add notify again.  
  frame.addNotify();
  super.init();
}

void setupFont() {
  font = createFont("HelveticaNeueLT Std", 80, true);
  textFont(font, 12);
  smooth();

  format = new SimpleDateFormat("MM/dd/yyyy");
  topInfo = new SimpleDateFormat("E, MM/dd/yyyy KK:mm a");
}

void setupSerial(int PortNumber) {

  if (!initalSerial) {
    myPort.stop();
  }
  // List all the available serial ports
  //println(Serial.list());
  //Select Serial port

  myPort = new Serial(this, Serial.list()[PortNumber], 9600);
  initalSerial = false;
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');
  myPort.write(5);
}


void setupCP5() {

  cp5 = new ControlP5(this);
  float firstPosX = width/2 - 320 + padding + thickpad + 160;
  float firstPosY =  1.25*(height/2 - 180 + 3*padding + thickpad) + padding ;
PImage[] imgs = {
  loadImage(dataPath("")+"settings.png"), loadImage(dataPath("")+"settings.png"), loadImage(dataPath("")+"settings_pushed.png")
  };
PImage[] radarImgs= {
  loadImage(dataPath("")+"radar.png"), loadImage(dataPath("")+"radar.png"), loadImage(dataPath("")+"radar_pushed.png")
  };
PImage[] houseImgs= {
  loadImage(dataPath("")+"home.png"), loadImage(dataPath("")+"home.png"), loadImage(dataPath("")+"home_pushed.png")
  };

  cp5.addButton("Settings")
    .setPosition(width*.9, thickpad)
      .setImages(imgs)
        .updateSize()
          ;
  radarButton = cp5.addButton("Radar")
    .setPosition(width*.8, thickpad)
      .setImages(radarImgs)
        .updateSize()
          ;
   houseButton = cp5.addButton("House")
    .setPosition(width*.8, thickpad)
      .setImages(houseImgs)
        .updateSize()
        .setVisible(false)
          ;

  FreezingBox =  cp5.addTextfield("FreezingBox")
    .setPosition(firstPosX, firstPosY)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(FreezingTemp))
                    //.setInputFilter(ControlP5.INTEGER); 
                    ;

  ColdBox =  cp5.addTextfield("ColdBox")
    .setPosition(firstPosX, firstPosY + thickpad)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(ColdTemp))
                    //.setInputFilter(ControlP5.INTEGER);
                    ;
  CoolBox = cp5.addTextfield("CoolBox")
    .setPosition(firstPosX, firstPosY + 2*thickpad)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(CoolTemp))
                    //.setInputFilter(ControlP5.INTEGER);
                    ;

  PerfectBox = cp5.addTextfield("PerfectBox")
    .setPosition(firstPosX, firstPosY + 3*thickpad)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(PerfectTemp))
                    //.setInputFilter(ControlP5.INTEGER);
                    ;

  WarmBox = cp5.addTextfield("WarmBox")
    .setPosition(firstPosX, firstPosY + 4*thickpad)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(WarmTemp))
                    //.setInputFilter(ControlP5.INTEGER);
                    ;

  HotBox = cp5.addTextfield("HotBox")
    .setPosition(firstPosX, firstPosY + 5*thickpad)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(HotTemp))
                    //.setInputFilter(ControlP5.INTEGER);
                    ;

  HellBox = cp5.addTextfield("HellBox")
    .setPosition(firstPosX, firstPosY + 6*thickpad)
      .setSize(40, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(str(HellTemp))
                    //.setInputFilter(ControlP5.INTEGER);
                    ;
  apiBox = cp5.addTextfield("apiBox")
    .setPosition(width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad)+padding*1.6 + 5*thickpad)
      .setSize(100, 20)
        .setFont(font)
          .setColor(255)
            .setVisible(false)
              .setAutoClear(false)
                .setLabel("")
                  .setText(apiKey);
  ;

  TempScale = cp5.addRadioButton("Temp Scale")
    .setPosition(firstPosX +160, firstPosY)
      .setSize(40, 20)
        .setColorForeground(color(120))
          .setColorActive(color(255))
            .setColorLabel(color(255))
              .setSpacingRow(5)
                .setVisible(false)
                  .hideLabels()
                    .addItem("C", 0)
                      .addItem("F", 1)
                        .addItem("K", 2)
                          .activate(TempUnits)

                            ;
  SpeedScale = cp5.addRadioButton("Speed Scale")
    .setPosition(firstPosX +160, firstPosY+100)
      .setSize(40, 20)
        .setColorForeground(color(120))
          .setColorActive(color(255))
            .setColorLabel(color(255))
              .setSpacingRow(5)
                .setVisible(false)
                  .hideLabels()
                    .addItem("KPH", 0)
                      .addItem("MPH", 1)
                        .addItem("Knots", 2)
                          .activate(SpeedUnits)
                            ;
  // create a DropdownList
  service = cp5.addDropdownList("Service")
    .setPosition(width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad)+padding*.6 + 5*thickpad)
      .setVisible(false);
  ;
  resolution = cp5.addDropdownList("resolution")
    .setPosition(width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad)+padding*.6 + 3*thickpad)
      .setVisible(false);
  ;
  d1 = cp5.addDropdownList("comPort")
    .setPosition(width/2 - 320 + padding + thickpad, 1.25*(height/2 - 180 + 3*padding + thickpad)+padding*.6 + thickpad)
      .setVisible(false);
  ;

  customize(d1); // customize the first list
  customize(resolution); // customize the first list
  customize(service); // customize the first list
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(20);
  ddl.captionLabel().set("Select");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  if (ddl.getName() == "comPort") {
    for (int i=0;i<Serial.list().length;i++) {
      ddl.addItem(Serial.list()[i], i);
    }
  }
  if (ddl.getName().equals("resolution")) {
    ddl.addItem("720p", 0);
    ddl.addItem("1080p", 1);
    ddl.addItem("Fullscreen", 2);
    ddl.setIndex(sizeSelect);
  } 
  if (ddl.getName().equals("Service")) {
    ddl.addItem("Google", 0);
    ddl.addItem("Wunderground", 1);
    ddl.setIndex(weatherService);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
  ddl.setScrollbarVisible(true);
}

