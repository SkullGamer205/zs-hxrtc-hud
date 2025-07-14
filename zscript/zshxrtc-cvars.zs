extend class zsHXRTC_HUD
{

	// Font
	HUDFont TimeFont, LinfoFont, 
				HPFont1, HPFont2, ArmFont, 
					InvFont, AmmoFont1, AmmoFont2;
	
	// Colors
	int col_kills, col_items, col_scrts;
	int col_hp, col_ap, col_par;
	
	// Death Zone
	int x, y;
	CVar w_deathzone;
	CVar h_deathzone;	
	
	// Toggle
	CVar HX_ShowTime;
	CVar HX_ShowLInfo;
	
	// Alpha
	float alpha;
	CVar HUD_alpha;
	
	// TexBoxes
	int TexBox1, TexBox2, TexBox3;
	
	// TimeBox
	bool show_time;
	Vector2 TimeBoxPos, TimeBoxSize, TimePos;
	float x_TimeBox, y_TimeBox;
	float w_TimeBox, h_TimeBox;
	
	// Level Info
	bool show_linfo;
	Vector2 LinfoBoxPos;
	Vector2 LinfoBoxSize;
	Vector2 LinfoNamePos;
	Vector2 LinfoValuePos;
	float x_LinfoBox, y_LinfoBox;
	float w_LinfoBox, h_LinfoBox;
	int LinfoStringID;
	
	array <int> LInfoCol;
	array <string> LInfoStr;
	
	// Player Stats & Inventory Vars
	int PHealth,  PMaxHealth;
	int PArmor, PMaxArmor, PArmorPercent;
	int PAirSupply, PAirSupplyMax;

	int BarWidth;
	int HealthStringID;
	int x_NamePos, 		y_NamePos,
		x_BarPos, 		y_BarPos,
		x_ValuePos, 	y_ValuePos;
		
	float x_HealthBox, y_HealthBox;
	float w_HealthBox, h_HealthBox;
	Vector2 HealthBoxPos;
	Vector2 HealthBoxSize;
	Vector2 HealthNamePos;
	Vector2 HealthBarPos;
	Vector2 HealthValuePos;
	
	// Mugshot	
	int MugBox;
	float x_MugBox, y_MugBox;
	float x_Mugshot, y_Mugshot;
	Vector2 MugPos, MugSize, MugPos2;
	
	// Current Inventory
	float x_InvCur, y_InvCur;
	float w_InvCur, h_invCur;
	float CurIconSize;	
	float x_InvCount, y_InvCount;
	
	Vector2 InvCurPos;
	Vector2 InvCurSize;
	
	Vector2 InvCBordPos;
	Vector2 InvCBordSize;
	
	Vector2 InvCountPos;
	Vector2 CurIconPos;
	
	// Inventory Bar
	float x_InvBar, y_InvBar;
	Vector2 InvBarPos;
	
	// Armor Iocn
	int SmallBox;
	float x_ArmIcoBox, y_ArmIcoBox;
	float w_ArmIcoBox, h_ArmIcoBox;
	
	float x_ArmPercBox, y_ArmPercBox;
	float w_ArmPercBox, h_ArmPercBox;
	float x_ArmPercNum, y_ArmPercNum;
	float x_ArmPercent, y_ArmPercent;
	
	float x_ArmIcon, y_ArmIcon;
	
	Vector2 ArmIcoBoxPos;
	Vector2 ArmIcoBoxSize;
	Vector2 ArmPercBoxPos;
	Vector2 ArmPercBoxSize;
	Vector2 ArmPercNumPos;
	Vector2 ArmPercentPos;
	Vector2 ArmIconPos;
	
	// Berserk Icon
	float x_BskIcoBox, y_BskIcoBox;
	float w_BskIcoBox, h_BskIcoBox;
	
	float x_BskIcon, y_BskIcon;
	
	Vector2 BskIcoBoxPos;
	Vector2 BskIcoBoxSize;
	Vector2 BskIconPos;
	
	// Ammo	
	// List Ammo
	Array<Ammo> ownedAmmo;
	int curAmmoIndex;
	float x_AllAmmoBox, y_AllAmmoBox,
			x_AllAmmoBoxLabel, y_AllAmmoBoxLabel;
	float w_AllAmmoBox, h_AllAmmoBox;
	Vector2 AllAmmoBoxPos;
	Vector2 AllAmmoBoxSize;
	
	float x_AmmoBox, y_AmmoBox;
	float w_AmmoBox, h_AmmoBox;
	Vector2 AmmoBoxPos;
	Vector2 AmmoBoxSize;
	
	// Current Ammo
	Ammo PAmmo1, PAmmo2;
	int PAmmo1_Amount, PAmmo2_Amount;
	int CurAmmoBarWidth;
	float x_PAmmo1, y_PAmmo1;
	float x_PAmmo2, y_PAmmo2;
	float x_PAmmo1Label, y_PAmmo1Label;
	float x_PAmmo2Label, y_PAmmo2Label;
	
	float w_PAmmo1, h_PAmmo1;
	float w_PAmmo2, h_PAmmo2;
	
	Vector2 PAmmo1Pos, PAmmo1Size;
	Vector2 PAmmo2Pos, PAmmo2Size;
	Vector2 PAmmo1LabelPos, PAmmo2LabelPos;
	
	ui void CacheCvars()
	{
		if (!p)
			p = CPlayer; 
		if (!pwm)
			pwm = (p).mo;
			
		if (!HX_ShowTime)
			HX_ShowTime = CVar.GetCVar('hxrtc_show_time', p);
		if (!HX_ShowLInfo)
			HX_ShowLInfo = CVar.GetCVar('hxrtc_show_linfo', p);					
		if (!HUD_alpha)
			HUD_alpha = CVar.GetCVar('hxrtc_alpha', p);
		if (!w_deathzone)
			w_deathzone = CVar.GetCVar('hxrtc_death_zone_x', p);
		if (!h_deathzone)
			h_deathzone = CVar.GetCVar('hxrtc_death_zone_y', p);
			
		if (show_time == true)
		{ y_TimeBox = y; }
		if (show_time == false)
		{ y_TimeBox = y - h_TimeBox; }	
			
		// Colors
		array<int> StatCol = {11, 11, 10};		
		array<int> ParCol = {10, 10, 11};
		array<int> HPCol = {11, 6, 8, 10, 3, 7};
		col_kills	 = GetColor(level.killed_monsters, level.total_monsters,	1, StatCol)	;
		col_items	 = GetColor(level.found_items, level.total_items,			1, StatCol)	;
		col_scrts	 = GetColor(level.found_secrets, level.total_secrets,		1, StatCol)	;
		col_par	 	 = GetColor(TicsConvert(level.Time), level.ParTime,			1,  ParCol) ;
		
		col_hp = GetColor(PHealth, PMaxHealth,		4, HPCol);
		col_ap = GetColor(PArmor, PMaxArmor,		4, HPCol);
		
		// Fonts
		TimeFont = HXCONSOLEFONT;
		LinfoFont = HXGENERALFONTS;
		HPFont1 = HXGENERALFONTM;
		HPFont2 = HXCONSOLEFONT;
		ArmFont = LinfoFont;
		InvFont = LinfoFont;
		AmmoFont1 = HXGENERALFONTS;
		AmmoFont2 = HXSTATUSFONT;
		
		// General HUD Vars
		x = w_deathzone.GetInt();
		y = h_deathzone.GetInt();
		alpha = HUD_alpha.GetFloat() / 100;
		TexBox1 = TexSize("HXBOX11");
		TexBox2 = TexSize("HXBOX21");
		TexBox3 = TexSize("HXBOX31");
			
		// Level Info Vars
		show_time  = HX_ShowTime.GetBool();
		show_linfo = HX_ShowLinfo.GetBool();
		w_TimeBox = FontStringWidth(level.TimeFormatted(), TimeFont) + (2 * TexBox1);
		h_TimeBox = FontGetWidth(TimeFont) + 1.5 * TexBox1;
		x_TimeBox = x;	
		TimeBoxPos = (x_TimeBox, y_TimeBox);
		TimeBoxSize = (w_TimeBox, h_TimeBox);
		TimePos = (x_TimeBox + (w_TimeBox / 2), y_TimeBox + (h_TimeBox / 2) - (FontGetWidth(TimeFont) / 2));
		
		x_LinfoBox = x_TimeBox;
		y_LinfoBox = y_TimeBox + h_TimeBox;
		w_LinfoBox = w_TimeBox; h_LinfoBox = ((2 * TexBox1) + (3 * (FontGetWidth(LinfoFont) + 1) - 1));
		LinfoBoxPos = (x_LinfoBox, y_LinfoBox);
		LinfoBoxSize = (w_LinfoBox, h_LinfoBox);
		
		// HP AP Vars
		PHealth = pwm.Health ;
		PMaxHealth = pwm.GetMaxHealth(true) ;
		let ArmorType = pwm.FindInventory("BasicArmor", true);	
		PArmor = ArmorType.amount;
		PMaxArmor = ArmorType.MaxAmount;
		PArmorPercent = basicarmor(ArmorType).SavePercent * 100;
		
		BarWidth = TexSize("HXHABROK");
		w_HealthBox = ((FontStringWidth("HEALTH", HPFont1) + 2) + BarWidth + ( FontStringWidth("999", HPFont2)) + (2 * TexBox1));
		h_HealthBox = (2 * TexBox1 + (2 * FontGetWidth(HPFont1)) + 1);
		x_HealthBox = x; y_HealthBox = -(y + h_HealthBox);
		HealthBoxPos = (x_HealthBox, y_HealthBox);
		HealthBoxSize = (w_HealthBox, h_HealthBox);
		
		// Mugshot
		MugBox = 46;
		x_MugBox = x_HealthBox;
		y_MugBox = y_HealthBox - MugBox;
		MugPos = (x_MugBox, y_MugBox);
		MugSize = (MugBox, MugBox);
		
		x_Mugshot = x_MugBox + (MugBox / 2);
		y_Mugshot = y_MugBox + (mugBox / 2);
		MugPos2 = (x_Mugshot, y_Mugshot);
		
		// Current Inventory
		w_InvCur = MugBox;
		h_InvCur = 32 + (2 * TexBox2);
		x_InvCur = x_MugBox;
		y_InvCur = y_MugBox - h_InvCur;
		x_InvCount = x_InvCur + w_InvCur - (TexBox2 * 2);
		y_InvCount = y_InvCur + (h_InvCur - ((2 * TexBox2) + FontGetWidth(InvFont)));
		
		InvCurPos = (x_InvCur , y_InvCur);
		InvCurSize = (w_InvCur , h_InvCur);
		InvCBordPos = (x_InvCur + TexBox2 , y_InvCur + TexBox2);
		InvCBordSize = (w_InvCur - (2 * TexBox2)  , h_InvCur - (2 * TexBox2));
		InvCountPos = (x_InvCount , y_InvCount);
		CurIconPos = (x_InvCur + (w_InvCur / 2) , y_InvCur + (h_InvCur - TexBox2 - 2));;
		CurIconSize = (h_InvCur - (2 * TexBox2) - 2);
		
		// Inventory Bar
		x_InvBar = 0;
		y_InvBar = -y;
		
		InvBarPos = (x_InvBar , y_InvBar);
		
		// Armor Icon
		SmallBox = 24;
		x_ArmIcoBox = x_MugBox + MugBox;
		y_ArmIcoBox = y_HealthBox - SmallBox;
		w_ArmIcoBox = SmallBox;
		h_ArmIcoBox = SmallBox;
		
		w_ArmPercBox = w_ArmIcoBox;
		h_ArmPercBox = FontGetWidth(ArmFont) + (2 * TexBox2);
		x_ArmPercBox = x_ArmIcoBox;
		y_ArmPercBox = y_ArmIcoBox - h_ArmPercBox;
		x_ArmPercNum = x_ArmPercBox + TexBox2 + FontStringWidth("100", ArmFont);
		y_ArmPercNum = y_ArmPercBox + TexBox2;
		x_ArmPercent = x_ArmPercBox + w_ArmPercBox - TexBox2;
		y_ArmPercent = y_ArmPercNum;
		
		x_ArmIcon = x_ArmIcoBox + (SmallBox / 2);
		y_ArmIcon = y_ArmIcoBox + (SmallBox / 2);
		
		ArmIcoBoxPos = (x_ArmIcoBox , y_ArmIcoBox);
		ArmIcoBoxSize = (w_ArmIcoBox , h_ArmIcoBox);
		ArmPercBoxPos = (x_ArmPercBox , y_ArmPercBox);
		ArmPercBoxSize = (w_ArmPercBox , h_ArmPercBox);
		ArmPercNumPos = (x_ArmPercNum , y_ArmPercNum);
		ArmPercentPos = (x_ArmPercent , y_ArmPercent);
		ArmIconPos = (x_ArmIcon , y_ArmIcon);
		
		// Berserk Icon
		x_BskIcoBox = x_ArmIcoBox + SmallBox;
		y_BskIcoBox = y_ArmIcoBox;
		w_BskIcoBox = SmallBox;
		h_BskIcoBox = SmallBox;
		
		x_BskIcon = x_BskIcoBox + (SmallBox / 2);
		y_BskIcon = y_BskIcoBox + (SmallBox / 2);
		
		BskIcoBoxPos = (x_BskIcoBox , y_BskIcoBox);
		BskIcoBoxSize = (w_BskIcoBox , h_BskIcoBox);
		BskIconPos = (x_BskIcon, y_BskIcon);
		
		// All Ammo	
		x_AllAmmoBox = -(x + w_AllAmmoBox); y_AllAmmoBox = -(y + h_AllAmmoBox);
		x_AllAmmoBoxLabel = -(x + TexBox1); y_AllAmmoBoxLabel = -(y + TexBox1); 
		w_AllAmmoBox = (FontStringWidth("999", AmmoFont1) + 2) + BarWidth + (2 + 8) + (2 * TexBox1); 
		h_AllAmmoBox = ((FontGetWidth(AmmoFont1) + 1) * ownedAmmo.Size() + (TexBox1 * 2) - 1);
		AllAmmoBoxSize = (w_AllAmmoBox, h_AllAmmoBox);
		AllAmmoBoxPos = (x_AllAmmoBox, y_AllAmmoBox);	
		
		// Current Ammo
		CurAmmoBarWidth = TexSize("HXAMBRBG");
		[PAmmo1, PAmmo2] = GetCurrentAmmo();
		if (!PAmmo1 && !PAmmo2)
		{
			return;
		}
		if ((PAmmo1 && !PAmmo2) || (!PAmmo1 && PAmmo2) || (PAmmo1 == PAmmo2))
		{
			Ammo PAmmo = PAmmo1 ? PAmmo1 : PAmmo2;
			x_PAmmo1 = x_AllAmmoBox - w_PAmmo1;
			y_PAmmo1 = -y - h_PAmmo1;
			
			w_PAmmo1= FontStringWidth(String.Format("%d", (PAmmo1.maxamount ? PAmmo1.maxamount : 0)), AmmoFont2) + CurAmmoBarWidth + (2 * TexBox1);
			h_PAmmo1 = (FontGetWidth(AmmoFont2) + 1) + (2 * TexBox1);
			
			x_PAmmo1Label = x_PAmmo1 + (w_PAmmo1 - TexBox1);
			y_PAmmo1Label = y_PAmmo1 + TexBox1;
		}
		else
		{
			x_PAmmo1 = x_AllAmmoBox - w_PAmmo1;
			y_PAmmo1 = -y - h_PAmmo1;
			x_PAmmo2 = x_PAmmo1 - w_PAmmo2;
			y_PAmmo2 = -y - h_PAmmo2;
		
			// FontGetWidthNew
			w_PAmmo1= FontStringWidth(String.Format("%d", (PAmmo1.maxamount ? PAmmo1.maxamount : 0)), AmmoFont2) + CurAmmoBarWidth + (2 * TexBox1);
			h_PAmmo1 = (FontGetWidth(AmmoFont2) + 1) + (2 * TexBox1);
		
			w_PAmmo2= FontStringWidth(String.Format("%d", (PAmmo2.maxamount ? PAmmo2.maxamount : 0)), AmmoFont2) + CurAmmoBarWidth + (2 * TexBox1);
			h_PAmmo2 = h_PAmmo1;
			
			x_PAmmo1Label = x_PAmmo1 + (w_PAmmo1 - TexBox1);
			y_PAmmo1Label = y_PAmmo1 + TexBox1;
			x_PAmmo2Label = x_PAmmo2 + (w_PAmmo2 - TexBox1);
			y_PAmmo2Label = y_PAmmo2 + TexBox1;
		}

		PAmmo1Pos = (x_PAmmo1 , y_PAmmo1) ;
		PAmmo2Pos = (x_PAmmo2 , y_PAmmo2) ;
		PAmmo1Size = (w_PAmmo1 , h_PAmmo1) ;
		PAmmo2Size = (w_PAmmo2 , h_PAmmo2) ;
		
		PAmmo1LabelPos = (x_PAmmo1Label , y_PAmmo1Label);
		PAmmo2LabelPos = (x_PAmmo2Label , y_PAmmo2Label);
	}
}