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
					DrawMugshot(TicFrac);
					DrawBerserk(TicFrac);
					DrawArmor(TicFrac);
					DrawArmorPercent(TicFrac);
					DrawAllAmmoBox(TicFrac);
					DrawAmmoBox(TicFrac);
				}
		}
		
		protected virtual void DrawBGNums (int y)
		{
			Vector2 pos1 = ((Right_x) , y);
			Vector2 pos2 = ((Right_x - (XIndex_Offset)) , y);
			int col = Font.CR_Gray;
			// DrawString(HXINDEXFONTS, "688888", pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);
			if (LI_Length == 3) { DrawString(HXINDEXFONTS, "888", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "888", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); }
			else if (LI_Length == 4) { DrawString(HXINDEXFONTS, "8888", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "8888", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);}
			else if (LI_Length == 5) { DrawString(HXINDEXFONTS, "88888", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "88888", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);}
			else if (LI_Length == 6) { DrawString(HXINDEXFONTS, "888888", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "888888", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);}
		}
		
		protected virtual void DrawLetters4Stats (String str1, String str2, String str3, String str4)
		{
			Vector2 pos = (x + (TexOffset - 1), y);
			if (LI_Length == 3) { DrawString(HXGENERALFONTS, str1, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);}
			else if (LI_Length == 4) { DrawString(HXGENERALFONTS, str2, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);}
			else if (LI_Length == 5) { DrawString(HXGENERALFONTS, str3, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);}
			else if (LI_Length == 6) { DrawString(HXGENERALFONTS, str4, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);}
		}
		
		protected virtual void DrawStats (double TicFrac)
		{
			CacheCvars();
			if (show_time == true)
			{
				Vector2 timepos = ((x + (x_TimeBox / 2) - 1) , (y + (y_TimeBox / 4)));
				int col = Font.CR_Gray;
				Draw9Slice((x, y), (x_TimeBox, y_TimeBox), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				DrawString(HXCONSOLEFONT, "88:88:88", timepos , DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_CENTER, Font.CR_Black);		
				DrawString(HXCONSOLEFONT, level.TimeFormatted(), timepos , DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_CENTER);
				y += y_TimeBox;
			}
			
			if (show_linfo == true)
			{
				Draw9Slice((x, y), (x_LInfoBox, y_LInfoBox), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				y += h_HXGENERALFONTS; DrawBGNums(y);
				DrawLetters4Stats("KILLS:", "KILLS", "KI:", "");
				DrawString(HXINDEXFONTS, level.killed_monsters.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_monsters.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				
				y += h_HXINDEXFONTS; DrawBGNums(y);
				DrawLetters4Stats("ITEMS:", "ITEMS", "IT:", "");
				DrawString(HXINDEXFONTS, level.found_items.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_items.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				
				y += h_HXINDEXFONTS; DrawBGNums(y);
				DrawLetters4Stats("SECRETS:", "SCRTS", "SC:w_HXSTATUSFONT", "");
				DrawString(HXINDEXFONTS, level.found_secrets.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_secrets.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			}
		}
		
		protected virtual void DrawHPAP (double TicFrac)
		{
			CacheCvars();
			int colorhealth = ColorNum(PHealth, HX_PMaxHealth);
			int colorarmor = ColorNum(PArmor, HX_PMaxArmor);
			
			Draw9Slice((x, -(y + y_HealthBox)), (x_HealthBox, y_HealthBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha); y += (w_HXGENERALFONTM + TexOffset - 1);
			DrawString(HXGENERALFONTM, "ARMOUR", ((x + TexOffset), (-y)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", PArmor, HX_PMaxArmor, ((x + (6 * w_HXGENERALFONTM) + TexOffset + Offset), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawBar("HXHEBROV", "", PArmorOverMax, PMaxArmorOverMax, ((x + (6 * w_HXGENERALFONTM) + TexOffset + Offset), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);		
			DrawString(HXCONSOLEFONT, "888", (((x + (7 * w_HXGENERALFONTM) + Offset) + (Bar_Width) + (3 * w_HXCONSOLEFONT)), -(y + Offset)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK);
			DrawString(HXCONSOLEFONT, PArmor.."", (((x + (7 * w_HXGENERALFONTM) + Offset) + (Bar_Width) + (3 * w_HXCONSOLEFONT)), -(y + Offset)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, colorarmor);
			
			y += (w_HXCONSOLEFONT - 1);
			DrawString(HXGENERALFONTM, "HEALTH", ((x + TexOffset), (-y)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", PHealth, HX_PMaxHealth, ((x + (6 * w_HXGENERALFONTM) + TexOffset + Offset), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawBar("HXHEBROV", "", PHealthOverMax, PMaxHealthOverMax, ((x + (6 * w_HXGENERALFONTM) + TexOffset + Offset), -(y - h_HXGENERALFONTM + 1)), 0, SHADER_HORZ, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
			DrawString(HXCONSOLEFONT, "888", (((x + (7 * w_HXGENERALFONTM) + Offset) + (Bar_Width) + (3 * w_HXCONSOLEFONT)), -(y + Offset)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, Font.CR_BLACK);
			DrawString(HXCONSOLEFONT, PHealth.."", (((x + (7 * w_HXGENERALFONTM) + Offset) + (Bar_Width) + (3 * w_HXCONSOLEFONT)), -(y + Offset)), DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, colorhealth);
		}
		
		// NEED TO REMADE! THIS IS A BULLSHIT!!!
		protected virtual void DrawMugshot (double TicFrac)
		{
			CacheCvars();			
			Draw9Slice( (x, -(y_MugBoxOffset)), (MugBox, MugBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
			DrawTexture(GetMugShot(5), (x_Mugshot, -y_Mugshot), DI_SCREEN_LEFT_BOTTOM | DI_ITEM_CENTER);
			
			// NEED TO REMADE! THIS IS A BULLSHIT!!!
			DrawBar("HXAIRBAR", "", PAirSupply, PAirSupplyMax, ((x + (TexOffset - Offset)), -(y + y_HealthBox + (TexOffset - Offset))), 0, SHADER_VERT | SHADER_REVERSE, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
		}
		
		protected virtual void DrawBerserk (double TicFrac)
		{
			let berserk = pwm.FindInventory("PowerStrength");
			Draw9Slice((x_BerserkBoxOffset, -y_SmallBoxOffset), (SmallBox, SmallBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
			DrawImage(berserk? "HXBERSRK" : "HXHEALTH", ((x_BerserkBoxOffset + (SmallBox / 2)) , -(y_SmallBoxOffset - (SmallBox / 2))), DI_ITEM_CENTER);
		}
		
		protected virtual void DrawArmor (double TicFrac)
		{
			CacheCvars();
			let ArmorType = pwm.FindInventory("BasicArmor");	
			let ArmorIcon = ArmorType.icon;
			double ArmorIconSize = (SmallBox / 1.5);
			Draw9Slice((x_ArmorBoxOffset, -y_SmallBoxOffset), (SmallBox, SmallBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
			if (PArmor != 0)
			{
				DrawTexture(ArmorIcon, (x_ArmorBoxOffset + (SmallBox / 2), -(y_SmallBoxOffset - (SmallBox / 2))), DI_ITEM_CENTER, scale:Scale2Box(ArmorIcon, ArmorIconSize));
			}
		}
		
		protected virtual void DrawArmorPercent (double TicFrac)
		{
			Draw9Slice((x_ArmorBoxOffset, -(y_SmallBoxOffset + h_ArmPercBox)), (SmallBox, h_ArmPercBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
			int col = Font.CR_Gray;
			int align = DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT;
			int RightAlign = (x_ArmorBoxOffset + SmallBox - TexOffset2);
			int RightAlign2 = (RightAlign - w_HXGENERALFONTS - Offset);
			int y_ArmPercBoxTxT = (-(y_SmallBoxOffset + h_ArmPercBox - TexOffset2));
			DrawString(HXGENERALFONTS, "8", (RightAlign , y_ArmPercBoxTxT), align, col);
			DrawString(HXGENERALFONTS, "888", (RightAlign2 , y_ArmPercBoxTxT), align, col);
			if (PArmor > 0)
			{
				DrawString(HXGENERALFONTS, "%", (RightAlign , y_ArmPercBoxTxT), align);
				DrawString(HXGENERALFONTS, PArmorPercent.."", (RightAlign2 , y_ArmPercBoxTxT), align);
			}
		}
		
		protected virtual void DrawAllAmmoBox (double TicFrac)
		{
			Draw9Slice((-(x + w_AllAmmoBox), -(y + h_AllAmmoBox)), (w_AllAmmoBox, h_AllAmmoBox), DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
		}
		
		protected virtual void DrawAmmoBox (double TicFrac)
		{
			int col = Font.CR_Gray;
			int align = DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT;
			Draw9Slice((-(x + w_AllAmmoBox + w_AmmoBox), -(y + h_AllAmmoBox)), (w_AmmoBox, h_AmmoBox), DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
			DrawString(HXSTATUSFONT, "8888", (-(x + w_AllAmmoBox + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align, col);
			DrawString(HXSTATUSFONT, PAmmo1.."", (-(x + w_AllAmmoBox + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align);
		}
	}