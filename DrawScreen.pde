void drawTopInformation() {
  textAlign(LEFT);
  textSize(60);
  fill(fontColor);
  //  text(cityName+" ", 39, 90);
  textSize(20);
  // text("Lon: "+nf(googleWeather.getLongitude(), 2, 2)+" Lat: "+nf(googleWeather.getLatitude(), 2, 2));
  textSize(20);
  textAlign(RIGHT);
  // text(topInfo.format(googleWeather.getLastUpdated()), 1070, 90);
}
void drawWeatherNow() { 
  int paddingTop = 203;
  int paddingLeft = 25;
  textAlign(LEFT);
  fill(fontColor);
  textSize(20);
  text("Updated: "+measureTime(weatherService, SpeedUnits), 46, 155);
  textSize(80);
  text(currentTemp(weatherService, TempUnits), paddingLeft+15, paddingTop+80);
  textSize(20);
  // text("Min:" + int(googleWeather.getMinTemperatureInFahrenheitInXDays(0))+"    Max:"+int(googleWeather.getMaxTemperatureInFahrenheitInXDays(0))+"F°",  paddingLeft+15, paddingTop+85+thickpad);
  textSize(50);
  text(currentCondition(weatherService, TempUnits), paddingLeft+17, paddingTop+180);
  textSize(30);
  text("Wind: "+currentWindDirection(weatherService, SpeedUnits)+" at "+ currentWindSpeed(weatherService, SpeedUnits), paddingLeft+20, paddingTop+235 );
  text("Humidity: "+currentHumidity(weatherService, SpeedUnits) +"%", paddingLeft+20, paddingTop+275);
  drawIcon(280, 125, 240, 240, currentCondition(weatherService, TempUnits));
}

void setupHistoryGraph() {
  pushStyle();
  textSize(10);
  if (!initalSerial) {
    minRange = min(min(outsideTempHistoryInt), min(insideTempHistoryInt))-5;
    maxRange = max(max(outsideTempHistoryInt), max(insideTempHistoryInt));
  }
  else {
    minRange = min(outsideTempHistoryInt)-5;
    maxRange = max(outsideTempHistoryInt);
  }
  quarterRange = lerp(minRange, maxRange, .25);
  halfRange = lerp(minRange, maxRange, .5);
  threeQuarterRange = lerp(minRange, maxRange, .75);
  text( maxRange, 3*padding, .68*height+4*padding); //prints the max measured value
  text(int(quarterRange), 3*padding, lerp(.68*height+ (1-.142875-.537125)*height-2*padding, .68*height+4*padding, .25));
  text(int(halfRange), 3*padding, lerp(.68*height+ (1-.142875-.537125)*height-2*padding, .68*height+4*padding, .5));
  text(int(threeQuarterRange), 3*padding, lerp(.68*height+ (1-.142875-.537125)*height-2*padding, .68*height+4*padding, .75));
  //text( max(max(outsideTempHistoryInt), max(insideTempHistoryInt)), 2*padding, .68*height+3*padding);
  text( minRange, 3*padding, .68*height+ (1-.142875-.537125)*height-2*padding); //min recored value
  stroke(255);
  line(3*padding + textWidth("1111"), .68*height+4*padding, 3*padding + textWidth("1111"), .68*height+ (1-.142875-.537125)*height-2*padding); //y axis line
  line(3*padding + textWidth("1111"), .68*height+ (1-.142875-.537125)*height-2*padding, .4*width-3*padding+6, .68*height+ (1-.142875-.537125)*height-2*padding); //x axis line
  popStyle();
}

