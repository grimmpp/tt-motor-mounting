
m_height = 22.5;
m_depth = 18.8;

translate([0,8,m_height]) import("lego_plate2x8.stl");
translate([-(5+4+m_depth+4),0,m_height]) cube([2*(5+4+m_depth+4),15,3.2]);

translate([5,10,0]) rotate([0,0,270]) import("MotorMounting.stl");
translate([-5,0,0]) rotate([0,0,90]) import("MotorMounting.stl");