package PS.PSelements.Switcher 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IswitchBehavior 
	{
		function select ():void
		function unselect():void
		function onPress():void
		function onRelease():void
		function init(client:DisplayObjectContainer, nativeTexture:DisplayObject):void
	}
	
}