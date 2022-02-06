let a = 80;
let b = 64;
let t = 0;


function setup() {
  createCanvas(500, 500, WEBGL);
  background(0);
}

function draw() {
  
  push();
  
  
  let x = (a + b)*cos(t) - b*cos((a/b + 1)*t);
  let y = (a + b)*sin(t) - b*sin((a/b + 1)*t);

  let redchannel = random(0, 255);
  let greenchannel = random(0, 255);
  let bluechannel = random(0, 255);
  
  fill(redchannel, greenchannel, bluechannel);
  ellipse(x, y, 5)

  t += 0.1;

  pop();
  
}