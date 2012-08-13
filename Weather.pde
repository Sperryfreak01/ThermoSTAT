String currentTemp(int serviceSelect, int units) {
  String FormatedTemp= "!!!";
  if (serviceSelect == 0) {
    switch (units) {
    case 0:
      FormatedTemp = nfc((float(googleWeather.getTemperatureInFahrenheit()) - 32)*5/9, 1) + "°C";
      break;
    case 1:
      FormatedTemp = nfc( googleWeather.getTemperatureInFahrenheit(), 0) + "°F";
      break;
    case 2: 
      FormatedTemp = nfc( int((float(googleWeather.getTemperatureInFahrenheit()) + 459.67) * 5/9)) + "K";
      break;
    }
  }
  if (serviceSelect == 1) {
    switch (units) {
    case 0:
      FormatedTemp = nfc(wundergroundWeather.getTemp("celsius"), 1) + "°C";
      break;
    case 1:
      FormatedTemp = nfc(wundergroundWeather.getTemp("fahrenheit"), 1)  + "°F";
      break;
    case 2: 
      FormatedTemp = nfc(wundergroundWeather.getTemp("kelvin"), 1)  + "K";
      break;
    }
  }

  return FormatedTemp;
}

String measureTime(int serviceSelect, int units) {
  String time= "";
  if (serviceSelect == 0) {
    time = new java.text.SimpleDateFormat("MMM d, h:mm zz").format(googleWeather.getLastUpdated());
  }
  if (serviceSelect == 1) {
    time = wundergroundWeather.getUpdateTime();
  }
  return time;
}

String currentHumidity(int serviceSelect, int units) {
  String humidity= "";
  if (serviceSelect == 0) {
    humidity = nfc(googleWeather.getHumidityInPercent(), 0);
  }
  if (serviceSelect == 1) {
    humidity = wundergroundWeather.getHumidity();
  }
  return humidity;
}

String currentWindDirection(int serviceSelect, int units) {
  String direction= "";
  if (serviceSelect == 0) {
    direction = googleWeather.getWindDirectionString();
  }
  if (serviceSelect == 1) {
    direction = nfc(wundergroundWeather.getWindDirection("degrees"), 0)+"°";
  }
  return direction;
}

String currentCondition(int serviceSelect, int units) {
  String conditions = "";
  if (serviceSelect == 0) {
    conditions = googleWeather.getWeatherInGeneral();
  }

  if (serviceSelect == 1) {
    conditions = wundergroundWeather.getCondition();
  }
  return conditions;
}



String currentWindSpeed (int serviceSelect, int units) {
  String WindSpeed = "";
  if (serviceSelect == 0) {
    switch (units) {
    case 0:
      WindSpeed = nfc( googleWeather.getWindSpeedInKMH(), 1) + " km/h";
      break;
    case 1:
      WindSpeed = nfc(googleWeather.getWindSpeedInKMH() * 0.621371, 1) + " mph";
      break;
    case 2: 
      WindSpeed = nfc( googleWeather.getWindSpeedInKMH() * 0.539957, 1) + " kts";
      break;
    }
  }
  if (serviceSelect == 1) {
    switch (units) {
    case 0:
      WindSpeed = nfc(wundergroundWeather.getWindSpeed("kmh"), 1) + " km/h";
      break;
    case 1:
      WindSpeed = nfc(wundergroundWeather.getTemp("mph"), 1) + " mph";
      break;
    case 2: 
      WindSpeed = nfc(wundergroundWeather.getTemp("kts"), 1) + " kts";
      break;
    }
  }

  return WindSpeed;
}

void updateWeather(int serviceSelect) {
  switch (serviceSelect) {
  case 0: 
    googleWeather.update();
    break;
  case 1:
    println("Updating WG: " + wundergroundWeather.update("74074", apiKey));
    break;
  default: 
    googleWeather.update();
    break;
  }
}


String getDateInXDays(int x) {
  calendar.add(calendar.DAY_OF_MONTH, x); // add x days
  Date tomorrow = calendar.getTime();
  calendar.add(calendar.DAY_OF_MONTH, -x); //reset calender
  return format.format(tomorrow);
}

