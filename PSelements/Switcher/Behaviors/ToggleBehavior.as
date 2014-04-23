package PS.PSelements.Switcher.Behaviors 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import PS.PSelements.Switcher.IswitchBehavior;
	//import Src.Control.Interfaces.Iswitcher;
	/**
	 * ...
	 * @author ...
	 */
	public class ToggleBehavior implements IswitchBehavior
	{
		
		
		protected var second:DisplayObject;
		protected var first:DisplayObject;
		
		protected var switchItem:DisplayObjectContainer;
		
		protected var enabled:Boolean = false;
		
		protected var active:Boolean = false;
		
		protected var flag_only_one_can_be_turnOn:Boolean;
		public function ToggleBehavior(secondCondition:DisplayObject, only_one_can_be_turnOn:Boolean = false) 
		{
			second = secondCondition;
			flag_only_one_can_be_turnOn = only_one_can_be_turnOn;
			
		}
		public function init(client:DisplayObjectContainer, nativeTexture:DisplayObject):void
		{
			
			switchItem = client;
			
			first = nativeTexture;
			switchItem.addChild(second);
						
			
			second.visible = false;
			
			enabled = true;
		}
		
		public function select():void
		{
			
			if (!active)
			{
				
			
				second.visible = true;
				first.visible = false;
				active = true;
			
			}
			else
			{
				
				first.visible = true;
				second.visible = false;
				active = false;
			
			}
			
		}
		
		public function unselect():void	
		{
			trace('unselect');
			if (flag_only_one_can_be_turnOn)
			{
				first.visible = true;
				second.visible = false;
				active = false;
			}
		}
		public function onPress():void {}
		public function onRelease():void {}
		
		
		
		
	}

}