
dist = 14.7;

translate([20,32,22.8+0.6]) rotate([0,0,90]) import("lego_plate5x8.stl");

//translate([0,dist+24.6,22.9+0.6]) cube([39.8,24.6,3]);
translate([0,0,22.9+0.5]) cube([39.8,2*24.6+dist,3.2]);


import("MotorMounting2_left.stl");

translate([0,24.6+dist,0]) import("MotorMounting2_right.stl");
