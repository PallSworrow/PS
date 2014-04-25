package PS.PSelements.video 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IVideoPlayer extends IEventDispatcher
	{
		function get EVENT_ON_LOAD():String;
		function get EVENT_ON_CLEAR():String;
		function load(link:String):void;
		function play():void
		function stop():void
		function setVolume(val:Number):void
		function goto(offset:Number):void
		
		function get progress():Number;
		function get isPlaying():Boolean;
		
		function get height():Number;
		function get width():Number;
		function set height(value:Number):void;
		function set width(value:Number):void;
		
	}
	
}