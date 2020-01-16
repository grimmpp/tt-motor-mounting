

 
difference() {
    union() {
        cylinder($fn=6, d=13.6, h=5);
        translate([0,0,5]) cylinder($fn=32, d=7.6, h=15);
    }
    cylinder($fn=32, d=4.6, h=20);
}
