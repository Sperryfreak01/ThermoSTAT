/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */



void  keyPressed() {
  updateFlag = true;
}

void mousePressed() {
  mX = mouseX;
  mY = mouseY;
  if (SettingsFlag) {
    if (resolution.isOpen()) {
      service.hide();
      d1.hide();
    }
    if (resolution.isOpen()) {
      service.hide();
      d1.hide();
    }
    if (d1.isOpen()) {
      service.hide();
      resolution.hide();
    }

    FreezingBox.submit();
    ColdBox.submit();
    CoolBox.submit();
    PerfectBox.submit();
    WarmBox.submit();
    HotBox.submit();
    HellBox.submit();    
    apiBox.submit();    

    if (  apiBox.isActive() && ! activeTextField.equals("apiBox")) {
      apiBoxOld = apiBox.getText(); //saves teh previous value to reuse if nothing entered
      apiBox.setText("");  //Clear the text 
      activeTextField = "apiBox"; //set the flag so this cant be reentered without going to another box
    }
    if (  FreezingBox.isActive() && ! activeTextField.equals("FreezingBox")) {
      FreezingBoxOld = float(FreezingBox.getText()); //saves teh previous value to reuse if nothing entered
      FreezingBox.setText("");  //Clear the text 
      activeTextField = "FreezingBox"; //set the flag so this cant be reentered without going to another box
    }
    if (  ColdBox.isActive() && ! activeTextField.equals("ColdBox")) {
      ColdBoxOld = float(ColdBox.getText());
      ColdBox.setText("");
      activeTextField = "ColdBox";
    }
    if (  CoolBox.isActive()&& ! activeTextField.equals("CoolBox" )) {
      CoolBoxOld = float(CoolBox.getText());
      CoolBox.setText("");
      activeTextField = "CoolBox";
    }
    if (  PerfectBox.isActive()&& ! activeTextField.equals("PerfectBox" )) {
      PerfectBoxOld = float(PerfectBox.getText());
      PerfectBox.setText("");
      activeTextField = "PerfectBox";
    }
    if (  WarmBox.isActive() && ! activeTextField.equals("WarmBox")) {
      WarmBoxOld = float(WarmBox.getText());
      WarmBox.setText("");
      activeTextField = "WarmBox";
    }
    if (  HotBox.isActive() && ! activeTextField.equals("HotBox")) {
      HotBoxOld = float(HotBox.getText());
      HotBox.setText("");
      activeTextField = "HotBox";
    }
    if (  HellBox.isActive() && ! activeTextField.equals("HellBox")) {
      HellBoxOld = float(HellBox.getText());
      HellBox.setText("");
      activeTextField = "HellBox";
    }
  }
}

void mouseReleased() {
}

void mouseDragged() {
  frame.setLocation(
  MouseInfo.getPointerInfo().getLocation().x-mX, 
  MouseInfo.getPointerInfo().getLocation().y-mY);
 }


