package ;

import flash.display.Sprite;
import openfl.Assets;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Bitmap;

import flash.events.MouseEvent;

class UIText {
	public var textObj:TextField;

	public function new(x:Int, y:Int, size:Int, color:Int, text:String) {
		trace('text: ' + text);
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

