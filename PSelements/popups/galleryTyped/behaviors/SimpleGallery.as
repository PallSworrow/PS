package PS.PSelements.popups.galleryTyped.behaviors 
{
	import com.greensock.events.TweenEvent;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.PSelements.popups.galleryTyped.IGalleryItem;
	import PS.PSelements.popups.galleryTyped.IGalleryItemBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class SimpleGallery implements IGalleryItemBehavior 
	{
		private var canLeft:Boolean;
		private var canRight:Boolean;
		private var item:IGalleryItem;
		
		private var centerX:int;
		private var centerY:int;
		
		private var lowerAppearanceX:int;
		private var lowerAppearanceY:int;
		
		private var upperAppearanceX:int;
		private var upperAppearanceY:int;
		
		private var draglimitX:int=300;
		private var draglimitY:int=100;
		
		private var _state:String;
		private var rect:Rectangle;
		
		private var duration:Number = 0.5;
		
		private var enabled:Boolean = false;
		public function SimpleGallery(dragRectangle:Rectangle) 
		{
			
			rect = dragRectangle;
			
		
		}
		private var initTween:TweenMax;
		private var tween:TweenMax;
		public function init(obj:IGalleryItem,startPos:int,leftAllowed:Boolean,rightAllowed:Boolean):void
		{
			item = obj;
			
			canLeft = leftAllowed;
			canRight = rightAllowed;
			trace('BEHAVIOR INIT')
			trace('left: ' + canLeft);
			trace('right: ' + canRight);
			
			
			centerX = rect.x+rect.width/2;
			centerY = rect.y+rect.height/2;
			
			lowerAppearanceX = rect.x;
			lowerAppearanceY = rect.y;
			
			upperAppearanceX = rect.x+rect.width;
			upperAppearanceY = rect.y + rect.height;
			
			
			
			switch(startPos)
			{
				case 0:
					item.x = centerX;
					item.y = centerY;
					break;
				case -1:
					item.x = lowerAppearanceX;
					item.y = lowerAppearanceY;
					break;
				case 1:
					item.x = upperAppearanceX;
					item.y = upperAppearanceY;
					break;
				
			}
			if (item.x != centerX || item.y != centerY)
			{
				/*trace('BEHAVIOR centerX = '+centerX);
				trace('BEHAVIOR centerY = '+centerY);
				trace('BEHAVIOR itemX = '+item.x);
				trace('BEHAVIOR itemY = '+item.y);*/
				item.forceOffCondition();
				var resCond:Object = item.activeCondition;
				resCond.y = centerY;
				resCond.x = centerX;
				initTween = new TweenMax( item,duration, resCond);
				initTween.addEventListener(TweenEvent.COMPLETE, initComplete);
			}
			else
			{
				item.forceActiveCondition();
				enabled = true;
			}
			
		}
		
		private function initComplete(e:Event):void 
		{
			initTween.removeEventListener(TweenEvent.COMPLETE, initComplete);
			initTween = null;
			enabled = true;
		}
		
		public function disable():void
		{
			enabled = false;
		}
		
		//FORCE DO:
		public function forceNext():void
		{
			if (canRight) nxt();
		}
		public function forceBack():void
		{
			if (canLeft) bck();
		}
		public function forceCenter():void
		{
			
			ctr();
			
		}
		public function nxt():void
		{
			var resCond:Object = item.offCondition;
			resCond.y = upperAppearanceY;
			resCond.x = upperAppearanceX;
			tween = new TweenMax(item, duration, resCond);
			tween.addEventListener(TweenEvent.COMPLETE, onNextComplete);
			item.onNext();
		}
		public function bck():void
		{
			var resCond:Object = item.offCondition;
			resCond.y = lowerAppearanceY;
			resCond.x = lowerAppearanceX;
			tween = new TweenMax(item, duration,resCond);
			tween.addEventListener(TweenEvent.COMPLETE, onBackComplete);
			item.onBack();
		}
		public function ctr():void
		{
			/*var resCond:Object = item.activeCondition;
			resCond.y = centerY;
			resCond.x = centerX;*/
			tween = new TweenMax(item, duration, { x:centerX, y:centerY } );
			tween.addEventListener(TweenEvent.COMPLETE, onCenterComplete);
			item.onCenter();
			
		}
		
		
		//ON ACTION COMPLETE
		private function onNextComplete(e:Event):void
		{
			tween.removeEventListener(TweenEvent.COMPLETE, onNextComplete);
			item.onNextComplete();
		}
		private function onBackComplete(e:Event):void
		{
			tween.removeEventListener(TweenEvent.COMPLETE, onBackComplete);
			item.onBackComplete();
		}
		private function onCenterComplete(e:Event):void 
		{
			tween.removeEventListener(TweenEvent.COMPLETE, onCenterComplete);
			item.onCenterComplete();
		}
		
		
		
		//IS OUT
		public function checkIsOut():Boolean
		{
		/*	trace('CHECK IS OUT');
			trace('limit=' + draglimitX);
			trace('pos.x = ' + item.x);
			trace('centerX =' + centerX);
			trace('left: ' + canLeft);
			trace('right: ' + canRight);
			trace('out: ' + (item.x < centerX - draglimitX || item.y < centerY - draglimitY));*/
			if ((item.x < centerX - draglimitX || item.y < centerY - draglimitY)&& canLeft  ) 
			{
				bck();
				return true;
			}
			else if ((item.x > centerX + draglimitX || item.y > centerY + draglimitY )&& canRight  )
			{
				nxt();
				return true;
			}
			else 
			{
				ctr();
				return false;
			}
			
		}
		
		public function get state():String 
		{
			return _state;
		}
		
		
	}

}