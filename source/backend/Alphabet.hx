package backend;

class Alphabet extends FlxSpriteGroup
{
	static final letters:Array<String> = [
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
	];

	var daX:Float = 0;
	var alignment:FlxTextAlign;

	public var option:Dynamic;

	public function new(x:Float, y:Float, text:String, bold:Bool, alignment:FlxTextAlign, scale:Float = 1, offsetX:Float = 0, offsetY:Float = 0,
			?antiAliasing:Bool, seperation:Float = 0)
	{
		super(x + offsetX, y - offsetY);
		var chars:Array<String> = text.split("");
		var letterWidth:Float = 0;
		for (i in 0...chars.length)
		{
			var animName:String = chars[i];
			var char:FlxSprite = Util.createSparrowSprite(0, 0, "alphabet", scale, antiAliasing);
			if (animName == "\r" || animName == "\n")
				continue;
			else if (animName == " ")
			{
				letterWidth += 35 * scale;
				continue;
			}
			else if (animName == "&")
				animName = "ampersand";
			else if (animName == "")
				animName = "bullet";
			else if (animName == "'")
			{
				animName = "apostrophe";
				char.y -= char.height / 2;
			}
			else if (animName == "-")
				char.y -= char.height / 4;
			else if (animName == "\\")
				animName = "back slash";
			else if (animName == "!")
				animName = "exclamation";
			else if (animName == "/")
				animName = "forward slash";
			else if (animName == "¡")
				animName = "inverted exclamation";
			else if (animName == "¿")
				animName = "inverted question";
			else if (animName == '"')
			{
				animName = "quote";
				char.y -= char.height / 2;
			}
			else if (animName == "“")
			{
				animName = "start quote";
				char.y -= char.height / 2;
			}
			else if (animName == "”")
			{
				animName = "end quote";
				char.y -= char.height / 2;
			}
			else if (animName == "*")
				char.y -= char.height / 2;
			if (bold)
				animName += " bold";
			else if (animName.toLowerCase() != animName && letters.contains(chars[i].toLowerCase()))
				animName += " uppercase";
			else if (animName.toLowerCase() == animName && letters.contains(chars[i].toLowerCase()))
				animName += " lowercase";
			else
				animName += " normal";
			animName = animName.toLowerCase();
			char.animation.addByPrefix("idle", animName, 24);
			char.animation.play("idle");
			char.updateHitbox();
			char.centerOffsets();
			char.x = letterWidth;
			char.y -= char.height;
			letterWidth += char.width;
			add(char);

			daX = x;
			this.alignment = alignment;
			updateAlignment();
		}
	}

	public override function set_x(Value:Float):Float
	{
		daX = Value;
		return super.set_x(Value);
	}

	public function updateAlignment():Void
	{
		this.x = daX;
		switch (alignment)
		{
			case LEFT | JUSTIFY:
			case CENTER:
				this.x -= this.width / 2;
			case RIGHT:
				this.x -= this.width;
		}
	}

	public override function setColorTransform(redMultiplier = 1.0, greenMultiplier = 1.0, blueMultiplier = 1.0, alphaMultiplier = 1.0, redOffset = 0.0,
			greenOffset = 0.0, blueOffset = 0.0, alphaOffset = 0.0):Void
	{
		for (member in members)
			member.setColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset);
	}
}
