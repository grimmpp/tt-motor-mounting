w=6.8;

rightPart();

module rightPart() {
    difference() {
        union() {
            cylinder($fn=100, d=14+6, h=10);
            translate([-38/2,0,w/2]) rotate([0,90,0]) cylinder($fn=32, d=w, h=38);
            
            translate([-w-4,13.5+w/2,w/2]) rotate([0,90,0]) cylinder($fn=32, d=w, h=w+8);

            translate([-4,0,0]) cube([8,22,10]);
            translate([-14,-6,0]) cube([28,12,10]);
            translate([-4,12,0]) cube([8,10,8]);
        }
        cylinder($fn=32, d=13.2, h=10);
    }
}

module leftPart() {
    mirror([0,1,0]) rightPart();
}

