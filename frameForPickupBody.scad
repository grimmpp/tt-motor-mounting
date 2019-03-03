
//motor case dimensions
m_length = 39.8;
m_depth = 19+3+2.6;

//motor platform length
pl_length=100;

//tolal length
t_length = 170;

//motor platform positions
m1_pos = [-m_length,0,-27];
m2_pos = [-t_length,0,-27];

//battery box dimensions
bb_length=75;
bb_width=40;
bb_height=20;

bb_pos = [-75-m_length+7.6,50-40/2,-20-4];

//* 
carBody();
eBoards();
axle();
translate([-182,0,0]) axle();
//*/

//* both motor platforms
    motorPlatforms();
//*/

//* battery box - sits between both platforms
    //translate(bb_pos) batteryBox();
    translate([-50,(pl_length-bb_length)/2,4]) rotate([0,0,90]) batteryBox();
//*/


unoHoles = [
    [  2.54, 15.24 ],
    [  17.78, 66.04 ],
    [  45.72, 66.04 ],
    [  50.8, 13.97 ]
];
        
motorPlatformHoles = [
    [  ]
];
        
mountingHoleRadius = 3.2 / 2;

difference(){
    
//frame
union(){
    
    
    /* bottom plate
    union() {
    translate([-t_length,pl_length/2-20,-4]) cube([t_length-m_length,40,4]);
    translate([-t_length-12.5,pl_length/2-20,-8]) cube([t_length-15,40,4]);
    }
    //*/
    
//car body mountings | rear
translate([-44,33.5,0]) {
    hull() {
        cylinder($fn=50, d=8, h=39.4-3);
        translate([0,32.4,0]) cylinder($fn=50, d=8, h=39.4-3);
    }
}

//car body mountings | front
translate([-173.5,33.5,0]) {
    hull() { 
        cylinder($fn=50, d=8, h=46-2);
        translate([4,0,0]) cylinder($fn=50, d=8, h=46-2);
    }
    translate([0,32.4,0]) hull() {
        cylinder($fn=50, d=8, h=46-2);
        translate([4,0,0]) cylinder($fn=50, d=8, h=46-2);
    }
}
translate([-173.5+4,33.5,0]) {
    hull() {
        cylinder($fn=50, d=8, h=46-2);
        translate([0,32.4,0]) cylinder($fn=50, d=8, h=46-2);
    }
}
    
//base plate
translate([-t_length-m_length+4,11,0]) cube([t_length+m_length-8,pl_length-22,4]);

}//union

//holes
translate([-m_length,0,-27-4.5]) mountingHoles();
translate([-t_length-m_length+2,0,-27-4.5]) mountingHoles();

//arduino uno holes
translate([-150,20,-4])
rotate([0,0,0]) {
    for(i = unoHoles) {
        translate(i) color("red") {
        cylinder($fn=32, d=3.2, h=12);
        translate([0,0,4]) cylinder($fn=6, h=3,r=3.3);
        }
    }
}

//battery box holes
translate([-50,(pl_length-bb_length)/2,0])
//translate([-49,10,0]) 
color("red") rotate([0,0,90]) batteryBoxHoles();

// body connection hole | front
color("red") translate([-173.5,33.5,44-18]) {
    cylinder($fn=50, d=3, h=20);
    translate([0,32.4,0]) cylinder($fn=50, d=3, h=20);
}
// body connection hole | rear
color("red") translate([-44,33.5,39.4-3-18]) {
    cylinder($fn=50, d=3, h=20);
    translate([0,32.4,0]) cylinder($fn=50, d=3, h=20);
}

}//difference



module motorPlatforms() {
    color("lightblue") {
        
        translate(m1_pos) 
        import("MotorMounting_Bridge2_length100_4scewHoles.stl");

        translate(m2_pos) 
        mirror([1,0,0]) 
        import("MotorMounting_Bridge2_length100_4scewHoles.stl");
    }//color
}


module batteryBox(){
    
    difference(){
        color("lightgreen")
        cube([bb_length,bb_width,bb_height]);
        
        batteryBoxHoles();
    }
}

module batteryBoxHoles() {
    translate([bb_length/2,10,-1]) {
        cylinder($fn=32, d=3.2, h=bb_height+2);
        cylinder($fn=6, h=3,r=3.3);
    }

    translate([bb_length/2,30,-1]) {
        cylinder($fn=32, d=3.2, h=bb_height+2);
        cylinder($fn=6, h=3,r=3.3);
    }
}

//mounting holes
module mountingHoles(){
    color("red"){ 
    _d = 15;
    
    translate([8,m_depth+_d,22.9]) {
        cylinder($fn=50, h=12+10,r=1.6);
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.2);
    }
    
    translate([8,pl_length-m_depth-_d,22.9]) {
        cylinder($fn=50, h=12+10,r=1.6);
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.2);
    }
    
    translate([39.8-10,m_depth+_d,22.9]) {
        cylinder($fn=50, h=12+10,r=1.6);
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.2);
    }
    
    translate([39.8-10,pl_length-m_depth-_d,22.9]) {
        cylinder($fn=50, h=12+10,r=1.6);
        rotate([0,0,30]) cylinder($fn=6, h=3,r=3.2);
    }
    }//color
}


module crossbar() {
    cube([8,pl_length-2*m_depth,4]);
}

module carBody() {
    color("lightblue") translate([-92,114,36]) rotate([0,0,90]) import("./pickupBody/wholeBody.stl");
}

module axle() {
    color("darkgrey") translate([-14,0,-16]) {
        translate([0,-2,0]) rotate([90,0,0]) cylinder($fn=100, d=66, h=26);
        translate([0,120,0]) rotate([90,0,0]) cylinder($fn=100, d=6, h=140);
        translate([0,100+26+2,0]) rotate([90,0,0]) cylinder($fn=100, d=66, h=26);
    }
}

module eBoards() {
    translate([-150,14,4]) color("lightgreen") cube([54,77,32]);
}