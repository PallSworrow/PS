package PS.PSelements.popups.galleryTyped 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.PSelements.micro.ArrowsFrame;
	import PS.PSelements.popups.galleryTyped.gpb.CarruselItemBehavior;
	import PS.PSmodel.popupSystem.Popup;
	import PS.PSmodel.Globals;
	
	/**
	 * ...
	 * @author 
	 */
	public class GalleryPopup extends Popup
	{
		private var arr:Array;
		private var index:int;
		protected var GPI:GalleryPopupItem;
		protected var box:Sprite;
		/*
		funcs:
			caruselbehavior control
			arrows
			popup methods
		
		*/
		protected var X0:int;
		protected var Y0:int;
		protected var CenterX:int;
		protected var CenterY:int;
		protected var arrows:ArrowsFrame;
		public function GalleryPopup(list:Array, Index:int) 
		{
			CenterX = Globals.stageWidth/2;
			items = new Array();
			//-------------------CHANGABLE--------------
			X0 = -Globals.stageWidth / 2;
			Y0 = -572;
			//=========================================
			
			
			arr = list
			index = Index;
			box = new Sprite();
			
			super(box, { } );
			arrows = addArrows();
			step(0);
			
			initArrows();
			
		}
		
		
		override public function close():void 
		{
			GPI.removeEventListener(GPIevent.ON_BACK,scrollForward);
			GPI.removeEventListener(GPIevent.ON_FORWARD, scrollBack);
			GPI = null;
			super.close();
		}
		protected function createItem():GalleryPopupItem//MUST OVERRIDE
		{
			return null;
		}
		
		
		
		
	//DRAG BEHAVIOR:
		protected function setBehavior():IGalleryItemBehavior//MUST OVERRIDE
		{
			return null;
		}
		
		private var items:Array;///pull
		
		//BAD CODE HERE: !!!
		private function step(from:int):void//position: -1/0/1
		{
			//save current:
			if (GPI) //if this is not fist creation
			{
				items[index] = GPI;
				GPI.control = false;
				//disable behavior?
				GPI.removeEventListener(GPIevent.ON_BACK,scrollForward);
				GPI.removeEventListener(GPIevent.ON_FORWARD,scrollBack);
			}
			
			
			
			// search new in pull:
			index += from;
			if (items[index]) //exists
			{
				GPI = items[index]
			}
			else // should create a new one
			{
				
				
				GPI = createItem();
				
				
			}
		/*	trace('STEP');
			trace('left: ' + canLeft);
			trace('right: ' + canRight);*/
			GPI.control = true;
			GPI.initBehavior(setBehavior(),from,canRight,canLeft);
			GPI.addEventListener(GPIevent.ON_BACK,scrollForward);
			GPI.addEventListener(GPIevent.ON_FORWARD,scrollBack);
			GPI.createContent(arr[index]);
			
			
			
			box.addChild(GPI);
			checArrows();
		}
		
		
		//======================================================
		private function scrollBack(e:Event):void
		{
			GPI.removeEventListener(GPIevent.ON_BACK,scrollForward);
			GPI.removeEventListener(GPIevent.ON_FORWARD, scrollBack);
			step(-1);
		}
		private function scrollForward(e:Event):void
		{
			GPI.removeEventListener(GPIevent.ON_BACK,scrollForward);
			GPI.removeEventListener(GPIevent.ON_FORWARD, scrollBack);
			step(1);
		}
		//Gettets:----------------------
		protected function get canLeft():Boolean
		{
			
			if (index <= 0) return false;
			else return true;
		}
		protected function get canRight():Boolean
		{
			if (index >= arr.length - 1) return false;
			else return true;
		}
	//=======================================================================
	
	///BAD CODE:
		protected function addArrows():ArrowsFrame
		{
			return null;
		}
		private function initArrows():void
		{
			if (arrows) {
				
				arrows.addEventListener(ArrowsFrame.ON_CLICK, onArrow);
				checArrows();
				box.addChild(arrows); 
			}
		}
		private function checArrows():void
		{
			arrows.arrowLeft = canLeft;
			arrows.arrowRight = canRight;
		}
		private function onArrow(e:Event):void 
		{
			if (arrows.lastDirection == 'left' || arrows.lastDirection == 'down') index--;
			else index ++ ;
			step(0);
			GPI.createContent(arr[index]);
			checArrows();
		}
	}

}