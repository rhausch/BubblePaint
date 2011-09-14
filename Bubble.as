package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Bubble extends Sprite
	{
		
		private var radius:Number;
		private var dx:Number;
		private var dy:Number;
		private var tx:Number;
		private var ty:Number;
		private var frame:uint;
		
		private var perfectColour:Boolean;
		
		public function Bubble()
		{
			super();
		}
		
		public function Init(size:uint, direction:uint)
		{
			var tempx:int;
			var tempy:int;
			if (direction == 0 || direction == 2)
			{
				tempx = 1;
			} else {
				tempx = -1;
			}
			if (direction == 0 || direction == 1)
			{
				tempy = -1;
			} else {
				tempy = 1;
			}
			var tempPoint = new Point(tempx * size / 2, tempy * size / 2);
			
			var colour:int = ImageGrid.averageColour(this.localToGlobal(tempPoint).x, this.localToGlobal(tempPoint).y,size);
			perfectColour = ImageGrid.perfectColour;
			
			var temp:Sprite = new Sprite;
			radius = size/2;
			temp.graphics.clear();
			temp.graphics.beginFill(colour);
			temp.graphics.drawCircle(0,0,radius);
			temp.graphics.endFill();
			this.addChild(temp);
		}
		
		public function activate()
		{
			if (radius > 1)
				this.addEventListener(MouseEvent.MOUSE_OVER, onClick);
		}
		
		public function onClick(e:Event)
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER, onClick);
			this.removeChildAt(0);
			var temp:Bubble;
			for (var i:uint = 0; i < 4; ++i)
			{
				temp = new Bubble();
				temp.x = 0;
				temp.y = 0;
				this.addChild(temp);
				temp.Init(radius, i);
				temp.move(i);
			}
			
		}
		
		public function move(direction:uint)
		{
			if (direction == 0 || direction == 2)
			{
				dx = 1;
			} else {
				dx = -1;
			}
			if (direction == 0 || direction == 1)
			{
				dy = -1;
			} else {
				dy = 1;
			}
			var speed:Number = radius/24;
			dy *= speed;
			dx *= speed;
			tx = 0;
			ty = 0;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(e:Event)
		{
			tx += dx;
			ty += dy;
			x = tx;
			y = ty;
			frame++;
			if (Math.abs(x) - radius >= 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				activate();
			}
		}
		
	}
}
