package PS.PSmodel.DataProcessing 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author 
	 */
	public class Memory 
	{
		//constants:
		private static var imgCountLimit:int = 100;
		private static var byteLimit:uint = 2000000;
		
		//-===================================================
		protected static var currentSize:uint = 0;
		
		
		protected static var LoadedImgs:Object = new Object();
		protected static var imgIds:Vector.<String> = new Vector.<String>();
		
		public static function newImg(img:Bitmap, id:String, size:uint):void
		{
			if (LoadedImgs[id])
			{
				//LogTracker.write('двойное добавление!', 'error', 'bitmapprofile');
			}
			else
			{
				LoadedImgs[id] = new BitmapProfile(img.bitmapData,size);
				imgIds.push(id);
				currentSize += size;
				checkMemory();
			}
		}
		
		public static function getImg(id:String):Bitmap
		{
			if (LoadedImgs[id])
			{
				return (LoadedImgs[id] as BitmapProfile).img;
			}
			else return null;
		}
		
		
		
		
		
		
		static private function checkMemory():void 
		{
			//if (imgIds.length > imgCountLimit)//условие для очистки
			if (currentSize > byteLimit)//условие для очистки
			{
				
				trace('--------memory limit----------');
				trace('current size: ' + currentSize);
				var l:int = imgIds.length;
				for ( var i:int = 0; i < imgIds.length; i++ )
				{
					//trace('photo' + i);
					//trace('add count=' + (LoadedImgs[imgIds[i]] as BitmapProfile).addsCount);
					//trace('size = ' + (LoadedImgs[imgIds[i]] as BitmapProfile).size);
					if ((LoadedImgs[imgIds[i]] as BitmapProfile).addsCount <= 0 && (LoadedImgs[imgIds[i]] as BitmapProfile).inited) //вне списков отоброжения
					{
						(LoadedImgs[imgIds[i]] as BitmapProfile).kill();
						LoadedImgs[imgIds[i]] = null;
						imgIds.splice(i, 1);
						currentSize -= (LoadedImgs[imgIds[i]] as BitmapProfile).size;
						trace('[removed]');
						i--;
						//if(currentSize < byteLimit) break;//если память освободили 
					}
					
				}
				trace('cleared: ' + i + '/' + l);
				trace('new size: ' + currentSize);
				trace('======memory cleaned ===============');
			}
		}
		
	}

}