package PS.PSmodel.DelegatedBehaviors.Behaviors 
{
	import com.greensock.events.TweenEvent;
	import com.greensock.loading.core.DisplayObjectLoader;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import PScontroller.Controller;
	import PScontroller.DragController;
	import PScontroller.SwipeController;
	import PSmodel.DelegatedBehaviors.Interfaces.IcarruselItem;
	
	/**
	 * ...
	 * @author Павел
	 */
	public class CarruselItemBehavior extends EventDispatcher
	{
		public static const UPPER_LIMIT_EXCEEDED:String = 'upper_limit';
		public static const LOWER_LIMIT_EXCEEDED:String = 'lower_limit';
		public static const TWEENOUT_ENDED:String = 'tweenout_end';
		
		protected var obj:Sprite;
		protected var dragRectangle:Rectangle;
		protected var dragLimit:int;
		protected var horizontal:Boolean;
		protected var controlListener:Controller;
		protected var swipeListener:Controller;
		
		protected var startX:int;
		protected var startY:int;
		protected var startPos:int;
		//flags:
		public var enabled:Boolean = false;
		
		//properties:
		protected var props:Object;
		public var swipeUpAllowed:Boolean = true;
		public var swipeDownAllowed:Boolean = true;
		
		public function CarruselItemBehavior(item:Sprite, borders:Rectangle, setDragLimit:int,  isHorizontal:Boolean= true, properties:Object = null) 
		{
			
			if (!properties) props = new Object();
			else 
			{
				
				props = properties;
				
			}
			checkProperties();
			horizontal = isHorizontal;	
			
			obj = item;
			
			
			dragRectangle = borders;
			
			if (horizontal)
			{
				startX = dragRectangle.x + (dragRectangle.width)/2;
				startY = dragRectangle.y;
				startPos = startX;
			}
			else
			{
				startY = dragRectangle.y + (dragRectangle.height)/2;
				startX = dragRectangle.x;
				startPos = startY;
			}
			dragLimit = setDragLimit;
		

			if (obj.x != startX || obj.y != startY) 
			{
				var tween:TweenMax = new TweenMax( obj, 0.5, { y: startY, x:startX, alpha:1 } );
				tween.addEventListener(TweenEvent.COMPLETE, init);
			}
			else
			{
				init();
			}
		}
		
		private function checkProperties():void 
		{
			if (props.banUp) 
			{
				trace('ban up' );
				swipeUpAllowed = false;
			}
			if (props.banDown)
			{
				trace('ban down');
				swipeDownAllowed = false;
				
			}
		}
		protected function init(e:Event = null):void
		{
			//trace('init behavior');
			controlListener = Controller.addDragListener(obj, dragRectangle); 
			controlListener.addEventListener(DragController.ON_START_DRAG, grab);
			controlListener.addEventListener(DragController.ON_STOP_DRAG, drop);

			enabled = true;
		}
		
		
		private function ondrag(e:Event):void 
		{
			
		}
		protected var startDragX:int;
		protected var startDragY:int;
		protected var swipeFailed:Boolean;
		protected var swipeTimer:Timer;
		public function grab(e:Event):void
		{
			//trace('start drag');
			startDragX = controlListener.stageX;
			startDragY = controlListener.stageY;
			swipeTimer = new Timer(200, 1);
			swipeTimer.start();
			swipeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, swipeTimer_timerComplete);
			swipeFailed = false;
		}
		
		private function swipeTimer_timerComplete(e:TimerEvent):void 
		{
			
			swipeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, swipeTimer_timerComplete);
			swipeFailed = true;
		}
		public function drop(e:Event):void 
		{
			//trace('drop');
			//trace(Math.abs(startDragX - controlListener.stageX));
			
			
			if (enabled == true ) 
			{
				if(!swipeFailed)
				{
					if (horizontal && Math.abs(startDragX - controlListener.stageX) > 30)
					{
						if (startDragX > controlListener.stageX && swipeUpAllowed) 
						{
							tweenOut( -1);
							return;
						}
						else if (startDragX < controlListener.stageX && swipeDownAllowed) 
						{
							tweenOut( 1);
							return;
						}
					}
					else if (!horizontal && Math.abs(startDragY - controlListener.stageY) > 30)
					{
						if (startDragY > controlListener.stageY && swipeUpAllowed) 
						{
							tweenOut( -1);
							return;
						}
						else if ( startDragY < controlListener.stageY && swipeDownAllowed) 
						{
							tweenOut( 1);
							return;
						}
					}
					
					
				}
				
				isOut();
			}
			
		}
		protected function isOut():void
		{
			//trace('is out?');
			var position:int;
			if (horizontal)	position = obj.x;
			else	position = obj.y;
			//trace(position);
			if (position < startPos-dragLimit && swipeUpAllowed) 
			{
				//swipeOut(true);
				//Popup.showPhotoWindow(PhotoGallery.gallery, 0, this.closeListener,1);
				tweenOut( -1);
			}
			else if (position > startPos+dragLimit && swipeDownAllowed)
			{
				tweenOut(1);
				//swipeOut(false);
				//Popup.showPhotoWindow(PhotoGallery.gallery, 0, closeListener,-1);
			}
			else {
				TweenLite.to(obj, 0.5, { x:startX, y:startY } );
			}
		}
		protected function tweenOut(dir:int = 1):void //-1 left/up , 1 right/down
		{
			
			//trace('out!');
			disable();
			var ev:Event;
			var tween:TweenMax
			if (horizontal)
			{
				if (dir == 1)
				{
					tween = new TweenMax( obj, 0.5, { x: dragRectangle.x + dragRectangle.width , alpha:0 } );
					ev = new Event(UPPER_LIMIT_EXCEEDED);
				}
				else
				{
					//trace('lower limit');
					tween = new TweenMax( obj, 0.5, { x: dragRectangle.x, alpha:0 } );
					ev = new Event(LOWER_LIMIT_EXCEEDED);
				}
			}
			else
			{
				if (dir == 1)
				{
					tween = new TweenMax( obj, 0.5, { y: dragRectangle.height, alpha:0 } );
					ev = new Event(UPPER_LIMIT_EXCEEDED);
				}
				else
				{
					tween = new TweenMax( obj, 0.5, { y: 0, alpha:0} );
					ev = new Event(LOWER_LIMIT_EXCEEDED);
				}
			}
			dispatchEvent(ev);
			
			tween.addEventListener(TweenEvent.COMPLETE, tweenComplete);
		}
		
		private function tweenComplete(e:Event):void 
		{
			//obj.tweenComplete();
			dispatchEvent(new Event(TWEENOUT_ENDED));
		}
		
		public function disable():void
		{
			
			//Controller.removePressListener(obj, grab); 
			enabled = false;
			//trace('disable')
			if(controlListener) controlListener.enabled = false;
			
			if(swipeListener) swipeListener.enabled = false;
			//Controller.removeReleaseListener(Globals.Stage, drop);
		}
		
		
		
	}

}