package oni.entities.lights 
{
	import oni.assets.AssetManager;
	import oni.Oni;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Sam Hellawell
	 */
	public class TexturedLight extends Light
	{
		/**
		 * The base point light image
		 */
		protected var _baseImage:Image;
		
		/**
		 * Crates a textured light with the given parameters
		 * @param	colour
		 * @param	intensity
		 */
		public function TexturedLight(params:Object) 
		{
			//Super
			super(params);
			
			//Create a base image
			if (params.atlas == "" || params.atlas == null)
			{
				_baseImage = new Image(AssetManager.getTexture(params.texture));
			}
			else
			{
				_baseImage = new Image(AssetManager.getTextureAtlas(params.atlas).getTexture(params.texture));
			}
			_baseImage.color = params.colour;
			_baseImage.alpha = params.intensity;
			addChild(_baseImage);
			
			//Listen for collision update
			addEventListener(Oni.UPDATE_DATA, _redraw);
		}
		
		/**
		 * Redraws/updates the light
		 * @param	e
		 */
		private function _redraw(e:Event):void
		{
			//Tint the base image
			if(_baseImage.color != colour) _baseImage.color = colour;
			
			//Set alpha
			if(_baseImage.alpha != intensity) _baseImage.alpha = intensity;
			
			//Set cull bounds
			cullBounds.setTo(0, 0, width + 64, height + 64);
		}
		
	}

}