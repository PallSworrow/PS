package PS.PSelements
{
	
	import air.net.SecureSocketMonitor;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import PS.PScontroller.Controller;
	import PS.PScontroller.DragController;
	import PS.PSelements.micro.ScrollBar;
	
	/**
	 * ...
	 * @author Павел
	 */
	public class ScrollContainer extends Sprite 
	{
	
		
		//Main parameters
		private var H:int;
		private var W:int;
		private var horizontal:Boolean;
		private var _enabled:Boolean
		private var _needScroll:Boolean;
		//====================================
		//engine:
		private var msk:Sprite;
		private var cntnt:DisplayObject;
		private var obj:Sprite;
		private var invisibleBg:Shape;
		private var ctrl:DragController;
		
		private var _maxOffset:int;
		
		//animation params:
		private var tweeningTime:Number = 0.2;
		
		
		public function ScrollContainer(w:int,h:int, isHorizontal:Boolean = false):void
		{
			horizontal = isHorizontal;
			H = h;
			W = w;
			
			//create mask;
			msk = new Sprite();
			var square:Shape;
			square = new Shape(); 
			square.graphics.lineStyle(0, 0x000000); 
			square.graphics.beginFill(0x00ff0000); 
			square.graphics.drawRect(0, 0, W, H); 
			square.graphics.endFill();
			square.alpha = 0;
			msk.addChild(square);
			
			
		}
		public function setContent(content:DisplayObject):void
		{
			clear();
			cntnt = content;
			
			obj = new Sprite();
			
			invisibleBg = new Shape(); 
			invisibleBg.graphics.lineStyle(0, 0x000000); 
			invisibleBg.graphics.beginFill(0x00ff0000); 
			invisibleBg.graphics.drawRect(0, 0, content.width, content.height); 
			invisibleBg.graphics.endFill();
			invisibleBg.alpha = 0;
			
			obj.addChild(invisibleBg);
			obj.addChild(content);
			
			addChild(obj);
			addChild(msk);
			obj.mask = msk;
			
			
			if (horizontal) _maxOffset = size-W;
			else _maxOffset = size-H;
			
			if (_maxOffset > 0) _needScroll = true;
			else _needScroll = false;
			
			correctScrollBarPosition();
			correctScrollBarProportion();
			enabled = true;
			
			
			
		}
		private function get offset():int
		{
			if (horizontal) return -obj.x;
			else return -obj.y;
		}
		private function set offset(val:int):void
		{
			if (val > _maxOffset || val < 0) {/*error*/}
			else
			{
				if (horizontal) obj.x = -val;
				else obj.y = -val;
			}
		}
		private function get size():int
		{
			if (horizontal) return obj.width;
			else return obj.height;
		}
		
		
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			
			
			_enabled = value;
			
			if (!obj) return;
			
			if (enabled && !ctrl)
			{
				if (needScroll)
				{
					var dragRectangle:Rectangle;
					
					if (horizontal) dragRectangle = new Rectangle(-_maxOffset, 0,_maxOffset, 0);
					else dragRectangle = new Rectangle(0, -_maxOffset, 0, _maxOffset);
					
					ctrl = Controller.addDragListener(obj, dragRectangle);
					ctrl.addEventListener(DragController.ON_DRAG , onMove);
			
				}
			}
			else if (ctrl)
			{
				ctrl.enabled = false;
				ctrl.removeEventListener(DragController.ON_DRAG , onMove);
				ctrl = null;
			}
		}
		
		
		public function clear():void
		{
			if (obj)
			{
				removeChild(obj);
				enabled = false;
				hideScrollBar();
				cntnt = null;
				obj = null;
				invisibleBg = null;
			
				
			}
		}
		
		
		
		
		
		
		private function onMove(e:Event):void 
		{
			//onScroll(e);
			dispatchEvent(new Event('SCROLL'));
			correctScrollBarPosition();
		}
		
		
		
		public function scrollTo(targ:Number, correctSbPos:Boolean = false):void
		{
			if (_needScroll)
			{
				if (targ > 1) targ = 1;
				else if (targ < 0) targ = 0;
			
				if(horizontal) TweenLite.to(obj, tweeningTime, {x : ( -_maxOffset) * targ } );
				else TweenLite.to(obj, tweeningTime, { y : ( -_maxOffset) * targ } );
				if(correctSbPos) correctScrollBarPosition(targ);
				
			}
		}
	//PUBLIC GET-ters and SET-ters---------------------------------------------------------------------------
		
		public function get persent():Number
		{
			return offset / _maxOffset;
		}
		public function set persent(val:Number):void
		{
			if (val > 1) val = 1;
			else if (val < 0) val = 0;
			
			offset = val * _maxOffset;
		}
		
		
		override public function get width ():Number
		{
			return W;
		}
		override public function get height ():Number
		{
			return H;
		}
		
		public function get needScroll():Boolean 
		{
			return _needScroll;
		}
	//extension:-----------------------------
		private var sb:ScrollBar;
		private function correctScrollBarPosition(pos:Number =-1):void
		{
			
			if (sb)
			{
				if (pos == -1)
				{
					if(obj)sb.persent = persent;
					else sb.persent = 0;
				}
				else
				{
					//trace('tweenMax');
					TweenMax.to(sb, tweeningTime, { persent:pos } );
				}
			}
		}
		private function hideScrollBar():void
		{
			if(sb) sb.visible = false;
		}
		private function showScrollBar():void
		{
			if(sb) sb.visible = true;
		}
		private function correctScrollBarProportion():void
		{
			if (sb)
			{
				if (obj)
				{
				
					
					if (horizontal) sb.init(W / size);
					else sb.init(H / size);
					
					//trace(needScroll);
					if (needScroll)	showScrollBar();
					else hideScrollBar();
				}
			
			}
		}
		
		public function listenToScrollbar(scroller:ScrollBar):void
		{
			sb = scroller;
			sb.addEventListener(ScrollBar.ON_CHANGE, onSbChange);
			if (!obj) hideScrollBar();
			correctScrollBarProportion();
			correctScrollBarPosition();
		}
		
		private function onSbChange(e:Event):void 
		{
			scrollTo(sb.persent);
		}
		public function stopListeningScrollBar():void
		{
			if (sb)
			{
				sb.removeEventListener(ScrollBar.ON_CHANGE, onSbChange)
				sb = null;
			}	
		}
		
		
		override public function set height(val:Number):void 
		{
			msk.height = val;
			
		}
		override public function set width(val:Number):void 
		{
			msk.width = val;
			
		}
		
		public function get maxOffset():int 
		{
			return _maxOffset;
		}
	
	
	
	//========================================
		
		
		
	}
	
}