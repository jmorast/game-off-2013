package ;

import flash.display.Sprite;
import motion.Actuate;
import openfl.Assets;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Bitmap;
import flash.events.MouseEvent;
//import MyCash;

class Main extends Sprite {
	static var AllMoney:Array<CashHandler> = new Array();
	static var MoneyInKitty:Int=0;
	var CustomerOwes:Int=0;
	var CustomerPaid:Int=0;
	public function new () {
		super ();
		
		// Display some text
		var titleText = new UIText(140, 50, 40, 0xff00ff, 'Busy Barista');
		trace('Debug Info: Stage Width = ' + stage.stageWidth);

//		var drawervalues : Array<Float> = [.25,.10,.05,.01,20,10,5,1];
		var drawervalues : Array<Int> = [25,10,5,1,2000,1000,500,100];
		var drawerX : Array<Float> = [100,200,300,400,100,200,300,400];
		var drawerY : Array<Float> = [500,500,500,500,350,350,350,350];

		// Put cash in cashbox drawer
                for ( i in 0...drawervalues.length ) {
	                AllMoney.push(new CashHandler(drawerX[i],drawerY[i],drawervalues[i],"CASHDRAWER"));
                }

		// Add a customer
		CustomerOwes = Std.random(1000) ;
		trace("Cust Owes: " + CustomerOwes);
		var TextCustomerOwes = new UIText(70,150,40, 0xff00ff, "Customer Owes: $" + getDollars(CustomerOwes) + "." + getCents(CustomerOwes) );
		CustomerPaid = 1000;
		var TextCustomerPaid = new UIText(70,100,40, 0xff00ff, "Customer Paid: $" + CustomerPaid/100);
		
		flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME,function(_) Main.onEnterFrame());

	}
	public function getDollars(cashIn:Int):String {
		if (cashIn > 100) {
			return Std.string(cashIn).substr(0,1);
		} else {
			return "0";
		}
	}

	function getCents(centsIn:Int):String {
		if (centsIn > 100) {
			return Std.string(centsIn).substr(1,2);
		} else {
			return Std.string(centsIn);
		}
	}

	static function onEnterFrame() {
		// game loop	
		// Deal with money
		for ( i in 0...AllMoney.length ){
			if (AllMoney[i].clicked) {
				AllMoney[i].clicked = false;
				if (AllMoney[i].gameloc == "CASHDRAWER") {
					// add money and move it to kitty
					MoneyInKitty+=AllMoney[i].value;
					trace("MoneyInKitty: " + MoneyInKitty);
					AllMoney.push(new CashHandler(AllMoney[i].initX,AllMoney[i].initY,AllMoney[i].value,"KITTY"));
				} else {
					trace("Kitty value clicked: " + AllMoney[i].value);
					MoneyInKitty-=AllMoney[i].value;
					trace("MoneyInKitty: " + MoneyInKitty);
				}
			}
		}
	}
}

