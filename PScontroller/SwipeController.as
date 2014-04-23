package PS.PScontroller 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	//import flash.events.GestureEvent;
	import org.gestouch.core.GestureState;
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.PanGesture;
	import org.gestouch.gestures.SwipeGesture;
	import org.gestouch.gestures.SwipeGestureDirection;
	
	/**
	 * ...
	 * @author 
	 */
	public class SwipeController extends Controller 
	{
		//EVENTS:
		public static const SWIPE_LEFT:String = 'swipeleft';
		public static const SWIPE_RIGHT:String = 'swiperight';
		
		
		//=============================================================
		public function SwipeController(_item:InteractiveObject) 
		{
			super(_item);
			
		}
		protected var leftGessture:PanGesture;
		protected var rightGessture:PanGesture;
		/*protected var leftGessture:SwipeGesture;
		protected var leftGessture:SwipeGesture;*/ //further work with directions

		
		
		override protected function enable():void 
		{
			leftGessture = new PanGesture(item);
			rightGessture = new PanGesture(item);
			
			
			
			leftGessture.direction = SwipeGestureDirection.LEFT;
			leftGessture.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipeLeft);
			
			rightGessture.direction = SwipeGestureDirection.RIGHT;
			rightGessture.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipeRight);
			
		}
		
		private function onSwipeRight(e:GestureEvent):void 
		{
			/*trace('swiperight');
			if (canI('GT'))
			{
			/*	
				resetListenerType();
				dispatchEvent(new Event(SWIPE_RIGHT));
			}*/
			
		}
		
		private function onSwipeLeft(e:GestureEvent):void 
		{
			//trace('swipeleft ' + leftGessture.state);
			/*/trace(leftGessture.direction);
			
			if (canI('GT'))
			{
				/*dispatchEvent(new Event(SWIPE_LEFT));
				resetListenerType();
				*/
				//
				//
			//}
		}
		
		
		
		
		//-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=
		override protected function disable():void 
		{
			super.disable();
		}
	}

}