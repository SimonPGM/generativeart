let r1 = 10;
let t1 = 0;
let c1 = 20;
let r2 = 10;
let t2 = 0;
let c2 = 20;

function setup() {
    createCanvas(500, 500, WEBGL);
    background(0);
}

function draw() {
    push();
    
    let x1 = r1 + c1*cos(t1);
    let y1 = r1 + c1*sin(t1);
    
    let x2 = r2 + c2*cos(t2);
    let y2 = r2 + c2*sin(t2);

    
    fill(255, 17, 0);
    ellipse(x1, y1, r1/2);
    fill(8, 0, 255);
    ellipse(x2, y2, r2/2);
    
    t1 += 0.1;
    t2 -= 0.1;
    c1 += 0.2;
    c2 += 0.2;
    pop();
}
