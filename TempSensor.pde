/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */



color TempReading(int Room, int TempValue, boolean Update, boolean drawTemp) {
  color roomColor = #CCCCCC;
    if (Update == false) {
    if (Room == 1 ) {
      LaundryTemp = round((TempValue*.1074)*1.8)+30;
      println("Laundry Room= " + LaundryTemp +"°")  ;
  }
    if (Room == 2 ) {
      LivingTemp = round(TempValue*.1074);
      println("Living Room= " + LivingTemp +"°");

    }
    if (Room == 3 ) {
      KitchenTemp = round(TempValue*.11);
    }
    if (Room == 4 ) {
      StudyTemp = round(TempValue*.11);
    }
  }
  if (drawTemp == true) {
    if (Room == 1 ) {
      TempValue = LaundryTemp ;
    }
    if (Room == 2 ) {
      TempValue = LivingTemp ;
    }
    if (Room == 3 ) {
      TempValue = KitchenTemp;
    }
    if (Room == 4 ) {
      TempValue = StudyTemp;
    }
  }

  if (Update == true) {
    if (TempValue < FreezingTemp) {
      roomColor = #1531AE;
    }   
    if (TempValue >= ColdTemp) {
      roomColor = #39AECF;
    }   
    if (TempValue > CoolTemp) {
      roomColor = #33CCCC;
    }   
    if (TempValue > PerfectTemp) {
      roomColor = #3BDA00;
    }   
    if (TempValue > WarmTemp) {
      roomColor = #FFFC00;
    }     
    if (TempValue > HotTemp) {
      roomColor = #FF9400;
    }  
    if (TempValue > HellTemp) {
      roomColor = #FF0000;
    }
  }

  return roomColor;
}


