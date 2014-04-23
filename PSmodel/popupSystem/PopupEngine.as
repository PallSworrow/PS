package PS.PSmodel.popupSystem 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import PSmodel.Engine;
	
	/**
	 * ...
	 * @author 
	 */
	
	internal class PopupEngine
	{
		
		internal static function addPopup(pp:Popup):void
		{
			if (Engine.popupContainer) 
			{
				trace('showing popup');
				Engine.popupContainer.addChild(pp.item);
				pp.dispatchEvent(new PopupEvent(PopupEvent.ON_SHOWN));
			}
		}
		internal static function closePopup(pp:Popup):void
		{
			if (Engine.popupContainer) 
			{
				Engine.popupContainer.removeChild(pp.item);
				pp.dispatchEvent(new PopupEvent(PopupEvent.ON_CLOSE));
			}
			
		}
		
	}

}