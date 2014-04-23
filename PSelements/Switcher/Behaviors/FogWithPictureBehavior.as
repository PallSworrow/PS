package PS.PSelements.Switcher.Behaviors 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import PSelements.Switcher.Iswitcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class FogWithPictureBehavior implements Iswitcher 
	{
		private var fog:DisplayObject;
		private var nativeImg:DisplayObject;
		protected var enabled:Boolean = false;
		protected var switchItem:DisplayObjectContainer;
		
		public function FogWithPictureBehavior(fogTexture:DisplayObject) 
		{
			fog = fogTexture;
		}
		
		/* INTERFACE Src.Control.Interfaces.Iswitcher */
		public function init(client:DisplayObjectContainer, nativeTexture:DisplayObject):void
		{
			
			switchItem = client;
			nativeImg = nativeTexture;
			
			switchItem.addChild(fog);
			fog.visible = false;
			enabled = true;
		}
		public function select():void 
		{
			fog.visible = false;
			switchItem.alpha = 1;
		}
		
		public function unselect():void 
		{
			fog.visible = true;
			switchItem.alpha = 0.5;
		}
		
		public function onPress():void 
		{
			
		}
		public function onRelease():void
		{
			
		}
		
	}

}