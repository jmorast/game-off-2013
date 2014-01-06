package ;

import flash.display.Sprite;
import motion.Actuate;
import openfl.Assets;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Bitmap;

import flash.events.MouseEvent;

class CashHandler extends Sprite {
        private var gfx:Sprite;
        public var value:Int;
        public var gameloc:String;
        public var initX:Float;
        public var initY:Float;
        public var kittyY : Float = 600;
        public var kittyX : Float = 250;
	public var clicked:Bool = false;

	public function new(x:Float, y:Float, amount:Int, location:String) {
                super();
                var img = new Bitmap(Assets.getBitmapData("assets/money-" + (amount/100) + ".png"));
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
                //trace('In Kitty:' + this.value);
                gfx.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
        }

        private function this_onMouseDown(event:MouseEvent):Void {
                //trace('Mouse Down:' + this.initX + ' : ' + this.initY + ' VALUE: ' + this.value);
		clicked=true;
		if (gameloc == 'KITTY') {
                	Actuate.tween (gfx, 1, { x:this.initX, y:this.initY}).onComplete (inHand);
		}
        }

	private function inHand():Void {
                //trace('In Hand:' + this.value);
                Actuate.tween (gfx, .1, { alpha:1 }).onComplete (removegfx);
        }

        function removegfx():Void {
		//trace('Remove ' + value);
                flash.Lib.current.stage.removeChild(gfx);
        }
}

