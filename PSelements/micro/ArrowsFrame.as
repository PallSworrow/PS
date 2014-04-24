package PS.PSelements.micro 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import PS.PSelements.Switcher.SwitchButton;
	
	/**
	 * ...
	 * @author 
	 */
	public class ArrowsFrame extends Sprite 
	{
		public static const ON_CLICK:String = 'onclick';
		public static const ARROW_LEFT:String = 'arrowleft';
		public static const ARROW_RIGHT:String = 'arrowright';
		public static const ARROW_UP:String = 'arrowup';
		public static const ARROW_DOWN:String = 'arrowdown';
		private var obj:DisplayObject;
		public function ArrowsFrame(item:DisplayObject, texture:DisplayObject, offset:int=0,horizontal:Boolean = true) 
		{
			super();
			obj = item;
			x = obj.x;
			y = obj.y;
			addArrows(texture, offset, horizontal);
		}
		private var _arrowRight:SwitchButton;
		private	var _arrowLeft:SwitchButton;
		private var _arrowUp:SwitchButton;
		private	var _arrowDown:SwitchButton;
		
		private function addArrows(arrowTexture:DisplayObject, offset:int=0,horizontal:Boolean = true ):void
		{
			var bmData:BitmapData;
			
			
			bmData = new BitmapData(arrowTexture.width, arrowTexture.height,true,0);
			bmData.draw(arrowTexture);
			
			//left:
			_arrowLeft = new SwitchButton(new Bitmap(bmData));
			_arrowLeft.addHandler(onLeft);
			
			_arrowLeft.rotation = 180;
			_arrowLeft.x = -offset;
			_arrowLeft.y = (obj.height + _arrowLeft.height) / 2;
			//right:
			_arrowRight = new SwitchButton(new Bitmap(bmData));
			_arrowRight.addHandler(onRight);
			_arrowRight.x = obj.width + offset;
			_arrowRight.y = (obj.height - _arrowRight.height) / 2;
			
			//up:
			_arrowUp = new SwitchButton(new Bitmap(bmData));
			_arrowUp.addHandler(onUp);
			_arrowUp.rotation = 180;
			_arrowUp.x = (obj.width +_arrowUp.width)/2;
			_arrowUp.y =  - offset;
			
			//down:
			_arrowDown = new SwitchButton(new Bitmap(bmData));
			_arrowDown.addHandler(onDown);
			_arrowDown.x = (obj.width -_arrowDown.width)/2;
			_arrowDown.y = obj.height + offset;
			
			
			
			
			if (horizontal)
			{
				addChild(_arrowLeft);
				addChild(_arrowRight);
			}
			else
			{
				addChild(_arrowDown);
				addChild(_arrowUp);
			}
		}
		
		private function onDown():void 
		{
			dispatchEvent(new Event(ARROW_DOWN));
		}
		
		private function onUp():void 
		{
			dispatchEvent(new Event(ARROW_UP));
		}
		
		private function onLeft():void 
		{
			dispatchEvent(new Event(ARROW_LEFT));
		}
		private function onRight():void 
		{
			dispatchEvent(new Event(ARROW_RIGHT));
		}
		
		public function get arrowRight():Boolean 
		{
			return _arrowRight.visible;
		}
		
		public function get arrowLeft():Boolean 
		{
			return _arrowLeft.visible;
		}
		public function set arrowRight(val:Boolean):void 
		{
			_arrowRight.visible=val;
		}
		
		public function set arrowLeft(val:Boolean):void 
		{
			_arrowLeft.visible=val;
		}
		
		public function get arrowUp():Boolean 
		{
			return _arrowUp.visible;
		}
		
		public function get arrowDown():Boolean 
		{
			return _arrowDown.visible;
		}
		public function set arrowUp(val:Boolean):void 
		{
			_arrowUp.visible=val;
		}
		
		public function set arrowDown(val:Boolean):void 
		{
			_arrowDown.visible=val;
		}
		
		
		
		
		
		public function set leftArrowAlpha(val:Number):void
		{
			_arrowLeft.alpha = val;
		}
		public function set rightArrowAlpha(val:Number):void
		{
			_arrowRight.alpha = val;
		}
		
	}

}