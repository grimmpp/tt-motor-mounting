
d = "r"; //left:l, right:r

// [width,depth,height]
m_depth = 19;
m_height = 22.9;
m_length1 = 39.8;//31.6;
wwd = 12; // wheel hole diameter

in_w = (d == "r" ? 3 : 2.6);// inner wall
out_w = (d == "r" ? 2.6 : 3); //outer wall

difference() {
    c_len = m_depth+in_w+out_w+2;
    
    union() {
        cube([m_length1,out_w,m_height]);
        translate([0,m_depth+out_w,0]) cube([m_length1,in_w,m_height]);
        //translate([0,0,m_height]) cube([m_length1,4+m_depth+4,1]);
        translate([0,0,m_height]) cube([m_length1,c_len-2,2]);
        
        //back
        translate([m_length1-2,0,0]) cube([2,in_w+m_depth+out_w,m_height+2]);
    }
    
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
    
    //back hole
    translate([m_length1-2,out_w+8.4,0]) cube([2,3.2,14]);
}
