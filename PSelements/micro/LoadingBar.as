package PS.PSelements.micro
{
	import air.desktop.URLFilePromise;
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoadingBar extends Sprite 
	{
		
		protected var size:int;
		protected var loaded:DisplayObject;
		protected var bg:DisplayObject;
		
		protected var trigger:Sprite;
		
		public function LoadingBar(w:int, h:int, bgTexture:DisplayObject, fillTexture:DisplayObject):void
		{
			/*bg = new Shape(); 
			bg.graphics.lineStyle(1, 0x000000); 
			bg.graphics.beginFill(0x666666); 
			bg.graphics.drawRect(0, 0, w, h); 
			bg.graphics.endFill();
			addChild(bg);
			
			
			
			loaded = new Shape(); 
			loaded.graphics.lineStyle(1, 0x000000); 
			loaded.graphics.beginFill(0x7777AA); 
			loaded.graphics.drawRect(0, 0, w, h); 
			loaded.graphics.endFill();
			loaded.width = 0;
			addChild(loaded);*/
			
			bg = bgTexture;
			bg.width = w;
			addChild(bg);
			loaded = fillTexture
			addChild(loaded);
			
			
			
			
			
			
			
			size = w;
			
			trigger = new Sprite();
			var sq:Shape = new Shape();
			sq.graphics.lineStyle(1, 0x000000); 
			sq.graphics.beginFill(0x7777AA); 
			sq.graphics.drawRect(0, 0, w, h); 
			sq.graphics.endFill();
			sq.alpha = 0;
			trigger.addChild(sq);
			addChild(trigger);
			
			persent=0;
			
		}
		
		public function set persent(val:Number):void // 0.0 -> 1.0
		{
			
			if (val > 1) val = 1;
			if (val < 0) val = 0;
			loaded.width = size * val;
		}
	}
	
}