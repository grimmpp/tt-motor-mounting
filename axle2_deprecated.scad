
// [width,depth,height]
// motor dimensions
m_depth = 19 + 3 + 2.6;
m_height = 22.9;
m_length = 39.8;//31.6;
wwd = 12; // wheel hole diameter

_inner_d = 4;
_outer_d = _inner_d + 4;

cyl_x = 25.8;
cyl_y = m_depth + 12+_inner_d/2;
_h_top = m_height+2.2;
_h_bottom = m_height - (m_height-8+.2);

length = 100;
//cube([8,length,8]);


 motorRight();
 motorLeft();

//axleConnection();
crossConnection();

//g9Servo();

module axleConnection() {
    
    difference() {
        union() {
            
            motorConnection("r");
            motorConnection("l");
            connectionTopPlate();
            
        }
    
        color("red") translate([19,0,2.5]) holes();
    }
}

module innerHole() {
    cylinder($fn=50, h=36,d=_inner_d);
}
module outerCylinder(height=2,_d1=_outer_d, _d2=_outer_d) {
    cylinder($fn=50, h=height,d1=_d1,d2=_d2);
}

module motorConnection(direction = "r") {
    
    _startPos_y = (direction == "r" ? cyl_y : length-cyl_y);
    _yF = (direction == "r" ? 1 : -1);
    _h = 3;
    
    difference() {
    union(){
    
    //top washer
    translate([cyl_x,_startPos_y,_h_top])  outerCylinder(1);
    
    //bottom washer
    translate([cyl_x,_startPos_y,_h_bottom -1]) outerCylinder(1);
        
    // platform at the top
    hull() {
    translate([cyl_x,_startPos_y,_h_top+1]) outerCylinder(_h,8,11);
    translate([cyl_x,_startPos_y+16*_yF,_h_top+1])   outerCylinder(_h);
    translate([cyl_x+24,_startPos_y+20*_yF,_h_top+1]) outerCylinder(_h);
    }
    
    // platform at the bottom
    hull() {
    translate([cyl_x,_startPos_y,_h_bottom -_h-1]) outerCylinder(_h,_outer_d+3);
    translate([cyl_x+10,_startPos_y+10*_yF,_h_bottom -_h-1]) scale(0.6,1,1) outerCylinder(_h);
    translate([cyl_x+0,_startPos_y+10*_yF,_h_bottom -_h-1]) scale(0.6,1,1) outerCylinder(_h);
    }
    
    // Connection betweent platforms
    hull() {
    translate([cyl_x+10,_startPos_y+10*_yF,_h_bottom -_h-1]) scale(0.6,1,1) outerCylinder(4);
    translate([cyl_x+0,_startPos_y+10*_yF,_h_bottom -_h-1]) scale(0.6,1,1) outerCylinder(4);
    translate([cyl_x,_startPos_y+16*_yF,_h_top+1]) scale(0.6,1,1) outerCylinder(4);
    translate([cyl_x+20,_startPos_y+16*_yF,_h_top+1]) scale(0.6,1,1) outerCylinder(4);
    }

    } //union
    
    color("red") translate([cyl_x,_startPos_y,-2]) innerHole();
    // nut hole
    color("red") translate([cyl_x,_startPos_y,_h-.6]) rotate([0,0,30]) cylinder($fn=6, h=4,r=4);
    //screw head hole
    color("red") translate([cyl_x,_startPos_y,_h_top+_h-1.4]) cylinder($fn=50, h=4,r=4);
    
    } //difference
}

module crossConnection(){
    _h = 3;
    
    difference() {
    union() {
    
    // button plate right
    hull(){
    translate([cyl_x-20,cyl_y,_h_top-6.2-_h])  outerCylinder(_h,11,11);
    translate([cyl_x-20,cyl_y+10,_h_top-6.2-_h])  outerCylinder(_h,6,6);
    }
    
    // button plate left
    hull(){
    translate([cyl_x-20,length-cyl_y,_h_top-6.2-_h])  outerCylinder(_h,11,11);
    translate([cyl_x-20,length-cyl_y-10,_h_top-6.2-_h])  outerCylinder(_h,6,6);
    }
    
    // center
    translate([cyl_x-20,length/2,_h_top-6.1-_h])  outerCylinder(8+_h,6,6);
      
    // top plate right
    hull(){
    translate([cyl_x-20,cyl_y,_h_top]) outerCylinder(_h,11,11);
    translate([cyl_x-20,length/2,_h_top])  outerCylinder(_h,6,6);
    }    
    
    // top plate left 
    hull(){   
    translate([cyl_x-20,length-cyl_y,_h_top]) outerCylinder(_h,11,11);
    translate([cyl_x-20,length/2,_h_top])  outerCylinder(_h,6,6);
    }
    
    } //union
    
    color("red") translate([cyl_x-20,cyl_y,-2]) innerHole();
    color("red") translate([cyl_x-20,length-cyl_y,-2]) innerHole();
    
    // nut hole
    color("red") translate([cyl_x-20,cyl_y,_h_top-6.1-1-4]) rotate([0,0,30]) cylinder($fn=6, h=4,r=3.3);
    color("red") translate([cyl_x-20,length-cyl_y,_h_top-6.1-1-4]) rotate([0,0,30]) cylinder($fn=6, h=4,r=3.3);
    //screw head hole
    color("red") translate([cyl_x-20,cyl_y,26.6]) cylinder($fn=50, h=4,r=3);
    color("red") translate([cyl_x-20,length-cyl_y,26.6]) cylinder($fn=50, h=4,r=3);
    
    } //difference
    
}

module connectionTopPlate() {
    _h = 3;
    
    hull() {
        translate([cyl_x,cyl_y+16,_h_top+1])   outerCylinder(_h);
        translate([cyl_x+24,cyl_y+20,_h_top+1]) outerCylinder(_h);
        translate([cyl_x,length-cyl_y-16,_h_top+1])   outerCylinder(_h);
        translate([cyl_x+24,length-cyl_y-20,_h_top+1]) outerCylinder(_h);
    }
}


module motorLeft() {
    translate([0,0,0]) color("lightgreen") import("MotorMounting2_right_axle.stl");
}

module motorRight() {
    translate([0,length-m_depth,0]) color("lightgreen") import("MotorMounting2_left_axle.stl");
}

module holes(){
    //nut holes
    _d = 15;
    hole_dist= length - 2*(m_depth+_d);
    echo("hole dist: ", hole_dist);
    translate([8,m_depth+_d,22.9]) {
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.3);
        cylinder($fn=50, h=6,r=1.6);
    }
    translate([8,length-m_depth-_d,22.9]) {
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.3);
        cylinder($fn=50, h=6,r=1.6);
    }
    translate([39.8-10,m_depth+_d,22.9]) {
        rotate([0,0,30])cylinder($fn=6, h=3,r=3.3);
        cylinder($fn=50, h=6,r=1.6);
    }
    translate([39.8-10,length-m_depth-_d,22.9]) {
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.3);
        cylinder($fn=50, h=6,r=1.6);
    }
}

module g9Servo() {
    color("LightSkyBlue") translate([49,length/2+12,_h_top+12.4]) rotate([90,0,270]) import("SG92R_servo.stl");
    
    color("Plum") translate([12,length/2-24/2,_h_top+18.4]) rotate([0,90,0]) import("gear.stl");
    color("Plum") translate([2,length/2-24/2,_h_top+18.4]) rotate([0,90,0]) import("gear.stl");

}