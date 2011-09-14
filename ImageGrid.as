package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class ImageGrid
	{
		
		public static var bmp:BitmapData;
		
		public function ImageGrid()
		{
			
		}
		
		public static function loadBitmap(img:BitmapData)
		{
			bmp = img;
			trace("Bitmap loaded: width=" + bmp.width + " height=" + bmp.height);
		}
		
		public static var perfectColour:Boolean = false;
		
		public static function averageColour( x:int, y:int, radius:int ):uint
		{
			//trace("averageColour(" + x + "," + y + "," + radius + ")");
			
			//return Math.random() * 0xFFFFFF;
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;

			var count:Number = 0;
			var pixel:Number;

			perfectColour = true;
			
			for (var xi:int = x; xi < x + radius; xi++)
			{
				for (var yi:int = y; yi < y + radius; yi++)
				{
					var tmp:Number = pixel;
					pixel = bmp.getPixel(xi, yi);

					if (perfectColour && !isNaN(tmp) && pixel != tmp)
					{	
						perfectColour = false;
					}
					
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;

					count++
				}
			}
			
			red /= count;
			green /= count;
			blue /= count;
			
			if (perfectColour)
				trace("Perfect! ", red << 16 | green << 8 | blue);
			
			return red << 16 | green << 8 | blue;
		}
		
		private static const BITMAP_SIZE:uint = 512;
		
		public static function loadSprite(sprite:Sprite)
		{
			//Start with the transform matrix of the target
			var transformMatrix:Matrix = new Matrix();// sprite.transform.concatenatedMatrix;
			//Get the bounding rectangle of the target relative to the wordbar
			var bounds:Rectangle = sprite.getBounds(sprite); //TODO: Change this from stage  //this.stage
			//Shift the transform matrix to put the object in the top left corner (adding a little buffer)
			transformMatrix.tx = transformMatrix.tx - bounds.left;
			transformMatrix.ty = transformMatrix.ty - bounds.top;
			
			//Scale to largest dimension
			var scaleX:Number;
			var scaleY:Number;
			if (bounds.width > bounds.height){ //Width is larger so scale to that
				scaleX = BITMAP_SIZE / bounds.width;
				scaleY = BITMAP_SIZE / bounds.width;
			} else { //Height is larger so scale to that
				scaleX = BITMAP_SIZE / bounds.height;
				scaleY = BITMAP_SIZE / bounds.height;
			}
			
			//Create the scale matrix
			var wordbarTransform:Matrix = new Matrix();
			wordbarTransform.createBox(scaleX, 		//Scale the width
									scaleY, 		//Scale the height
									0,				//No rotation
									(BITMAP_SIZE - (bounds.width * scaleX)) / 2,	//Shift to the center of the box
									(BITMAP_SIZE - (bounds.height * scaleY)) / 2);	//Shift to the center of the box
			
			//Combind the two transforms
			transformMatrix.concat(wordbarTransform);
			
			
			//Create the bitmapData to the desired size (with buffer)
			var bitmapData:BitmapData = new BitmapData(BITMAP_SIZE, BITMAP_SIZE);
			//Draw the target into it using the combined transform
			bitmapData.draw(sprite, transformMatrix, sprite.transform.concatenatedColorTransform);
			
			//Save bitmap
			bmp = bitmapData;
			
		}

	}
}