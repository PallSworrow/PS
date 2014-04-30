package PS.PSelements.popups.galleryTyped 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IGalleryItemBehavior 
	{
		
		function init(obj:IGalleryItem,startPos:int,leftAllowed:Boolean,rightAllowed:Boolean):void;
		function disable():void;
		function forceNext():void;
		function forceBack():void;
		function forceCenter():void;
		function checkIsOut():Boolean;
		function get state():String;
		
		
		
		
	}
	
}