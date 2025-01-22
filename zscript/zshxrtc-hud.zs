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
					LB_Draw(TicFrac);
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
		
	ui int TexSize(String texname)
	{
		TextureID tex = TexMan.CheckForTexture(texname);
		return TexMan.GetSize(tex);
	}
		
		protected virtual void DrawStats (double TicFrac)
		{
			CacheCvars();
			bool show_time  = HX_ShowTime.GetBool();
			bool show_linfo = HX_ShowLinfo.GetBool();
			
			int x = w_deathzone.GetInt();
			int y = h_deathzone.GetInt();
			
			int Offset = TexSize("HXBOX11");
			
			float alpha = HUD_alpha.GetFloat() / 100;
			
			float TimeBox_x = ((8 * h_HXCONSOLEFONT) + (2 * Offset));
			float TimeBox_y = (h_HXCONSOLEFONT + (1.5 * Offset));
			
			float LInfoBox_x = TimeBox_x;
			float LinfoBox_y = ((h_HXGENERALFONTS * 3) + (2 * Offset));
			
			float Right_x = (x + TimeBox_x) - (Offset);
			int LI_Length = HX_LI_Length.GetInt();
			float XIndex_Offset = (LI_Length + 1) * (w_HXINDEXFONTS -1); 
			
			if (show_time == true)
			{
				Draw9Slice((x, y), (TimeBox_x, TimeBox_y), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				DrawString(HXCONSOLEFONT, level.TimeFormatted(), ((x + (TimeBox_x / 2) - 1) , (y + (TimeBox_y / 4))), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_CENTER);
				y += TimeBox_y;
			}
			
			if (show_linfo == true)
			{
				Draw9Slice((x, y), (LInfoBox_x, LinfoBox_y), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				y += h_HXGENERALFONTS;
				DrawString(HXGENERALFONTS, "KILLS", (x + (Offset - 1), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.killed_monsters.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_monsters.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				
				y += h_HXINDEXFONTS;
				DrawString(HXGENERALFONTS, "ITEMS", (x + (Offset - 1), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.found_items.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_items.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				
				y += h_HXINDEXFONTS;
				DrawString(HXGENERALFONTS, "SCRTS", (x + (Offset - 1), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.found_secrets.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_secrets.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
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
			
			int Offset = 2;
			int TexOffset = TexSize("HXBOX11");
			int LabOffset = (6 * w_HXGENERALFONTM);
			int ValOffset = (3 * w_HXCONSOLEFONT);
			int Bar_Width = TexSize("HXHABROK");
			
			let ArmorType = pwm.FindInventory("BasicArmor");
			let PArmor = ArmorType.amount;
			let PMaxArmor = ArmorType.MaxAmount;
			
			// Change 43 to Bar Width and 6 to something...
			// float x_HealthBox = (((6 * w_HXGENERALFONTM)) + (43) + (4 * w_HXCONSOLEFONT) + (6));
			float x_HealthBox = ((2 * TexOffset + Offset) + LabOffset + Bar_Width  + ValOffset);
			int y_HealthBox = (2 * (TexOffset + (h_HXGENERALFONTM - 1)) + Offset);
			//float y_HealthBox = (3 * w_HXCONSOLEFONT);
			
			Draw9Slice((x, -(y + y_HealthBox)), (x_HealthBox, y_HealthBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha); y += (w_HXGENERALFONTM + TexOffset - 1);
			DrawString(HXGENERALFONTM, "ARMOUR", ((x + TexOffset), (-y)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", PArmor, PMaxArmor, ((x + (6 * w_HXGENERALFONTM) + TexOffset + Offset), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawString(HXCONSOLEFONT, PArmor.."", (((x + (7 * w_HXGENERALFONTM) + Offset) + (Bar_Width) + (3 * w_HXCONSOLEFONT)), -(y + Offset)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);
			
			y += (w_HXCONSOLEFONT - 1);
			DrawString(HXGENERALFONTM, "HEALTH", ((x + TexOffset), (-y)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", PHealth, PMaxHealth, ((x + (6 * w_HXGENERALFONTM) + TexOffset + Offset), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawString(HXCONSOLEFONT, PHealth.."", (((x + (7 * w_HXGENERALFONTM) + Offset) + (Bar_Width) + (3 * w_HXCONSOLEFONT)), -(y + Offset)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);
		}
		
		// NEED TO REMADE! THIS IS A BULLSHIT!!!
		protected virtual void DrawMugshot (double TicFrac)
		{
			CacheCvars();
			int x = w_deathzone.GetInt();
			int y = h_deathzone.GetInt();
			float alpha = HUD_alpha.GetFloat() / 100;
			int MugBox = 46;
		
			int Offset = 2;
			int TexOffset = TexSize("HXBOX11");
			int y_HealthBox = (2 * (TexOffset + (h_HXGENERALFONTM - 1)) + Offset);
			int y_MugBoxOffset = (y + (y_HealthBox + MugBox));
			
			int x_Mugshot = (x + (MugBox / 2));
			int y_Mugshot = ((y + y_HealthBox) + (MugBox / 2));
			
			Draw9Slice( (x, -(y_MugBoxOffset)), (MugBox, MugBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
			DrawTexture(GetMugShot(5), (x_Mugshot, -y_Mugshot), DI_SCREEN_LEFT_BOTTOM | DI_ITEM_CENTER);
			
			// NEED TO REMADE! THIS IS A BULLSHIT!!!
			DrawBar("HXAIRBAR", "", 20, 20, ((x + (TexOffset - Offset)), -(y + y_HealthBox + (TexOffset - Offset))), 0, SHADER_VERT | SHADER_REVERSE, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
		}
		
		protected virtual void LB_Draw (double TicFrac)
		{
			DrawHPAP(TicFrac);
			DrawMugshot(TicFrac);
		}
	}