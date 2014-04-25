package PS.PSelements.video 
{
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import PS.PSelements.Switcher.Behaviors.ToggleBehavior;
	import PS.PSelements.Switcher.SwitchButton;
	
	/**
	 * ...
	 * @author 
	 */
	public class VideoBox extends Sprite 
	{
		public static const ONLOAD:String = 'onload';
		public static const ONCLEAR:String = 'onclear';
		private var vl:IVideoPlayer;
		private var vc:VPControls;
		
		
		private var isFogged:Boolean = true;
		
		
		
		private var fog:SwitchButton;
		private var fogBGpause:Shape;
		private var fogBG2play:Shape;
		private var fogBtn:DisplayObject;
		public function VideoBox(video:IVideoPlayer, playerControls:VPControls, fogButton:DisplayObject=null) 
		{
			//local:
			vl = video;
			vc = playerControls;
			
			//=========================================
			
			
			
			
			
			//Make fog object:-------------
			var fg:Sprite = new Sprite();
			fogBGpause = new Shape(); 
			fogBGpause.graphics.lineStyle(0, 0x000000); 
			fogBGpause.graphics.beginFill(0x00ff0000); 
			fogBGpause.graphics.drawRect(0, 0, 100, 100); 
			fogBGpause.graphics.endFill();
			fogBGpause.alpha = 0;
			fg.addChild(fogBGpause);
			if (fogButton)
			{
				fogBtn = fogButton;
				fg.addChild(fogBtn);
			}
			
			fog = new SwitchButton(fg, 'videobox',false);
			fog.addHandler(onVideoTap);
			
			
			fogBG2play = new Shape(); 
			fogBG2play.graphics.lineStyle(0, 0x000000); 
			fogBG2play.graphics.beginFill(0x00ff0000); 
			fogBG2play.graphics.drawRect(0, 0, 100, 100); 
			fogBG2play.graphics.endFill();
			fogBG2play.alpha = 0;
			fog.addSwitchBehavior(new ToggleBehavior(fogBG2play));
			
			fog.x = (vl.width - fog.width) / 2;
			fog.y = (vl.height- fog.height) / 2;
			fog.visible = false;
			//=======================================
			
			vc.addEventListener(VPControls.PAUSE, vc_pause);
			vc.addEventListener(VPControls.PLAY, vc_play);
			
			
			addChild((vl as DisplayObject));
			addChild(fog);
			addChild(vc);
			vc.init(vl);
			vc.y = vl.height - vc.height;
			
			vl.addEventListener(vl.EVENT_ON_LOAD, vl_onLoad);
			vl.addEventListener(vl.EVENT_ON_CLEAR, vl_eventOnClear);
			
		
			
			
			//================================
		}
		
		private function vl_eventOnClear(e:Event):void 
		{
			dispatchEvent(new Event(ONCLEAR));
		}
		
		private function vc_play(e:Event):void 
		{
			trace('VC - play. fog:'+isFogged);
			if (isFogged)
			{
				
				fog.select(false);
			}
			isFogged = false;
		}
		
		private function vc_pause(e:Event):void 
		{
			trace('VC - stop fog:'+isFogged);
			if (!isFogged)
			{
				trace('SELECT!');
				fog.select(false);
			}
			isFogged = true;
		}
		
		private function onVideoTap():void 
		{
			trace('tap video');
			if (vl.isPlaying == false)
			{
				isFogged = false;
				vl.play();
			}
			else
			{
				isFogged = true;
				vl.stop();
			}
		}
		
		private function vl_onLoad(e:Event):void 
		{
			
			vc.width = vl.width;
			trace(vl.width);
			vc.x = (vl.width - vc.width) / 2
			
			fog.visible = true;
			fogBGpause.width = vl.width;
			fogBGpause.height = vl.height;
			if (fogBtn)
			{
				
				fogBtn.x = (vl.width - fogBtn.width) / 2;
				fogBtn.y = (vl.height - fogBtn.height) / 2;
			}
			fog.x = (vl.width - fog.width) / 2;
			fog.y = (vl.height - fog.height) / 2;
			
			fogBG2play.width = vl.width;
			fogBG2play.height = vl.height;
			dispatchEvent(new Event(ONLOAD));
		}
		public function load(id:String):void
		{
			vl.load(id);
			fog.visible = false;
		}
		
		protected function get currentVideoPlayer():IVideoPlayer 
		{
			return vl;
		}
		
	}

}