package;

import flash.display.Sprite;
import openfl.Assets;
import flash.events.Event;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import motion.Actuate;

class CashDrawer extends Sprite {
	
	public function new () {
		super ();
		var drawervalues : Array<Float> = [.01,.05,.10,.25,1,5,10,20];
		var drawerX : Array<Float> = [100,200,300,400,100,200,300,400];
 		var drawerY : Array<Float> = [600,600,600,600,500,500,500,500];

		// Put cash in cashbox drawer	
		for ( i in 0...drawervalues.length ) {
			var cashbox = new MyCash(drawerX[i],drawerY[i],drawervalues[i]);
		}
	}

	static function onEnterFrame() {
		// game loop
	}
	
	public function returnvalue(value:Float) {
		trace('value is here? ' + value + ' is this right ');
		
	}
}

private class CashMove extends Sprite {
	private var gfx:Sprite;
	public var value:Float;
	public var initX:Float;
	public var initY:Float;

	public function new(fromX:Float, fromY:Float, toX:Float, toY:Float, amount:Float) {
		super();
		
		var img = new Bitmap(Assets.getBitmapData("assets/money-" + amount + ".png"));
		gfx = new Sprite();
		gfx.x = fromX - (this.gfx.width / 2);
		gfx.y = fromY - (this.gfx.height / 2);
		initX = gfx.x;
		initY = gfx.y;
		value = amount;
		gfx.addChild(img);
		flash.Lib.current.stage.addChild(gfx);
		Actuate.tween (gfx, 1, { x:toX, y:toY}).onComplete (inKitty);
	}

	private function inKitty():Void {
		trace('In Kitty:');
		gfx.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
	}
	private function inHand():Void {
		trace('In Hand:');
		Actuate.tween (gfx, .1, { alpha:1 }).onComplete (removegfx);
	}

	function removegfx():Void {
		flash.Lib.current.stage.removeChild(gfx);
	}
	
	private function this_onMouseDown(event:MouseEvent):Void {
//		trace('value is here? ' + value + ' is this right ' + Lambda.indexOf(drawervalues,value));
		trace('what variables do we have' + value);
		gfx.removeEventListener(MouseEvent.MOUSE_DOWN, this_onMouseDown);
		Actuate.tween (gfx, 1, { x:initX, y:initY}).onComplete (inHand);
	}
}

private class MyCash extends Sprite {
	private var gfx:Sprite;
	public var value:Float;
	public var initX:Float;
	public var initY:Float;
	public var kittyY : Float = 650;
	public var kittyX : Float = 250;
	
	public function new(x:Float, y:Float, amount:Float) {
		super();
		initX = x;
		initY = y;
		
		var img = new Bitmap(Assets.getBitmapData("assets/money-" + amount + ".png"));
		gfx = new Sprite();
		gfx.x = x - (this.gfx.width / 2);
		gfx.y = y - (this.gfx.height / 2);
		value = amount;
		gfx.addChild(img);
		gfx.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
		flash.Lib.current.stage.addChild(gfx);
	}

	private function this_onMouseDown(event:MouseEvent):Void {
		// this might be cool later Actuate.tween (this, 0.4);
		trace('Mouse Down:' + mouseX + ' : ' + mouseY + ' VALUE: ' + value);
		trace('Mouse Down:' + initX + ' : ' + initY + ' VALUE: ' + value);
		var fun = new  CashMove(initX,initY,kittyX,kittyY, value);
	}
}


