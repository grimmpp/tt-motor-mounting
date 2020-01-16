
length = 100;
width = 40;

/*
servoMotor();
servoMotorSupport();
transverseLinks();
//*/

upperPart();

crossPart();

/*
lowerPartRight();
lowerPartLeft();
//*/

module crossPart() {
    w = 10;
    s = 13;
    h = 4.4;
    p1 = [0,w/2,0];
    p2 = [length-w/2-1.5,w/2,0];
    
    translate([s/2,-20+7,-7])
    difference() {
        union() { 
            translate(p1) cylinder($fn=32, d=w, h=h);
            translate(p2) cylinder($fn=32, d=w, h=h);
            translate(p1+[0,-1,0]) cube([length-w/2-1,w/2+1,h]);
            
            hull(){
                translate(p2+[-8-w,0,0]) cylinder($fn=32, d=w, h=h);
                translate(p2+[-8-w,-1,0]) cylinder($fn=32, d=w, h=h);
            }
        }
        color("red") {
            translate(p1) cylinder($fn=32, d=7.4, h=h);
            translate(p2) cylinder($fn=32, d=7.4, h=h);
            
            hull() {
                translate(p2+[-8-w-5/2,2,0]) cube([5,w/2,h]);
                translate(p2+[-8-w-5,5,0])cube([3,w/2,h]);
                translate(p2+[-8-w+2,5,0])cube([3,w/2,h]);
            }
            translate(p2+[-8-w,10,h/2]) rotate([90,0,0]) cylinder($fn=32, d=2.4, h=20);
            translate(p2+[-8-w,2,h/2]) rotate([90,0,0]) cylinder($fn=6, d=4.6, h=2);
        }   
    }
}



module upperPart()  {

difference() {
    union() { 
        cube([length+7,18,4]);
        translate([0,9,0]) scale([0.3,1,,1]) cylinder($fn=32, d=18, h=4);
        translate([length+7,9,0]) scale([0.3,1,,1]) cylinder($fn=32, d=18, h=4);
    }
    color("red") {
        translate([13.2/2,9,0]) cylinder($fn=32, d=7.4, h=4);
        translate([length,9,0]) cylinder($fn=32, d=7.4, h=4);
        translate([30.6,9,h-5]) cylinder($fn=32, d=3, h=12);
        translate([length-23.6,9,h-5]) cylinder($fn=32, d=3, h=12);
    }
}

p_center = [(length+7)/2,0,4];
p1 = p_center + [-23/2,0,0];
p2 = p_center + [23/2,0,0];
p3 = p_center + [-33.4/2,2,0];
w=6;
os =2.5+2;

//servo support
difference() {
    union() {
        translate(p1+[-6,os,0]) cube([6,w,12.2]);
        translate(p2+[0,os,0]) cube([6,w,12.2]);
    }
    color("red") {
        //translate(p3) cube([33.4,2.7,12.5]);
        translate(p1+[-2.3,w+os+1,6]) rotate([90,0,0]) {
            cylinder($fn=32, h=w+2, d=2.5);
            rotate([0,0,90]) cylinder($fn=6, h=3, d=4.6);
        }
        translate(p2+[2.3,w+os+1,6]) rotate([90,0,0]) {
            cylinder($fn=32, h=w+2, d=2.5);
            rotate([0,0,90]) cylinder($fn=6, h=3, d=4.6);
        }
    }
}

    //platform extension
    difference() {
        hull() {
            translate([(length+7)/2-20,18,h-5]) cube([40,35-18,4]);
            translate([(length+7)/2-20-10,17,h-5]) cube([10+40+10,1,4]);
        }
        
        color("red") {
            translate([(length+7)/2-10-.4,18+9,h-5]) {
                cylinder($fn=32, h=6, d=3.3);
                cylinder($fn=6, h=2, d=6.6);
            }
            
            translate([(length+7)/2+10,18+9,h-5]) {
                cylinder($fn=32, h=6, d=3.3);
                cylinder($fn=6, h=2, d=6.6);
            }
        }
    }
}



module lowerPartLeft() {
    translate([length+7,0,0]) mirror([1,0,0]) lowerPartRight();
}

module lowerPartRight() {
    h = 24.6;

    translate([13.2/2,0,-h]) {
        difference() {
            hull() {
                translate([0.4,9,0]) cylinder($fn=32, d=12, h=4);
                translate([0.4+10,9+6,3]) cylinder($fn=32, d=4, h=1);
                translate([0.4+10,9-6,3]) cylinder($fn=32, d=4, h=1);
                //translate([0.4+9,9,3]) cylinder($fn=32, d=6, h=1);
            }
            color("red") translate([0,9,0]) cylinder($fn=32, d=7.4, h=4);
        }
        hull() {
            translate([0.4+10,9+6,3]) cylinder($fn=32, d=4, h=1);
            translate([0.4+10,9-6,3]) cylinder($fn=32, d=4, h=1);
            
            translate([0.4+14,0,h-4]) cube([4,18,4]);
        }
        difference() {
            hull() {
                translate([0.4+14,0,h-4]) cube([33,18,4]);
                translate([0.4+14+24+2,0,h-0.1]) cube([2,18,0.1]);
            }
            
            color("red") translate([24,9,h-5]) {
                rotate([0,0,90]) cylinder($fn=6, d=6.6, h=4);
                translate([0,0,-1]) cylinder($fn=32, d=3, h=12);
            }
        }
        
    }
}


module transverseLinks(){
    translate([10,9,-11.3])
    color("lightblue") {
        rotate([0,90,0]) rotate([180,0,0]) import("transverseLink_v3.stl");

        dist = length + 4 -7 -3.6;
        translate([dist,0,0]) rotate([0,90,0]) rotate([180,0,0]) import("transverseLink_v3.stl");
    }
}

module servoMotor() {
    color("lightblue")
    translate([53.5,8.5,10.2])
    rotate([90,0,0])
    rotate([0,0,180])
    import("9g_servo.stl");
}

module servoMotorSupport() {
    color("lightblue") {
        translate([48,-10,10])
        rotate([90,116,0])
        import("ServoSupport_v2.stl");
    
        translate([47,-13,-5])
        rotate([90,0,-1.5])
        import("crossBarSteering.stl");
    }
}