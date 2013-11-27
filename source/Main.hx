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
	    var drawervalues : Array<Float> = [.01,.05,.10,.25,1,5,10,20];
                var drawerX : Array<Float> = [100,200,300,400,100,200,300,400];
                var drawerY : Array<Float> = [600,600,600,600,500,500,500,500];
		
		// Display some text
		var titleText = new MyText(140, 50, 40, 0xffffff, 'Busy Barista');
		trace('Debug Info: Stage Width = ' + stage.stageWidth);

		var testing = new CashDrawer();

	}

	static function onEnterFrame() {
		// game loop
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

