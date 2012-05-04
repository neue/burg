/*
  @pjs preload="./img/but_beef_b.png,./img/but_beef_d.png,./img/but_bun_b.png,./img/but_bun_d.png,./img/but_cheese_b.png,./img/but_cheese_d.png,./img/but_lettuce_b.png,./img/but_lettuce_d.png,./img/but_tomato_b.png,./img/but_tomato_d.png,./img/food_beef.png,./img/food_bun_bottom.png,./img/food_bun_top.png,./img/food_cheese.png,./img/food_lettuce.png,./img/food_tomato.png,./img/sidebar.png,./img/wood.png,./img/wall.png,./img/but_test.png";
       crisp="true";
*/

// Food
PImage food_bun_bottom,food_bun_top,food_beef,food_tomato,food_lettuce,food_cheese;

food_bun_bottom = loadImage("./img/food_bun_bottom.png");
food_bun_top    = loadImage("./img/food_bun_top.png");
food_beef       = loadImage("./img/food_beef.png");
food_tomato     = loadImage("./img/food_tomato.png");
food_lettuce    = loadImage("./img/food_lettuce.png");
food_cheese     = loadImage("./img/food_cheese.png");

slices = [];
int sliceNumber;

// Buttons
PImage but_beef_b,but_beef_d,but_bun_b,but_bun_d,but_cheese_b,but_cheese_d,but_lettuce_b,but_lettuce_d,but_tomato_b,but_tomato_d;

but_beef_b	  = loadImage("./img/but_beef_b.png");
but_beef_d    = loadImage("./img/but_beef_d.png");
but_bun_b	  = loadImage("./img/but_bun_b.png");
but_bun_d 	  = loadImage("./img/but_bun_d.png");
but_cheese_b  = loadImage("./img/but_cheese_b.png");
but_cheese_d  = loadImage("./img/but_cheese_d.png");
but_lettuce_b = loadImage("./img/but_lettuce_b.png");
but_lettuce_d = loadImage("./img/but_lettuce_d.png");
but_tomato_b  = loadImage("./img/but_tomato_b.png");
but_tomato_d  = loadImage("./img/but_tomato_d.png");
but_test	  = loadImage("./img/but_test.png");

// Background
PImage sidebar, wood;
sidebar	= loadImage("./img/sidebar.png");
wood	= loadImage("./img/wood.png");
wall	= loadImage("./img/wall.png");

int penX, penY;
penX = 36;
penY = 450;

boolean mouseRel;

var gameLoop = new GameLoop();
// Hack to set up first run
boolean newStack = true;
// End Hack
boolean allowSlice = true;
boolean stackCorrect = false;



void setup() {
	size(320, 480);
	background(80,90,111);
	image(wall,0,0);
	
	// Setup Sidebar
	buttonMgr		= new SpriteManager();
	
	button_topbun	= new ImgButton(215, 20,  but_bun_b, but_bun_d,drawTopBun);
	button_lettuce	= new ImgButton(215, 103, but_lettuce_b, but_lettuce_d,drawLettuce);
	button_tomato	= new ImgButton(215, 186, but_tomato_b, but_tomato_d,drawTomato);
	button_cheese	= new ImgButton(215, 269, but_cheese_b, but_cheese_d,drawCheese);
	button_beef		= new ImgButton(215, 352, but_beef_b, but_beef_d,drawBeef);

	buttonMgr.add(button_topbun);
	buttonMgr.add(button_lettuce);
	buttonMgr.add(button_tomato);
	buttonMgr.add(button_cheese);
	buttonMgr.add(button_beef);

	button_test		= new ImgButton(0, 0, but_test, but_test,generateStack);
	button_test2	= new ImgButton(0, 35, but_test, but_test,serve);
	buttonMgr.add(button_test);
	buttonMgr.add(button_test2);

	// Setup Food
	sliceMgr		= new SpriteManager();
	// drawBottomBun();

}

void draw(){
	gameLoop.update();
    gameLoop.draw();
}

class GameLoop {
    
    public GameLoop(){}
    
    public void draw(){        
		drawBackground();
		drawForeground();
        // sliceMgr.update();
		mouseRel = false;

    }
    public void update(){
        TWEEN.update();
        if(newStack){
            sliceMgr.clear();
			console.log("Target stack:  "+targetStack);
			console.log("Current Stack: "+currentStack);
			stackCorrect = true;

			if (currentStack.length == targetStack.length){
				for (var i=0; i < currentStack.length; i++) {
					if (currentStack[i] != targetStack[i]) {
						stackCorrect = false;
					}
				}
			} else {
				stackCorrect = false;
			}
			
			console.log("Won?:"+stackCorrect);

            // if (targetStack == currentStack){
            //     background(0,220,0);
            // } else {
            //     background(222,0,0);
            // }
            //currentStack = 0;
            //targetStack = ceil(random(3,10));
            newStack = false;
			targetStack  = [];
			currentStack = [];
			
			generateStack();

			drawBottomBun();	
  
        }
    }
}

void drawBackground(){
	image(wall,0,0);
	image(wood,0,450);	
}

void drawForeground(){
	imageMode(CORNERS);	
	sliceMgr.update();
	image(sidebar,205,10);
	buttonMgr.update();
}

void mousePressed() {
}

void mouseReleased() {
	mouseRel = true;
}

var foodDescriptions = ["bottom bun","meat","cheese","tomato","lettuce","top bun"];


