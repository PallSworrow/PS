package PS.PScontroller 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.utils.setTimeout;
	import PS.PSmodel.Globals;
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
			
			
			
			item.addEventListener(TouchEvent.TOUCH_BEGIN, TE_touchBegin);
			
			
		}
		
		private var startX:int;
		private var startY:int;
		private var gesFailed:Boolean;
		
		private static const SwipeTimeRestriction:int = 60;
		private static const SwipeMinDist:int = 40;
		private function TE_touchBegin(e:TouchEvent):void 
		{
			if (!canI('TE')) return;
			gesFailed = false;
			startX = e.stageX;
			startY = e.stageY;
			setTimeout(TE_failSwipe, SwipeTimeRestriction);
			Globals.mainClip.addEventListener(TouchEvent.TOUCH_END, TE_touchEnd);
		}
		private function TE_failSwipe():void
		{
			gesFailed = true;
			//trace('SWIPE FAILED');
			resetListenerType();
		}
		private function TE_touchEnd(e:TouchEvent):void 
		{
			
			Globals.mainClip.removeEventListener(TouchEvent.TOUCH_END, TE_touchEnd);
			if (gesFailed) return;
			
			//trace('SWIPE');
			//trace(e.stageX - startX);
			if (e.stageX > startX + SwipeMinDist) dispatchEvent(new Event(SWIPE_RIGHT));
			if (e.stageX < startX - SwipeMinDist) dispatchEvent(new Event(SWIPE_LEFT));
			resetListenerType();
		}
		
		private function onSwipeRight(e:GestureEvent):void 
		{
		//	trace('swiperight');
			if (canI('GT'))
			{
				
				resetListenerType();
				dispatchEvent(new Event(SWIPE_RIGHT));
			}
			
		}
		
		private function onSwipeLeft(e:GestureEvent):void 
		{
			//trace('swipeleft ');
			
			if (canI('GT'))
			{
				dispatchEvent(new Event(SWIPE_LEFT));
				resetListenerType();
				
			}
		}
		
		
		
		
		//-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=
		override protected function disable():void 
		{
			super.disable();
		}
	}

}