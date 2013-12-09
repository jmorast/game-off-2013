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
	static var AllMoney:Array<MyCash> = new Array();
	static var MoneyInKitty:Float=0;
	public function new () {
		super ();
		
		// Display some text
		var titleText = new MyText(140, 50, 40, 0xff00ff, 'Busy Barista');
		trace('Debug Info: Stage Width = ' + stage.stageWidth);

//		var drawervalues : Array<Float> = [.01,.05,.10,.25,1,5,10,20];
		var drawervalues : Array<Float> = [.25,.10,.05,.01,20,10,5,1];
		var drawerX : Array<Float> = [100,200,300,400,100,200,300,400];
		var drawerY : Array<Float> = [500,500,500,500,350,350,350,350];

		// Put cash in cashbox drawer
                for ( i in 0...drawervalues.length ) {
	                AllMoney.push(new MyCash(drawerX[i],drawerY[i],drawervalues[i],"CASHDRAWER"));
                }
		flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME,function(_) Main.onEnterFrame());
	}

	static function onEnterFrame() {
		// game loop	
		for ( i in 0...AllMoney.length ){
			if (AllMoney[i].clicked) {
				AllMoney[i].clicked = false;
				if (AllMoney[i].gameloc == "CASHDRAWER") {
					MoneyInKitty+=AllMoney[i].value;
					//trace("Cash Drawer value clicked: " + AllMoney[i].value + " X:Y " + AllMoney[i].initX + ":" + AllMoney[i].initY);
					// add money and move it to kitty
					trace("MoneyInKitty: " + MoneyInKitty);
					AllMoney.push(new MyCash(AllMoney[i].initX,AllMoney[i].initY,AllMoney[i].value,"KITTY"));
				} else {
					trace("Kitty value clicked: " + AllMoney[i].value);
					MoneyInKitty-=AllMoney[i].value;
					trace("MoneyInKitty: " + MoneyInKitty);
				}
			}
		}
	}
	

}

private class MyCash extends Sprite {
        private var gfx:Sprite;
        public var value:Float;
        public var gameloc:String;
        public var initX:Float;
        public var initY:Float;
        //public var kittyY : Float = 700;
//        public var kittyX : Float = 250;
        public var kittyY : Float = 600;
        public var kittyX : Float = 250;
	public var clicked:Bool = false;

	public function new(x:Float, y:Float, amount:Float, location:String) {
                super();
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
		clicked=true;
		if (gameloc == 'KITTY') {
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

