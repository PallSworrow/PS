package PS.PSelements.Switcher
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import PS.PScontroller.Controller;
	import PS.PScontroller.TapController;
	/**
	 * ...
	 * @author Павел
	 */
	public class SwitchButton extends Sprite 
	{
		private static var groups:Object = { };
		private var cond:int = 1;
		private var index:int;
		private var mygroup:String;
		
		private var _switchBehavior:IswitchBehavior;
		
		private var bg:DisplayObject;
		private var defaultChoice:Boolean;
		
		private var _control:Controller;
		public function SwitchButton(obj:DisplayObject, group:String = 'no',first:Boolean=false, clickable:Boolean=true):void
		{
			
			
			
			
			defaultChoice = first;
			bg = obj;
			//addChild(Embeds.getButtonTexture(stageName));
			addChild(bg);
			
			//if (group == 'no') return;
			
			if (!groups[group])
			{
				groups[group] = new Array(); 
				
			}
			mygroup = group;
			index = groups[group].length;
			groups[group].push(this);
			//addEventListener(MouseEvent.CLICK, click);
			if (clickable)
			{
				
				_control = Controller.addTapListener(this);
				_control.addToGroup('switchers');
		
			//Controller.addPressListener(this, onPress);
				_control.addEventListener(TapController.ON_PRESS,onPress );
				_control.addEventListener(TapController.ON_RELEASE, onRelease);
				_control.addEventListener(TapController.ON_TAP,click );
			}
		}
		private var handler:Function;
		private var handParam:Object;
		private var isHandlerSet:Boolean = false;
		public function addHandler(func:Function, param:Object=null):void
		{
			handler = func;
			handParam = param;
			isHandlerSet = true;
		}
		public function callHandler():void
		{
			if (isHandlerSet)
			{
				//trace('switcher: nadler param:' + handParam);
				if (handParam!=null)
				{
					
					handler(handParam);
				}
				else
				{
					handler();
				}
			}
			
		}
		public function onRelease(e:Event):void 
		{
			if(_switchBehavior)_switchBehavior.onRelease();
		}
		
		
		
		public function onPress(e:Event):void 
		{
			if(_switchBehavior)_switchBehavior.onPress();
		}
		private function click(e:Event):void
		{
			dispatchEvent(new Event('SELECT'));
			if (listeningSW) listeningSW.select();
			select();
		}
		public function select(withHandler:Boolean = true):void
		{
			//trace('select item');
			
			
			if (mygroup != 'no')
			{
				
				for (var i:int = groups[mygroup].length-1; i >= 0; i --)
				{
					if (groups[mygroup][i].index != index)
					{
			
						
						if(groups[mygroup][i].cond!=0) groups[mygroup][i].turnOff();
					}
					else 
					{
						groups[mygroup][i].turnOn();
					}
				}
			}
			else
			{
				turnOn();
				
			}
			
				if(withHandler) callHandler();
		}
		private function turnOff():void
		{
			if (_switchBehavior)_switchBehavior.unselect();
		
			//this.alpha = 0.5;
			cond = 0;
			
		}
		private function turnOn():void
		{
			if(_switchBehavior)_switchBehavior.select();
			//this.alpha = 1;
			cond = 1;
		}
		
		public function addSwitchBehavior(value:IswitchBehavior):void 
		{
			_switchBehavior = value;
			_switchBehavior.init(this, bg);
			if (!defaultChoice) turnOff();
		}
		public function get control():Controller 
		{
			return _control;
		}
		
		private var listeningSW:SwitchButton;
		public function synchronizeWith(listener:SwitchButton):void
		{
			listeningSW = listener;
		}
		
		//STATIC METHODS:
		public static function unselectGroup(group:String):void
		{
			if (!groups[group])
			{
				trace('unselectGroup error');
				return;
			}
			for (var i:int = groups[group].length-1; i >= 0; i --)
			{
				groups[group][i].turnOff();
				
			}
		}
		public static function disableGroup(group:String):void
		{
			if (!groups[group])
			{
				trace('no group found');
				return;
			}
			for (var i:int = groups[group].length-1; i >= 0; i --)
			{
				(groups[group][i].control as Controller).enabled = false;
				
			}
		}
		
		
		//================================
		
	
		
		
		
		
	}
	
}