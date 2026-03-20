// Site footprint base
// Source: land brochure PDF
// Dimensions:
// - East-West: 25.75 m
// - North-South: 8.90 m
//
// All units are millimeters.

lot_width = 25750;
lot_depth = 8900;

line_thickness = 120;
label_size = 500;
margin = 1200;

show_labels = true;

module outline_rect(w, d, t=line_thickness) {
    difference() {
        square([w, d]);
        translate([t, t]) square([w - 2 * t, d - 2 * t]);
    }
}

module dimension_h(x1, x2, y, label) {
    color("dimgray") {
        translate([x1, y]) square([x2 - x1, 50]);
        translate([x1, y - 200]) square([50, 450]);
        translate([x2, y - 200]) square([50, 450]);
    }
    if (show_labels) {
        color("black")
            translate([(x1 + x2) / 2, y + 180])
                text(label, size=label_size, halign="center", valign="bottom");
    }
}

module dimension_v(x, y1, y2, label) {
    color("dimgray") {
        translate([x, y1]) square([50, y2 - y1]);
        translate([x - 200, y1]) square([450, 50]);
        translate([x - 200, y2]) square([450, 50]);
    }
    if (show_labels) {
        color("black")
            translate([x - 250, (y1 + y2) / 2])
                rotate(90)
                    text(label, size=label_size, halign="center", valign="bottom");
    }
}

module north_arrow(x, y, size=1200) {
    color("black") {
        translate([x, y]) polygon(points=[
            [0, size],
            [size * 0.35, 0],
            [0, size * 0.2],
            [-size * 0.35, 0]
        ]);
        translate([0, size + 150])
            text("N", size=label_size, halign="center", valign="bottom");
    }
}

projection(cut = false)
union() {
    color("black")
        outline_rect(lot_width, lot_depth);

    if (show_labels) {
        color("black")
            translate([lot_width / 2, lot_depth / 2])
                text("SITE", size=800, halign="center", valign="center");
    }

    dimension_h(0, lot_width, -700, "25.75m");
    dimension_v(-700, 0, lot_depth, "8.90m");

    north_arrow(lot_width + margin - 200, lot_depth - 1000);
}
