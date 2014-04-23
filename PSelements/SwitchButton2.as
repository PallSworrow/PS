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
		public var clickable:Boolean = true;
		private var _active:Boolean = false;
		
		//ENGINE:
		private var behavior:IswitchBehavior;
		private var texture:DisplayObject;
		private var ctrl:Controller;
		private var group:String;
		
		private var controlledSwitcher:SwitchButton2;
		public function SwitchButton2(obj:DisplayObject,addToGroup:String) 
		{
			super();
			group = addToGroup;
			switcherGroups.addToGroup(this, group);
			
			
			ctrl = Controller.addTapListener(this);
			ctrl.addEventListener(TapController.ON_PRESS, ctrl_onPress);
			ctrl.addEventListener(TapController.ON_RELEASE, ctrl_onRelease);
			ctrl.addEventListener(TapController.ON_TAP, ctrl_onTap);
		}
		
		
		//PUBLIC METHODS:
			//main:
		public function Select():void
		{
			switcherGroups.unselectGroup(group);
			if (behavior) behavior.select();
			
			
			
			
			
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
		public function addController(trigger:InteractiveObject):void
		{
			if (secondaryCtrl)
			{
				secondaryCtrl.enabled = false;
			}
			
			secondaryCtrl = Controller.addTapListener(trigger
		}
		
		
		//INNER METHODS:
		private function ctrl_onTap(e:Event):void 
		{
			if (clickable)
			{
				Select();
				
			}
		}
		
		private function ctrl_onRelease(e:Event):void 
		{
			
		}
		
		private function ctrl_onPress(e:Event):void 
		{
			
		}
		
		
		//GETTERS:
		public function get active():Boolean 
		{
			return _active;
		}
	}

}