void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());

    if (theEvent.getName().equals("comPort")) {
      //drawSettingsWindow(false);
      setupSerial(int(theEvent.getGroup().getValue()));
    }
    if (theEvent.getName().equals("resolution")) {
      //drawSettingsWindow(false);
      int sizeOld = sizeSelect;
      sizeSelect = int(theEvent.getGroup().getValue());
    }
    if (theEvent.getName().equals("Service")) {
      //drawSettingsWindow(false);
      weatherService = int(theEvent.getGroup().getValue());
      if (weatherService == 1) {
        apiBox.setVisible(SettingsFlag);
      }
      updateWeather(weatherService);
    }

    if (theEvent.isFrom("Temp Scale")) {
      //  print("got an event from "+theEvent.getName()+"\t");
      for (int i=0;i<theEvent.getGroup().getArrayValue().length;i++) {
        if (int(theEvent.getGroup().getArrayValue()[i]) == 1) {    
          TempUnits = i;
        }
      }
    }
    if (theEvent.isFrom("Speed Scale")) {
      //  print("got an event from "+theEvent.getName()+"\t");
      for (int i=0;i<theEvent.getGroup().getArrayValue().length;i++) {
        if (int(theEvent.getGroup().getArrayValue()[i]) == 1) {    
          SpeedUnits = i;
        }
      }
    }
  }
  else if (theEvent.isController()) {
    //  println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());

    if (theEvent.isFrom("Settings")) {
      SettingsFlag = ! SettingsFlag;
      if (SettingsFlag) {
        drawSettingsWindow(true);
      }
      if (!SettingsFlag) {
        activeTextField = "";
        FreezingBox.submit();
        ColdBox.submit();
        CoolBox.submit();
        PerfectBox.submit();
        WarmBox.submit();
        HotBox.submit();
        HellBox.submit();
      }
      d1.setVisible(SettingsFlag);
      resolution.setVisible(SettingsFlag);
      service.setVisible(SettingsFlag);
      apiBox.setVisible(false);
      if (weatherService == 1) {
        apiBox.setVisible(SettingsFlag);
      }
      TempScale.setVisible(SettingsFlag);
      TempScale.hideLabels();
      SpeedScale.setVisible(SettingsFlag);
      SpeedScale.hideLabels();
      FreezingBox.setVisible(SettingsFlag);
      ColdBox.setVisible(SettingsFlag);
      CoolBox.setVisible(SettingsFlag);
      PerfectBox.setVisible(SettingsFlag);
      WarmBox.setVisible(SettingsFlag);
      HotBox.setVisible(SettingsFlag);
      HellBox.setVisible(SettingsFlag);
    }
    if (theEvent.isFrom("apiBox")) {
       apiKey = (apiBox.getText());
      if ((apiBox.getText()).equals("")) { //check if user didnt enter anything
        println("got apiBox null");     
        apiKey = apiBoxOld;        //roll setpoint back
        println(apiKey);
      }
    }
    if (theEvent.isFrom("FreezingBox")) {
            FreezingTemp = float(FreezingBox.getText());
      if ((FreezingBox.getText()).equals("")) { //check if user didnt enter anything
        println("got freezingbox null");     
        FreezingTemp = FreezingBoxOld;        //roll setpoint back
        FreezingBox.setText(nfc(FreezingTemp, 1));
        println(nf(FreezingTemp, 2, 1));
      }
    }

    if (theEvent.isFrom("ColdBox")) {
      ColdTemp = float(ColdBox.getText());
      if ((ColdBox.getText()).equals("")) { //check if user didnt enter anything
        println("got ColdBox null");     
        ColdTemp = ColdBoxOld;        //roll setpoint back
        ColdBox.setText(nf(ColdTemp, 2, 1));
        println(nf(ColdTemp, 2, 1));
      }
    }
    if (theEvent.isFrom("CoolBox")) {
                              CoolTemp = float(CoolBox.getText());
      if ((CoolBox.getText()).equals("")) { //check if user didnt enter anything
        println("got CoolBox null");     
        CoolTemp = CoolBoxOld;        //roll setpoint back
        CoolBox.setText(nf(CoolTemp, 2, 1));
        println(nf(CoolTemp, 2, 1));
      }
    }
    if (theEvent.isFrom("PerfectBox")) {
                        PerfectTemp = float(PerfectBox.getText());
      if ((PerfectBox.getText()).equals("")) { //check if user didnt enter anything
        println("got PerfectBox null");     
        PerfectTemp = PerfectBoxOld;        //roll setpoint back
        PerfectBox.setText(nf(PerfectTemp, 2, 1));
        println(nf(PerfectTemp, 2, 1));
      }
    }
    if (theEvent.isFrom("WarmBox")) {
                  WarmTemp = float(WarmBox.getText());
      if ((WarmBox.getText()).equals("")) { //check if user didnt enter anything
        println("got WarmBox null");     
        WarmTemp = WarmBoxOld;        //roll setpoint back
        WarmBox.setText(nf( WarmTemp, 2, 1));
        println(nf( WarmTemp, 2, 1));
      }
    }
    if (theEvent.isFrom("HotBox")) {
            HotTemp = float(HotBox.getText());
      if ((HotBox.getText()).equals("")) { //check if user didnt enter anything
        println("got HotBox null");     
        HotTemp = HotBoxOld;        //roll setpoint back
        HotBox.setText(nf( HotTemp, 2, 1));
        println(nf( HotTemp, 2, 1));
      }
    }
    if (theEvent.isFrom("HellBox")) {
      HellTemp = float(HellBox.getText());
      if ((HellBox.getText()).equals("")) { //check if user didnt enter anything
        println("got HellBox null");     
        HellTemp = HellBoxOld;        //roll setpoint back
        HellBox.setText(nf( HellTemp, 2, 1));
        println(nf( HellTemp, 2, 1));
      }
    }
  }
}

