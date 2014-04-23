package PS.PScontroller 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	//import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.sampler.NewObjectSample;
	import org.gestouch.events.*;
	import org.gestouch.gestures.*;
	import org.gestouch.gestures.TapGesture;
	/**
	 * ...
	 * @author Павел
	 */
	public class Controller extends EventDispatcher
	{
		///EVENTS:
		
		
		
		
		
		
		
		
		//==========================================
		//public data:
		protected var _stageX:int;
		protected var _stageY:int;
		
		protected var _localX:int; // only on press events!
		protected var _localY:int;
		protected var _targetName:String;
		protected var _target:Object;
		public function get stageX():int 
		{
			return _stageX;
		}
		
		public function get stageY():int 
		{
			return _stageY;
		}
		
		public function get targetName():String 
		{
			return _targetName;
		}
		
		/*
		 здесь можно сохранить весь массив контроллеров и единовременно их отключать/включать. менять настройки. мб оптимизировать? 
		 */
		public static var mouse_enabled:Boolean = true;
		public static var touchEvents_enabled:Boolean = true;
		
		protected static var groups:Object = new Object(); 
		 
		public static function addTapListener(item:InteractiveObject, name:String=''):TapController
		{
			return new TapController(item,name);
		}
		
		
		public static function addDragListener(item:InteractiveObject,dragRectangle:Rectangle):DragController
		{
			return new DragController(item,dragRectangle);	
		}
		
		
		public static function addSwipeListener(item:InteractiveObject):SwipeController
		{
			return new SwipeController(item);
		}
		
		
		public static function groupSetEnabled(group:String, value:Boolean):void
		{
			//trace('set ' + group + '-group value to ' + value);
			if (groups[group])
			{
				
				for each(var item:Controller in groups[group])
				{
					
					item.enabled = value;
					
				}
			}
		}
		
		public var autoDelete:Boolean = true;
		
		protected var item:InteractiveObject;
		private var _enabled:Boolean = false;
		protected static var listenerType:String = 'free'; // free/ME/TE/GT
		private var _name:String;
		public function Controller(_item:InteractiveObject, name:String=''):void
		{
			item = _item;
			enabled = true;
			
			item.addEventListener(Event.REMOVED_FROM_STAGE, itemRemoved);
			_name = name;
		}
		
		private function itemRemoved(e:Event):void 
		{
			if (autoDelete)
			{
				removeEventListener(Event.REMOVED_FROM_STAGE, itemRemoved);
				if (enabled) enabled = false;
				if (mygroup) removeFromGroup();
			}
		}
		protected var mygroup:String;
		public function addToGroup(group:String):void // пока только одна группа единовременно
		{
			if (mygroup != group) removeFromGroup(); 
			
			
			if (!groups[group]) groups[group] = new Array();
				
			groups[group].push(this);
			mygroup = group;
			
		}
		public function removeFromGroup(group:String=''):void
		{
			
			if (groups[mygroup])
			{
				
				for (var i:int = groups[mygroup].length - 1; i >= 0;i--)
				{
					if (groups[mygroup][i] == this) groups[mygroup].splice(i, 1);
					
				}
			}
		}
		/*public function sleep(milliseconds:int):void
		{
			listenerType = 'blocked';
			resetListenerType(milliseconds);
		}*/
		
		public function set enabled(value:Boolean):void 
		{
			if (_enabled && !value) disable();
			else if (!_enabled && value) enable();
			
			_enabled = value;
			
		}
		public function get enabled():Boolean 
		{
			
			return _enabled;
		}
		
		public function get localX():int 
		{
			return _localX;
		}
		
		public function set localX(value:int):void 
		{
			_localX = value;
		}
		
		public function get localY():int 
		{
			return _localY;
		}
		
		public function set localY(value:int):void 
		{
			_localY = value;
		}
		
		public function get target():Object 
		{
			return _target;
		}
		protected var flag:Boolean;
		
		/*protected static var freezedType:String = 'free';
		protected function staticTypeFreeze(delay:int):void
		{
			
		}*/
		
		
		protected function canI(type:String):Boolean
		{
			/*/
			trace('<<Controller event: --------');
			trace('controller name: ' + _name);
			trace('event type: ' + type);
			trace('controller type: ' + this);
			trace('item: '+item);
			trace('handler box: '+listenerType);
			//*/
			flag = false;
			if (listenerType == 'free' || listenerType == type)
			{
				
				
				
				if (type == 'ME' && mouse_enabled) flag = true;
				else if (type == 'TE' && touchEvents_enabled) flag = true;
				else if (type == 'GT')  flag = true;
				
				if (flag)
				{
					/*/
					trace('accept');
					trace('------------------->>');//*/
					listenerType = type;
					return true;
				}
				
				
			}
		/*/
			trace('cancel');
				trace('------------------->>');
			//*/
			return false;
		}
		protected function resetListenerType(delay:int = 0):void
		{
			/*trace('<<Controller reset: --------');
			trace('event type: ' + listenerType);
			trace('controller type: ' + this);
			trace('item: ' + item);
			*/
			if (delay == 0)
			{
				//trace('reset listener type');
				listenerType = 'free';
			}
			else {
				
				setTimeout(resetListenerType, delay, 0);
				//trace('delay reset listener type: '+delay);
			}
			//trace('------------------->>');
		}
		protected function enable():void{}
		protected function disable():void{}
		
				
		
		
		
	}

}