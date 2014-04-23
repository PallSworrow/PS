package PS.PSmodel 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class Globals 
	{
		protected static var _mainStage:Sprite;
		protected static var _stageWidth:int;
		protected static var _stageHeight:int;
		
		internal static function init(stg:Sprite, w:int,h:int):void 
		{
			if (_mainStage)
			{
				
			}
			_mainStage = stg;
			_stageHeight = h;
			_stageWidth = w;
		}
		
		static public function get mainClip():DisplayObject {return _mainStage;}
		static public function get stageWidth():int {return _stageWidth;}
		static public function get stageHeight():int {return _stageHeight;}
		
	}

}