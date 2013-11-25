package;

import flash.display.Sprite;
import openfl.Assets;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Bitmap;

import flash.events.MouseEvent;

class Main extends Sprite {
	
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
		
		// Display some text
		var titleText = new MyText(140, 50, 40, 0xffffff, 'Busy Barista');
		trace('Debug Info: Stage Width = ' + stage.stageWidth);

	}

	static function onEnterFrame() {
		// game loop
	}
}

class MyCash extends Sprite {
	private var gfx:Sprite;
	public var value:Float;
	private var dragOffsetX:Float;
	private var dragOffsetY:Float;
	
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

	private function stage_onMouseMove (event:MouseEvent):Void {
		// this might be cool later Actuate.tween (this, 0.4);
		trace('Mouse Drag');
		var targetX = mouseX + dragOffsetX;
		var targetY = mouseY + dragOffsetY;
		gfx.x = gfx.x + (targetX - gfx.x) * 0.5;
		gfx.y = gfx.y + (targetY - gfx.y) * 0.5;
	}

	private function stage_onMouseUp (event:MouseEvent):Void {
		trace('Mouse Up');
		gfx.removeEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		gfx.removeEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
	}
	
	private function this_onMouseDown(event:MouseEvent):Void {
		// this might be cool later Actuate.tween (this, 0.4);
		trace('Mouse Down:' + mouseX + ' : ' + mouseY + ' VALUE: ' + value);
		gfx.addEventListener (MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		gfx.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		dragOffsetX = gfx.x - mouseX;
		dragOffsetY = gfx.y - mouseY;
		
	}
}

class MyText {
	public var textObj:TextField;

	public function new(x:Int, y:Int, size:Int, color:Int, text:String) {
		this.textObj = new TextField();
		this.textObj.x = x;
		this.textObj.y = y;
		var font = Assets.getFont("assets/EHSMB.TTF");
		this.textObj.defaultTextFormat =  new TextFormat(font.fontName, size, color);
		this.textObj.embedFonts = true; 
		this.textObj.text = text;
		this.textObj.width = 640;
		flash.Lib.current.addChild(this.textObj);
	}

	public function updateText(text:String) {
		this.textObj.text = text;
	}

	public function hideText() {
		flash.Lib.current.removeChild(this.textObj);
	}
	public function showText() {
		flash.Lib.current.addChild(this.textObj);
	}

}

