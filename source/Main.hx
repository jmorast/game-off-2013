package ;

import flash.display.Sprite;
import motion.Actuate;
import openfl.Assets;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Bitmap;

import flash.events.MouseEvent;

class Main extends Sprite {
	public function new () {
		super ();
		
		// Display some text
		var titleText = new MyText(140, 50, 40, 0xff00ff, 'Busy Barista');
		trace('Debug Info: Stage Width = ' + stage.stageWidth);

		var drawervalues : Array<Float> = [.01,.05,.10,.25,1,5,10,20];
		var drawerX : Array<Float> = [100,200,300,400,100,200,300,400];
		var drawerY : Array<Float> = [600,600,600,600,450,450,450,450];
		// keep score
		var fun = new KittyHandler();
                
		// Put cash in cashbox drawer
                for ( i in 0...drawervalues.length ) {
	                var cashbox = new MyCash(drawerX[i],drawerY[i],drawervalues[i],"CASHDRAWER");
                }

	}

	public static function kittyMan(operation:String, value:Float) {
		//public var kittyTotal:Float = 0;	
		trace('operation' + operation + ' value: ' + value);
		if (operation == 'ADD') {
			//kittyTotal += value;
			trace('ADD');
		}
	}

	static function onEnterFrame() {
		// game loop
	}

}

class KittyHandler {
	
	public var amountInKitty:Float=0;
	public function new() {
		trace('KittyHandler added');
		amountInKitty=0;
	}
	public function addToKitty(value:Float) {
		trace('add: ' + value);
		amountInKitty += value;
	}
}

private class MyCash extends Sprite {
        private var gfx:Sprite;
        public var value:Float;
        public var gameloc:String;
        public var initX:Float;
        public var initY:Float;
        public var kittyY : Float = 700;
        public var kittyX : Float = 250;

	public function new(x:Float, y:Float, amount:Float, location:String) {
                super();

		//thisdoesnotwork 	fun.addToKitty(this.value);
		//thisworksbutisirrelevent		Main.kittyMan("ADD",value);
                var img = new Bitmap(Assets.getBitmapData("assets/money-" + amount + ".png"));
                gfx = new Sprite();
                gfx.x = x - (this.gfx.width / 2);
                gfx.y = y - (this.gfx.height / 2);
                initX = x;
                initY = y;
                value = amount;
		gameloc = location;	
                gfx.addChild(img);
                gfx.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
                flash.Lib.current.stage.addChild(gfx);
		if ( gameloc == "KITTY") {
                	Actuate.tween (gfx, 1, { x:(kittyX - (gfx.width/2) + (Math.random() * 20)), y:(kittyY - (gfx.height/2) + (Math.random()*20))}).onComplete (inKitty);
		}
        }
        
	private function inKitty():Void {
                trace('In Kitty:' + this.value);
                gfx.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
        }

        private function this_onMouseDown(event:MouseEvent):Void {
                trace('Mouse Down:' + this.initX + ' : ' + this.initY + ' VALUE: ' + this.value);
		if (gameloc == 'CASHDRAWER') {
                	var funk = new MyCash(this.initX,this.initY, this.value, "KITTY");
		} else if (gameloc == 'KITTY') {
                	Actuate.tween (gfx, 1, { x:this.initX, y:this.initY}).onComplete (inHand);
		}
        }
	private function inHand():Void {
                trace('In Hand:' + this.value);
                Actuate.tween (gfx, .1, { alpha:1 }).onComplete (removegfx);
        }
        function removegfx():Void {
		trace('Remove ' + value);
                flash.Lib.current.stage.removeChild(gfx);
        }
}

