package PS.PSelements.popups.galleryTyped 
{
	import Antares.ImgBox;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.security.SignerTrustSettings;
	import PS.PSelements.micro.ArrowsFrame;
	import PS.PSelements.micro.ImgPreview;
	import PS.PSelements.micro.ScalableFrame;
	import PS.PSmodel.DelegatedBehaviors.Behaviors.CarruselItemBehavior;
	import PS.PSmodel.Globals;
	import PS.PSmodel.text.TextBox;
	
	/**
	 * ...
	 * @author 
	 */
		
	public class GalleryPopupItem extends Sprite 
	{
		private static const dragLimit:int = 400;
		/*
		funcs:
			carusel behavior
			content box
		*/
		 
		private var props:Object;
		protected var X0:int;
		protected var Y0:int;
		public function GalleryPopupItem(data:Object,x0:int=0,y0:int=0) 
		{
			super(); 
			props = data;
			X0 = x0;
			Y0 = y0;
			trace('new ' + this);
			
			createContent(props);
			
			
			
		}
		private var cb:CarruselItemBehavior;
		public function initBehavior( leftAllowed:Boolean = true,rightAllowed:Boolean=true):void 
		{
			if (cb) return;//error double init!
			cb = new CarruselItemBehavior(this , new Rectangle(0, y, Globals.stageWidth, 0), dragLimit,true,{banUp:!rightAllowed,banDown:!leftAllowed});
			cb.addEventListener(CarruselItemBehavior.LOWER_LIMIT_EXCEEDED, cb_lowerLimitExceeded);
			cb.addEventListener(CarruselItemBehavior.UPPER_LIMIT_EXCEEDED, cb_upperLimitExceeded);
			cb.addEventListener(CarruselItemBehavior.TWEENOUT_ENDED, cb_tweenoutEnded);
		}
		
		private function cb_tweenoutEnded(e:Event):void 
		{
			cb.disable();
			parent.removeChild(this);
		}
		
		private function cb_upperLimitExceeded(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		private function cb_lowerLimitExceeded(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		protected function createContent(data:Object):void
		{
			trace('??');
		}
		
	}

}