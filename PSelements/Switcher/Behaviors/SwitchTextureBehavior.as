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
	public class SwitchTextureBehavior implements IswitchBehavior
	{
		protected var switchItem:DisplayObjectContainer;
		
		protected var onPressImg:DisplayObject;
		protected var onActiveImg:DisplayObject;
		protected var normalImg:DisplayObject;
		protected var enabled:Boolean = false;
		protected var active:Boolean = false;
		
		public function SwitchTextureBehavior(onActiveImage:DisplayObject,onPressImage:DisplayObject=null) 
		{
			onActiveImg = onActiveImage;
			onPressImg = onPressImage;
		}
		public function init(client:DisplayObjectContainer, nativeTexture:DisplayObject):void
		{
			
			switchItem = client;
			normalImg = nativeTexture;
			if(onPressImg) switchItem.addChild(onPressImg);
			switchItem.addChild(onActiveImg);
			
			
			onActiveImg.visible = false;
			if(onPressImg) onPressImg.visible = false;
			enabled = true;
		}
		
		public function select():void
		{
			//trace('select');
			if (!enabled) return;
			if(onPressImg) onPressImg.visible = false;
			onActiveImg.visible = true;
			normalImg.visible = false;
			active = true;
			
		}
		public function unselect():void
		{
			//trace('unselect');
			if (!enabled) return;
			if(onPressImg) onPressImg.visible = false;
			normalImg.visible = true;
			onActiveImg.visible = false;
			active = false;
		}
		public function onPress():void
		{
			//trace('press');
			if (!enabled) return;
			
			if (onPressImg) 
			{
				onPressImg.visible = true;
				normalImg.visible = false;
				onActiveImg.visible = false;
			}
			
			
		}
		public function onRelease():void
		{
			if (active) select();
			else unselect();
		}
		
		
		
		
	}

}