package PS.PScontroller 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import PS.PSmodel.Globals;
	/**
	 * ...
	 * @author 
	 */
	public class DragController extends Controller
	{
		//EVENTS:
		
		public static const ON_START_DRAG:String = 'onstartdrag';
		public static const ON_DRAG:String = 'ondrag';
		public static const ON_STOP_DRAG:String = 'onstopdrag';
		//=========================================================
		
		
		protected var dragRect:Rectangle;
		
		
		
		
		//listeners flags:
		//protected var TElistener_onBegin:Boolean = false;
		protected var TElistener_onEnd:Boolean = false;
		protected var TElistener_onRollOut:Boolean = false;
		protected var TElistener_onMove:Boolean = false;
		
		//protected var MElistener_onDown:Boolean = false;
		protected var MElistener_onUp:Boolean = false;
		protected var MElistener_onUpOutside:Boolean = false;
		protected var MElistener_onMove:Boolean = false;
		
		public function DragController(_item:InteractiveObject, dragRectangle:Rectangle) 
		{
			//trace('new dragcontroller');
			if (_item is Sprite)
			{
				dragRect = dragRectangle;
				super(_item);
			
			}
			else
			{
				trace('[DragController]error: ' + _item + 'is not draggable object');
			}
		}
		override protected function enable():void
		{
			//trace('enable drag controller');
			item.addEventListener(TouchEvent.TOUCH_BEGIN, TE_onGrab);
			item.addEventListener(MouseEvent.MOUSE_DOWN, ME_onDown);
		}
		
	
		
		
	//TOUCH EVENT HANDLERS-------------------------------
		private function TE_onGrab(e:TouchEvent):void 
		{
			
			if (canI('TE') == false) return;
			
			_stageX = e.stageX;
			_stageY = e.stageY;
			_localX = e.localX;
			_localY = e.localY;
			_targetName = e.target.name;
			
			(item as  Sprite).startTouchDrag(e.touchPointID, false, dragRect );
			
			
			item.addEventListener(TouchEvent.TOUCH_END, TE_onDrop);
			//item.addEventListener(TouchEvent.TOUCH_ROLL_OUT, TE_onDrop);
			Globals.mainClip.addEventListener(TouchEvent.TOUCH_MOVE, TE_onDrag );//
			
			TElistener_onEnd = true;
			TElistener_onRollOut = true;
			TElistener_onMove = true;
			
			
			
			dispatchEvent(new Event(ON_START_DRAG));
		}
		private function TE_onDrag(e:TouchEvent):void 
		{
			_stageX = e.stageX;
			_stageY = e.stageY;
			_targetName = e.target.name;
			dispatchEvent(new Event(ON_DRAG));
			
		}
		
		private function TE_onDrop(e:TouchEvent):void 
		{
			resetListenerType();
				
			item.removeEventListener(TouchEvent.TOUCH_END, TE_onDrop);
			//item.removeEventListener(TouchEvent.TOUCH_ROLL_OUT, TE_onDrop);
			Globals.mainClip.removeEventListener(TouchEvent.TOUCH_MOVE, TE_onDrag );
			
			TElistener_onEnd = false;
			TElistener_onRollOut = false;
			TElistener_onMove = false;
			
			_stageX = e.stageX;
			_stageY = e.stageY;
			_targetName = e.target.name;
			
			(item as Sprite).stopTouchDrag(e.touchPointID );
			
			dispatchEvent(new Event(ON_STOP_DRAG));
		
		}
		
	//=================================================================================
		
		
	//MOUSE EVENT HANDLERS------------------------------------------
		private function ME_onDown(e:MouseEvent):void 
		{
			if (canI('ME') == false) return;
			
			
			_stageX = e.stageX;
			_stageY = e.stageY;
			_localX = e.localX;
			_localY = e.localY;
			_targetName = e.target.name;
			
			(item as  Sprite).startDrag(false, dragRect );
			item.addEventListener(MouseEvent.MOUSE_UP, ME_onDrop);
			item.addEventListener(MouseEvent.RELEASE_OUTSIDE, ME_onDrop);
			Globals.mainClip.addEventListener(MouseEvent.MOUSE_MOVE, ME_onMove);
			MElistener_onUp = true;
			MElistener_onUpOutside = true;
			MElistener_onMove = true;
			
			dispatchEvent(new Event(ON_START_DRAG));
		}
		
		private function ME_onMove(e:MouseEvent):void 
		{
			_stageX = e.stageX;
			_stageY = e.stageY;
			_targetName = e.target.name;
			dispatchEvent(new Event(ON_DRAG));
		}
		
		private function ME_onDrop(e:MouseEvent):void 
		{
			item.removeEventListener(MouseEvent.MOUSE_UP, ME_onDrop);
			item.removeEventListener(MouseEvent.RELEASE_OUTSIDE, ME_onDrop);
			Globals.mainClip.removeEventListener(MouseEvent.MOUSE_MOVE, ME_onMove);
			MElistener_onUp = false;
			MElistener_onUpOutside = false;
			MElistener_onMove = false;
			
			resetListenerType();
			_stageX = e.stageX;
			_stageY = e.stageY;
			_targetName = e.target.name;
			(item as Sprite).stopDrag();
			
			dispatchEvent(new Event(ON_STOP_DRAG));
			
		}
	//==============================================================================
		
		
		
	//GESTOUCH EVENTS HANDLERS----------------------------------------
	//=================================================================================
		
		
		
		
		
		override protected function disable():void 
		{
			item.removeEventListener(TouchEvent.TOUCH_BEGIN, TE_onGrab);
			
			if(TElistener_onEnd) item.removeEventListener(TouchEvent.TOUCH_END, TE_onDrop);
			if (TElistener_onMove) Globals.mainClip.removeEventListener(TouchEvent.TOUCH_MOVE, TE_onDrag );
			
			if (MElistener_onUp)
			{
				item.removeEventListener(MouseEvent.MOUSE_UP, ME_onDrop);
				item.removeEventListener(MouseEvent.RELEASE_OUTSIDE, ME_onDrop);
				Globals.mainClip.removeEventListener(MouseEvent.MOUSE_MOVE, ME_onMove);
			}
			
		}
		
	}

}