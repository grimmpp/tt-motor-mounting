w=6.8;
h = 10;

rightPart();

module rightPart() {
    difference() {
        union() {
            os = (14+6);
            //body
            cylinder($fn=100, d=os, h=h);
            translate([-10,-6,0]) cube([20,12,h]);
            
            translate([-os/2-5,0,w/2]) rotate([0,90,0]) cylinder($fn=32, d=w, h=os+2*5);
            
            //arm
            translate([-3,0,0]) cube([8,21,h]);
            translate([-8,13.5+w/2,w/2]) rotate([0,90,0]) cylinder($fn=32, d=w, h=5);
        }
        cylinder($fn=32, d=13.2, h=h);
    }
}

module leftPart() {
    mirror([0,1,0]) rightPart();
}
