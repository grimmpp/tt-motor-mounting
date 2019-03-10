
//file version 1.1

//motor case dimensions
m_length = 39.8;
m_depth = 19+3+2.6;

//motor platform length
pl_length=100;

//tolal length
t_length = 170-1;

//motor platform positions
m1_pos = [-m_length,0,-27];
m2_pos = [-t_length,0,-27];

bodySupportFront_pos = [-173.5,pl_length/2,0];
bodySupportRear_pos = [-44,33.5,0];

//battery box dimensions
bb_length=75;
bb_width=40;
bb_height=20;

bb_pos = [-pl_length/2-bb_width,(pl_length-bb_length)/2,4];

plateWidth = pl_length-22;

// other parts to get a picture of the whole car
/* // car body
carBody();
//*/

//*  //arduino board
eBoards();
//*/

//*  // axles
axle();
translate([-t_length-12,0,0]) axle();
//*/

//* // both motoplatforms
motorPlatforms();
//*/

//* // battery box
translate(bb_pos) batteryBox();

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
    
//car body mountings | rear
bodySupportRear();
//car body mountings | front
bodySupportFront();
    
arduinoSupport();
    
//base plate
translate([-t_length-m_length+4,11,0]) {
    cube([t_length+m_length-8,plateWidth,4]);
    
    translate([0,0,4]) cube([t_length+m_length-8,10,2]);
    translate([0,plateWidth-10,4]) cube([t_length+m_length-8,10,2]);
    translate([0,(plateWidth-10)/2,4]) cube([t_length+m_length-8,10,2]);
}
//*/

}//union

color("red") {

//holes for motor platforms (axles)
translate([-m_length,0,-27-4.5]) mountingHoles();
translate([-t_length-m_length+2,0,-27-4.5]) mountingHoles();

//arduino uno holes
arduinoBoardHoles();

//holes for motor cables
cableHoles();


//battery box holes
translate(bb_pos) batteryBoxHoles();

// body connection hole
bodyMountHolesFront();
bodyMountHolesRear();

}//color("red")
}//difference

module cableHoles() {
    translate([-m_length-bb_width-13, 20, -20]) cylinder($fn=50, d=5, h=50);
translate([-m_length-bb_width-13, pl_length-20, -20]) cylinder($fn=50, d=5, h=50);
translate([-t_length+10, 20, -20]) cylinder($fn=50, d=5, h=50);
translate([-t_length+10, pl_length-20, -20]) cylinder($fn=50, d=5, h=50);
}

module arduinoSupport() {
    translate([-150,20,0])
    for(i = unoHoles) {
        translate(i)
        cylinder($fn=32, d=12, h=6);
    }
}

module arduinoBoardHoles() {
    translate([-150,20,-5])
    for(i = unoHoles) {
        translate(i) color("red") {
        cylinder($fn=32, d=3.2, h=12);
        translate([0,0,4]) cylinder($fn=6, h=3,r=3.3);
        }
    }
}

module bodySupportFront() {
    //support height
    sh2=47-2;
    c=20;
    
    //top part | position is independent of total length (t_length)
    translate(bodySupportFront_pos)
    hull() {
        _sh=10;
        translate([6,-c,sh2-_sh]) cylinder($fn=50, d=8, h=_sh);
        translate([-2,-c,sh2-_sh]) cylinder($fn=50, d=8, h=_sh);
        translate([6,c,sh2-_sh]) cylinder($fn=50, d=8, h=_sh);
        translate([-2,c,sh2-_sh]) cylinder($fn=50, d=8, h=_sh);
        
        translate([6,c,30]) cylinder($fn=50, d=8, h=4);
        translate([6,-c,30]) cylinder($fn=50, d=8, h=4);
    }

