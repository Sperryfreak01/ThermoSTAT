
public class Wunderground {
  // processing.xmlweather.xmlweatherElement weatherData;
  // processing.xmlweather.xmlweatherElement currentObservations;
  String[] wgXML;
  String temp_c;             //getTemp
  String high_c;             //getTemp
  String low_c;             //getTemp
  String wind_degrees;       //getWindDirection
  String wind_gust_kph;      //getWindGust
  String wind_kph;           //getWindSpeed
  String pressure_mb;        //getAirPressure
  String dewpoint_c;         //getDewPoint
  String heat_index_c;       //getHeatIndex
  String windchill_c;        //getWindChill
  String icon;               //getCondition
  String forecast_url;       //getForecastLink
  String observation_epoch;  //getUpdateTime
  String relative_humidity;  //getHumidity
  public int hitCount;
  public int hitCountPerMinute;
  public int date = 0;
  int minutes = minute();
  String updateSuccess;



  void setHitCounter(int dayCount, int minCount) {
    int hitCount = dayCount;
    println("hitcount:"+ hitCount);
    int hitCountPerMinute = minCount;
  }

  public String getCondition() {
    String formatedIcon = "";
    String[] temp = new String [2];
    temp[0] = icon.substring(0, 1).toUpperCase();
    temp[1] = icon.substring(1, icon.length());
    formatedIcon = join(temp, "");
    return formatedIcon;
  }

  public String getUpdateTime() {
    String date = "";
    try {
      date = new java.text.SimpleDateFormat("MMM d, h:m zz").format(new java.util.Date (int(observation_epoch)*1000L));
    }
    catch (Exception e) {
      date = new java.text.SimpleDateFormat("MMM d, h:m zz").format(new java.util.Date (int("8975640")*1000L));
    }
    return date;
  }

  public String getHumidity() {
    //accepts celsius, fahrenheit, kelvin as valid units
    String[] humidityOutput = split (relative_humidity, "%") ;
    return humidityOutput[0];
  }

  public String getForecastLink() {
    return forecast_url;
  }

  public float getWindChill(String units) {
    //accepts celsius, fahrenheit, kelvin as valid units

      float windChillOutput = 0;
    float windChill = float(windchill_c);

    if (units.equals("celsius")) {
      windChillOutput = windChill;
    }
    if (units.equals("fahrenheit")) {
      windChillOutput = ((windChill * (9/5)) + 32) ;
    }
    if (units.equals("kelvin")) {
      windChillOutput = windChill + 273.15;
    }
    return windChillOutput;
  }

  public float getHeatIndex(String units) {
    //accepts celsius, fahrenheit, kelvin as valid units

      float heatIndexOutput = 0;
    float heatIndex = float(heat_index_c);

    if (units.equals("celsius")) {
      heatIndexOutput = heatIndex;
    }
    if (units.equals("fahrenheit")) {
      heatIndexOutput = ((heatIndex * (9/5)) + 32) ;
    }
    if (units.equals("kelvin")) {
      heatIndexOutput = heatIndex + 273.15;
    }
    return heatIndexOutput;
  }

  public float getDewPoint(String units) {
    //accepts celsius, fahrenheit, kelvin as valid units

      float dewPointOutput = 0;
    float dewpoint = float(dewpoint_c);

    if (units.equals("celsius")) {
      dewPointOutput = dewpoint;
    }
    if (units.equals("fahrenheit")) {
      dewPointOutput = ((dewpoint * (9/5)) + 32) ;
    }
    if (units.equals("kelvin")) {
      dewPointOutput = dewpoint + 273.15;
    }
    return dewPointOutput;
  }

  public float getAirPressure(String units) {
    //accepts mbar, mmHg, or inHg as units
    float airPressureOutput = 0;
    float airPressureFloat = float(pressure_mb);

    if (units.equals("mbar")) {
      airPressureOutput = airPressureFloat;
    }
    if (units.equals("inHg")) {
      airPressureOutput = (airPressureFloat * .0295333727) ;
    }
    if (units.equals("mmHg")) {
      airPressureOutput = (airPressureFloat * .75006375541921);
    }
    return airPressureOutput;
  }

  public float getWindSpeed(String units) {
    //accepts kmh,mph, or kts as units
    float windSpeedOutput = 0;
    float windSpeed = float(wind_kph);

    if (units.equals("kmh")) {
      windSpeedOutput = windSpeed;
    }
    if (units.equals("mph")) {
      windSpeedOutput = (windSpeed * .621371) ;
    }
    if (units.equals("kts")) {
      windSpeedOutput = (windSpeed * .539956803);
    }
    return windSpeedOutput;
  }

