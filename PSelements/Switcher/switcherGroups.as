package PS.PSelements.Switcher 
{
	import PS.PSelements.SwitchButton2;
	/**
	 * ...
	 * @author 
	 */
	public class switcherGroups 
	{
		public static var allGroups:Object = new Object();
		
		
		public static function addToGroup(switcher:SwitchButton2, group:String):void
		{
			if (!allGroups[group]) allGroups[group] = new Vector.<SwitchButton2>;
			allGroups[group].push(switcher);
		}
		public static function removeFromGroup(switcher:SwitchButton2, group:String):void
		{
			
		}
		
		public static function unselectGroup(group:String):void
		{
			if (allGroups[group])
			{
				var gr:Vector.<SwitchButton2> = allGroups[group];
				for (var i:int = gr.length-1; i >=0; i--)
				{
					gr[i].Unselect();
					
				}
			}
		}
	
		
	}

}