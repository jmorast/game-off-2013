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
		
		// Put cash in the cash drawer
		var cashbox1 = new MyCash(100,500,1);	
		var cashbox5 = new MyCash(200,500,5);	
		var cashbox10 = new MyCash(300,500,10);	
		var cashbox20 = new MyCash(400,500,20);	
		var cashbox001 = new MyCash(100,600,.01);	
		var cashbox005 = new MyCash(200,600,.05);	
		var cashbox010 = new MyCash(300,600,.10);	
		var cashbox025 = new MyCash(400,600,.25);	
	}

	static function onEnterFrame() {
		// game loop
	}
}

private class CashMove extends Sprite {
	private var gfx:Sprite;
	public var value:Float;
	var kittyY : Float = 650;
	var kittyX : Float = 250;

	public function new(x:Float, y:Float, amount:Float) {
		super();
		
		var img = new Bitmap(Assets.getBitmapData("assets/money-" + amount + ".png"));
		gfx = new Sprite();
		gfx.x = x - (this.gfx.width / 2);
		gfx.y = y - (this.gfx.height / 2);
		value = amount;
		gfx.addChild(img);
		flash.Lib.current.stage.addChild(gfx);
		Actuate.tween (gfx, 1, { x:kittyX, y:kittyY});
		// Actuate.tween (gfx, 1, { x:kittyX, y:kittyY}).onComplete (trace, 'Tween finished');
	}
}

private class MyCash extends Sprite {
	private var gfx:Sprite;
	public var value:Float;
	
	public function new(x:Float, y:Float, amount:Float) {
		super();
		
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
		// Actuate.tween (gfx, 1, { alpha:0.0 });
//		Actuate.tween (gfx, 1, { x:kittyX, y:kittyY});
		var fun = new  CashMove(mouseX, mouseY, value);
		
	}
}


