package PS.PSelements.video 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import PS.PScontroller.Controller;
	import PS.PScontroller.TapController;
	import PS.PSelements.micro.LoadingBar;
	import PS.PSelements.micro.ScrollBar;
	import PS.PSelements.Switcher.SwitchButton;
	import PS.PSmodel.Engine;

	/**
	 * ...
	 * @author 
	 */
	public class VPControls extends Sprite
	{
		//events:---------
		public static const PLAY:String = 'play';
		public static const PAUSE:String = 'pause';
		public static const GOTO:String = 'goto';
		public static const VOLUME_CHANGED:String = 'volumechanged';
		//========================
		
		//stats:
		private var _progress:Number = 0;
		private var _volume:Number=0.5;
		private var _isPlaying:Boolean = false;
		private var _isSoundEnabled:Boolean = true;
		//==================================
		
		//graphics:
		private var _playBtn:SwitchButton;
		private var _progressBar:LoadingBar;
		private var _soundBtn:SwitchButton;
		private var _volumeBar:ScrollBar;
		private var _bg:DisplayObject;
		//===============================
		
		//engine
		private var player:IVideoPlayer;
		//=================================================
		
		
		///FLAGS and SWITCHERS:
		private var soundBtnFunction:String = 'switchSound';// showVolumeBar, switchSound.    should add a setter.
		
		private var gotoController:TapController;
		public function VPControls(playButton:SwitchButton,progressLine:LoadingBar,soundButton:SwitchButton,volumeControll:ScrollBar=null, bgTexture:DisplayObject=null) 
		{
			_playBtn = playButton;
			_progressBar = progressLine;
			_soundBtn = soundButton;
			
			if (bgTexture)
			{
				_bg = bgTexture;
				addChild(_bg);
			}
			
			
			
			addChild(_progressBar);
			addChild(_soundBtn);
			addChild(_playBtn);
			
			_playBtn.addHandler(playSwitch, { } );
			_playBtn.addHandler(playSwitch, { } );
			_soundBtn.addHandler(onSoundBtn, { } );
			
			
			Engine.instance.addEventListener(Event.ENTER_FRAME, update);
			
			gotoController = Controller.addTapListener(_progressBar);
			gotoController.addEventListener(TapController.ON_TAP, goto)
			
			if (volumeControll)
			{
				_volumeBar = volumeControll;
				addChild(_volumeBar);
				_volumeBar.addEventListener(ScrollBar.ON_CHANGE, onVolumeBarChanged);
			}
			
		}
		public function init(vPlayer:IVideoPlayer):void
		{
			player = vPlayer;
		/*	if (isPlaying) player.play();
			else player.stop()*/
			
		}
		public function forcePlay():void
		{
			if (!isPlaying) 
			{
				_playBtn.select();
			}
			
		}
		public function forcePause():void
		{
			if (isPlaying) 
			{
				
				_playBtn.select();
			}
			
		}
		//EventHandlers:-------------------------
		private function playSwitch(e:Object):void
		{
			if (isPlaying == false)
			{
				
				isPlaying = true;
				dispatchEvent(new Event(PLAY));
				
			}
			else
			{
				isPlaying = false;
				dispatchEvent(new Event(PAUSE));
			}
		}
		private function onSoundBtn(e:Object):void 
		{
			switch(soundBtnFunction) 
			{
				case 'showVolumeBar':
					showVolumeBar();
					break;
					
				case 'switchSound':
					isSoundEnabled = !_isSoundEnabled;
					
					break;
			}
		}
		
		private function showVolumeBar():void
		{
			if(_volumeBar)_volumeBar.visible = true;
		}
		private function hideVolumeBar():void
		{
			if(_volumeBar)_volumeBar.visible = false;
		}
		
		private function update(e:Event):void 
		{
			if (player)
			{
				
			
				_progressBar.persent = player.progress;
				if (player.isPlaying != isPlaying)
				{
					
					if (player.isPlaying) forcePlay();
					else forcePause();
				}
				
			}
		}
		
		
		private function onVolumeBarChanged(e:Event):void 
		{
			volume = _volumeBar.persent;
		}
		
		private function goto(e:Event):void 
		{
			progress = (_progressBar.x + gotoController.localX) / _progressBar.width ;  
		}
		
		
		
		
		
		
		//=========================================================
		
		
		//PROTECTED------------------------------------------------------------
		protected function get soundBtn():SwitchButton 
		{
			return _soundBtn;
		}
		
		protected function get progressBar():LoadingBar 
		{
			return _progressBar;
		}
		
		protected function get playBtn():SwitchButton 
		{
			return _playBtn;
		}
		protected function get volumeBar():ScrollBar 
		{
			return _volumeBar;
		}
		protected function get bg():DisplayObject 
		{
			return _bg;
		}
		//======================================================================
		
		
		
		
		
		
		
		
		/// PUBLIC--------------------------------------
		
		//getters
		
		public function get progress():Number
		{
			return _progress;
		}
		public function get volume():Number 
		{
			if (_isSoundEnabled) return _volume;
			else return 0;
		}
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		public function get isSoundEnabled():Boolean 
		{
			return _isSoundEnabled;
		}
		//setters
		
		public function set isSoundEnabled(val:Boolean):void
		{
			_isSoundEnabled = val;
			if (player) 
			{
				if (val)	player.setVolume(_volume);
				else	player.setVolume(0);
			}
		}
	
		public function set progress(value:Number):void 
		{
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			_progress = value;
			_progressBar.persent = value;
			if (player) player.goto(value);
		}
		public function set volume(value:Number):void 
		{
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			
			_volume = value;
			if (value != 0) _isSoundEnabled = true;
			if (player) player.setVolume(value);
			
			if(_volumeBar) _volumeBar.persent = value;
		}
		public function set isPlaying(value:Boolean):void 
		{
			trace('set is playing to: ' + value);
			_isPlaying = value;
			
			
			
			if (player)
			{
				
				if (value) 
				{
					player.play();
				}
				else 
				{
					player.stop();
				}
			}
		}
		
		
		
		override public function set width(value:Number):void 
		{
			progressBar.scaleX = value / bg.width;
			if(bg)bg.width = value;
		}
		
		override public function set height(value:Number):void 
		{
			progressBar.scaleY = value / bg.height;
			if(bg)bg.height = value;
		}
		
		
	}

}