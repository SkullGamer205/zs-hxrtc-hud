Class zsHXRTC_HUD : BaseStatusBar
{
	PlayerInfo p;
	PlayerPawn pwm;
	Inventory pinvsel;
	InventoryBarState pinv;
	HUDFont HXINDEXFONTM;
	HUDFont HXSTATUSFONT;
	HUDFont HXGENERALFONTS;
	HUDFont HXGENERALFONTM;
	HUDFont HXCONSOLEFONT;
	
	HUDFont JenocideSmall;

	override void Init()
	{
		Super.Init();
		// Create Fonts
		HXINDEXFONTM = HUDFont.Create("HXINDEXFONTM");
		HXSTATUSFONT = HUDFont.Create("HXSTATUSFONT");
		HXGENERALFONTS = HUDFont.Create("HXGENERALFONTS");
		HXGENERALFONTM = HUDFont.Create("HXGENERALFONTM");
		HXCONSOLEFONT  = HUDFont.Create("consolefont");
		
		JenocideSmall  = HUDFont.Create("BigFont");
		
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
			DrawPlayerInv(TicFrac);
			DrawArmorBox(TicFrac);
			DrawArmorPercentBox(TicFrac);
			DrawBerserkBox(TicFrac);
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
				LinfoNamePos = ((x_LinfoBox + TexBox1) , (y_LinfoBox + TexBox1 + (FontGetWidth(LinfoFont) + 1) * (LinfoStringID)));
				LinfoValuePos = ((x_LinfoBox + w_LinfoBox - TexBox1) , (y_LinfoBox + TexBox1 + (FontGetWidth(LinfoFont) + 1) * (LinfoStringID)));
				DrawString(LinfoFont, LInfoStr[i].."", LinfoNamePos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_LEFT, LInfoCol[i]);
				DrawString(LinfoFont, LInfoNums[2*i].." - "..LInfoNums[(2*i)+1], LinfoValuePos, DI_SCREEN_LEFT_TOP | DI_TEXT_ALIGN_RIGHT, LInfoCol[i]);
			}
		}
	}
	
	protected virtual void DrawHPAP (double TicFrac)
	{
		Draw9Slice(HealthBoxPos, HealthBoxSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
		array <int> HealthCol = {col_ap, col_hp};
		array<string> HealthStr = {"ARMOUR", "HEALTH"};
		int HealthNums[4] = {
				PArmor, PMaxArmor,
				PHealth, PMaxHealth
		};

		for (int i = 0; i < HealthStr.Size(); i++)
		{
			HealthStringID = i;
			x_NamePos = x_HealthBox + TexBox1;
			y_NamePos = -(y + TexBox1) - (FontGetWidth(HPFont1)) * (HealthStringID + 1);
			
			x_BarPos = x_NamePos + (6 * (FontGetWidth(HPFont1)) + 2);
			y_BarPos = y_NamePos;
		
			x_ValuePos = x_BarPos + BarWidth + (3 * FontGetWidth(HPFont2));
			y_ValuePos = y_BarPos - 2;
			
			HealthNamePos = (x_NamePos, y_NamePos);
			HealthBarPos = (x_BarPos, y_BarPos);
			HealthValuePos = (x_ValuePos, y_ValuePos);
			
			DrawString(HPFont1, HealthStr[i].."", HealthNamePos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_LEFT);
			DrawBar("HXHABROK", "HXHABRBG", HealthNums[2*i], HealthNums[(2*i)+1], HealthBarPos, 0, SHADER_HORZ, DI_ITEM_LEFT_TOP | DI_ITEM_LEFT);
			DrawString(HPFont2, HealthNums[2*i].."", HealthValuePos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT, HealthCol[i]);
		}
	}
	
	protected virtual void DrawMugshot (double TicFrac)
	{
		Draw9Slice(MugPos, MugSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX1", alpha);
		DrawTexture(GetMugShot(5), MugPos2, DI_SCREEN_LEFT_BOTTOM | DI_ITEM_CENTER);
	}
	
	protected virtual void DrawPlayerInv (double TicFrac)
	{
		// Current (Selected)
		pinvsel = pwm.InvSel;
		if (pinvsel != NULL) {
			Draw9Slice(InvCurPos, InvCurSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
			Draw9Slice(InvCBordPos, InvCBordSize, DI_SCREEN_LEFT_BOTTOM, "HXSEL", alpha);
			DrawInventoryIcon(pinvsel, CurIconPos, DI_SCREEN_LEFT_BOTTOM | DI_ITEM_HCENTER);
			if (pinvsel.Amount > 1) {
				DrawString(LinfoFont, pinvsel.Amount.."", InvCountPos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
			}
		}
		// All (Bar)
		pinv = InventoryBarState.Create(InvFont, Font.CR_WHITE, alpha, "ARTIBOX", "HXSLCT");
		if (isInventoryBarVisible()) {
			DrawInventoryBar(pinv, InvBarPos, 7, DI_SCREEN_CENTER_BOTTOM | DI_ITEM_HCENTER | DI_ITEM_BOTTOM);
		}
	}
	
	protected virtual void DrawArmorBox (double TicFrac)
	{	
		let ArmorType = pwm.FindInventory("BasicArmor");	
		let ArmorIcon = ArmorType.icon;
		double ArmorIconSize = (SmallBox - (2 * TexBox2));
		Draw9Slice(ArmIcoBoxPos, ArmIcoBoxSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
		if (PArmor != 0)
		{
			DrawTexture(ArmorIcon, ArmIconPos, DI_ITEM_CENTER, scale:Scale2Box(ArmorIcon, ArmorIconSize));
		}
	}
	
	protected virtual void DrawArmorPercentBox (double TicFrac)
	{
		Draw9Slice(ArmPercBoxPos, ArmPercBoxSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
		if (PArmor > 0)
			{
				DrawString(ArmFont, PArmorPercent.."", ArmPercNumPos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
				DrawString(ArmFont, "%", ArmPercentPos, DI_SCREEN_LEFT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
			}
	}
	
	protected virtual void DrawBerserkBox (double TicFrac)
	{
		let berserk_status = pwm.FindInventory("PowerStrength");
		Draw9Slice(BskIcoBoxPos, BskIcoBoxSize, DI_SCREEN_LEFT_BOTTOM, "HXBOX2", alpha);
		DrawImage(berserk_status? "HXBERSRK" : "HXHEALTH", BskIconPos , DI_ITEM_CENTER);
	}
	
	protected virtual void DrawAmmoInv (double TicFrac)
	{
		ownedAmmo.Clear();
		GetCurAmmo();
		if (ownedAmmo.Size() > 0) {
			Draw9Slice(AllAmmoBoxPos, AllAmmoBoxSize, DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
			for (int i = 0; i < ownedAmmo.Size(); i++) {
				int AmmoAmount =ownedAmmo[i].Amount;
				int AmmoMaxAmount = ownedAmmo[i].MaxAmount;
				Vector2 AllAmmoBoxLabelPos = (x_AllAmmoBoxLabel, y_AllAmmoBoxLabel - FontGetWidth(AmmoFont1) - ((FontGetWidth(AmmoFont1) + 1) * i));
				DrawString(AmmoFont1, AmmoAmount.."",AllAmmoBoxLabelPos , DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
			}
		}
	}
	
	protected virtual void DrawAmmoIcon (double TicFrac)
	{
		DrawInventoryIcon(CPlayer.ReadyWeapon, (60, 60), DI_SCREEN_LEFT_TOP);
	}
	
	protected virtual void DrawAmmoCur (double TicFrac)
	{
		CacheCvars();
		if (!PAmmo1 && !PAmmo2)
		{
			return;
		}
		
		if ((PAmmo1 && !PAmmo2) || (!PAmmo1 && PAmmo2) || (PAmmo1 == PAmmo2))
		{
			Ammo PAmmo = PAmmo1 ? PAmmo1 : PAmmo2;
			Draw9Slice(PAmmo1Pos, PAmmo1Size, DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
			DrawString(AmmoFont2, PAmmo.amount.."" , PAmmo1LabelPos, DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
		}
		
		else
		{		
			Draw9Slice(PAmmo1Pos, PAmmo1Size, DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
			Draw9Slice(PAmmo2Pos, PAmmo2Size, DI_SCREEN_RIGHT_BOTTOM, "HXBOX1", alpha);
			DrawString(AmmoFont2, PAmmo1.amount.."" , PAmmo1LabelPos, DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
			DrawString(AmmoFont2, PAmmo2.amount.."" , PAmmo2LabelPos, DI_SCREEN_RIGHT_BOTTOM | DI_TEXT_ALIGN_RIGHT);
		}
	}
	
}