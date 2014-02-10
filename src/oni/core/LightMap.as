package oni.core 
{
	import oni.assets.AssetManager;
	import oni.core.DisplayMap;
	import oni.entities.lights.AmbientLight;
	import oni.entities.lights.Light;
	import oni.Oni;
	import oni.utils.Platform;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	/**
	 * ...
	 * @author Sam Hellawell
	 */
	public class LightMap extends DisplayMap
	{
		private var _ambientQuad:Quad;
		
		private var _ambientLight:Light;
		
		public function LightMap() 
		{
			//Create an ambient quad
			_ambientQuad = new Quad(1, 1, 0x0);
			
			//Disable touching
			this.touchable = false;
		}
		
		public function get ambientQuad():Quad
		{
			return _ambientQuad;
		}
		
		public function get ambientLight():Light
		{
			return _ambientLight;
		}
		
		public function set ambientLight(light:Light):void
		{
			//Check if we have a light
			if (_ambientLight != null)
			{
				_ambientLight.removeEventListener(Oni.UPDATE_DATA, _onAmbientDataUpdated);
			}
			
			//Set actual light
			_ambientLight = light;
			
			//Listen for data update
			_ambientLight.addEventListener(Oni.UPDATE_DATA, _onAmbientDataUpdated);
			
			//Update data
			_onAmbientDataUpdated(null);
		}
		
		private function _onAmbientDataUpdated(e:Event):void
		{
			//Set colour
			_ambientQuad.color = _ambientLight.colour;
			
			//Set intensity
			_ambientQuad.alpha = _ambientLight.intensity;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			//Check if ambient light
			if (child is AmbientLight)
			{
				this.ambientLight = child as AmbientLight;
				return child;
			}
			else
			{
				//Add child
				return super.addChild(child);
			}
		}
		
	}

}