void drawHistoryLine() {
  setupHistoryGraph();

  pushStyle();
  stroke(color(0, 0, 255));
  fill(color(0, 0, 255, 200));
  textSize(10);
  for (int i=0; i <outsideTempHistoryInt.length; i++) {
    int yPos = int(map(outsideTempHistoryInt[i], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
    int xPos = int( (.4*width-3*padding - 3*padding + textWidth("1111") )/ outsideTempHistoryInt.length);
    int yPos2 = 0;

    //  rectMode(CORNERS);
    if (i == outsideTempHistoryInt.length) { 
      yPos2 = int(map(outsideTempHistoryInt[outsideTempHistoryInt.length], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
      line(3*padding + 1+ textWidth("1111")+ i*9, yPos, (3*padding + 1+ textWidth("1111")+ i*9)+18, yPos2) ;
    }
    else if (i <  outsideTempHistoryInt.length - 1) {
      yPos2 = int(map(outsideTempHistoryInt[i+1], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
      line(3*padding + 1+ textWidth("1111")+ i*9, yPos, (3*padding + 1+ textWidth("1111")+ i*9)+9, yPos2) ;
    }
  }
  popStyle();

  if (!initalSerial) {
    pushStyle();
    stroke(color(255, 128, 0));
    fill(color(255, 128, 0, 200));
    textSize(10);
    for (int i=0; i <insideTempHistoryInt.length; i++) {
      int yPos = int(map(insideTempHistoryInt[i], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
      int xPos = int( (.4*width-3*padding - 3*padding + textWidth("1111") )/ insideTempHistoryInt.length);
      int yPos2 = 0;

      //  rectMode(CORNERS);
      if (i == insideTempHistoryInt.length) { 
        yPos2 = int(map(insideTempHistoryInt[insideTempHistoryInt.length], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
        line(3*padding + 1+ textWidth("1111")+ i*9, yPos, (3*padding + 1+ textWidth("1111")+ i*9)+18, yPos2) ;
      }
      else if (i <  insideTempHistoryInt.length - 1) {
        yPos2 = int(map(insideTempHistoryInt[i+1], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
        line(3*padding + 1+ textWidth("1111")+ i*9, yPos, (3*padding + 1+ textWidth("1111")+ i*9)+9, yPos2) ;
      }
    }
    popStyle();
  }
}

void drawHistoryBar() {
  setupHistoryGraph();
  pushStyle();
  stroke(color(0, 0, 255));
  fill(color(0, 0, 255, 200));
  textSize(10);
  for (int i=0; i <outsideTempHistoryInt.length; i++) {
    int yPos = int(map(outsideTempHistoryInt[i], minRange, maxRange, .68*height+ (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
    int xPos = int( (.4*width-3*padding - 3*padding + textWidth("1111") )/ outsideTempHistoryInt.length);
    rectMode(CORNERS);
    rect(3*padding + 1+ textWidth("1111")+ i*9, yPos, (3*padding + 1+ textWidth("1111")+ i*9)+9, .68*height + (1-.142875-.537125)*height-2*padding -1);
  }
  popStyle();
  if (!initalSerial) {
    pushStyle();
    // stroke(color(255, 128, 0));
    // fill(color(255, 128, 0, 100));
    textSize(10);

    for (int i=0; i <insideTempHistoryInt.length; i++) {
      if (insideTempHistoryInt[i] > outsideTempHistoryInt[i] ) {
        stroke(color(255, 128, 0)); //orange
        fill(color(255, 128, 0, 1)); //orange with partial transparent
      }
      else {
        stroke(color(255, 128, 0));
        fill(color(255, 128, 0, 192));
      }
      int yPos = int(map(insideTempHistoryInt[i], minRange, maxRange, .68*height + (1-.142875-.537125)*height-2*padding -1, .68*height+4*padding));
      int xPos = int( (.4*width-3*padding - 3*padding + textWidth("1111") )/ insideTempHistoryInt.length);
      rectMode(CORNERS);
      rect(3*padding + 1+ textWidth("1111")+ i*9, yPos, 3*padding + 1+ textWidth("1111")+ i*9+9, .68*height+ (1-.142875-.537125)*height-2*padding -1);
    }
    popStyle();
  }
}



void drawHouseInformation() {
  float houseXstart = .4*width+padding;
  float houseYstart = .142875*height+2*padding;
  float houseWidth = .6*width-2*padding;
  float houseHeight = height-.142875*height-3*padding;

  pushStyle(); //Draw the LAundry room
  noSmooth();
  stroke(255);
  strokeWeight(4);
  color fillcolor = TempReading(1, 0, true, true);
  fill(fillcolor);
  rect(houseXstart + thickpad, houseYstart + thickpad, houseWidth - houseWidth*.125- 2*thickpad, (houseWidth - 2*thickpad)/5.5 );
  textSize(60);
  fill(0);
  text(LaundryTemp, houseXstart + (houseWidth - houseWidth*.125- 2*thickpad)/2, houseYstart + 2*thickpad +((houseWidth - 2*thickpad)/5.5)/2 );

  popStyle();

  pushStyle(); //draw the living room
  noSmooth();
  stroke(255);
  strokeWeight(4);
  fillcolor = TempReading(2, 0, true, true);
  fill(TempReading(2, 0, true, true));
  rect(houseXstart + houseWidth/2 + thickpad, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5, houseWidth/2 - 2*thickpad, houseHeight - 2*thickpad -(houseWidth - 2*thickpad)/5.5 );
  textSize(60);
  fill(0);
  text(LivingTemp, houseXstart + houseWidth/2 + ((houseWidth/2 - 2*thickpad)/2), houseYstart + thickpad +(houseWidth - 3*thickpad)/5.5+((houseHeight - 2*thickpad -(houseWidth - 2*thickpad)/5.5)/2)  );

  popStyle();

  pushStyle(); //draw the kitchen
  noSmooth();
  stroke(255);
  strokeWeight(4);
  fillcolor = TempReading(3, 0, true, true);
  fill(fillcolor);
  rect(houseXstart + thickpad, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5, houseWidth/2, (houseWidth - 2*thickpad)/5 );
  popStyle();

  pushStyle(); //draw the Bathroom and closet
  noSmooth();
  stroke(255);
  strokeWeight(4);
  fill(96);
  rect(houseXstart + thickpad, houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5, houseWidth/2, (houseWidth - 2*thickpad)/7 );
  line(houseXstart + thickpad + houseWidth/2.75, houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5, houseXstart + thickpad + houseWidth/2.75, houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/7);
  popStyle();

  pushStyle(); //draw the Study
  noSmooth();
  stroke(255);
  strokeWeight(4);
  fillcolor = TempReading(4, 0, true, true);
  fill(fillcolor);
  rect(houseXstart + thickpad, houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/7, houseWidth/2, (houseWidth - 2*thickpad)/3.8 );
  popStyle();

  /*
  pushStyle(); //Draw the doors
   noSmooth();
   stroke(0);
   strokeWeight(4);
   line( houseXstart + 75+ thickpad, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5, houseXstart + thickpad+150, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5); //laundry to kitchen
   line( houseXstart + 75+ thickpad + houseWidth/2, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5, houseXstart + thickpad+150 +houseWidth/2, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5); //laundry to living
   line( houseXstart + 75+ thickpad, houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/7, houseXstart + 150+ thickpad, houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/7); //bathrrom to study
   line( houseXstart + houseWidth/2 + thickpad, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5 +25, houseXstart + houseWidth/2 + thickpad, houseYstart + thickpad +(houseWidth - 2*thickpad)/5.5 +95); //kitchen to living
   line( houseXstart + houseWidth/2 + thickpad, (1.33*houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/7), houseXstart + houseWidth/2 + thickpad, 100+ (1.33*houseYstart + (houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/5 +(houseWidth - 2*thickpad)/7)); //living to study
   popStyle();
   */

  smooth();
}

