package PS.PSelements 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import PS.PScontroller.Controller;
	import PS.PScontroller.TapController;
	import PS.PSelements.Switcher.IswitchBehavior;
	import PS.PSelements.Switcher.SwitchButton;
	import PS.PSelements.Switcher.switcherGroups;
	
	/**
	 * ...
	 * @author 
	 */
	public class SwitchButton2 extends Sprite 
	{
		//MAIN FLAGS:
		private var _clickable:Boolean;
		private var _active:Boolean = false;
		
		//ENGINE:
		private var behavior:IswitchBehavior;
		private var texture:DisplayObject;
		private var ctrl:Controller;
		private var group:String;
		
		private var controlledSwitcher:SwitchButton2;
		public function SwitchButton2(obj:DisplayObject,addToGroup:String=null) 
		{
			super();
			texture = obj;
			addChild(texture);
			clickable = true;
			group = addToGroup;
			if(addToGroup) switcherGroups.addToGroup(this, group);
			
			
			
		}
		
		
		//PUBLIC METHODS:----------------------------------------------------------------------
			//main:
		public function Select(needCallHandler:Boolean = true):void
		{
			switcherGroups.unselectGroup(group);//!
			if (behavior) behavior.select();
			
			if (needCallHandler) callHandler();
			
			
			
		}
		public function Unselect():void
		{
			if (behavior) behavior.unselect();
		}
		public function Press():void
		{
			if (behavior) behavior.onPress();
		}
		public function Release():void
		{
			if (behavior) behavior.onRelease();
		}
			//behavior:
		public function addBehavior(newBehavior:IswitchBehavior):void
		{
			behavior = newBehavior;
			behavior.init(this, texture);
		}
		
			//extra:
		private var secondaryCtrl:Controller;
		public function addControlTrigger(trigger:InteractiveObject):void
		{
			removeControlTrigger();
			
			secondaryCtrl = Controller.addTapListener(trigger);
			secondaryCtrl.addEventListener(TapController.ON_PRESS, ctrl2_onPress);
			secondaryCtrl.addEventListener(TapController.ON_RELEASE, ctrl2_onRelease);
			secondaryCtrl.addEventListener(TapController.ON_TAP, ctrl2_onTap);
		}
		public function removeControlTrigger():void
		{
			if (secondaryCtrl)
			{
				secondaryCtrl.enabled = false;
				secondaryCtrl.removeEventListener(TapController.ON_PRESS, ctrl2_onPress);
				secondaryCtrl.removeEventListener(TapController.ON_RELEASE, ctrl2_onRelease);
				secondaryCtrl.removeEventListener(TapController.ON_TAP, ctrl2_onTap);
			}
		}
		private var handlerFunc:Function;
		private var handlerParam:Object;
		private var handlerAdded:Boolean = false;
		public function addHandler(handler:Function, param:Object=null):void
		{
			handlerAdded = true;
			handlerFunc = handler;
			handlerParam = param;
		}
		public function removeHandler():void
		{
			handlerAdded = false;
			handlerFunc = null;
			handlerParam = null;
		}
		//====================================================================================
		
		//INNER METHODS:--------------------------------------------------------------------------------------
		private function ctrl_onTap(e:Event):void 
		{
			if (clickable) Select();
		}
		
		private function ctrl_onRelease(e:Event):void 
		{
			if (clickable) Release(); 
		}
		
		private function ctrl_onPress(e:Event):void 
		{
			if (clickable) Press(); 
		}
		private function ctrl2_onTap(e:Event):void 
		{
			Select();
		}
		
		private function ctrl2_onRelease(e:Event):void 
		{
			Release(); 
		}
		
		private function ctrl2_onPress(e:Event):void 
		{
			Press(); 
		}
		private function enableControl():void
		{
			if (!ctrl)
			{
				ctrl = Controller.addTapListener(this);
				ctrl.addEventListener(TapController.ON_PRESS, ctrl_onPress);
				ctrl.addEventListener(TapController.ON_RELEASE, ctrl_onRelease);
				ctrl.addEventListener(TapController.ON_TAP, ctrl_onTap);
			}
		}
		private function disableControl():void
		{
			if (ctrl)
			{
				ctrl.enabled = false;
				ctrl.removeEventListener(TapController.ON_PRESS, ctrl_onPress);
				ctrl.removeEventListener(TapController.ON_RELEASE, ctrl_onRelease);
				ctrl.removeEventListener(TapController.ON_TAP, ctrl_onTap);
				ctrl = null;
			}
		}
		private function callHandler():void
		{
			if (handlerAdded)
			{
				if (handlerParam != null) handlerFunc(handlerParam);
				else handlerFunc();
			}
		}
		//=========================================================================================
		
		//GETTERS && SETTERS:-------------------------------------------------------
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function get clickable():Boolean 
		{
			return _clickable;
		}
		
		public function set clickable(value:Boolean):void 
		{
			_clickable = value;
			if (value) enableControl();
			else disableControl();
		}
		
		
		//=====================================================================
	}

}