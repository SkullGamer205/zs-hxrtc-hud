	Class zsHXRTC_HUD : BaseStatusBar
	{
		PlayerInfo p;
		PlayerPawn pwm;
		HUDFont HXINDEXFONTS;
		HUDFont HXINDEXFONTM;
		HUDFont HXSTATUSFONT;
		HUDFont HXGENERALFONTS;
		HUDFont HXGENERALFONTM;
		HUDFont HXCONSOLEFONT;
		
		override void Init()
		{
			Super.Init();
			// Create Fonts
			HXINDEXFONTS = HUDFont.Create("HXINDEXFONTS");
			HXINDEXFONTM = HUDFont.Create("HXINDEXFONTM");
			HXSTATUSFONT = HUDFont.Create("HXSTATUSFONT");
			HXGENERALFONTS = HUDFont.Create("HXGENERALFONTS");
			HXGENERALFONTM = HUDFont.Create("HXGENERALFONTM");
			HXCONSOLEFONT  = HUDFont.Create("consolefont");
		}
		
		override void Draw (int state, double TicFrac)
		{
			Super.Draw (state, TicFrac);
				if (state == HUD_StatusBar)
				{
					BeginStatusBar();
				}
				else if (state == HUD_Fullscreen)
				{
					BeginHUD();
					DrawStats(TicFrac);
				}
		}
		
	// HUGE THANKS TO Agent_Ash!!!
	ui void Draw9Slice(Vector2 pos, Vector2 boxSize, int flags, String prefix, Vector2 scale = (1.0, 1.0))
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

		// left top:
		DrawTexture(images[0], (pos.x, pos.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, scale:scale);
		// right top:
		DrawTexture(images[2], (pos.x + boxSize.x, pos.y), flags|StatusBarCore.DI_ITEM_RIGHT_TOP, scale:scale);
		// left bottom:
		DrawTexture(images[6], (pos.x, pos.y + boxSize.y), flags|StatusBarCore.DI_ITEM_LEFT_BOTTOM, scale:scale);
		// right bottom:
		DrawTexture(images[8], (pos.x + boxSize.x, pos.y + boxSize.y), flags|StatusBarCore.DI_ITEM_RIGHT_BOTTOM, scale:scale);

		double distHor = boxSize.x - imgSize.x*2;
		double distVert = boxSize.y - imgSize.y*2;

		// top:
		DrawTexture(images[1], (pos.x + imgSize.x, pos.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, scale: (distHor / imgSize.x, scale.y));
		// bottom:
		DrawTexture(images[7], (pos.x + imgSize.x, pos.y + imgSize.y + distVert), flags|StatusBarCore.DI_ITEM_LEFT_TOP, scale: (distHor / imgSize.x, scale.y));
		// left:
		DrawTexture(images[3], (pos.x, pos.y + imgSize.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, scale: (scale.x, distVert / imgSize.y));
		// right:
		DrawTexture(images[5], (pos.x + imgSize.x + distHor, pos.y + imgSize.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, scale: (scale.x, distVert / imgSize.y));
		// center:
		DrawTexture(images[4], (pos.x + imgSize.x, pos.y + imgSize.y), flags|StatusBarCore.DI_ITEM_LEFT_TOP, scale: (distHor / imgSize.x, distVert / imgSize.y));
	}
		
		protected virtual void DrawStats (double TicFrac)
		{
			CacheCvars();
			int x = w_deathzone.GetInt();
			int y = h_deathzone.GetInt();
			
			// Draw9Slice((0, 0), (256, 150), StatusBarCore.DI_SCREEN_LEFT_TOP, "TestBox");
			Draw9Slice((x, y), ((h_HXCONSOLEFONT * 8) + 2 * 3, h_HXCONSOLEFONT + 2 * 3 ), DI_SCREEN_LEFT_TOP, "HXBOX1");
			
			DrawString(HXCONSOLEFONT, level.TimeFormatted(), (x, y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT); y+=h_HXCONSOLEFONT + 1;
			
			DrawString(HXGENERALFONTS, "KILLS", (x, y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
			DrawString(HXGENERALFONTS, level.killed_monsters.."", (x + 3 + (8 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			DrawString(HXGENERALFONTS, "-", (x + 4 + (8 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
			DrawString(HXGENERALFONTS, level.total_monsters.."", (x + 4 + (12 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT); y+=h_HXGENERALFONTS + 1;
			
			DrawString(HXGENERALFONTS, "ITEMS", (x, y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
			DrawString(HXGENERALFONTS, level.found_items.."", (x + 3 + (8 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			DrawString(HXGENERALFONTS, "-", (x + 4 + (8 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
			DrawString(HXGENERALFONTS, level.total_items.."", (x + 4 + (12 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT); y+=h_HXGENERALFONTS + 1;
			
			DrawString(HXGENERALFONTS, "SCRTS", (x, y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
			DrawString(HXGENERALFONTS, level.found_secrets.."", (x + 3 + (8 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			DrawString(HXGENERALFONTS, "-", (x + 4 + (8 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
			DrawString(HXGENERALFONTS, level.total_secrets.."", (x + 4 + (12 * w_HXGENERALFONTS), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			
		}
	}