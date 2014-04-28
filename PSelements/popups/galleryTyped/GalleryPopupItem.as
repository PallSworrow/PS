package PS.PSelements.popups.galleryTyped 
{
	import Antares.ImgBox;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.security.SignerTrustSettings;
	import PS.PSelements.micro.ArrowsFrame;
	import PS.PSelements.micro.ImgPreview;
	import PS.PSelements.micro.ScalableFrame;
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
		 
		protected var X0:int;
		protected var Y0:int;
		public function GalleryPopupItem(x0:int=0,y0:int=0) 
		{
			super(); 
			X0 = x0;
			Y0 = y0;
			trace('new ' + this);
			
			
			
		}
		private var behavior:GPIbehavior;
		public function initBehavior(behav:GPIbehavior ):void
		{
			if (behavior) return;//error double init;
			behavior = behav;
			behavior.addEventListener(GPBevents.ON_NEXT,onNext);
			behavior.addEventListener(GPBevents.ON_PREV,onPrev);
			behavior.addEventListener(GPBevents.ON_OUT,onOut);
			
		
		}
		
		private function onOut(e:Event):void 
		{
			//cb.disable();
			parent.removeChild(this);
		}
		
		private function onNext(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		private function onPrev(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		public function createContent(data:Object):void
		{
		}
		
	}

}