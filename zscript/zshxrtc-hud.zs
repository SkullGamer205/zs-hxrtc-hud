Class zsHXRTC_HUD : BaseStatusBar
{
	PlayerInfo p;
	PlayerPawn pwm;
	HUDFont HXINDEXFONTM;
	HUDFont HXSTATUSFONT;
	HUDFont HXGENERALFONTS;
	HUDFont HXGENERALFONTM;
	HUDFont HXCONSOLEFONT;

	override void Init()
	{
		Super.Init();
		// Create Fonts
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
			DrawAmmoInv(TicFrac);
			DrawAmmoCur(TicFrac);
		}
	}
	
	protected virtual void DrawStats (double TicFrac)
	{
		CacheCvars();
		if (show_time == true)
		{
			Draw9Slice(TimeBoxPos, TimeBoxSize, DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
			DrawString(TimeFont, level.TimeFormatted(), TimePos , DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_CENTER, col_par);
		}
		if (show_linfo == true)
		{
			Draw9Slice(LinfoBoxPos, LinfoBoxSize, DI_SCREEN_LEFT_TOP, "HXBOX1", alpha);
			array<string> LInfoStr = {"KILLS", "ITEMS", "SCRTS"};
			int LInfoNums[6] = {
				level.killed_monsters, level.total_monsters,
				level.found_items, level.total_items,
				level.found_secrets, level.total_secrets
			};		
			array <int> LInfoCol = {col_kills, col_items, col_scrts};
			for (int i = 0; i < LInfoStr.Size(); i++)
			{
				LinfoStringID = i;
				LinfoNamePos = (x_LinfoBox + TexBox1, y_LinfoBox + (FontGetWidth(HXGENERALFONTS) + 1) * (LinfoStringID + 1));
				LinfoValuePos = ((x_LinfoBox + w_LinfoBox - TexBox1) , (y_LinfoBox + (FontGetWidth(HXGENERALFONTS) + 1) * (LinfoStringID + 1)));
				DrawString(HXGENERALFONTS, LInfoStr[i].."", LinfoNamePos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, LInfoCol[i]);
				DrawString(HXGENERALFONTS, LInfoNums[2*i].." - "..LInfoNums[(2*i)+1], LinfoValuePos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, LInfoCol[i]);
			}
		}
	}
	
	protected virtual void DrawHPAP (double TicFrac)
	{
		Draw9Slice(HealthBoxPos, HealthBoxSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
		array<string> HealthStr = {"ARMOUR", "HEALTH"};
		array <int> HealthCol = {col_ap, col_hp};
		int HealthNums[4] = {
				PArmor, PMaxArmor,
				PHealth, PMaxHealth
		};

		for (int i = 0; i < HealthStr.Size(); i++)
		{
			HealthStringID = i;
			x_NamePos = x_HealthBox + TexBox1;
			y_NamePos = -(y + TexBox1) - (FontGetWidth(HXGENERALFONTS) + 1) * (HealthStringID + 1);
			
			x_BarPos = x_NamePos + (6 * (FontGetWidth(HXGENERALFONTM)) + 2);
			y_BarPos = y_NamePos;
		
			x_ValuePos = x_BarPos + BarWidth + (3 * FontGetWidth(HXCONSOLEFONT));
			y_ValuePos = y_BarPos - 2;
			
			HealthNamePos = (x_NamePos, y_NamePos);
			HealthBarPos = (x_BarPos, y_BarPos);
			HealthValuePos = (x_ValuePos, y_ValuePos);
			
			DrawString(HXGENERALFONTM, HealthStr[i].."", HealthNamePos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", HealthNums[2*i], HealthNums[(2*i)+1], HealthBarPos, 0, SHADER_HORZ, DI_ITEM_LEFT_TOP | DI_ITEM_LEFT);
			DrawString(HXCONSOLEFONT, HealthNums[2*i].."", HealthValuePos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, HealthCol[i]);
		}
	}
	
	protected virtual void DrawMugshot (double TicFrac)
	{
		Draw9Slice(MugPos, MugSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
		DrawTexture(GetMugShot(5), MugPos2, DI_SCREEN_LEFT_BOTTOM | DI_ITEM_CENTER);
	}
	
	protected virtual void DrawAmmoInv (double TicFrac)
	{
		ownedAmmo.Clear();
		GetCurrentAmmo();
		if (ownedAmmo.Size() > 0) {
			Draw9Slice(AllAmmoBoxPos, AllAmmoBoxSize, DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
			for (int i = 0; i < ownedAmmo.Size(); i++) {
				int AmmoAmount =ownedAmmo[i].Amount;
				int AmmoMaxAmount = ownedAmmo[i].MaxAmount;
				Vector2 AllAmmoBoxLabelPos = (x_AllAmmoBoxLabel, y_AllAmmoBoxLabel - ((FontGetWidth(HXGENERALFONTS) + 1) * ownedAmmo.Size()) + ((FontGetWidth(HXGENERALFONTS) + 1) * i));
				DrawString(HXGENERALFONTS, AmmoAmount.."",AllAmmoBoxLabelPos , DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
			}
		}
	}
	
	protected virtual void DrawAmmoCur (double TicFrac)
	{
	}
	
}