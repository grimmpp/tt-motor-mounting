w=6.8;
h = w;
d = 13.2;
os = (d+6); //offset

part();
lid();

module part() {
    difference() {
        union() {
            cylinder($fn=100, d=d+5, h=h);
            
            //arm
            translate([-4,0,0]) cube([6,21,h]);
            /*hull() {
                translate([-1,21-w/2,0]) cylinder($fn=50, d=6, h=h);
                translate([-4,0,0]) cube([3.6,20.6,h]);
                translate([-4+3.6,7,0]) cube([2.4,2,h]);
            }*/
            translate([-9,13.5+w/2,w/2]) rotate([0,90,0]) cylinder($fn=32, d=w, h=5);
            
            //support
            d1 = w+2*2;
            translate([-11,-d1/2,0]) cube([20,d1,h]);
            translate([-os/2-5-1,0,w/2]) rotate([0,90,0]) cylinder($fn=32, d=w, h=os+2*5);
        }
        color("red") {
            cylinder($fn=32, d=d, h=h);
            translate([-9,13.5+w/2,w/2]) rotate([0,90,0]) cylinder($fn=32, d=3, h=5+6);
            translate([-0.9,13.5+w/2,w/2]) rotate([0,90,0]) rotate([0,0,90]) cylinder($fn=6, d=6.6, h=3);
        }
    }
}

module lid() {
    translate([-9-2,13.5+w/2,w/2]) rotate([0,90,0]) 
    difference() {
        color("grey") cylinder($fn=32, d=w+4, h=2);
        color("red") cylinder($fn=50, d=3, h=2);
    }
}