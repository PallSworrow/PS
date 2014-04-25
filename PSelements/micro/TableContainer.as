package PS.PSelements.micro 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class TableContainer extends Sprite 
	{
		private var _rows:int;
		private var _itvX:int;
		private var _itvY:int;
		private var _vertical:Boolean;
		private var _count:int=0;
		
		private var _itemWidth:int;
		private var _itemHeight:int;
		public function TableContainer(numOfRows:int, intervalX:int = 0, intervalY:int = 0, isVertical:Boolean = true )
		{
			super();
			_rows = numOfRows;
			_itvX = intervalX;
			_itvY = intervalY;
			_vertical = isVertical;
			
		}
		public function forceItemSize(w:int, h:int):void
		{
			_itemWidth = w;
			_itemHeight = h;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			trace('itemWidth = ' + itemWidth)
			trace('itvX = ' + _itvX)
			if (!_itemWidth)
			{
				_itemWidth = child.width;
				_itemHeight = child.height;
			}
			var _x:int = (_itemWidth + _itvX);
			var _y:int = (_itemHeight + _itvY);
			if (_vertical)
			{
				child.x = (_count % _rows) *_x ;
				child.y =  int(_count / _rows) * _y;
				
			}
			else
			{
				child.x =  int(_count/ _rows)*_x;
				child.y = (_count %  _rows) *_y ;
			}
			_count++;
			return super.addChild(child);
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			//return super.removeChild(child);????
			return null;
		}
		
		public function getSizeOfXrows(rows:int):int
		{
			if (_vertical) return _itemHeight * rows + _itvY * (rows-1);
			else return _itemWidth * rows + _itvX * (rows-1);
			
		}
		
		
		
		public function get rows():int {return _rows;}
		
		public function get intervalX():int {return _itvX;}
		
		public function get intervalY():int {return _itvY;}
		
		public function get vertical():Boolean {return _vertical;}
		
		public function get count():int {return _count;}
		
		public function get itemWidth():int {return _itemWidth;}
		
		public function get itemHeight():int {return _itemHeight;}
	}

}