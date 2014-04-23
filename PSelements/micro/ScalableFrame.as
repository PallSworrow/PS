package PS.PSelements.micro 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import PSmodel.LogTracker;
	/**
	 * ...
	 * @author 
	 */
	public class ScalableFrame extends Sprite
	{
		private var cornerLU:Bitmap;
		private var cornerRU:Bitmap;
		private var cornerLD:Bitmap;
		private var cornerRD:Bitmap;
		
		private var borderU:Bitmap;
		private var borderL:Bitmap;
		private var borderR:Bitmap;
		private var borderD:Bitmap;
		
		private var center:Bitmap;
		private var minSideLength:int;
		
		
		private var cornerSize:int;
		
		private var centerOffsetX:int;
		private var centerOffsetY:int;
		private var centerOffset:Boolean;
		public function ScalableFrame(cornerTextrure:DisplayObject, borderTextrure:DisplayObject, centerTextrure:DisplayObject, fromCorner:Boolean = false ) 
		{
			if (cornerTextrure.width != cornerTextrure.height) LogTracker.write('corner texture is not acceptable, w!=h.', 'error', 'scalableframe');
			
			centerOffset = !fromCorner;
			var bmData:BitmapData;
			bmData = new BitmapData(cornerTextrure.width, cornerTextrure.height);
			bmData.draw(cornerTextrure);
			
			cornerLU = new Bitmap(bmData);
			cornerLD = new Bitmap(bmData);
			cornerRU = new Bitmap(bmData);
			cornerRD = new Bitmap(bmData);
			
			cornerLU.rotation = 0;
			cornerRU.rotation = 90;
			cornerLD.rotation = 270;
			cornerRD.rotation = 180;
			
			addChild(cornerLU);
			addChild(cornerRU);
			addChild(cornerLD);
			addChild(cornerRD);
			
			
			
			bmData = new BitmapData(borderTextrure.width, borderTextrure.height);
			bmData.draw(borderTextrure);
			
			borderU = new Bitmap(bmData);
			borderL = new Bitmap(bmData);
			borderR = new Bitmap(bmData);
			borderD = new Bitmap(bmData);
			addChild(borderU);
			addChild(borderL);
			addChild(borderR);
			addChild(borderD);
			
			
			bmData = new BitmapData(centerTextrure.width, centerTextrure.height);
			bmData.draw(centerTextrure);
			center = new Bitmap(bmData);
			addChild(center);
			
			cornerSize = cornerLU.width;
			
			minSideLength = cornerTextrure.width * 2;
			
			setSize();
		}
	
		public function setSize(w:int=0, h:int=0):void
		{
			if (w < minSideLength) w = minSideLength;
			if (h < minSideLength) h = minSideLength;
			if (centerOffset)
			{
				centerOffsetX = -w / 2;
				centerOffsetY = -h / 2;
			}
			else
			{
				centerOffsetX = 0;
				centerOffsetY = 0;
			}
			
			
			
			
			cornerLU.y = centerOffsetY;
			cornerLU.x = centerOffsetX;
			
			cornerRU.y = centerOffsetY;
			cornerRU.x = w +centerOffsetX;
			
			cornerLD.y = h + centerOffsetY;
			cornerLD.x = centerOffsetX;
			
			cornerRD.x = w+centerOffsetX;
			cornerRD.y = h+centerOffsetY;
			
			borderR.rotation = 0;
			borderU.rotation = 0;
			borderL.rotation = 0;
			borderD.rotation = 0;
			
			borderU.x = cornerSize+centerOffsetX;
			borderU.y = centerOffsetY;
			borderU.width = w - 2 * cornerSize;
						
			borderL.x = centerOffsetX;
			borderL.y = h - cornerSize+centerOffsetY;
			borderL.width = h - 2 * cornerSize;
			
			borderD.x = w-cornerSize+centerOffsetX;
			borderD.y = h + centerOffsetY;
			borderD.width = w - 2 * cornerSize;
			
			borderR.x = w + centerOffsetX;
			borderR.y = cornerSize +centerOffsetY;
			borderR.width = h - 2 * cornerSize;
			
			
			
			borderR.rotation = 90;
			borderU.rotation = 0;
			borderL.rotation = -90;
			borderD.rotation = 180;
			
			center.x = cornerSize+centerOffsetX;
			center.y = cornerSize+centerOffsetY;
			center.width = w - 2 * cornerSize;
			center.height = h - 2 * cornerSize;
			
			
		}
	}

}