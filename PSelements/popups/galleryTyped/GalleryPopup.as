package PS.PSelements.popups.galleryTyped 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.PSelements.popups.galleryTyped.gpb.CarruselItemBehavior;
	import PS.PSmodel.popupSystem.Popup;
	import PS.PSmodel.DelegatedBehaviors.Interfaces.IcarruselItem;
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
		private var box:Sprite;
		/*
		funcs:
			caruselbehavior control
			arrows
			popup methods
		
		*/
		protected var X0:int;
		protected var Y0:int;
		public function GalleryPopup(list:Array, Index:int) 
		{
			arr = list
			index = Index;
			box = new Sprite();
			super(box, { } );
			addItem('center');
			
		}
		
		override protected function onTap(e:Event):void 
		{
			
			super.onTap(e);
			/*if (IPC) 
			{
				IPC.removeEventListener(CarruselItemBehavior.LOWER_LIMIT_EXCEEDED,onItemTweenedLeft);
				IPC.removeEventListener(CarruselItemBehavior.UPPER_LIMIT_EXCEEDED, onItemTweenedRight);
			}
			IPC = null;
			close();*/
		}
		protected function createItem():GalleryPopupItem//MUST OVERRIDE
		{
			return null;
		}
		protected function setBehavior(canLeft:Boolean, canRight:Boolean):GPIbehavior//MUST OVERRIED
		{
			//HARD-CODE!
			return new CarruselItemBehavior(GPI , new Rectangle(0, GPI.y, Globals.stageWidth, 0), 400, true, { banUp: !canRight, banDown: !canLeft } );
		}
		private function addItem(position:String):void//position: left/center/right
		{
			//-------------------CHANGABLE--------------
			X0 = -Globals.stageWidth / 2;
			Y0 = -572;
			//=========================================
			
			GPI = createItem();
			GPI.createContent(arr[index]);
			
			//-------------------CHANGABLE--------------
			GPI.y = 572;
			
			//=========================================
			
			switch(position)
			{
				case 'left':
					GPI.x = 0;
					break;
				case 'center':
					GPI.x = Globals.stageWidth/2;
					break;
				case 'right':
					GPI.x = Globals.stageWidth;
					break;
			}
			var canLeft:Boolean = true;
			var canRight:Boolean = true;
			if (index <= 0) canLeft = false;
			if (index >= arr.length - 1) canRight = false;
			GPI.initBehavior(setBehavior(canLeft, canRight));
			
			
			GPI.addEventListener(GPBevents.ON_PREV,onItemTweenedLeft);
			GPI.addEventListener(GPBevents.ON_NEXT,onItemTweenedRight);
			box.addChild(GPI);
		}
		private function onItemTweenedRight(e:Event):void
		{
			GPI.removeEventListener(GPBevents.ON_PREV,onItemTweenedLeft);
			GPI.removeEventListener(GPBevents.ON_NEXT, onItemTweenedRight);
			index--;
			addItem('left');
		}
		private function onItemTweenedLeft(e:Event):void
		{
			GPI.removeEventListener(GPBevents.ON_PREV,onItemTweenedLeft);
			GPI.removeEventListener(GPBevents.ON_NEXT, onItemTweenedRight);
			index++;
			addItem('right');
		}
		
		
		
	}

}