package PS.PScontroller 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.utils.Timer;
	import PS.PSmodel.Globals;
	/**
	 * ...
	 * @author 
	 */
	public class TapController extends Controller
	{
		//EVENTS:
		public static const ON_PRESS:String = 'onpress';
		public static const ON_RELEASE:String = 'onrelease';
		public static const ON_TAP:String = 'ontap';
		
		//=============================================
		private static const tapAccurancy:int = 10;
		
		
		
		
		
		//listeners flags
		protected var MElistener:Boolean = false;
		protected var TElistener:Boolean = false;
		
		
		
		private var startX:int;
		private var startY:int;
		
		
		
		
		
		public function TapController(_item:InteractiveObject, name:String) 
		{
			super(_item,name);
			
			
		}
		

		
		
		override protected function enable():void
		{
			
			item.addEventListener(TouchEvent.TOUCH_BEGIN, TE_onPress);
			item.addEventListener(MouseEvent.MOUSE_DOWN, ME_onPress);
		}
		
		
		protected var tapFlag:Boolean = false;
	//TOUCH EVENTS-------------------------------------------------------------------
		
		private function TE_onPress(e:TouchEvent):void 
		{
			if (canI('TE') == false) return;
			
			trace(item+' TE ');
			tapFlag  = true;
			_stageX = e.stageX;
			_stageY = e.stageY;
			
			_localX = e.localX;
			_localY = e.localY;
			_targetName = e.target.name;
			
			Globals.mainClip.addEventListener(TouchEvent.TOUCH_END, TE_onRelease);
			Globals.mainClip.addEventListener(TouchEvent.TOUCH_MOVE, TE_move);
			TElistener = true;
			dispatchEvent(new Event(TapController.ON_PRESS));
			
			startX = e.stageX;
			startY = e.stageY;
			
			
			
			
		}
		
		private function TE_move(e:TouchEvent):void 
		{
			if (Math.abs(startX - e.stageX) > tapAccurancy || Math.abs(startY - e.stageY) > tapAccurancy) 
			{
				tapFlag = false;
			}
		}
		
		
		protected function TE_onRelease(e:TouchEvent):void
		{
			Globals.mainClip.removeEventListener(TouchEvent.TOUCH_MOVE, TE_move);
			trace(item+' TE-end');
			_stageX = e.stageX;
			_stageY = e.stageY;
			_target = e.target;
			
			Globals.mainClip.removeEventListener(TouchEvent.TOUCH_END, TE_onRelease);
			TElistener = false;
			resetListenerType(200);
			
			if(tapFlag) dispatchEvent(new Event(TapController.ON_TAP));
			else dispatchEvent(new Event(TapController.ON_RELEASE));
			
			
		}
		
	//============================================================================================================
		
	//MOUSE EVENTS-------------------------------------------------
		
		private function ME_onPress(e:MouseEvent):void 
		{
			
			if (canI('ME') == false) return;
			trace(item+' ME');
			_stageX = e.stageX;
			_stageY = e.stageY;
			_localX = e.localX;
			_localY = e.localY;
			
			_targetName = e.target.name;
			
			Globals.mainClip.addEventListener(MouseEvent.MOUSE_UP, ME_onRelease);
			MElistener = true;
			tapFlag = true;
			
			dispatchEvent(new Event(TapController.ON_PRESS));
			
			startX = e.stageX;
			startY = e.stageY;
			Globals.mainClip.addEventListener(MouseEvent.MOUSE_MOVE, ME_move);
			
		}
		private function ME_move(e:MouseEvent):void 
		{
			if (Math.abs(startX - e.stageX) > tapAccurancy || Math.abs(startY - e.stageY) > tapAccurancy) 
			{
				tapFlag = false;
			}
		}
		private function ME_onRelease(e:MouseEvent):void 
		{
			trace(item+' ME-end');
			Globals.mainClip.removeEventListener(MouseEvent.MOUSE_UP, ME_onRelease);
			Globals.mainClip.removeEventListener(MouseEvent.MOUSE_MOVE, ME_move);
			
			_stageX = e.stageX;
			_stageY = e.stageY;
				_target = e.target;
			if (tapFlag)  dispatchEvent(new Event(TapController.ON_TAP));
			else dispatchEvent(new Event(TapController.ON_RELEASE));
			
			
			MElistener = false;
			resetListenerType(200);
		}
		
	//=====================================================================
		
		
		//?--
		//===
		
		
		
		
		
		
		
		
		override protected function disable():void 
		{
			
			item.removeEventListener(TouchEvent.TOUCH_BEGIN, TE_onPress);
			item.removeEventListener(MouseEvent.MOUSE_DOWN, ME_onPress);
			
			if (MElistener)
			{
				Globals.mainClip.removeEventListener(MouseEvent.MOUSE_MOVE, ME_move);
				Globals.mainClip.removeEventListener(MouseEvent.MOUSE_UP, ME_onRelease);
			}
			if (TElistener) 
			{
				Globals.mainClip.removeEventListener(TouchEvent.TOUCH_MOVE, TE_move);
				Globals.mainClip.removeEventListener(TouchEvent.TOUCH_END, TE_onRelease);
			}
			
		}
		
		
		
	}

}