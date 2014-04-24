package PS.PSmodel 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.TabAlignment;
	import flash.utils.setTimeout;
	import PS.PScontroller.Controller;
	import PS.PScontroller.TapController;
	
	/**
	 * ...
	 * @author 
	 */
	public class Window extends Sprite 
	{
		//EVENTS:
		public static const BACK:String = 'back';
		public static const CLOSE:String = 'close';
		
		
		//========================================================
		
		protected var myChild:Window;
		protected var previous:Window;
		public var owner:Window;
		protected var controller:TapController;
		
		protected var contentBox:Sprite;
		public function Window(_owner:Window,prevChild:Window=null) 
		{
			super();
			//trace('new ' + this);
			previous = prevChild;
			//owner = _owner;
			
			addEventListener(Event.ADDED_TO_STAGE, added);
		
		}
		
		protected function onTap(e:Event):void 
		{
			
		}
		
		protected function init():void
		{
			contentBox = new Sprite();
			super.addChild(contentBox);
			controller = Controller.addTapListener(this);
			controller.autoDelete = false;
			controller.addEventListener(TapController.ON_TAP, onTap)
			
		}//add content
		protected function onRendered():void
		{
			
		}
		protected function kill():void 
		{
			//trace('kill window');
			
			super.removeChild(contentBox);
			controller.enabled = false;
			controller.removeEventListener(TapController.ON_TAP, onTap)
			controller = null;
		
		}// full clear
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			if (contentBox) return contentBox.addChild(child);
			else return null;
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			if (contentBox) return contentBox.removeChild(child);
			else return null;
		}
		
		public function back():void //on back btn
		{
			dispatchEvent(new Event(BACK));
		}
		public function close():void//on close btn
		{
			dispatchEvent(new Event(CLOSE));
			//trace('close');
		}
		public function loadChild(scr:Window):void //add new child
		{
			
			closeChild();
			myChild = scr;
			addChild(myChild);
			//addChild(myChild);
			setTimeout(myChild.onRendered, 60);
			
			myChild.addEventListener(BACK, onChildBack);
			myChild.addEventListener(CLOSE, onChildClose);
				
			// myChild.init();
		}
		
		//PRIVATE METHODS-------------------------------------------------
		protected function added(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			init();
		}	
		protected function removed(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, removed);
			addEventListener(Event.ADDED_TO_STAGE, added);
			kill();
			
		}
		protected function closeChild():void
		{
			if (myChild)
			{
				//myChild.kill();
				removeChild(myChild);
				myChild.removeEventListener(BACK, onChildBack);
				myChild.removeEventListener(CLOSE, onChildClose);
				myChild = null;
			}
		}
		
		private function onChildClose(e:Event):void 
		{
			trace('on child close');
			closeChild();
		}
		
		private function onChildBack(e:Event):void //это событие может означать не закрывание child-а, а его смену на предыдущего
		{
			trace('click back');
			if (myChild.previous)
			{
				
				loadChild(myChild.previous);
			}
			else
			{
				closeChild();
			}
		}
		
		
		
		
		
		
	}

}