void drawIcon(int xPos, int yPos, int sizeX, int sizeY, String weatherS) {
  PShape iconSVG = loadShape("fin/sunny.svg");
  if (weatherS.equals("Sunny") || weatherS.equals("Clear")) {
    iconSVG = loadShape("fin/sunny.svg");
  } 
  else if (weatherS.equals("Partly Sunny")) {
    iconSVG = loadShape("fin/mostly_cloudy.svg");
  } 
  else if (weatherS.equals("Partly Cloudy")) {
    iconSVG = loadShape("fin/mostly_sunny.svg");
  } 
  else if (weatherS.equals("Cloudy")) {
    iconSVG = loadShape("fin/cloudy.svg");
  } 
  else if (weatherS.equals("Light rain")) {
    iconSVG = loadShape("fin/light_rain.svg");
  }
  else if (weatherS.equals("Rain")) {
    iconSVG = loadShape("fin/rain.svg");
  } 
  else if (weatherS.equals("Mostly Cloudy")) {
    iconSVG = loadShape("fin/mostly_cloudy.svg");
  }
  else if (weatherS.equals("Fog")) {
    iconSVG = loadShape("fin/fog.svg");
  }
  else if (weatherS.equals("Haze")) {
    iconSVG = loadShape("fin/fog.svg");
  }
  else if (weatherS.equals("Overcast")) {
    iconSVG = loadShape("fin/cloudy.svg");
  }
  else if (weatherS.equals("Rain Showers")) {
    iconSVG = loadShape("fin/light_rain.svg");
  }
  else if (weatherS.equals("Showers")) {
    iconSVG = loadShape("fin/light_rain.svg");
  }
  else if (weatherS.equals("Thunderstorm")) {
    iconSVG = loadShape("fin/thunderstorm.svg");
  }
  else if (weatherS.equals("Chance of Showers")) {
    iconSVG = loadShape("fin/light_rain.svg");
  }
  else if (weatherS.equals("Chance of Rain")) {
    iconSVG = loadShape("fin/light_rain.svg");
  }
  else if (weatherS.equals("Chance of Snow")) {
    iconSVG = loadShape("fin/light_snow.svg");
  }
  else if (weatherS.equals("Chance of Storm")) {
    iconSVG = loadShape("fin/chance_of_storm.svg");
  }
  else if (weatherS.equals("Mostly Sunny")) {
    iconSVG = loadShape("fin/mostly_sunny.svg");
  }
  else if (weatherS.equals("Scattered Showers")) {
    iconSVG = loadShape("fin/scattered_showers.svg");
  }
  else if (weatherS.equals("Snow Showers")) {
    iconSVG = loadShape("fin/scattered_showers.svg");
  }
  else if (weatherS.equals("Light snow")) {
    iconSVG = loadShape("fin/light_snow.svg");
  }
  else if (weatherS.equals("Snow")) {
    iconSVG = loadShape("fin/snow.svg");
  }
  shape(iconSVG, xPos, yPos, sizeX, sizeY);
}

void outdoorTempatureLogger() {
  String[] currentTempSpliter = splitTokens(currentTemp(weatherService, TempUnits), "°K");
  outdoorTempatureAvg = outdoorTempatureAvg + float(currentTempSpliter[0]);
  outdoorCount++;
  if (outdoorCount == 6) { 
    outdoorTempatureAvg = outdoorTempatureAvg/6;
    updateTempHistory("Outside", int(outdoorTempatureAvg));
    outdoorCount = 0;
    outdoorTempatureAvg = 0;
  }
}

void indoorTempatureLogger() {
  indoorTempatureAvg = indoorTempatureAvg + float(LivingTemp);
  indoorCount++;
  if (indoorCount == 6) { 
    indoorTempatureAvg = indoorTempatureAvg/6;
    updateTempHistory("Inside", int(indoorTempatureAvg));
    indoorCount = 0;
    indoorTempatureAvg = 0;
  }
}

