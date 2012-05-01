
int targetStack = [];
int currentStack = [];

int foodTypes = [0,1,2,3,4,5];
var foodDescriptions = ["bottom bun","meat","cheese","tomato","lettuce","top bun"];



void setup(){
    size(400,400);    
    generateStack();
    
}
void mouseClicked() {
    println("----------------------");
    totalSlices = 0;
    targetStack = [];
    
    generateStack();

}


void draw(){
    
    
}

void generateStack(){
    int totalSlices = ceil(random(0,5));
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
    
    for (var i = targetStack.length - 1; i >= 0; i--){
        println(foodDescriptions[targetStack[i]]);
    }
    console.log(targetStack);
}