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
	import PS.PScontroller.Controller;
	import PS.PScontroller.SwipeController;
	import PS.PSelements.micro.ArrowsFrame;
	import PS.PSelements.micro.ImgPreview;
	import PS.PSelements.micro.ScalableFrame;
	import PS.PSmodel.Globals;
	import PS.PSmodel.text.TextBox;
	
	/**
	 * ...
	 * @author 
	 */
		
	public class GalleryPopupItem extends Sprite implements IGalleryItem
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
			//trace('new ' + this);
			
			
			
		}
		protected var behavior:IGalleryItemBehavior;
		public function initBehavior(behav:IGalleryItemBehavior , startPosition:int, backAllowed:Boolean,forwardAllowed:Boolean):void
		{
			if (!behavior) behavior = behav;
			behavior.init(this,startPosition,backAllowed,forwardAllowed);
		
		}
		private var ctr:Boolean = false;
		private var swipe:SwipeController;
		public function get control():Boolean
		{
			return ctr;
		}
		public function set control(val:Boolean):void
		{
			
			if (val)
			{
				swipe = Controller.addSwipeListener(this);
				swipe.addEventListener(SwipeController.SWIPE_LEFT, swipe_swipeLeft);
				swipe.addEventListener(SwipeController.SWIPE_RIGHT, swipe_swipeRight);
			}
			else
			{
				swipe.removeEventListener(SwipeController.SWIPE_LEFT, swipe_swipeLeft);
				swipe.removeEventListener(SwipeController.SWIPE_RIGHT, swipe_swipeRight);
			}
			ctr = val;
		}
		
		private function swipe_swipeRight(e:Event):void 
		{
			behavior.forceNext();
		}
		
		private function swipe_swipeLeft(e:Event):void 
		{
			behavior.forceBack();
		}
		
		public function createContent(data:Object):void
		{
		}
		//INTERFACE IMPLEMENTATION:
		//call backs:
		public function onNext():void
		{
			dispatchEvent(new Event(GPIevent.ON_FORWARD));
		}
		public function onBack():void
		{
			dispatchEvent(new Event(GPIevent.ON_BACK));
		}
		public function onCenter():void
		{
			dispatchEvent(new Event(GPIevent.ON_CENTER));
		}
		public function onNextComplete():void
		{
			dispatchEvent(new Event(GPIevent.ON_FORWARD_COMPLETE));
			dispatchEvent(new Event(GPIevent.ON_OUT));
		}
		public function onBackComplete():void
		{
			dispatchEvent(new Event(GPIevent.ON_BACK_COMPLETE));
			dispatchEvent(new Event(GPIevent.ON_OUT));
		}
		public function onCenterComplete():void
		{
			dispatchEvent(new Event(GPIevent.ON_CENTER_COMPLETE));
		}
		public function forceActiveCondition():void
		{
			for (var param:String in activeCondition)
			{
				this[param] = activeCondition[param];
			}
		}
		public function forceOffCondition():void
		{
			for (var param:String in offCondition)
			{
				this[param] = offCondition[param];
			}
		}
		
		//getters & setters:
		//x&y implts by Sprite class
		public function get activeCondition():Object { return { }; }
		public function get offCondition():Object { return { }; }
	}

}