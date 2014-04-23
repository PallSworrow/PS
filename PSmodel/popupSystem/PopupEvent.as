package PS.PSmodel.popupSystem 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class PopupEvent extends Event
	{
		public static const ON_SHOWN:String = 'onshown';
		public static const ON_CLOSE:String = 'onclose';
		public static const ON_TAP:String = 'ontap';
		
		public function PopupEvent(type:String) 
		{
			super(type);
		}
		
		
		
	}

}