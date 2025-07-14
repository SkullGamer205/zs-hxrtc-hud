extend class zsHXRTC_HUD
{
	// HUGE THANKS TO Agent_Ash!!!
	ui void Draw9Slice(Vector2 pos, Vector2 boxSize, int flags, String prefix, double alpha = 1.0, Vector2 scale = (1.0, 1.0))
	{
		array<TextureID> images;
		for (int i = 1; i <= 9; i++)
		{
			TextureID tex = TexMan.CheckForTexture(prefix..i);
			if (!tex.IsValid()) return;
			images.Push(tex);
		}

		boxSize.x *= scale.x;
		boxSize.y *= scale.y;
		Vector2 imgSize = TexMan.GetScaledSize(images[0]);
		double squareSize = min(boxSize.x, boxSize.y) / 3;
		scale.x = 1.0;
		scale.y = 1.0;
		imgSize.x *= scale.x;
		imgSize.y *= scale.y;
		alpha = alpha;

		// left top:
		DrawTexture(images[0], (pos.x, pos.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, alpha, scale:scale);
		// right top:
		DrawTexture(images[2], (pos.x + boxSize.x, pos.y), flags|StatusBarCore.DI_ITEM_RIGHT_TOP, alpha, scale:scale);
		// left bottom:
		DrawTexture(images[6], (pos.x, pos.y + boxSize.y), flags|StatusBarCore.DI_ITEM_LEFT_BOTTOM, alpha, scale:scale);
		// right bottom:
		DrawTexture(images[8], (pos.x + boxSize.x, pos.y + boxSize.y), flags|StatusBarCore.DI_ITEM_RIGHT_BOTTOM, alpha, scale:scale);

		double distHor = boxSize.x - imgSize.x*2;
		double distVert = boxSize.y - imgSize.y*2;

		// top:
		DrawTexture(images[1], (pos.x + imgSize.x, pos.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, alpha, scale: (distHor / imgSize.x, scale.y));
		// bottom:
		DrawTexture(images[7], (pos.x + imgSize.x, pos.y + imgSize.y + distVert), flags|StatusBarCore.DI_ITEM_LEFT_TOP, alpha, scale: (distHor / imgSize.x, scale.y));
		// left:
		DrawTexture(images[3], (pos.x, pos.y + imgSize.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, alpha, scale: (scale.x, distVert / imgSize.y));
		// right:
		DrawTexture(images[5], (pos.x + imgSize.x + distHor, pos.y + imgSize.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, alpha, scale: (scale.x, distVert / imgSize.y));
		// center:
		DrawTexture(images[4], (pos.x + imgSize.x, pos.y + imgSize.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, alpha, scale: (distHor / imgSize.x, distVert / imgSize.y));
	}
	
	ui Vector2 Scale2Box(TextureID tex, double BoxSize)
	{
		Vector2 size = TexMan.GetScaledSize(tex);
		double LongSide = max(size.x, size.y);
		double s = BoxSize / LongSide;
		return (s,s);
	}

	ui int GetColor(float value1, float value2 , int numColors, array<int> colors)
	{
		int out_color;	
		
		if (value1 <= 0) {
			return colors[0];
		}
		
		if (numColors == 1) {
			if (value1 < value2) {
			//Console.Printf("%d / %d", value1, value2);
			return colors[1];
			}
			if (value1 >= value2) {
			return colors[2];
			}
		}
		
		for (int i = 1; i <= numColors; i++) {
			float value3 = ((value2 / numColors) * i) ;
			if (value1 <= value3) {
				out_color = colors[i];
				// Console.Printf("%d / %f / %d :: %d :: %d | NumColors:: %d", value1, value3 , value2, i - 1, out_color, numColors);
				break;
			}
		}
		
		if (value1 > value2) {
			out_color = colors[numColors + 1];
		}
		return out_color;
	}

	ui int FontGetWidth(HUDFont FontName)
	{
		return FontName.mFont.GetHeight();
	}
	
	ui int FontStringWidth(String str, HUDFont FontName)
	{
		return FontName.mFont.StringWidth(str);
	}
	
	ui int TexSize(String texname)
	{
		TextureID tex = TexMan.CheckForTexture(texname);
		return TexMan.GetSize(tex);
	}
	
	clearscope int TicsConvert(int tics){
	int totalSeconds = tics / TICRATE;
	return totalSeconds;
	}
	
	// See https://forum.zdoom.org/viewtopic.php?f=46&t=56148 (Thanks Gutawer)
	ui void GetCurAmmo()
		{
		if (p) {
			for (let inv = pwm.Inv; inv; inv = inv.Inv) {
				// [argv] look through the player pawn's inventory for weapons
				if (inv is "Weapon") {
					// [argv] take each ammo item, and add it to ownedAmmo if not already present
					let ammo = Weapon(inv).Ammo1;
					if (ammo && ownedAmmo.Size() == ownedAmmo.Find(ammo)) {
						ownedAmmo.Push(ammo);
					}
					
					ammo = Weapon(inv).Ammo2;
					if (ammo && ownedAmmo.Size() == ownedAmmo.Find(ammo)) {
						ownedAmmo.Push(ammo);
					}
				}
			}
		}
				for (int i = 0; i < ownedAmmo.Size(); i++) {
					if (p.ReadyWeapon) {
						if (p.ReadyWeapon.Ammo1 == ownedAmmo[i]) {
							curAmmoIndex = i;
							break;
						}
						else if (p.ReadyWeapon.Ammo1 == NULL &&
								 p.ReadyWeapon.Ammo2 == ownedAmmo[i]) {
							curAmmoIndex = i;
							break;
						}
					}
				}
		}

}