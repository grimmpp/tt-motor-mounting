
qs=7;
qh=2;
//translate([0,0,20]) part2();
part1();

module part2() {
    h=10.2;
    difference() {
        union() {
            translate([0,0,-qh]) translate([-qs/2,-qs/2,0]) cube([qs,qs,qh]);
            cylinder($fn=100, d=12.6, h=h);
            translate([0,0,h]) cylinder($fn=100, d=18, h=3);
        }
        translate([0,0,-qh]) cylinder($fn=32, d=4.6, h=h+qh+3);
        translate([0,0,h]) cylinder($fn=6, d=8.6, h=3.5);    
    }
}

module part1() {
    d = 0.2;
    difference() {
        union() {
            cylinder($fn=6, d=13.6, h=17);
            translate([0,0,17]) cylinder($fn=100, d=18, h=3);
        }
        cylinder($fn=32, d=4.6, h=20);
        translate([-qs/2-d/2,-qs/2-d/2,20-qh-2*d]) cube([qs+d,qs+d,qh+d*2]);
    }
}