  public float getWindGust(String units) {
    //accepts kmh,mph, or kts as units
    float windGustOutput = 0;
    float windGust = float(wind_gust_kph);

    if (units.equals("kmh")) {
      windGustOutput = windGust;
    }
    if (units.equals("mph")) {
      windGustOutput = (windGust * .621371) ;
    }
    if (units.equals("kts")) {
      windGustOutput = (windGust * .539956803);
    }
    return windGustOutput;
  }

  public float getWindDirection(String units) {
    //accepts degrees or radians as units
    float directionOutput = 0;
    float windDirectionFloat = float(wind_degrees);

    if (units.equals("degrees")) {
      directionOutput = windDirectionFloat;
    }
    if (units.equals("radians")) {
      directionOutput = ((windDirectionFloat * PI) / 180);
    }
    return directionOutput;
  }

  public float getTemp(String units) {
    //accepts celsius, fahrenheit, kelvin as valid units

      float tempOutput = 0;
    float temperature = float(temp_c);

    if (units.equals("celsius")) {
      tempOutput = temperature;
    }
    if (units.equals("fahrenheit")) {
      tempOutput = (temperature*1.8 + 32) ;
    }
    if (units.equals("kelvin")) {
      tempOutput = temperature + 273.15;
    }
    return tempOutput;
  }

  public String update(String zipCode, String key) {
    if (date != day()) {
      println("date:"+day());
      println("reseting hitcount");
      hitCount = 0;
      date = day();
    } 
    if (minutes != minute()) {
      hitCountPerMinute = 0;
      minutes = minute();
    } 

    if (hitCount <= 490) {
      if (hitCountPerMinute <= 5) {
        //Construct URL to fetch from the zipcode provided
        String [] urlParts = new String [5];
        urlParts[0] = "http://api.wunderground.com/api/";
        urlParts[1] = key;
        urlParts[2] = "/conditions/q/";
        urlParts[3] = zipCode;
        urlParts[4] = ".xml";
        String updateURL = join(urlParts, "");
        // println(updateURL);
        //Request the current conditions from Wunderground in xmlweather format 
        try { 
          XMLTag xmlweather = XMLDoc.from(new URL(updateURL), true);
          hitCount++;
          hitCountPerMinute++;
          xmlweather.gotoRoot();
          xmlweather.gotoChild("current_observation");
          xmlweather.gotoChild("temp_c");
          temp_c =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("wind_degrees");
          wind_degrees =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("wind_gust_kph");
          wind_gust_kph =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("wind_kph");
          wind_kph =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("pressure_mb");
          pressure_mb =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("dewpoint_c");
          dewpoint_c =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("heat_index_c");
          heat_index_c =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("windchill_c");
          windchill_c =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("icon");
          icon =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("forecast_url");
          forecast_url =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("observation_epoch");
          observation_epoch =  xmlweather.getText().toString();
          xmlweather.gotoParent();
          xmlweather.gotoChild("relative_humidity");
          relative_humidity =  xmlweather.getText().toString();
          xmlweather.gotoRoot();
          if (xmlweather.hasTag("forecast")) {
            xmlweather.gotoChild("forecast");
            xmlweather.gotoChild("simpleforecast");
            xmlweather.gotoChild("forecastdays");
            xmlweather.gotoChild(1);
            xmlweather.gotoChild("date");
            xmlweather.gotoChild("day");
            if (xmlweather.getText().toString().equals(str(day()))) {
              xmlweather.gotoParent();
              xmlweather.gotoChild("high");
              xmlweather.gotoChild("high_c");
              high_c = xmlweather.getText().toString();
              xmlweather.gotoParent();
              xmlweather.gotoParent();
                            xmlweather.gotoChild("low");
              xmlweather.gotoChild("low_c");
                            low_c = xmlweather.getText().toString();

            }
          }

          updateSuccess = "Update successful";
        }         
        catch (Exception e) {
          println("failed to parse WG XML");
          println(e);
          updateSuccess = "update failed";
        }
      }
      else {
        updateSuccess = "per minute api limit exceeded";
      }
    }
    else {
      updateSuccess = "daily api limit exceeded";
    }
    return updateSuccess;
  }
}
PApplet getPapplet ()
{
  return this;
}

