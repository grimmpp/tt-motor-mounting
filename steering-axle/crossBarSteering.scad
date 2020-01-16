h = 1;
l = 35;

difference() {
    hull() {
        cylinder($fn=32, h=h, d=4);
        translate([l,0,0]) cylinder($fn=32, h=h, d=4);
    }
    cylinder($fn=32, h=h, d=2.2);
    translate([l,0,0]) cylinder($fn=32, h=h, d=2.4);
}