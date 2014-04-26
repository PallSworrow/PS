package PS.PSelements.micro 
{
	import flash.events.Event;
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
		protected var _minLength:Number;
		protected var endHeight:Number;
		
		/*/планы:
		добавить возможность не растягивать центральную текстурку, а копировать н-кол-во раз.
		с использованием соотв маскирующего объекта
		
		
		set-ер ширины и высоты не искажающий изображение
		
		другие настройки?
		
		/*/
		private var currentLength:Number;
		private var isVertical:Boolean;
		public function ScalableLine(endTextrure:DisplayObject, centerTextrure:DisplayObject, vertical:Boolean=true) 
		{
			//isVertical = vertical;
			var bmData:BitmapData;
			bmData = new BitmapData(endTextrure.width, endTextrure.height,true,0);
			bmData.draw(endTextrure);
			
			endImg0 = new Bitmap(bmData);
			endImg1 = new Bitmap(bmData);
			
			
			
			
			var bmData2:BitmapData = new BitmapData(centerTextrure.width, centerTextrure.height,true,0);
			bmData2.draw(centerTextrure);
			
			centerImg = new Bitmap(bmData2);
			
			addChild(centerImg);
			
			centerImg.y = endImg0.height;
			_minLength = endImg0.height * 2;
			endHeight = endImg0.height;
		
			
			
			addChild(endImg0);
			addChild(endImg1);
			endImg1.x = endImg1.width;
			endImg1.rotation = 180;
			
			
			
			setSize(0);
			//test();
			//addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			//trace(endImg1.x);
		}
		
		public function setSize(l:int):void
		{
			
			if (l < _minLength) l = _minLength;
			currentLength = l;
			centerImg.height = l - endHeight * 2;
			endImg1.y = endHeight*2 + centerImg.height;
			
		}
		
		override public function get height():Number 
		{
			return endImg0.height*2 + centerImg.height;
		}
		
		override public function set height(value:Number):void 
		{
			
			setSize(value);
		}
		public function get length():Number
		{
			return currentLength;
		}
		public function get minLength():Number 
		{
			return _minLength;
		}
		/*public function test():void
		{
			trace('Test');
			trace('x=' + centerImg.width);
		}*/
		
		
	}

}