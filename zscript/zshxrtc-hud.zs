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
					DrawHPAP(TicFrac);
				}
		}
		
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
		
		protected virtual void DrawStats (double TicFrac)
		{
			CacheCvars();
			bool show_time  = HX_ShowTime.GetBool();
			bool show_linfo = HX_ShowLinfo.GetBool();
			
			int x = w_deathzone.GetInt();
			int y = h_deathzone.GetInt();
			float alpha = HUD_alpha.GetFloat() / 100;
			
			float TimeBox_x = (h_HXCONSOLEFONT * 9.625);
			float TimeBox_y = (h_HXCONSOLEFONT*2.25);
			
			float LInfoBox_x = TimeBox_x;
			float LinfoBox_y = ((h_HXGENERALFONTS * 5) + 2);
			if (show_time == true)
			{
				Draw9Slice((x, y), (TimeBox_x, TimeBox_y), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				DrawString(HXCONSOLEFONT, level.TimeFormatted(), ((x + (TimeBox_x / 2) - 1) , (y + (TimeBox_y / 4))), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_CENTER);
				y += TimeBox_y;
			}
			
			if (show_linfo == true)
			{
				Draw9Slice((x, y), (LInfoBox_x, LinfoBox_y), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				DrawString(HXGENERALFONTS, "KILLS", (x + w_HXGENERALFONTS, y + h_HXGENERALFONTS), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXGENERALFONTS, level.killed_monsters.."", ((x + (10 * w_HXGENERALFONTS)), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXGENERALFONTS, "-", ((x + (10 * w_HXGENERALFONTS)), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXGENERALFONTS, level.total_monsters.."", ((x + (14 * w_HXGENERALFONTS) ), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				y += h_HXGENERALFONTS + 1;
				
				DrawString(HXGENERALFONTS, "ITEMS", (x + w_HXGENERALFONTS, y + h_HXGENERALFONTS), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXGENERALFONTS, level.found_items.."", ((x + (10 * w_HXGENERALFONTS)), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXGENERALFONTS, "-", ((x + (10 * w_HXGENERALFONTS)), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXGENERALFONTS, level.total_items.."", ((x + (14 * w_HXGENERALFONTS) ), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				y += h_HXGENERALFONTS + 1;
				
				DrawString(HXGENERALFONTS, "SCRTS", (x + w_HXGENERALFONTS, y + h_HXGENERALFONTS), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXGENERALFONTS, level.found_secrets.."", ((x + (10 * w_HXGENERALFONTS)), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXGENERALFONTS, "-", ((x + (10 * w_HXGENERALFONTS)), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXGENERALFONTS, level.total_secrets.."", ((x + (14 * w_HXGENERALFONTS) ), (y + h_HXGENERALFONTS)), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			}
		}
		
		protected virtual void DrawHPAP (double TicFrac)
		{
			CacheCvars();
			int x = w_deathzone.GetInt();
			int y = h_deathzone.GetInt();
			float alpha = HUD_alpha.GetFloat() / 100;
			
			int PHealth = pwm.Health;
			int PMaxHealth = pwm.GetMaxHealth(true);
			
			let ArmorType = pwm.FindInventory("BasicArmor");
			let PArmor = ArmorType.amount;
			let PMaxArmor = ArmorType.MaxAmount;
			
			// Change 43 to Bar Width and 6 to something...
			float x_HealthBox = (((6 * w_HXGENERALFONTM)) + (43) + (4 * w_HXCONSOLEFONT) + (6));
			float y_HealthBox = (3 * w_HXCONSOLEFONT);
			
			Draw9Slice((x, -(y + y_HealthBox)), (x_HealthBox, y_HealthBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha); y += (1.25 * w_HXCONSOLEFONT);
			DrawString(HXGENERALFONTM, "ARMOUR", ((x + w_HXGENERALFONTM), (-y)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", PArmor, PMaxArmor, ((x + (7 * w_HXGENERALFONTM) + 2), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawString(HXCONSOLEFONT, PArmor.."", (((x + (7 * w_HXGENERALFONTM) + 2) + (43) + (3 * w_HXCONSOLEFONT)), -(y + 2)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);
			
			y += (w_HXCONSOLEFONT);
			DrawString(HXGENERALFONTM, "HEALTH", ((x + w_HXGENERALFONTM), (-y)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", PHealth, PMaxHealth, ((x + (7 * w_HXGENERALFONTM) + 2), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawString(HXCONSOLEFONT, PHealth.."", (((x + (7 * w_HXGENERALFONTM) + 2) + (43) + (3 * w_HXCONSOLEFONT)), -(y + 2)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);
		}
		
	}