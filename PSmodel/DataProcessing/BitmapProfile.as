package PS.PSmodel.DataProcessing 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class BitmapProfile 
	{
		protected var _source:BitmapData;
		protected var _size:uint;
		protected var _addsCount:int = 0;
		protected var _inited:Boolean = false;
		//protected var _size:int; для очистки п кол-ву занимаемой памяти
		//protected var _usageFrequency:? для оптимизиации
		
		public function BitmapProfile(img:BitmapData, bitmapSize:uint) 
		{
			_source = img;
			_size = bitmapSize;
			
		}
		public function get img():Bitmap
		{
			
			var bm:Bitmap = new Bitmap(_source);
			bm.addEventListener(Event.ADDED_TO_STAGE, added);
			bm.addEventListener(Event.REMOVED_FROM_STAGE, removed);
			return bm;
			
		}
		
		private function removed(e:Event):void 
		{
			_addsCount --;
		}
		
		private function added(e:Event):void 
		{
			_addsCount ++;
			_inited = true;
		}
	
		
		
		public function kill():void
		{
			_source.dispose();
			//обойти все экземпляры и выключить слушатели?
		}
		
		
		
		
		
		//GETTERS:  --------------------------------------------
		public function get addsCount():int {return _addsCount;}
		
		public function get size():uint 
		{
			return _size;
		}
		
		public function get inited():Boolean 
		{
			return _inited;
		}
		
		//====================================================================
		
		
	}

}