    translate([-t_length-3.5,pl_length/2,0]) {   
    //long stand
    hull() {
        translate([6,c,0]) cylinder($fn=50, d=8, h=sh2);
        translate([6,-c,0]) cylinder($fn=50, d=8, h=sh2);
        translate([6,c+14,0]) cylinder($fn=50, d=8, h=4);
        translate([6,-c-14,0]) cylinder($fn=50, d=8, h=4);
    }
    //short cross stand
    hull() {
        translate([-20,0,0]) cylinder($fn=50, d=8, h=4);
        translate([4,0,0]) cylinder($fn=50, d=8, h=sh2);
        translate([16,0,0]) cylinder($fn=50, d=8, h=4);
    }
    }
}

module bodyMountHolesFront() {
    bs_d=3.3;
    // body connection hole | front
    translate([-173.5,33.5,44]) {
        //screw holes
        translate([0,0,-25])cylinder($fn=50, d=bs_d, h=30);
        translate([0,32.4,-25]) cylinder($fn=50, d=bs_d, h=30);
        //nut holes
        translate([0,0,-1.8]) rotate([0,0,30]) cylinder($fn=6, r=3.4, h=3);
        translate([0,32.4,-1.8]) rotate([0,0,30]) cylinder($fn=6, r=3.4, h=3);
    }
}

module bodySupportRear() {
    //spport height
sh1=40.4-3;
translate(bodySupportRear_pos) {
    hull() {
        cylinder($fn=50, d=8, h=sh1);
        translate([0,32.4,0]) cylinder($fn=50, d=8, h=sh1);
        
        translate([0,32.4+18,0]) cylinder($fn=50, d=8, h=4);
        translate([0,-18,0]) cylinder($fn=50, d=8, h=4);
    }
    hull() {
        translate([0,32.4/2,0]) cylinder($fn=50, d=8, h=sh1);
        translate([20,32.4/2,0]) cylinder($fn=50, d=8, h=4);
    }
    hull() {
    translate([0,0,sh1-10]) cylinder($fn=50, d2=16, d1=8, h=10);
    translate([0,32.4,sh1-10]) cylinder($fn=50, d2=16, d1=8, h=10);
    }
}
}

module bodyMountHolesRear() {
    bs_d=3.3;
    // body connection hole | rear
    translate([-44,33.5,39.4-3-16]) {
        //screw holes
        cylinder($fn=50, d=bs_d, h=22);
        translate([0,32.4,0]) cylinder($fn=50, d=bs_d, h=22);
        
        //nut holes
        translate([0,0,19-3.2-1.6]) 
            rotate([0,0,30]) cylinder($fn=6, r=3.4, h=3);
        
        translate([0,32.4,19-3.2-1.6]) 
            rotate([0,0,30]) cylinder($fn=6, r=3.4, h=3);
    }
}

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
    color("lightgreen")
    translate([0,0,2])
    difference(){
        cube([bb_width,bb_length,bb_height]);       
        translate([2,2,2]) cube([bb_width-4,bb_length-4,bb_height+2]);
        color("blue") batteryBoxHoles();
    }
}

module batteryBoxHoles() {
    translate([10,bb_length/2,-5]) {
        cylinder($fn=32, d=3.2, h=bb_height+8);
        cylinder($fn=6, h=3,r=3.3);
    }

    translate([30,bb_length/2,-5]) {
        cylinder($fn=32, d=3.2, h=bb_height+8);
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



module carBody() {
    color("lightblue") 
    translate([-92,114,36+1]) 
    rotate([0,0,90]) 
    import("./pickupBody/wholeBody.stl");
}

module axle() {
    color("darkgrey") translate([-14,0,-16]) {
        translate([0,-2,0]) rotate([90,0,0]) cylinder($fn=100, d=66, h=26);
        translate([0,120,0]) rotate([90,0,0]) cylinder($fn=100, d=6, h=140);
        translate([0,100+26+2,0]) rotate([90,0,0]) cylinder($fn=100, d=66, h=26);
    }
}

module eBoards() {
    translate([-150,14,4+2]) 
    color("lightgreen") 
    cube([54,77,32]);
}