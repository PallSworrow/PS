package PS.PSmodel
{
	import Antares.BasicFunctional;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Antares.BasicFunctional;
	
	/**
	 * ...
	 * @author
	 */
	public class Engine extends EventDispatcher
	{
		private var clip:Sprite;
		private static var _inst:Engine;
		private static var _popupContainer:DisplayObjectContainer;
		
		
		
		public function Engine(clip:Sprite, w:int, h:int )
		{
			if(!_inst)
			{
				Globals.init(clip, w, h);
				BasicFunctional.init();
				clip = new Sprite();
				clip.addEventListener(Event.ENTER_FRAME, clip_enterFrame);
				//init all classes from PS-libriary
				_inst = this;
				
			}
			else trace('error - double engine init');
		}
		public static function addPopupContainer(container:DisplayObjectContainer, fog:DisplayObject = null):void
		{
			_popupContainer = container;
			
		}
		
		private function clip_enterFrame(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		static public function get instance():Engine 
		{
			return _inst;
		}
		
		static public function get popupContainer():DisplayObjectContainer 
		{
			return _popupContainer;
		}
		
		
	}

}