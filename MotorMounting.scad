
// [width,depth,height]
m_depth = 19;
m_height = 23;
m_length1 = 10; //36.8;
w=3;

difference() {
    union() {
        cube([10,w,m_height]);
        translate([0,w+m_depth,0]) cube([10,w,m_height]);
        //translate([0,0,m_height]) cube([m_length1,4+m_depth+4,1]);
        translate([0,0,m_height]) cube([10,w+m_depth+w,2]);
    }
    
    //whole 1
    h1 = 1.5+1;
    c_len = w+m_depth+w+2;
    translate([5,-1,h1]) rotate([0,90,90]) cylinder($fn=50, h=c_len,r=1.6);
    translate([5,-1,h1]) rotate([0,30,0]) rotate([0,90,90]) cylinder($fn=6, h=3,r=3.3);
    translate([5,c_len-4,h1]) rotate([0,90,90]) cylinder($fn=50, h=3,r=2.7);
    
    h2 = m_height-1.2-1.5;
    //whole 2
    translate([5,-1,h2]) rotate([0,90,90]) cylinder($fn=50, h=c_len,r=1.6);
    translate([5,-1,h2]) rotate([0,30,0]) rotate([0,90,90]) cylinder($fn=6, h=3,r=3.3);
    translate([5,c_len-4, h2]) rotate([0,90,90]) cylinder($fn=50, h=3,r=2.7);
    
    //translate([10,0,m_height]) cube([m_length1-10,4,1]);
    //translate([10,4+m_depth,m_height]) cube([m_length1-10,4,1]);
}
