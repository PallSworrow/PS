package PS.PSmodel.popupSystem 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import PS.PScontroller.Controller;
	import PS.PScontroller.TapController;
	import PS.PSmodel.Engine;
	
	/**
	 * ...
	 * @author 
	 */
	public class Popup extends EventDispatcher
	{
		private var _item:DisplayObject;
		private var currentCondition:String;
		private var goalCondition:String;
		private var ctrl:Controller;
		public function Popup (obj:Sprite,param:Object) 
		{
			super();
			_item = obj;
			
			currentCondition = goalCondition = 'hidden';
			checkParameters(param);
			ctrl = Controller.addTapListener(obj);
			ctrl.addEventListener(TapController.ON_TAP, onTap);
			
			
			
			
		}
		//basic functional:
		private function _showComplete():void
		{
			currentCondition = 'shown';
			PopupEngine.addPopup(this);
		}
		private function _closeComplete():void
		{
			currentCondition = 'hidden';
			PopupEngine.closePopup(this);
		}
		public function get item():DisplayObject 
		{
			return _item;
		}
		//PROTECTED METHODS:
		protected var tapObjectName:String;
		protected var tapX:int;
		protected var tapY:int;
		protected function checkParameters(obj:Object):void
		{
			if (!obj) obj = { };
		}
		protected function onTap(e:Event):void
		{
			tapObjectName = ctrl.targetName;
			
			if (ctrl.targetName == closeButtonName) close();
			
			tapX = ctrl.stageX - (Engine.popupContainer.x+item.x);
			tapX = ctrl.stageY - (Engine.popupContainer.y + item.y);
			dispatchEvent(new PopupEvent(PopupEvent.ON_TAP));
			
		}
		
		//PUBLIC
		public function show():void
		{
			goalCondition = 'shown';
			if (currentCondition != goalCondition)
			{
				//init show behavior
				_showComplete();
			}
		}
		public function close():void
		{
			goalCondition = 'hidden';
			if (currentCondition != goalCondition)
			{
				//init close behavior
				_closeComplete();
			}
		}
		public function addShowBehavior():void
		{
			
		}
		public function addCloseBehavior():void
		{
			
		}
		public var closeButtonName:String = 'closeBtn';
	}

}