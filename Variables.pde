/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */



//Imported libraries
import java.text.SimpleDateFormat;
import java.util.Date;
import googleweather.GoogleWeather;
import java.awt.MouseInfo;
import processing.serial.*;     // import the Processing serial library
import controlP5.*;
import java.util.prefs.Preferences;
import java.util.prefs.BackingStoreException;
import com.mycila.xmltool.*;
import org.xml.sax.SAXParseException;
import java.util.logging.*;
import java.util.logging.Level;
import gifAnimation.*;


int outdoorCount = 0;
int indoorCount = 0;
boolean radarFlag = false;


String[] outsideTempHistorySave = new String[48];
String[] insideTempHistorySave = new String[48];
String[] outsideTempHistoryLoad = new String[48];
String[] insideTempHistoryLoad = new String[48];
int[] outsideTempHistoryInt = new int[48];
int[] insideTempHistoryInt = new int[48];

float quarterRange;
float halfRange;
float threeQuarterRange;
int updateRateMin = 5;
float outdoorTempatureAvg = 0;
float indoorTempatureAvg = 0;
Logger logger;
XMLTag xml;
PrintWriter output;
XMLTag xmlweather;
int minRange = 0;
int maxRange = 0;
boolean read = false;
boolean write = true;
boolean restartFlag = false;
//Sensor values used to display information on house
int LaundryTemp = 0;
int LivingTemp = 0;
int StudyTemp = 0;
int KitchenTemp = 0;

// 0=degree C  1=Degree F  3=Kelvin 
int TempUnits = 1;
//0=KPH 1=MPH 2=Knots
int SpeedUnits = 1;
// 0=720p 1=1080p 2=fullscreen
int sizeSelect= 0;



  //ControlP5 UI items
  ControlP5 cp5;  
DropdownList d1;  //ComPort dropdown menu 
DropdownList resolution;  //window size dropdown menu
DropdownList service;
RadioButton TempScale;  //Radio buttons menu for selecting the tempature units
RadioButton SpeedScale; //Radio buttons menu for selecting the speed units
//Text fields used to enter the tempature ranges for coloro coding the house
Textfield FreezingBox;
Textfield ColdBox;
Textfield CoolBox;
Textfield PerfectBox;
Textfield WarmBox;
Textfield HotBox;
Textfield HellBox;
Textfield apiBox;
Button radarButton;
Button houseButton;


String activeTextField = ""; //stores the active temp range text box, so it cannot be cleared twice

//Default Tempature ranges to use in color coding the house
float FreezingTemp = 69;
float ColdTemp = 73;
float CoolTemp = 75;
float PerfectTemp = 77;
float WarmTemp = 79;
float HotTemp = 81;
float HellTemp = 84;
String apiKey = "22b2e40cc17fd591";

//The previous contents of the temp range text boxes, intially uses the default values 
//of the textbox.  These values are updated when the textbox data is saved.  
//thhe values are recalled when the user clicks a textbox and doesnt enter a new value
float FreezingBoxOld = FreezingTemp;
float ColdBoxOld = ColdTemp;
float CoolBoxOld = CoolTemp;
float PerfectBoxOld = PerfectTemp;
float WarmBoxOld = WarmTemp;
float HotBoxOld = HotTemp;
float HellBoxOld = HellTemp;
String apiBoxOld = "";
;

//weather
GoogleWeather googleWeather;
Wunderground wundergroundWeather;
String cityName = "Stillwater"; //city to get weather for
int updateIntervallInSeconds = 30;
int weatherService = 0;

//typo
PFont font;

color fontColor = color(255);

//Serial
Serial myPort;  
boolean initalSerial = true;

//date
Date today;
GregorianCalendar calendar = new GregorianCalendar();
SimpleDateFormat format;
SimpleDateFormat topInfo;
int updateInterval = 0;
int updateIntervalold = 0;


//background and drawing
int mX;
int mY;
int padding = 10;
int thickpad = 25;
float houseXstart = .4*width+padding;
float houseYstart = .142875*height+2*padding;
float houseWidth = .6*width-2*padding;
float houseHeight = height-.142875*height-3*padding;
boolean updateFlag = false;
boolean SettingsFlag = false;

