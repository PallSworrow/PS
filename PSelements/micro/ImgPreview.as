package PS.PSelements.micro 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import PS.PScontroller.Controller;
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import PS.PScontroller.TapController;

	
	/**
	 * ...
	 * @author Павел
	 */
	public class ImgPreview extends Sprite
	{
		//events:
		public static const ON_CLICK:String = 'onclick';
		public static const ARROW_LEFT:String = 'arrowleft';
		public static const ARROW_RIGHT:String = 'arrowright';
		public static const ON_SHOW:String = 'onshow';
		
		//=========================================
		
		protected var box:Sprite;
		protected var msk:Shape;
		protected var bg:DisplayObject = null;
	
		
		protected var onClickFunc:Function;
		
		//graphic props
		protected var _maskW:int;
		protected var _maskH:int;
		protected var maskOffsetX:int = 0;
		protected var maskOffsetY:int = 0;
		
		
		private var initialW:int;
		private var initialH:int;
		//props
		protected var ftsType:String = 'full'; //fill
		
		
		
		private var ctrl:Controller;
		public function ImgPreview(w:int,h:int, parameters:Object = null) 
		{
			
			//initGraphics();
			//var bg:DisplayObject = new bgTexture();
		
			if (parameters)
			{
				if (parameters.maskOffsetX) maskOffsetX = parameters.maskOffsetX;
				if (parameters.maskOffsetY) maskOffsetY = parameters.maskOffsetY;
				 bg = parameters.bg;
				if (parameters.ftsType) 
				{
					if (parameters.ftsType == 'fill') ftsType = 'fill';
					if (parameters.ftsType == 'full') ftsType = 'full';
					if (parameters.ftsType == 'horizontal') ftsType = 'horizontal';
				}
				if (parameters.bg)
				{
					if (parameters.bg is DisplayObject) 
					{
						
						bg.width = w;
						bg.height = h;
						addChild(bg);
						if (parameters.bgX) bg.x = parameters.bgX; 
						if (parameters.bgY) bg.y = parameters.bgY; 
						if (parameters.bgW) bg.width = parameters.bgW; 
						if (parameters.bgH) bg.height = parameters.bgH; 
						
					}
				}
				
			}
		
			
			
			
			
			
			msk = new Shape(); 
			msk.graphics.lineStyle(0, 0x000000); 
			msk.graphics.beginFill(0xff0000); 
			msk.graphics.drawRect(0, 0, w - 2*maskOffsetX, h - 2*maskOffsetY); 
			msk.graphics.endFill();
			msk.x = maskOffsetX;
			msk.y = maskOffsetY;
			msk.visible = false;
			addChild(msk);
			maskH = h - 2*maskOffsetY;
			maskW = w - 2 * maskOffsetX;
			initialH = maskH;
			initialW = maskW;
			
			ctrl = Controller.addTapListener(this);
			ctrl.addEventListener(TapController.ON_TAP, onTap);
			
		}
		protected var arrowLeft:Sprite;
		protected var arrowRight:Sprite;
		public function addArrows(arrowTexture:DisplayObject, offset:int=0,horizontal:Boolean = true ):void
		{
			var bmData:BitmapData;
			bmData = new BitmapData(arrowTexture.width, arrowTexture.height,true,0);
			bmData.draw(arrowTexture);
			
			arrowLeft = new Sprite();
			arrowRight = new Sprite();
			
			arrowLeft.addChild(new Bitmap(bmData));
			arrowLeft.name = 'arrowLeft';
			
			arrowRight.addChild(new Bitmap(bmData));
			arrowRight.name = 'arrowRight';
			
			arrowLeft.rotation = 180;
			arrowLeft.x = -offset;
			arrowLeft.y = (msk.height + arrowLeft.height) / 2;
			
			arrowRight.x = msk.width + offset;
			arrowRight.y = (msk.height - arrowRight.height) / 2;
			
			addChild(arrowLeft);
			addChild(arrowRight);
			
		}
		private function onTap(e:Event):void 
		{
			if (ctrl.targetName == 'arrowLeft') trace('L');
			if (ctrl.targetName == 'arrowRight') trace('R');
			else dispatchEvent(new Event(ON_CLICK));
			
		}
		
		public function show(img:DisplayObject, fts:Boolean = true):void
		{
			
			clear();
			
			box = new Sprite();
			
			box.addChild(img);
			/*/trace('<<-new priev box->>');
			trace('x=' + img.x);
			trace('y=' + img.y);
			trace('imgW='+img.width);
			trace('imgH=' + img.height);
			trace('boxW='+box.width);
			trace('boxH='+box.height);*/
			
			
			
			
		
			addChild(box);
			if (fts) 
			{
				fitTheSize();
				box.mask = msk;
			}
			dispatchEvent(new Event(ON_SHOW));
		}
		
		public function clear():void
		{
			maskH = initialH;
			maskW = initialW;
			msk.x = maskOffsetX;
			msk.y = maskOffsetY;
			
			if (box) removeChild(box);
			box = null;
			
		}
		public function fitTheSize():void
		{
			
			///подгоняем под размеры maskW x maskH:
			/*trace('maskW=' + maskW);
			trace('maskH=' + maskH);
			
			*/
			
			var sx:Number = maskW/box.width;
			var sy:Number = maskH / box.height;
		/*
			trace('sx=' + sx);
			trace('sy=' + sy);*/
			var resScale:Number;
			if (ftsType == 'full')
			{
				if(sx < sy)resScale = sx;
				else resScale = sy;
			}
			else if(ftsType == 'fill')
			{
				if (sx < sy) resScale = sy;
				else resScale = sx;
			}
			else if (ftsType == 'horizontal')
			{
				customFTS('horizontal');
				return;
			}
			
			
			box.scaleX = box.scaleY = resScale;
			//определяем положение картинки:
			box.x = maskOffsetX + (maskW - box.width)/2;
			box.y = maskOffsetY + (maskH - box.height) / 2;
			
			
		}
		
		
		
		
		
		public function customFTS(type:String = 'horizontal'):void
		{
			/*trace('------CUSTOM FTS------')
			trace(box.width);*/
			if (type == 'horizontal')
			{
				var sy:Number = maskH / box.height;
				/*trace('maskH = ' + maskH);
				trace('boxH = ' + box.height);
				trace('sy = ' + sy);*/
				box.scaleX = box.scaleY = sy;
				maskW = box.width;
				
				
				
				box.x = 0;
				box.y = 0;
				
				msk.x = box.x;
				msk.y = 0;
				
				
			}
			//trace('<=========>');
		}
		
		
		
		public function forceTheSize(w:int, h:int):void
		{
			box.width = w;
			box.height = h;
			
			//определяем положение картинки:
			box.x = maskOffsetX + (maskW - w)/2;
			box.y = maskOffsetY + (maskH - h)/2;
		}
		
		public function get maskW():int 
		{
			return msk.width
		}
		
		public function set maskW(value:int):void 
		{
			msk.width = value;
		}
		
		public function get maskH():int 
		{
			return msk.height;
		}
		
		public function set maskH(value:int):void 
		{
			msk.height = value;
		}
		
		
		
		
		public function get frame():Boolean
		{
			return bg.visible;
		}
		public function set frame(val:Boolean):void
		{
			bg.visible = val;
			
		}
		
	/*	override public function get height():Number 
		{
			
			if(!bg)return msk.height;
			if (msk.height > bg.height )	return msk.height;
			else return bg.height;
		}
		
		override public function set height(value:Number):void 
		{
			if(bg) bg.height = value;
		}
		override public function get width():Number 
		{
			trace('call width');
			if(!bg)	return msk.width;
			if (msk.width > bg.width )	return msk.width;
			else return bg.width;
		}
		
		override public function set width(value:Number):void 
		{
			//?
			if(bg) bg.width = value;
		}*/
	}

}