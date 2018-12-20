
dist = 14.7;

m_depth = 19+3+2.6;
m_height = 22.9;
m_length1 = 39.8;

length = 100;

difference() {
    union() {
        // top plate
        translate([0,0,m_height+0.2]) cube([39.8,length,4]);

        // Motor cover left
        import("MotorMounting2_left.stl");

        // Motor cover right
        translate([0,length-m_depth,0]) import("MotorMounting2_right.stl");
        
        // walls/link between motor covers
        translate([13.4,m_depth,0]) cube([4,length-m_depth*2,m_height+1]);
        
        translate([m_length1-4,m_depth,0]) cube([4,length-m_depth*2,m_height+1]);
        
    }
    
    //nut holes
    holes();
    
    // hole in center support walls
    translate([-5,length/2, m_height-1 - (length-m_depth*2)/2])  rotate([0,90,0]) cylinder($fn=50, h=50, d=length - m_depth*2-3.2);
    
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

