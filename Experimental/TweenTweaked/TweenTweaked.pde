
var nexttween;

void setup() {
  size(600, 600);
	position = {x: 100, y: 100, rotation: 0};
	target = document.getElementById('target');
	tween = new TWEEN.Tween(position)
		.to({x: 300, y: 200, rotation: 359}, 2000)
		.delay(1000)
		.easing(TWEEN.Easing.Elastic.InOut)
		.onUpdate(update);
		
	tweenBack = new TWEEN.Tween(position)
		.to({x: 100, y: 100, rotation: 0}, 3000)
		.easing(TWEEN.Easing.Elastic.InOut)
		.onUpdate(update);


nexttween = tween;
		
	tween.chain(tweenBack);
	tweenBack.chain(nexttween);

	tween.start();
}

void draw() {
fill(244,100);
rect(0,0,width,height);

TWEEN.update();
drawSprite();

}

void mousePressed() {
	tweenck = new TWEEN.Tween(position)
		.to({x: 50, y: 300, rotation: 0}, 3000)
		.easing(TWEEN.Easing.Elastic.InOut)
		.onUpdate(update);
	nexttween = tweenck;
	
	
}

int spriteX = 10;
int spriteY = 10;

PImage bub = loadImage("./img/bub.png");


function update() {
	spriteX = position.x;
	spriteY = position.y;
	// target.style.webkitTransform = 'rotate(' + Math.floor(position.rotation) + 'deg)';
	// target.style.MozTransform = 'rotate(' + Math.floor(position.rotation) + 'deg)';
}

void drawSprite(){
	fill(255,0,255);
	image(bub,spriteX,spriteY);
}