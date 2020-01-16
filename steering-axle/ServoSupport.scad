h = 2.6;
difference() {
    d = 14.6+4.8+0.4;
    hull() {
        cylinder($fn=32, h=h, d=10);
        translate([d,0,0]) cylinder($fn=32, h=h, d=7.2);
    }
    
    hull() {
        cylinder($fn=32, h=h-0.5, d=6);
        translate([14.5,0,0]) cylinder($fn=32, h=h-0.6, d=4);
    }
    cylinder($fn=32, h=h-0.5, d=7.4);
    translate([d,0,0]) cylinder($fn=32, h=h, d=2.6);
    translate([d,0,0]) rotate([0,0,30]) cylinder($fn=6, h=2, d=4.8);
    cylinder($fn=32, h=h, d=2);
}

