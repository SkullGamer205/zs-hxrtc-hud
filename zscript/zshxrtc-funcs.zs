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
		
	ui int ColorNum(int num1, int num2, int col1 = Font.CR_UNTRANSLATED, int col2 = Font.CR_UNTRANSLATED, int col3 = Font.CR_UNTRANSLATED, int col4 = Font.CR_UNTRANSLATED, int col5 = Font.CR_UNTRANSLATED , int col6 = Font.CR_UNTRANSLATED)
	{
		int col;
		if (num1 > num2 * 1)
			col = col6;
		else if (num1 == num2)
			col = col5;
		else if (num1 >= num2 * 0.75)
			col = col4;
		else if (num1 >= num2 * 0.5)
			col = col3;
		else if (num1 >= num2 * 0.25)
			col = col2;
		else
			col = col1;
		return col;
	}
		
	ui int TexSize(String texname)
	{
		TextureID tex = TexMan.CheckForTexture(texname);
		return TexMan.GetSize(tex);
	}
	
	ui int AmmoBoxSize(int a)
	{
		int b;
		if (a < 10)
			b = 1;
		else if (a < 100)
			b = 2;
		else if (a < 1000)
			b = 3;
		else
			b = 4;
		return b;
	}
	
	ui Vector2 Scale2Box(TextureID tex, double BoxSize)
	{
		Vector2 size = TexMan.GetScaledSize(tex);
		double LongSide = max(size.x, size.y);
		double s = BoxSize / LongSide;
		return (s,s);
	}

}