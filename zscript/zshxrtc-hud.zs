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
				}
		}
		
		protected virtual void DrawStats (double TicFrac)
		{
			CacheCvars();
			if (show_time == true)
			{
				Draw9Slice((x, y), (x_TimeBox, y_TimeBox), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				DrawString(HXCONSOLEFONT, level.TimeFormatted(), ((x + (x_TimeBox / 2) - 1) , (y + (y_TimeBox / 4))), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_CENTER);
				y += y_TimeBox;
			}
			
			if (show_linfo == true)
			{
				Draw9Slice((x, y), (x_LInfoBox, y_LInfoBox), DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
				y += h_HXGENERALFONTS;
				DrawString(HXGENERALFONTS, "KILLS", (x + (TexOffset - 1), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.killed_monsters.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_monsters.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				
				y += h_HXINDEXFONTS;
				DrawString(HXGENERALFONTS, "ITEMS", (x + (TexOffset - 1), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.found_items.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_items.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				
				y += h_HXINDEXFONTS;
				DrawString(HXGENERALFONTS, "SCRTS", (x + (TexOffset - 1), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.found_secrets.."", ((Right_x - (XIndex_Offset)), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
				DrawString(HXINDEXFONTS, "-", (Right_x - (XIndex_Offset), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT);
				DrawString(HXINDEXFONTS, level.total_secrets.."", ((Right_x), y), DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT);
			}
		}
		
		protected virtual void DrawHPAP (double TicFrac)
		{
			CacheCvars();
			
			int PHealth = pwm.Health;
			int PMaxHealth = pwm.GetMaxHealth(true);
			let ArmorType = pwm.FindInventory("BasicArmor");
						
			let PArmor = ArmorType.amount;
			let PMaxArmor = ArmorType.MaxAmount;
						
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
			int PAirSupply = CPlayer.air_finished - level.maptime;
			int PAirSupplyMax = level.airSupply;
			Draw9Slice( (x, -(y_MugBoxOffset)), (MugBox, MugBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
			DrawTexture(GetMugShot(5), (x_Mugshot, -y_Mugshot), DI_SCREEN_LEFT_BOTTOM | DI_ITEM_CENTER);
			
			// NEED TO REMADE! THIS IS A BULLSHIT!!!
			DrawBar("HXAIRBAR", "", PAirSupply, PAirSupplyMax, ((x + (TexOffset - Offset)), -(y + y_HealthBox + (TexOffset - Offset))), 0, SHADER_VERT | SHADER_REVERSE, DI_ITEM_LEFT_BOTTOM | DI_ITEM_LEFT);
		}
		
		protected virtual void DrawBerserk (double TicFrac)
		{
			Draw9Slice((x_BerserkBoxOffset, -y_SmallBoxOffset), (SmallBox, SmallBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
		}
		
		protected virtual void DrawArmor (double TicFrac)
		{
			let ArmorType = pwm.FindInventory("BasicArmor");
			let PArmor = ArmorType.amount;
			let ArmorIcon = ArmorType.icon;
			double ArmorIconSize = (SmallBox / 1.5);
			Draw9Slice((x_ArmorBoxOffset, -y_SmallBoxOffset), (SmallBox, SmallBox), DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
			if (PArmor != 0)
			{
				DrawTexture(ArmorIcon, (x_ArmorBoxOffset + (SmallBox / 2), -(y_SmallBoxOffset - (SmallBox / 2))), DI_ITEM_CENTER, scale:Scale2Box(ArmorIcon, ArmorIconSize));
			}
		}
	}