
//motor case dimensions
m_length = 39.8;
m_depth = 19+3+2.6;

//motor platform length
pl_length=100;

//tolal length
t_length = 100;

//motor platform positions
m1_pos = [-m_length,0,-27];
m2_pos = [-t_length,0,-27];

//battery box dimensions
bb_length=75;
bb_width=40;
bb_height=20;

bb_pos = [-75-m_length+7.6,50-40/2,-20-4];

cornerHoles = false; // true;
batteryCrossbarHeight = 8; // 4;

/* both motor platforms
    motorPlatforms();
//*/

/* battery box - sits between both platforms
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
    
//corssbars platform1
translate([m1_pos[0],m_depth,0])  {
    translate([m_length-8-6,0,0]) crossbar();
    translate([4,0,0]) crossbar();
}

//corssbars platform2 (steering)
translate([m2_pos[0]+6,m_depth,0])  {
    translate([-18,0,0]) crossbar();
    translate([-18,0,-4]) crossbar();
    translate([-m_length,0,0]) crossbar();
}
// extension for steering
translate([-133.8-22,66.04+10-5-2,0]) cube([22,12,4]);
translate([-133.8-22,(15.24+13.97)/2+10-5,0]) cube([22,12,4]);

//corssbars center / battery box
translate([bb_pos[0]+bb_length/2-5,m_depth-5,4-batteryCrossbarHeight]) {
    cube([10,100-2*m_depth+10.6,batteryCrossbarHeight]);
}

//side bars
translate([-133.8,66.04+10-5,0]) cube([139.8-12,10,4]);
translate([-133.8,(15.24+13.97)/2+10-5,0]) cube([139.8-12,10,4]);


}//union

//holes
translate([-m_length,0,-27]) mountingHoles();
translate([-100-m_length+2,0,-27]) mountingHoles();

//steeting extension
color("red") translate([-t_length-30+.2-18,27.1,-4]) {
    cylinder($fn=50, h=12,r=1.6);
    translate([0,45.8,0]) cylinder($fn=50, h=12,r=1.6);
}

//side holes
if (cornerHoles) color("red") {
translate([-133.8+4,66.04+10,-1]) cylinder($fn=32, d=3.2, h=12);
translate([-133.8+4+10,66.04+10,-1]) cylinder($fn=32, d=3.2, h=12);
    
translate([-133.8+4,(15.24+13.97)/2+10,-1]) cylinder($fn=32, d=3.2, h=12);
translate([-133.8+4+10,(15.24+13.97)/2+10,-1]) cylinder($fn=32, d=3.2, h=12);
    
translate([-14+4-10,66.04+10,-1]) cylinder($fn=32, d=3.2, h=12);
translate([-14+4,66.04+10,-1]) cylinder($fn=32, d=3.2, h=12);
    
translate([-14+4-10,(15.24+13.97)/2+10,-1]) cylinder($fn=32, d=3.2, h=12);
translate([-14+4,(15.24+13.97)/2+10,-1]) cylinder($fn=32, d=3.2, h=12);
}

//arduino uno holes
translate([-96,10,-4])
rotate([0,0,0]) {
    for(i = unoHoles) {
        translate(i) color("red") {
        cylinder($fn=32, d=3.2, h=12);
        translate([0,0,4]) cylinder($fn=6, h=3,r=3.3);
        }
    }
}

//battery box holes
translate([-75-m_length+7.6,50-40/2,-14]) color("red") batteryBoxHoles();

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
        translate([0,0,16]) rotate([0,0,30])
        cylinder($fn=6, h=3,r=3.3);
    }

    translate([bb_length/2,30,-1]) {
        cylinder($fn=32, d=3.2, h=bb_height+2);
        translate([0,0,16]) rotate([0,0,30])
        cylinder($fn=6, h=3,r=3.3);
    }
}

//mounting holes
module mountingHoles(){
    color("red"){ 
    _d = 15;
    
    translate([8,m_depth+_d,22.9]) 
    cylinder($fn=50, h=12,r=1.6);
    
    translate([8,pl_length-m_depth-_d,22.9])
    cylinder($fn=50, h=12,r=1.6);
    
    translate([39.8-10,m_depth+_d,22.9])
    cylinder($fn=50, h=12,r=1.6);
    
    translate([39.8-10,pl_length-m_depth-_d,22.9])
    cylinder($fn=50, h=12,r=1.6);
    }//color
}


module crossbar() {
    cube([8,pl_length-2*m_depth,4]);
}