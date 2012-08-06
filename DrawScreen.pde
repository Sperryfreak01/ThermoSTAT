void drawTopInformation() {
  textAlign(LEFT);
  textSize(60);
  fill(fontColor);
  text(cityName+" ", 39, 90);
  textSize(20);
  text("Lon: "+nf(googleWeather.getLongitude(), 2, 2)+" Lat: "+nf(googleWeather.getLatitude(), 2, 2));
  textSize(20);
  textAlign(RIGHT);
  text(topInfo.format(googleWeather.getLastUpdated()), 1070, 90);
}
void drawWeatherNow() { 
  int paddingTop = 203;
  int paddingLeft = 25;
  textAlign(LEFT);
  fill(fontColor);
  textSize(20);
  text(googleWeather.getWeekdayInXDays(0)+", "+getDateInXDays(0), 46, 155);
  textSize(90);
  text(currentTemp(weatherService, TempUnits), paddingLeft+15, paddingTop+80);
  textSize(20);
  text("Min:" + int(googleWeather.getMinTemperatureInFahrenheitInXDays(0))+"    Max:"+int(googleWeather.getMaxTemperatureInFahrenheitInXDays(0))+"F°",  paddingLeft+15, paddingTop+85+thickpad);
  textSize(50);
  text(currentCondition(weatherService, TempUnits), paddingLeft+17, paddingTop+180);
  textSize(30);
  text("Wind: "+currentWindDirection(weatherService, SpeedUnits)+" at "+ currentWindSpeed(weatherService, SpeedUnits), paddingLeft+20, paddingTop+235 );
  text("Humidity: "+currentHumidity(weatherService, SpeedUnits) +"%", paddingLeft+20, paddingTop+275);
  drawIcon(280, 125, 240, 240, currentCondition(weatherService, TempUnits));
}


void drawWeatherForecastToday() {
  textSize(20);
  text("Forecast today", 40, 540);
  textSize(60);
  textSize(30);
  text(googleWeather.getWeatherInGeneralInXDays(0), 40, 660);
  drawIcon(350, 518, 140, 140, googleWeather.getWeatherInGeneralInXDays(0));
}
/*
void drawWeatherForecastTomorrow() {
  textSize(20);
  text(googleWeather.getWeekdayInXDays(1)+", "+getDateInXDays(1), 620, 155);
  textSize(60);
  text(int(googleWeather.getMinTemperatureInFahrenheitInXDays(1))+"/"+int(googleWeather.getMaxTemperatureInFahrenheitInXDays(1))+"F°", 620, 238);
  textSize(30);
  text(googleWeather.getWeatherInGeneralInXDays(1), 620, 279);
  drawIcon(910, 140, 140, 140, googleWeather.getWeatherInGeneralInXDays(1));
}

void drawWeatherForecastIn2Days() {
  int paddingTop = 300;
  textSize(20);
  text(googleWeather.getWeekdayInXDays(2)+", "+getDateInXDays(2), 620, 50+paddingTop);
  textSize(60);
  text(int(googleWeather.getMinTemperatureInFahrenheitInXDays(2))+"/"+int(googleWeather.getMaxTemperatureInFahrenheitInXDays(2))+"F°", 620, 130+paddingTop);
  textSize(30);
  text(googleWeather.getWeatherInGeneralInXDays(2), 620, 170+paddingTop);
  drawIcon(910, 36+paddingTop, 140, 140, googleWeather.getWeatherInGeneralInXDays(2));
}

void drawWeatherForecastIn3Days() {
  int paddingTop = 490;
  textSize(20);
  text(googleWeather.getWeekdayInXDays(3)+", "+getDateInXDays(3), 620, 50+paddingTop);
  textSize(60);
  text(int(googleWeather.getMinTemperatureInFahrenheitInXDays(3))+"/"+int(googleWeather.getMaxTemperatureInFahrenheitInXDays(3))+"F°", 620, 127+paddingTop);
  textSize(30);
  text(googleWeather.getWeatherInGeneralInXDays(3), 620, 170+paddingTop);
  drawIcon(910, 38+paddingTop, 140, 140, googleWeather.getWeatherInGeneralInXDays(3));
}

*/
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



  // houseWidth - 2*thickpad, (houseWidth - 2*thickpad)/2
}
