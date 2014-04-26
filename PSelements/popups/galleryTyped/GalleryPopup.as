package PS.PSelements.popups.galleryTyped 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.PSmodel.popupSystem.Popup;
	import PS.PSmodel.DelegatedBehaviors.Behaviors.CarruselItemBehavior;
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
		private var IPC:GalleryPopupItem;
		private var box:Sprite;
		/*
		funcs:
			caruselbehavior control
			arrows
			popup methods
		
		*/
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
		protected function createContent(data:Object):GalleryPopupItem//MUST OVERRIDE
		{
			return null;
		}
		private function addItem(position:String):void//position: left/center/right
		{
			//!!!-------------------------------------------
			IPC = createContent(arr[index]);
			
			//---------------------------------
			IPC.y = 572;
			trace('L=' + arr.length);
			trace('index: ' + index);
			switch(position)
			{
				case 'left':
					IPC.x = 0;
					break;
				case 'center':
					IPC.x = Globals.stageWidth/2;
					break;
				case 'right':
					IPC.x = Globals.stageWidth;
					break;
			}
			var canLeft:Boolean = true;
			var canRight:Boolean = true;
			if (index <= 0) canLeft = false;
			if (index >= arr.length - 1) canRight = false;
			IPC.initBehavior(canLeft, canRight);
			IPC.addEventListener(CarruselItemBehavior.LOWER_LIMIT_EXCEEDED,onItemTweenedLeft);
			IPC.addEventListener(CarruselItemBehavior.UPPER_LIMIT_EXCEEDED,onItemTweenedRight);
			box.addChild(IPC);
		}
		private function onItemTweenedRight(e:Event):void
		{
			IPC.removeEventListener(CarruselItemBehavior.LOWER_LIMIT_EXCEEDED,onItemTweenedLeft);
			IPC.removeEventListener(CarruselItemBehavior.UPPER_LIMIT_EXCEEDED, onItemTweenedRight);
			index--;
			addItem('left');
		}
		private function onItemTweenedLeft(e:Event):void
		{
			IPC.removeEventListener(CarruselItemBehavior.LOWER_LIMIT_EXCEEDED,onItemTweenedLeft);
			IPC.removeEventListener(CarruselItemBehavior.UPPER_LIMIT_EXCEEDED, onItemTweenedRight);
			index++;
			addItem('right');
		}
		
		
		
	}

}