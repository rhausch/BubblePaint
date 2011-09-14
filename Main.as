package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends MovieClip
	{
		public function Main()
		{
			trace("Start of constructor of main");
			//ImageGrid.loadBitmap(new Bitmap2());
			ImageGrid.loadSprite(new Speckles());
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		public function addedToStage(e:Event)
		{
			var topBubble:Bubble = new Bubble;
			topBubble.Init(512,5);
			topBubble.activate();
			topBubble.x = 256;
			topBubble.y = 256;
			this.addChild(topBubble);
			//this.addChild(new Bitmap(ImageGrid.bmp));
		}
		
	}
	
}