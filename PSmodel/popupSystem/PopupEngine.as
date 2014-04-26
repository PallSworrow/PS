package PS.PSmodel.popupSystem 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import PS.PSmodel.Engine;
	
	/**
	 * ...
	 * @author 
	 */
	
	internal class PopupEngine
	{
		private static var isFree:Boolean = true;
		internal static function addPopup(pp:Popup):void
		{
			if (Engine.popupContainer && isFree) 
			{
				isFree = false;
				trace('showing popup');
				Engine.popupContainer.addChild(pp.item);
				pp.dispatchEvent(new PopupEvent(PopupEvent.ON_SHOWN));
				
			}
		}
		internal static function closePopup(pp:Popup):void
		{
			if (Engine.popupContainer) 
			{
				isFree = true;
				Engine.popupContainer.removeChild(pp.item);
				pp.dispatchEvent(new PopupEvent(PopupEvent.ON_CLOSE));
			}
			
		}
		
	}

}