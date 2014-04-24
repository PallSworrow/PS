package PS.PSmodel.text 
{
	import fl.text.TLFTextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class TextBox extends TLFTextField 
	{
		
		public function TextBox(w:int, str:String = '',param:Object = null) 
		{
			super();
			var font:TextFormat;
			
			
		
			
			if (!param) param = { };
			//defaults:		
			var fnt:String='';
			var sz:int=24;
			var clr:uint=0;
			var bld:Boolean=false;
			var itl:Boolean=false;
			var undr:Boolean=false;
			var align:String;
			var Asize:String = TextFieldAutoSize.LEFT;
			wordWrap = true;
			//customs:
			if (param.font) fnt = param.font;
			if (param.size) sz = param.size;
			if (param.color) clr = param.color;
			if (param.italic) itl = param.italic;
			if (param.underlined) undr = param.underlined;
			if (param.align) align = param.align;
			if (param.autoSize) Asize = param.autoSize;
			if (param.singleLine) 
			{
				wordWrap = false;
				multiline = false;
			}
			
			
			//apply:
			font = new TextFormat(fnt, sz, clr, bld, itl, undr, null, null, align);
			autoSize = Asize;
			width = w;
			//border = true;
			embedFonts = true;
			selectable = false;
			htmlText = str;
			
			setTextFormat(font);
		}
		
	}

}