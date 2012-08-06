
public class Wunderground {
  XMLElement weatherData;
  XMLElement currentObservations;

  String temp_c;             //getTemp
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
 public int hitCount = 0;
 public int hitCountPerMinute = 0;
  int date = day();
  int minutes = minute();
  boolean updateSuccess;

void setHitCounter(int dayCount, int minCount){
    int hitCount = dayCount;
    int hitCountPerMinute = minCount;
}


  

  public String getCondition() {
    String formatedIcon = "";
    String[] temp = new String [2];
    temp[0] = icon.substring(0,1).toUpperCase();
    temp[1] = icon.substring(1,icon.length());
    formatedIcon = join(temp,"");
    return formatedIcon;
  }

  public String getUpdateTime() {
    String date = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date (int(observation_epoch)*1000L));
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

  public boolean update(String zipCode, String key) {
    if (date != day()) {
      hitCount = 0;
      date = day();
    } 
    if (minutes != minute()) {
      hitCountPerMinute = 0;
      minutes = minute();
    } 

    updateSuccess = false;
    if (hitCount <= 500) {
      if (hitCountPerMinute <= 5) {
        int conditionsElementPos = 0;
        //Construct URL to fetch from the zipcode provided
        String [] urlParts = new String [5];
        urlParts[0] = "http://api.wunderground.com/api/";
        urlParts[1] = key;
        urlParts[2] = "/conditions/q/";
        urlParts[3] = zipCode;
        urlParts[4] = ".xml";
        String updateURL = join(urlParts, "");
        println(updateURL);
        //Request the current conditions from Wunderground in XML format 
        try {
          weatherData = new XMLElement(getPapplet(), updateURL);
          hitCount++;
          hitCountPerMinute++;
          updateSuccess = true;
        }
        catch (Exception e) {
          updateSuccess = false;
        }

        //find the child that contains the conditions, as of now its 3 but lets be clean about it
        for (int i = 0; i < weatherData.getChildCount(); i++) {
          XMLElement weatherDataChildren = weatherData.getChild(i);
          if (weatherDataChildren.getName().equals("current_observation") ) {
            conditionsElementPos = i;
          }
        }

        XMLElement currentObservations = weatherData.getChild(conditionsElementPos);

        for (int i = 0; i < currentObservations.getChildCount(); i++) {
          XMLElement kid = currentObservations.getChild(i);
          if (kid.getName().equals("temp_c") ) {
            temp_c = kid.getContent();
            println("temp C: " + temp_c);
          }
          if (kid.getName().equals("wind_degrees") ) {
            wind_degrees = kid.getContent();
            println("wind_degrees: " + wind_degrees);
          }
          if (kid.getName().equals("wind_gust_kph") ) {
            wind_gust_kph = kid.getContent();
            println("wind_gust_kph: " + wind_gust_kph);
          }
          if (kid.getName().equals("wind_kph") ) {
            wind_kph = kid.getContent();
            println("wind_kph: " + wind_kph);
          }
          if (kid.getName().equals("pressure_mb") ) {
            pressure_mb = kid.getContent();
            println("pressure_mb: " + pressure_mb);
          }
          if (kid.getName().equals("dewpoint_c") ) {
            dewpoint_c = kid.getContent();
            println("dewpoint_c: " + dewpoint_c);
          }
          if (kid.getName().equals("heat_index_c") ) {
            heat_index_c = kid.getContent();
            println("heat_index_c: " + heat_index_c);
          }
          if (kid.getName().equals("windchill_c") ) {
            windchill_c = kid.getContent();
            println("windchill_c: " + windchill_c);
          }
          if (kid.getName().equals("icon") ) {
            icon = kid.getContent();
            println("icon: " + icon);
          }
          if (kid.getName().equals("forecast_url") ) {
            forecast_url = kid.getContent();
            println("forecast_url: " + forecast_url);
          }
          if (kid.getName().equals("observation_epoch") ) {
            observation_epoch = kid.getContent();
            println("observation_epoch: " + observation_epoch);
          }
          if (kid.getName().equals("relative_humidity") ) {
            relative_humidity = kid.getContent();
            println("relative_humidity: " + relative_humidity);
          }
        }
      }
    }
    return updateSuccess;
  }
}

//myAnimation = new Gif(this, "http://api.wunderground.com/api/22b2e40cc17fd591/animatedradar/q/OK/Stillwater.gif?newmaps=1&timelabel=1&timelabel.y=10&num=5&delay=50");
// myAnimation.play();




PApplet getPapplet ()
{
  return this;
}

