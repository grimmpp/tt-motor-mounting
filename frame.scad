
_h = 4;
m_depth = 19+3+2.6;
length = 220;

//translate([39.8 + 16.6,0,27.1+4]) rotate([180,0,180]) import("C:/Users/Philipp/Documents/3d printing/4WD/MyMotorSupport/MyMotorSupport_Bridge2_length100_4scewHoles.stl");


// arduino platte
difference() {
    union() {
        translate([length/2 + 26, 100/2, 0])
            for(i =[0:_h-1]) {
                translate([0,0,i]) mirror([1,0,0]) import("C:/Users/Philipp/Documents/3d printing/arduino/ArduinoUnoBasePlate2.stl");
            }
            //connector / gap filler
           translate([length/2+55, 100/2-22, 0])cube([8,22*2,_h]); 
            translate([length/2-10, 100/2-22, 0])cube([2,22*2,_h]);
            translate([length/2-2, 100/2-22, 0])cube([2,22*2,_h]);
            translate([length/2+6, 100/2-22, 0])cube([1,22*2,_h]);
        }    
    //entfernen hinterer balken
    translate([length/2+53, 100/2-20, -1])cube([10,20*2,_h+2]);
    
    // nusslöcher für den arduino
    translate([156.3,22.5+3.4,-1]) cylinder($fn=6, r=3.3,h=3);
    translate([155,100-(22.5+6)+2.5,-1]) cylinder($fn=6, r=3.3,h=3);
    translate([104.2,22.5+8.4,-1]) rotate([0,0,30]) cylinder($fn=6, r=3.3,h=3);
    translate([104.2,22.5+36.4,-1]) rotate([0,0,30]) cylinder($fn=6, r=3.3,h=3);
}

// Äußerer rahmen
/*
difference() {
    hull() {
        translate([4, 4, 0]) cylinder($fn=50, r=4, h=_h);
        translate([4, 100-4, 0]) cylinder($fn=50, r=4, h=_h);
        translate([length-4, 4, 0]) cylinder($fn=50, r=4, h=_h);
        translate([length-4, 100-4, 0]) cylinder($fn=50, r=4, h=_h);
    }

    // innerer Ausschnitt
    hull() {
        translate([10, 10, -1]) cylinder($fn=50, r=4, h=_h+2);
        translate([10, 100-10, -1]) cylinder($fn=50, r=4, h=_h+2);
        translate([length-10, 10, -1]) cylinder($fn=50, r=4, h=_h+2);
        translate([length-10, 100-10, -1]) cylinder($fn=50, r=4, h=_h+2);
    }
}
//*/

// verbindungsstreben für die radaufhängung
difference() {
    union() {
        translate([25,0,0]) Connection();
        translate([25+22,0,0]) Connection();
        translate([length - 25,0,0]) Connection();
        translate([length -(25+22),0,0]) Connection();
        // mittelstrebe
        translate([length/2,0,0]) Connection();

        translate([25,38+1.6 -3,0]) cube([22,6,_h]);
        translate([25,100 - (38+1.6+3),0]) cube([22,6,_h]);
        translate([length-47,38+1.6 -3,0]) cube([22,6,_h]);
        translate([length-47,100 - (38+1.6+3),0]) cube([22,6,4]);
    }
    
    // löcher für radaufhängung
    translate([25,0 ,0]) holes();
    translate([25+22,0,0]) holes();
    translate([length - 25,0,0]) holes();
    translate([length -(25+22),0,0]) holes();
    
    // löcher in der mitte für batteriefach
    translate([length/2 +3,50 + 19/2,-1]) cylinder($fn=50, r=1.6, h=_h+2); 
    translate([length/2 +3,50 - 19/2,-1]) cylinder($fn=50, r=1.6, h=_h+2); 
    translate([length/2 +3,50 + 19/2,_h-2]) rotate([0,0,30]) cylinder($fn=6, r=3.3,h=3);
    translate([length/2 +3,50 - 19/2,_h-2]) rotate([0,0,30]) cylinder($fn=6, r=3.3,h=3);
}

difference() {
    // innere längsstreifen
    union() {
        translate([0,22.5,0]) cube([length,6,_h]);
        translate([0,100-(22.5+6),0]) cube([length,6,_h]);
    }
    // nachbohrungen für arduino löcher
    translate([156.3,22.5+3.4,-1]) cylinder($fn=50, r=1.6,h=_h+2);
    translate([156.3,22.5+3.4,-1]) cylinder($fn=6, r=3.3,h=3);
    translate([155,100-(22.5+6)+2.5,-1]) cylinder($fn=50, r=1.6,h=_h+2);
    translate([155,100-(22.5+6)+2.5,-1]) cylinder($fn=6, r=3.3,h=3);
    // nachbohrung nussloch für den arduino
    translate([104.2,22.5+8.4,-1]) rotate([0,0,30]) cylinder($fn=6, r=3.3,h=3);
}


module Connection() {
    cube([6,100,4]);
}

// schraubenlöcher + schraubenkopflöcher
// hole dist
module holes() {
    _d=15;
    translate([3,m_depth+_d,-1]) cylinder($fn=50, r=1.6, h=_h+2);
    translate([3,m_depth+_d,_h-2]) cylinder($fn=50, r=3, h=3);
    translate([3,100 - m_depth-_d,-1]) cylinder($fn=50, r=1.6, h=_h+2);
    translate([3,100 - m_depth-_d,_h-2]) cylinder($fn=50, r=3, h=3);
}