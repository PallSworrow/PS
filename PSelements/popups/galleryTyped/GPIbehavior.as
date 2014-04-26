package PS.PSelements.popups.galleryTyped 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class GPIbehavior extends EventDispatcher 
	{
		protected var obj:Sprite
		public function GPIbehavior(item:Sprite) 
		{
			obj = item;
		}
		protected function onGoNextStart():void
		{
			dispatchEvent(new Event(GPBevents.ON_NEXT));
		}
		protected function onGoNextComplete():void
		{
			dispatchEvent(new Event(GPBevents.ON_NEXT_COMPLETE));
		}
		
		protected function onGoPrevStart():void
		{
			dispatchEvent(new Event(GPBevents.ON_PREV));
		}
		protected function onGoPrevComplete():void
		{
			dispatchEvent(new Event(GPBevents.ON_PREV_COMPLETE));
		}
		protected function onGoOut():void
		{
			dispatchEvent(new Event(GPBevents.ON_OUT));
		}
		
		public function disable():void
		{
			
		}
		
		
		
		
	}

}