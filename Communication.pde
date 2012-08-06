void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);

  // split the string at the commas
  // and convert the sections into integers:
  int packets[] = int(split(myString, ','));

  // print out the values you got:
  for (int packetNum = 0; packetNum < packets.length; packetNum++) {
    print("Packet " + packetNum + ": " + packets[packetNum] + "\t");
  }
  // add a linefeed after all the sensor values are printed:
  println();
  if (packets.length > 1) {
    TempReading(1, packets[1], false, false);
    TempReading(2, packets[0], false, false);
    //  TempReading(3,packets[2],false,false);
    //  TempReading(3,packets[3],false,false);
  }
  // send a byte to ask for more data:
  // myPort.write(5);
}


String settings(boolean RW, String label, String attr) {
  //try and open the properties folder
  try {
    props.load(createInput("settings"));
    println("settings XML opened   ");
  }
  catch (IOException e) {
    println("Could not open   " + e);
  }

  if (RW) {
    props.setProperty(label, attr);
    //try and save the settings file
    try {
      props.store(createOutput("settings"), "ThermoSTAT program settings");
      attr = "write OK";
    }
    catch (IOException e) {
      println("Could not save   " + e);
    }
  }
  if (!RW) {
    attr = props.getProperty(label);
  }
  println(label + " : " + attr);
  return attr;
}

