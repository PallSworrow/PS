package PS.PSelements.Switcher.Behaviors 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import PS.PSelements.Switcher.IswitchBehavior;
	/**
	 * ...
	 * @author ...
	 */
	public class ChangeAlphaBehavior implements IswitchBehavior
	{
		protected var switchItem:DisplayObjectContainer;
		
		protected var normalImg:DisplayObject;
		protected var enabled:Boolean = false;
		protected var active:Boolean = false;
		
		protected var alphaVal:Number;
		
		public function ChangeAlphaBehavior(inActiveAlpha:Number=0.5) 
		{
			alphaVal = inActiveAlpha;
		}
		public function init(client:DisplayObjectContainer, nativeTexture:DisplayObject):void
		{
			
			switchItem = client;
			normalImg = nativeTexture;
			
			
			enabled = true;
		}
		
		public function select():void
		{
			//trace('select');
			if (!enabled) return;
			normalImg.alpha = 1;
		
			active = true;
			
		}
		public function unselect():void
		{
			//trace('unselect');
			if (!enabled) return;
			normalImg.alpha = alphaVal;
			active = false;
		}
		public function onPress():void
		{
			//trace('press');
			if (!enabled) return;
			
			
		}
		public function onRelease():void
		{
			if (active) select();
			else unselect();
			
		}
		
		
		
		
	}

}