void drawBottomBun(){ addSlice(food_bun_bottom	,0  ,0  ); currentStack.push(0); }
void drawTopBun()	{ addSlice(food_bun_top		,0  ,0  ); currentStack.push(5); }
void drawLettuce()	{ addSlice(food_lettuce		,-5 ,+6 ); currentStack.push(4); }
void drawTomato()	{ addSlice(food_tomato 		,-5 ,+5 ); currentStack.push(3); }
void drawCheese()	{ addSlice(food_cheese 		,-6 ,+7 ); currentStack.push(2); }
void drawBeef()		{ addSlice(food_beef   		,0  ,0  ); currentStack.push(1); }

void addSlice(PImage foodType, int offsetX, int offsetY){
	if (allowSlice) {    
		penY = penY - foodType.height + offsetY;
		slices[sliceNumber] = new FoodSlice(36, -80, penX, penY,foodType,offsetX,0);
		sliceMgr.add(slices[sliceNumber]);
		sliceNumber++;
	}
}


//
// Food Items
//

class FoodSlice {
	var position;
	PImage foodGraphic;
	int offsetX;
	int offsetY;
	
	public FoodSlice(int ix, int iy, int itx, int ity, PImage ifoodGraphic, int ioffsetX, int ioffsetY) {
		position = {x: ix, y: iy};
		this.foodGraphic = ifoodGraphic;
		this.offsetX = ioffsetX;
		this.offsetY = ioffsetY;
		
		tween = new TWEEN.Tween(position)
			.to({x: itx, y: ity}, 800)
			.easing(TWEEN.Easing.Bounce.Out);
		tween.start();
	}
	
	public void update() {
		// tx.tick();
		// ty.tick();
	}

	public void draw() {
		image(foodGraphic,position.x+offsetX,position.y+offsetY);
	}

	public void tweenTo(itx,ity) {
		tween = new TWEEN.Tween(position)
			.to({x: itx, y: ity}, 800)
			.easing(TWEEN.Easing.Sinusoidal.In)
			.onComplete(sliceMgr.clear);
		tween.start();
	}

	public void serveThis() {
		allowSlice = false;
		tween = new TWEEN.Tween(position)
			.to({x: -300, y: position.y}, 500)
			.easing(TWEEN.Easing.Back.In)
			.onComplete(deleteMe);
		tween.start();
	}
	public void deleteMe(){
		// sliceMgr.clear();	
		newStack = true;
		
	}
}

//
//	Buttons
//

class SpriteManager {
	var sprites = [];
	public SpriteManager(){
		sprites = [];
	}
	
	public void add(newSprite){	sprites.push(newSprite); }
	
	public void update(){
		for (var i = sprites.length - 1; i >= 0; i--){			
			sprites[i].update();
			sprites[i].draw();
		}
	}
	public void clear(){
		sprites = [];
		allowSlice = true;
	}
}


class ImgButton {
	int x,y;
	int w,h;
	PImage base;
	PImage down;
	PImage currentimage;
	boolean pressed;
	function buttonFunction;
	
	public ImgButton(int ix, int iy, PImage ibase, PImage idown, function ibuttonFunction){
		this.x = ix;
		this.y = iy;
		this.w = ibase.width;
		this.h = ibase.height;
		this.base = ibase;
		this.down = idown;
		this.currentimage = base;
		this.buttonFunction = ibuttonFunction;
		// console.log("Created button x:"+x+" y:"+y+" w:"+w+" h:"+h);
	}
	
	public void update(){
		if(mouseRel){
			if(mouseX >= x && mouseX <= x+w &&	mouseY >= y && mouseY <= y+h){
				buttonFunction();
				currentimage = down;
			}
		} else {
			currentimage = base;
		}
	}
	public void draw() {
		imageMode(CORNERS);
		image(currentimage, x, y);
	}
}


//
// Stack Control
//

int targetStack = [];
int currentStack = [];

int foodTypes = [0,1,2,3,4,5];
var foodDescriptions = ["bottom bun","meat","cheese","tomato","lettuce","top bun"];

void generateStack(){
    int totalSlices = ceil(random(0,8));
    // add bottom
    targetStack.push(0);
    // add base fill
    if(ceil(random(10)) == 5) {
        targetStack.push(2);
    } else {
        targetStack.push(1);        
    }
    // add fillings 
    for (var i = totalSlices - 1; i >= 0; i--){
        targetStack.push(ceil(random(foodTypes.length-2)));
    }
    targetStack.push(5);
    
	// for (var i=0; i < targetStack.length; i++) {
	// 	switch(targetStack[i]){
	// 	case 0:			
	// 	break;
	// 	case 1:			
	// 		drawBeef();
	// 	break;
	// 	case 2:			
	// 		drawCheese();
	// 	break;
	// 	case 3:			
	// 		drawTomato();
	// 	break;
	// 	case 4:			
	// 		drawLettuce();
	// 	break;
	// 	case 5:			
	// 		drawTopBun();
	// 	break;
	// 		
	// 	}
	//     }
	
	// Stack debug
	console.log("-------------");
	for (var i=0; i < targetStack.length; i++) {
		console.log(foodDescriptions[targetStack[i]]);
	}
    console.log(targetStack);
}

void serve(){
    for (var i = slices.length - 1; i >= 0; i--){
		slices[i].serveThis();
	}
	penY = 450;
	
}