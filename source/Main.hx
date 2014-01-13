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

    static var AllMoney:Array<CashHandler> = new Array();
	static var gfxCustomer:Sprite;
    static var gfxCountDown:Sprite;
	static var MoneyInKitty:Int=0;
	var CustomerOwes:Int=0;
	var CustomerPaid:Int=0;
	var CustomerNeeds:Int=0;
    static var toPrune:Bool=false;
    public static var playState:String;
        // Play states 
        //   SETUP - compys turn
        //   PLAYER - waiting for player to move
    var TextCustomerPaid:UIText;
    var TextCustomerOwes:UIText;
    var TextCustomerNeeds:UIText;

	public function new () {
		super ();

        // Set Initial Play State
        playState = "SETUP";
        
        // Add UI
        createUI();	

		// Display some text
		trace('Debug Info: Stage Width = ' + stage.stageWidth);

		//var titleText = new UIText(140, 50, 40, 0xff00ff, 'Busy Barista');
		
		//var drawervalues : Array<Float> = [.25,.10,.05,.01,20,10,5,1];
		var drawervalues : Array<Int> = [25,10,5,1,2000,1000,500,100];
        var drawerX : Array<Float> = [40,95,150,205,40,95,150,205];
		var drawerY : Array<Float> = [500,500,500,500,350,350,350,350];

        // Put cash in cashbox drawer
        for ( i in 0...drawervalues.length ) {
                AllMoney.push(new CashHandler(drawerX[i],drawerY[i],drawervalues[i],"CASHDRAWER"));
        }

        TextCustomerPaid = new UIText(30,100,40, 0x5DE627, "");
        TextCustomerOwes = new UIText(30,150,40, 0x5DE627, "");
        TextCustomerNeeds = new UIText(30,200,40, 0x5DE627, "" );
        newCustomer();
 
        playState = "PLAYER";
		flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME,function(_) Main.onEnterFrame());

        var orderTimer:haxe.Timer = new haxe.Timer(100);
        orderTimer.run = function():Void{
           // trace("test" + haxe.Timer.stamp());
           // gfxCountDown.width= gfxCountDown.width - 1;
        }
	}

    public function createUI() {

        // Add countdown clock
        gfxCountDown = new Sprite();
        gfxCountDown.graphics.beginFill(0xff00ff);
        gfxCountDown.graphics.drawRect(0,0,600,100);
        //gfxCountDown.endFill();
        flash.Lib.current.stage.addChild(gfxCountDown);

        var gfxCountDownRect:Sprite = new Sprite();
        gfxCountDownRect.graphics.lineStyle(2,0xFF000000);
        gfxCountDownRect.graphics.drawRect(0,0,600,100);
        flash.Lib.current.stage.addChild(gfxCountDownRect);

		// Add customer image
		trace('Add customer');
        var customerIMG = new Bitmap(Assets.getBitmapData("assets/customer.png"));
        gfxCustomer = new Sprite();
        gfxCustomer.x = 400; 
        gfxCustomer.y = 10;
        gfxCustomer.addChild(customerIMG);
        flash.Lib.current.stage.addChild(gfxCustomer);

		// Add yes button
        var gfxYes:Sprite = new Sprite();
        var yesIMG = new Bitmap(Assets.getBitmapData("assets/yes.png"));
        gfxYes.x = 400; 
        gfxYes.y = 400;
        gfxYes.addChild(yesIMG);
		gfxYes.addEventListener (MouseEvent.MOUSE_DOWN, yes_onMouseDown);
        flash.Lib.current.stage.addChild(gfxYes);

		// Add no button
        var gfxNo:Sprite = new Sprite();
        var noIMG = new Bitmap(Assets.getBitmapData("assets/no.png"));
        gfxNo.x = 400; 
        gfxNo.y = 500;
        gfxNo.addChild(noIMG);
		gfxNo.addEventListener (MouseEvent.MOUSE_DOWN, no_onMouseDown);
        flash.Lib.current.stage.addChild(gfxNo);

    }

    private function no_onMouseDown(event:MouseEvent):Void {
        trace('clicked ClearKitty') ;
		clearKitty("CASHDRAWER");
    } 

    private function yes_onMouseDown(event:MouseEvent):Void {
        trace('clicked yes check needs vs moneyinkitty' ) ;
		trace('Kitty: ' + MoneyInKitty);
		trace('Customer Needs: ' + CustomerNeeds);
		if (MoneyInKitty == CustomerNeeds) {
			trace('Congrats you did it!');
            playState = "SETUP";
            clearKitty('CUSTOMER');
            newCustomer();
            playState = 'PLAYER';
     
		} else {
			trace('oops not quite');
			//clearKitty();
		}
		
      } 

    function newCustomer():Void {
        CustomerOwes = Std.random(1000) ;
        trace("New customer owes: " + CustomerOwes);
        CustomerPaid = 1000;
        CustomerNeeds = CustomerPaid - CustomerOwes;
        TextCustomerPaid.updateText("Customer Paid: $10.00");
        TextCustomerOwes.updateText( "Customer Owes: $" + getDollars(CustomerOwes) + "." + getCents(CustomerOwes));
        TextCustomerNeeds.updateText( "Customer Needs: $" + getDollars(CustomerNeeds) + "." + getCents(CustomerNeeds));
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

	function clearKitty(target:String) {
        for (i in 0...AllMoney.length ) {
			if (AllMoney[i].gameloc == 'KITTY') {
				//trace(AllMoney[i].value);
                //MoneyInKitty =- AllMoney[i].value;
                if (target == "CASHDRAWER") {
                    if (AllMoney[i].value > 0) {
                        AllMoney[i].moveAndDelete(AllMoney[i].initX,AllMoney[i].initY);
                    }
                } else {
                    if (AllMoney[i].value > 0) {
                        AllMoney[i].moveAndDelete(gfxCustomer.x,gfxCustomer.y);
                    }
                }
			}
            trace('Loc - ' + AllMoney[i].gameloc + ' val: ' + AllMoney[i].value);
            MoneyInKitty=0;
		}    
	}

    public static function delete_pruned() {
        for ( item in AllMoney ) {
            if ( item.pruneMe ) {
                AllMoney.remove(item);
            }
        }
    }

	static function onEnterFrame() {

        // prune out old items
        delete_pruned();

        if ( playState == "PLAYER") {
            // Handle clicks on CashDrawer or Kitty cash
            for ( i in 0...AllMoney.length ){
                if (AllMoney[i].clicked) {
                    AllMoney[i].clicked = false;
                    if (AllMoney[i].gameloc == "CASHDRAWER") {
                            // Cash drawer was clicked, add money then move it to kitty
                            MoneyInKitty+=AllMoney[i].value;
                            trace("MoneyInKitty: " + MoneyInKitty);
                            AllMoney.push(new CashHandler(AllMoney[i].initX,AllMoney[i].initY,AllMoney[i].value,"KITTY"));
                    } else {
                            // Kitty item was clicked, remove money from kitty
                            MoneyInKitty-=AllMoney[i].value;
                            //trace("Kitty value clicked: " + AllMoney[i].value);
                            //trace("MoneyInKitty: " + MoneyInKitty);
                    }
                }
            }
        }
    }
}

