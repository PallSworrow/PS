package PS.PSelements.micro
{
	import air.net.ServiceMonitor;
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.text.engine.TabAlignment;
	import org.gestouch.gestures.TapGesture;
	import PS.PScontroller.Controller;
	import PS.PScontroller.DragController;
	import PS.PScontroller.TapController;

	
	/**
	 * ...
	 * @author Павел
	 */
	public class ScrollBar extends Sprite 
	{
		//EVENTS:
		public static const ON_SCROLL:String = 'onscroll';
		public static const ON_STEP:String = 'onscroll';
		public static const ON_CHANGE:String = 'onchange';//dragg or step
		
		
		//====================================================
		/*/
		планы:
			сделать добавление текстур не addchild-ом а через копирование bitmapdata-ы. 
			
			более красивая активация
			
			больше динамики)
			
		/*/
		
		//GRAPHIC PARAMS:
		private var indOffset:int;
		private var indicator:InteractiveObject;
		private var bg:DisplayObject;
		private var fill:DisplayObject;
		private var stepTrigger:Sprite;
		
		
		
		private var length:int;
		
		
		private var _enabled:Boolean = false;
		private var ctrl:DragController;
		private var stepControll:TapController;
		
		private var maxOffset:int;
		
		public function ScrollBar(Length:int, indicatorTex:DisplayObject, bgTex:DisplayObject, indicatorOffset:int = 0, fillTex:DisplayObject = null):void
		{
			length = Length;
			indOffset = indicatorOffset;
			
			bg=bgTex;
			bg.x = -bg.width / 2;
			
			bg.height = length;
			
			
			
			//fill
			fill = fillTex;
			if (indicatorTex is ScalableLine)
			{
				indicator = (indicatorTex as ScalableLine);
			}
			else
			{
				indicator = new Sprite();
				(indicator as Sprite).addChild(indicatorTex);
				
			}
			indicator.x = -indicator.width / 2;
				indicator.y = indOffset;
			init(0.3);
			
		}
		
		
		public function init(proportion:Number):void
		{
			enabled = false;
			
			if (proportion > 1) proportion = 1;
			if (proportion <= 0) proportion = 0.2; 
			
			stepTrigger = new Sprite();
			var square:Shape;
			square = new Shape(); 
			square.graphics.lineStyle(0, 0x000000); 
			square.graphics.beginFill(0x00ff0000); 
			square.graphics.drawRect(0, 0, indicator.width, length- indOffset*2); 
			square.graphics.endFill();
			square.alpha = 0;
			stepTrigger.addChild(square);
			stepTrigger.x = -stepTrigger.width / 2;
			stepTrigger.y = indOffset;
			stepTrigger.name = 'trigger';
			
			stepControll = Controller.addTapListener(stepTrigger);
			stepControll.addEventListener(TapController.ON_TAP, onTap);
			
			
			addChild(bg);
			//add fill
			if (fill)
			{
				addChild(fill);
				fill.x = -fill.width / 2;
				
				
			}
			addChild(stepTrigger);
			indicator.height = (bg.height - indOffset * 2) * proportion;
			addChild(indicator);
			
			enabled = true;
		}
		
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (_enabled == value) return;
			if (value)
			{
				maxOffset =  bg.height - 2 * indOffset - indicator.height;
				ctrl = Controller.addDragListener(indicator, new Rectangle(indicator.x,indOffset,  0,maxOffset));
				ctrl.addEventListener(DragController.ON_DRAG, onDrag);
				fillUpdate();
			}
			else
			{
				ctrl.enabled = false;
				ctrl.removeEventListener(DragController.ON_DRAG, onDrag);
				ctrl = null;
			}
			_enabled = value;	
		}
		
		private function onDrag(e:Event):void 
		{
			dispatchEvent(new Event(ON_CHANGE));
			dispatchEvent(new Event(ON_SCROLL));
			fillUpdate();
			
		}
		private function fillUpdate():void
		{
			if(fill) fill.height = length * persent;
		}
		private function onTap(e:Event):void 
		{
			if (stepControll.targetName == 'trigger')
			{
				
				if (stepControll.localY > indicator.y-indOffset) 
				{
					persent = persent + 0.2;
					dispatchEvent(new Event(ON_STEP));
					dispatchEvent(new Event(ON_CHANGE));
				}
				else if (stepControll.localY < indicator.y-indOffset) {
					
					persent = persent - 0.2;
					dispatchEvent(new Event(ON_STEP));
					dispatchEvent(new Event(ON_CHANGE));
				}
			}
			
		}
		
		
		
		
		public function get persent():Number
		{
			return (indicator.y - indOffset) / maxOffset;
		}
		
		public function set persent(val:Number):void
		{
			if (val > 1) val = 1;
			if (val < 0) val = 0;
			indicator.y = indOffset + maxOffset * val;
			fillUpdate();
		}
		
		
		
		
		
		
		
		
		
		
	}
}