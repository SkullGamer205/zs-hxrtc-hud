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
			if (LI_Length == 3) { DrawString(HXINDEXFONTS, "OOO", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "OOO", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); }
			else if (LI_Length == 4) { DrawString(HXINDEXFONTS, "OOOO", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "OOOO", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);}
			else if (LI_Length == 5) { DrawString(HXINDEXFONTS, "OOOOO", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "OOOOO", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);}
			else if (LI_Length == 6) { DrawString(HXINDEXFONTS, "OOOOOO", pos1, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col); DrawString(HXINDEXFONTS, "OOOOOO", pos2, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col);}
		}
		
		protected virtual void DrawLetters4Stats (String str1, String str2, String str3, String str4, int col = Font.CR_UNTRANSLATED)
		{
			Vector2 pos = (x + (TexOffset - 1), y);
			if (LI_Length == 3) { DrawString(HXGENERALFONTS, str1, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col);}
			else if (LI_Length == 4) { DrawString(HXGENERALFONTS, str2, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col);}
			else if (LI_Length == 5) { DrawString(HXGENERALFONTS, str3, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col);}
			else if (LI_Length == 6) { DrawString(HXGENERALFONTS, str4, pos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col);}
		}
		
		protected virtual void DrawBGNumAmmo (int y, Vector2 pos, int align)
		{
			if (y < 10) {DrawString(HXSTATUSFONT, "O", pos, align);}
			else if (y < 100) {DrawString(HXSTATUSFONT, "OO", pos, align);}
			else if (y < 1000) {DrawString(HXSTATUSFONT, "OOO", pos, align);}
			else {DrawString(HXSTATUSFONT, "OOOO", pos, align);}
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
				int col_kills = ColorNum(level.killed_monsters, level.total_monsters, 11, 11, 11, 11, Font.CR_YELLOW);
				int col_items = ColorNum(level.found_items, level.total_items, 11, 11, 11, 11, Font.CR_YELLOW);
				int col_scrts = ColorNum(level.found_secrets, level.total_secrets, 11, 11, 11, 11, Font.CR_YELLOW);
				
				Draw9Slice((x, y), (x_LInfoBox, y_LInfoBox), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				y += h_HXGENERALFONTS; DrawBGNums(y);
				DrawLetters4Stats("KILLS:", "KILLS", "KI:", "", col_kills);
				DrawString(HXINDEXFONTS, level.killed_monsters.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col_kills);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col_kills);
				DrawString(HXINDEXFONTS, level.total_monsters.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col_kills);
				
				y += h_HXINDEXFONTS; DrawBGNums(y);
				DrawLetters4Stats("ITEMS:", "ITEMS", "IT:", "", col_items);
				DrawString(HXINDEXFONTS, level.found_items.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col_items);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col_items);
				DrawString(HXINDEXFONTS, level.total_items.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col_items);
				
				y += h_HXINDEXFONTS; DrawBGNums(y);
				DrawLetters4Stats("SECRETS:", "SCRTS", "SC:", "", col_scrts);
				DrawString(HXINDEXFONTS, level.found_secrets.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col_scrts);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, col_scrts);
				DrawString(HXINDEXFONTS, level.total_secrets.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, col_scrts);
			}
		}
		
		protected virtual void DrawHPAP (double TicFrac)
		{
			CacheCvars();
			int colorhealth = ColorNum(PHealth, HX_PMaxHealth, Font.CR_Red, Font.CR_Orange, Font.CR_Yellow, Font.CR_Green, Font.CR_Green, Font.CR_Blue);
			int colorarmor = ColorNum(PArmor, HX_PMaxArmor, Font.CR_Red, Font.CR_Orange, Font.CR_Yellow, Font.CR_Green, Font.CR_Green, Font.CR_Blue);
			
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
			int col = Font.CR_Black;
			int align = DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT;
			int RightAlign = (x_ArmorBoxOffset + SmallBox - TexOffset2);
			int RightAlign2 = (RightAlign - w_HXGENERALFONTS - Offset);
			int y_ArmPercBoxTxT = (-(y_SmallBoxOffset + h_ArmPercBox - TexOffset2));
			DrawString(HXGENERALFONTS, "@", (RightAlign , y_ArmPercBoxTxT), align);
			DrawString(HXGENERALFONTS, "@@@", (RightAlign2 , y_ArmPercBoxTxT), align);
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
			CacheCvars();
			int col = Font.CR_Gray;
			int align = DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT;
					
			[PAmmo1, PAmmo2, PAmmo1Amt, PAmmo2Amt] = GetCurrentAmmo();
				if (!PAmmo1 && !PAmmo2)
				{
				return;
				}
				
			if ((PAmmo1 && !PAmmo2) || (!PAmmo1 && PAmmo2) || (PAmmo1 == PAmmo2))
			{
				Ammo PAmmo = PAmmo1 ? PAmmo1 : PAmmo2;
				int ColorPAmmo = ColorNum(PAmmo.amount, PAmmo.maxamount, Font.CR_Red);
				Size_AmmoBox = PAmmo.maxamount ? AmmoBoxSize(PAmmo.maxamount) : 0;
				w_AmmoBox = (Size_AmmoBox / (1.5) * w_HXSTATUSFONT + (2 * TexOffset));
				h_AmmoBox = h_AllAmmoBox;
				Draw9Slice((-(x + w_AllAmmoBox + w_AmmoBox), -(y + h_AllAmmoBox)), (w_AmmoBox, h_AmmoBox), DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
				DrawBGNumAmmo(PAmmo.maxamount, (-(x + w_AllAmmoBox + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align );
				DrawBar("HXAMBROK", "HXAMBRBG",PAmmo.amount, PAmmo.maxamount, (-(x + w_AllAmmoBox + w_AmmoBox - TexOffset + Offset), -(y + TexOffset - 2)), 0,  SHADER_VERT | SHADER_REVERSE, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
				DrawString(HXSTATUSFONT,PAmmo.amount.."" , (-(x + w_AllAmmoBox + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align, ColorPAmmo);
			}
			else
			{
				Size_Ammo1Box = PAmmo1.maxamount ? AmmoBoxSize(PAmmo1.maxamount) : 0;
				Size_Ammo2Box = PAmmo2.maxamount ? AmmoBoxSize(PAmmo2.maxamount) : 0;
				int ColorPAmmo1 = ColorNum(PAmmo1.amount, PAmmo1.maxamount, Font.CR_Red);
				int ColorPAmmo2 = ColorNum(PAmmo2.amount, PAmmo2.maxamount, Font.CR_Red);
				w_Ammo1Box = (Size_Ammo1Box / (1.5) * w_HXSTATUSFONT + (2 * TexOffset));
				w_Ammo2Box = (Size_Ammo2Box  / (1.5) * w_HXSTATUSFONT + (2 * TexOffset));
				h_Ammo1Box = h_AllAmmoBox; h_Ammo2Box = h_Ammo1Box;
				Draw9Slice((-(x + w_AllAmmoBox + w_Ammo2Box), -(y + h_AllAmmoBox)), (w_Ammo2Box, h_Ammo2Box), DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
				DrawBGNumAmmo(PAmmo2.maxamount, (-(x + w_AllAmmoBox + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align );
				DrawBar("HXAMBROK", "HXAMBRBG",PAmmo2.amount, PAmmo2.maxamount, (-(x + w_AllAmmoBox + w_Ammo2Box - TexOffset + Offset), -(y + TexOffset - 2)), 0,  SHADER_VERT | SHADER_REVERSE, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
				DrawString(HXSTATUSFONT,PAmmo2Amt.."" , (-(x + w_AllAmmoBox + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align, ColorPAmmo2);
				
				Draw9Slice((-(x + w_AllAmmoBox + w_Ammo2Box + w_Ammo1Box), -(y + h_AllAmmoBox)), (w_Ammo1Box, h_Ammo1Box), DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
				DrawBGNumAmmo(PAmmo1.maxamount, (-(x + w_AllAmmoBox + w_Ammo2Box +TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align);
				DrawBar("HXAMBROK", "HXAMBRBG",PAmmo1.amount, PAmmo1.maxamount, (-(x + w_AllAmmoBox + w_Ammo2Box + w_Ammo1Box - TexOffset + Offset), -(y + TexOffset - 2)), 0,  SHADER_VERT | SHADER_REVERSE, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
				DrawString(HXSTATUSFONT,PAmmo1Amt.."" , (-(x + w_AllAmmoBox + w_Ammo2Box + TexOffset - 1), -(y + h_AllAmmoBox - TexOffset + 2)), align, ColorPAmmo1);
			}
		}
	}