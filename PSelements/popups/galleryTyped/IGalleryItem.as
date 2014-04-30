package PS.PSelements.popups.galleryTyped 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IGalleryItem 
	{
		//call backs:
		function onNext():void
		function onBack():void
		function onCenter():void
		function onNextComplete():void
		function onBackComplete():void
		function onCenterComplete():void
		function forceActiveCondition():void;
		function forceOffCondition():void;
		
		//getters & setters:
		function get x():Number
		function set x(value:Number):void
		function get y():Number
		function set y(value:Number):void
		function get activeCondition():Object;
		function get offCondition():Object;
		
		//
		
		
	}
	
}