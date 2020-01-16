
d = "r"; //left:l, right:r
axle = false; // true or false

// [width,depth,height]
m_depth = 19;
m_height = 22.9;
m_length1 = 39.8+2;//31.6;
wwd = 12; // wheel hole diameter

in_w = (d == "r" ? 3 : 2.6);// inner wall
out_w = (d == "r" ? 2.6 : 3); //outer wall

difference() {
    c_len = m_depth+in_w+out_w+2;
    
    union() {
        
        // right wall
        cube([m_length1,out_w,m_height]);
        
        // left wall
        translate([0,m_depth+out_w,0]) cube([m_length1,in_w,m_height]);
        
        // top
        difference() {
            translate([0,0,m_height]) cube([m_length1,c_len-2,2]);
            if (axle) {
                _td = m_depth + in_w + out_w;
                _center = (d == "r" ? _td/2-4.7 : _td/2+4.7);
                translate([25.8,_center,m_height]) cylinder($fn=6, h=3, d=8);
            }
        }
        
        // back wall
        translate([m_length1-4,0,0]) cube([4,in_w+m_depth+out_w,m_height+2]);
        
        //axle
        if (axle) axle();
    
    } // union()

    //screw
    //hole 1
    h1 = 1.5+1.1; //z offset
    x1 = 3.5 + 1.5; //x offset
    r1 = 1.6; // screw hole
    r2 = 3.3; //nut
    r3 = 2.9; //screw head hole //2.7
    y1 = (d == "r" ? -1 : c_len-4);
    y2 = (d == "r" ? c_len-4 : -1);
    translate([x1,-1,h1]) rotate([0,90,90]) cylinder($fn=50, h=c_len,r=r1);
    translate([x1,y2,h1]) rotate([0,30,0]) rotate([0,90,90]) cylinder($fn=6, h=3,r=r2);
    translate([x1,y1,h1]) rotate([0,90,90]) cylinder($fn=50, h=3,r=r3);
    
    h2 = m_height-1.2-1.5;
    //hole 2
    translate([x1,-1,h2]) rotate([0,90,90]) cylinder($fn=50, h=c_len,r=r1);
    translate([x1,y2,h2]) rotate([0,30,0]) rotate([0,90,90]) cylinder($fn=6, h=3,r=r2);
    translate([x1,y1, h2]) rotate([0,90,90]) cylinder($fn=50, h=3,r=r3);
    
    // middle 
    middle_x = out_w-1.5;
    hull(){ 
        translate([14.5,middle_x, m_height/2]) rotate([0,90,90]) cylinder($fn=50, h=2.5,r=2.1);
        translate([14.5-2.1,middle_x, 0]) cube([4.2,2.5,1]);
    }
    
    //wheel hole
    hull() {
    translate([25.8,-1,10.6]) rotate([0,90,90]) cylinder($fn=50,r=8,h=c_len);
    translate([25.8-3,-1,0]) cube([6,c_len,1]); //11
    }
    
    //whole for axle
    hull() {
        translate([25.8,-1-11,10.6]) rotate([0,90,90]) cylinder($fn=50,r=3,h=c_len+22);
        translate([25.8-3,-1-11,0]) cube([6,c_len+22,1]); //11
    }
    
    //back hole
    translate([m_length1-4,out_w+8.4,0]) cube([4,3.2,14]);
}

module axle(){
    _inner_d = 4;
    _outer_d = _inner_d + 4;
    
    _startPos = (d == "r" ? m_depth+in_w+out_w : 0);
    _cylDistDelta = 12+_inner_d/2;
    _cylDist = (d == "r" ? _cylDistDelta : -1 * _cylDistDelta);
    _cylDist2 = (d == "r" ? _cylDist +10 : _cylDist-10);
    _supportOffSet = (d == "r" ? -1 : 0);
    _supportDist = (d == "r" ? _cylDist - _outer_d/2 -2: _cylDist + _outer_d/2 +1);
    _support3OffSet = (d == "r" ? _cylDist - _outer_d/4 : _cylDist);
    
    module inner_cylinder1() {
        translate([25.8,_startPos+_cylDist,0]) cylinder($fn=50, d=_inner_d, h=m_height+4);
    }
    
    module outer_cylinder1() {
        translate([25.8,_startPos+_cylDist,8]) cylinder($fn=50, d=_outer_d, h=m_height+2-8);
    }
    
    module inner_cylinder2() {
        translate([25.8-20,_startPos+_cylDist,0])cylinder($fn=50, h=m_height+4, d=_inner_d);
    }
    
    module outer_cylinder2() {
        translate([25.8-20,_startPos+_cylDist,m_height-m_height/4+2]) cylinder($fn=50, d=_outer_d, h=m_height/4);
    }
    
    difference() {
        union() {
    
    outer_cylinder1();
            
    // support 1
    hull() {
        translate([m_length1-_outer_d/2,_startPos+_supportOffSet,0])
    cube([_outer_d/2,1,m_height+2]);
        
        translate([25.8,_startPos+_supportDist,8]) cube([_outer_d/2,1,m_height+2-8]);
    }    
    
    // support 2
    hull() {
        translate([25.8-_outer_d-9,_startPos+_supportOffSet,0])
    cube([_outer_d,1,m_height+2]);
        
        translate([25.8-_outer_d/2,_startPos+_supportDist,8]) cube([_outer_d/2,1,m_height+2-8]);
    }
    
    // connect outer cylinder and support 1 & 2
    hull() {
        outer_cylinder1();
        
        translate([25.8,_startPos+_supportDist,8]) cube([_outer_d/2,1,m_height+2-8]);
        
        translate([25.8-_outer_d/2,_startPos+_supportDist,8]) cube([_outer_d/2,1,m_height+2-8]);
    }
    
    outer_cylinder2();
    
    hull() {    
        outer_cylinder1();
        translate([14,0,0]) outer_cylinder2();
    }
    
    hull() {
        translate([20,0,0]) outer_cylinder2();
        outer_cylinder2();
    }
    
    }//union
        inner_cylinder1();
        inner_cylinder2();
        
    }//difference
    
    _td = m_depth + in_w + out_w;
    _center = (d == "r" ? _td/2-4.7 : _td/2+4.7); 
    
    difference() {
    color("lightblue") 
    translate([25.8,_center,m_height+2]) {
        rotate([0,0,-90]) import("MotorMountingGear.stl");
        //translate([-15,-7.6,0]) cube([30,10,4]);
        cylinder($fn=100, h=4, d=10);
        
    }
    translate([25.8,_center,m_height+2]) {
        cylinder($fn=100, h=8, d=4.2);
        cylinder($fn=6, h=1, d=8);
    }
    translate([m_length1,0,m_height+1]) cube([8,28,6]);
    _cd = (d == "r" ? -12 : _td);
    translate([0,_cd,m_height+1]) cube([m_length1+6,14.4,6]);
    } // difference
    
    
}

