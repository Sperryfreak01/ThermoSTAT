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
void openXMLfile(String filename) {
  println(filename);
  try {
  } 
  catch (Exception e) {
    println(e);
  }
}


/* called automatically whenever an XML file is loaded */
String settings(boolean RW, String label, String attr) {
  //XMLTag xml =XMLDoc.from(new File(dataPath("") +"settings.xml"), true);

  if (!RW ) {

    try {
      XMLTag xml =XMLDoc.from(new File(dataPath("") +"settings.xml"), true);

      xml.gotoRoot();
      xml.gotoChild(label);
      attr = xml.getText().toString();
      println(label + " : " + attr);
    } 
    catch (Exception e) {
      println("Threw exception" + e);
      // println("No settings object with the name:  " +label);
    }
  }
  if (RW ) {
    XMLTag xml =XMLDoc.newDocument(true).addRoot("settings");
    xml.gotoRoot();
    xml.deleteChilds();
    xml.addTag("FreezingTemp").addText(str(FreezingTemp));
    xml.addTag("ColdTemp").addText(str(ColdTemp));
    xml.addTag("CoolTemp").addText(str(CoolTemp));
    xml.addTag("PerfectTemp").addText(str(PerfectTemp));
    xml.addTag("WarmTemp").addText(str(WarmTemp));
    xml.addTag("HotTemp").addText(str(HotTemp));
    xml.addTag("HellTemp").addText(str(HellTemp));
    xml.addTag("TempUnits").addText(str(TempUnits));
    xml.addTag("SpeedUnits").addText(str(SpeedUnits));
    xml.addTag("weatherService").addText(str(weatherService));
    xml.addTag("sizeSelect").addText(str(sizeSelect));
    xml.addTag("WG_last_sample_date").addText(str(wundergroundWeather.date));
    xml.addTag("hitCount").addText(str(wundergroundWeather.hitCount));
    xml.addTag("hitCountPerMinute").addText(str(wundergroundWeather.hitCountPerMinute));
    xml.addTag("apiKey").addText(apiKey);
    output = createWriter(dataPath("") + "settings.xml"); 
    output.println(xml); // Write the doc to the file
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
  }
  return attr;
}

void writeToFile(String filename) {
  output = createWriter(filename); 
  output.println(xml); // Write the doc to the file
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file}
}
