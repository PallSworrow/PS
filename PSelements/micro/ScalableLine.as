package PS.PSelements.micro 
{
	import flash.utils.ByteArray;
	import PS.PSmodel.LogTracker;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class ScalableLine extends Sprite
	{
		protected var endImg0:DisplayObject;
		protected var endImg1:DisplayObject;
		protected var centerImg:Bitmap;
		protected var minLength:int;
		protected var endHeight:int;
		
		/*/планы:
		добавить возможность не растягивать центральную текстурку, а копировать н-кол-во раз.
		с использованием соотв маскирующего объекта
		
		
		set-ер ширины и высоты не искажающий изображение
		
		другие настройки?
		
		/*/
		public function ScalableLine(endTextrure:DisplayObject, centerTextrure:DisplayObject, length:int=0) 
		{
			var bmData:BitmapData;
			bmData = new BitmapData(endTextrure.width, endTextrure.height,true,0);
			bmData.draw(endTextrure);
			
			endImg0 = new Bitmap(bmData);
			endImg1 = new Bitmap(bmData);
			
			
			
			
		
			trace(endImg1);
			var bmData2:BitmapData = new BitmapData(centerTextrure.width, centerTextrure.height,true,0);
			bmData2.draw(centerTextrure);
			
			centerImg = new Bitmap(bmData2);
			
			addChild(centerImg);
			
			centerImg.y = endImg0.height;
			minLength = endImg0.height * 2;
			endHeight = endImg0.height;
		
			
			
			addChild(endImg0);
			endImg1.rotation = 180;
			endImg1.x = endImg1.width;
			
			
			setSize(length);
			
		}
		
		public function setSize(l:int):void
		{
			if (l < minLength) l = minLength;
			
			centerImg.height = l - endHeight * 2;
			endImg1.y = endHeight*2 + centerImg.height;
			
		}
		
		override public function get height():Number 
		{
			return endImg0.height*2 + centerImg.height;
		}
		
		override public function set height(value:Number):void 
		{
			trace('set height');
			trace('x=' + endImg0.x);
			setSize(value);
		}
		
		
	}

}