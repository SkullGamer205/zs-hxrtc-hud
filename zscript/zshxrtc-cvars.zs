extend class zsHXRTC_HUD
{
	// General HUD Vars
	int x;
	int y;
	int Offset;
	int TexOffset;
	int TexOffset2;
	float alpha;
	
	// Level Info Vars
	bool show_time;
	bool show_linfo;
	float x_TimeBox;
	float y_TimeBox;
	float x_LInfoBox;
	float y_LInfoBox;
	float Right_x;
	int LI_Length;
	float XIndex_Offset;
	
	// Player Stats Vars
	int LabOffset;
	int ValOffset;
	int Bar_Width;
	
	int x_HealthBox;
	int y_HealthBox;
	// Mughsot Vars
	int MugBox;
	int y_MugBoxOffset;
	int x_Mugshot;
	int y_Mugshot;
	
	// Player Stats & Inventory Vars
	int PHealth;
	int PMaxHealth;
	int PHealthOverMax;
	int PMaxHealthOverMax;
	
	int PArmor;
	int PMaxArmor;
	int PArmorPercent;
	int PArmorOverMax;
	int PMaxArmorOverMax;
	
	int PAirSupply;
	int PAirSupplyMax;
	
	int HX_PMaxHealth;
	int HX_POverMaxHealth;	
	int HX_PMaxArmor;
	int HX_POverMaxArmor;	
	
	int SmallBox;
	int x_BerserkBoxOffset;
	int x_ArmorBoxOffset;
	int y_SmallBoxOffset;
	int h_ArmPercBox;
	
	// AmmoBoxes
	int w_AllAmmoBox;
	int h_AllAmmoBox;
	
	int w_AmmoBox;
	int h_AmmoBox;
	
	// Ammo
	int PAmmo1;
	int PAmmo2;
	
	// Font Width and Height
	int w_HXINDEXFONTS;
	int h_HXINDEXFONTS;
	int w_HXINDEXFONTM;
	int h_HXINDEXFONTM;
	int w_HXSTATUSFONT;
	int h_HXSTATUSFONT;
	int w_HXGENERALFONTS;
	int h_HXGENERALFONTS;
	int w_HXGENERALFONTM;
	int h_HXGENERALFONTM;
	int w_HXCONSOLEFONT;
	int h_HXCONSOLEFONT;
	
	// Toggle
	CVar HX_ShowTime;
	CVar HX_ShowLInfo;
	// Alpha
	CVar HUD_alpha;
	
	// Changable Values
	//// Level Info Length
	CVar HX_LI_Length;
	
	//// Death Zone
	CVar w_deathzone;
	CVar h_deathzone;	
	
	// Max HP/AP
	CVar HX_PMaxHealthType;
	CVar HX_OverMaxHealthType;
	CVar HX_PMaxArmorType;
	CVar HX_OverMaxArmorType;
	
	ui void CacheCvars()
	{	
	// Font width & height values.
		w_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		h_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		w_HXGENERALFONTM = HXGENERALFONTM.mFont.GetHeight();
		h_HXGENERALFONTM = HXGENERALFONTM.mFont.GetHeight();
		w_HXINDEXFONTS 	 = HXINDEXFONTS.mFont.GetHeight();
		h_HXINDEXFONTS   = HXINDEXFONTS.mFont.GetHeight();
		w_HXSTATUSFONT 	 = HXSTATUSFONT.mFont.GetHeight();
		h_HXSTATUSFONT   = HXSTATUSFONT.mFont.GetHeight();
		w_HXCONSOLEFONT	 = HXCONSOLEFONT.mFont.GetHeight();
		h_HXCONSOLEFONT  = HXCONSOLEFONT.mFont.GetHeight();
	// CValues (From CVARINFO)
		if (!p)
			p = CPlayer; 
		if (!pwm)
			pwm = (p).mo;
			
		if (!HX_ShowTime)
			HX_ShowTime = CVar.GetCVar('hxrtc_show_time', p);
		if (!HX_ShowLInfo)
			HX_ShowLInfo = CVar.GetCVar('hxrtc_show_linfo', p);		
		if (!HX_LI_Length)
			HX_LI_Length = CVar.GetCVar('hxrtc_linfo_length', p);		
			
		if (!HUD_alpha)
			HUD_alpha = CVar.GetCVar('hxrtc_alpha', p);
			
		if (!w_deathzone)
			w_deathzone = CVar.GetCVar('hxrtc_death_zone_x', p);
		if (!h_deathzone)
			h_deathzone = CVar.GetCVar('hxrtc_death_zone_y', p);
			
		if (!HX_PMaxHealthType)
			HX_PMaxHealthType = CVar.GetCVar('hxrtc_max_hp', p);
		if (!HX_OverMaxHealthType)
			HX_OverMaxHealthType = CVar.GetCVar('hxrtc_overmax_hp', p);
		if (!HX_PMaxArmorType)
			HX_PMaxArmorType = CVar.GetCVar('hxrtc_max_ap', p);
		if (!HX_OverMaxArmorType)
			HX_OverMaxArmorType = CVar.GetCVar('hxrtc_overmax_ap', p);
	
	// General HUD Vars
		x = w_deathzone.GetInt();
		y = h_deathzone.GetInt();
		
		Offset = 2;
		TexOffset = TexSize("HXBOX11");
		TexOffset2 = TexSize("HXBOX21");
		alpha = HUD_alpha.GetFloat() / 100;
		
	// Level Info Vars
		show_time  = HX_ShowTime.GetBool();
		show_linfo = HX_ShowLinfo.GetBool();
		
		x_TimeBox = ((8 * h_HXCONSOLEFONT) + (2 * TexOffset));
		y_TimeBox = (h_HXCONSOLEFONT + (1.5 * TexOffset));
		
		x_LInfoBox = x_TimeBox;
		y_LInfoBox = ((h_HXGENERALFONTS * 3) + (2 * TexOffset));
			
		Right_x = (x + x_TimeBox) - (TexOffset);
		LI_Length = HX_LI_Length.GetInt();
		XIndex_Offset = (LI_Length + 1) * (w_HXINDEXFONTS -1); 
		
	// Player Stats Vars		
		PHealth = pwm.Health;
		PMaxHealth = pwm.GetMaxHealth(true);
		PHealthOverMax = (PHealth - HX_PMaxHealth);
		PMaxHealthOverMax = (HX_POverMaxHealth - HX_PMaxHealth);
		
		let ArmorType = pwm.FindInventory("BasicArmor", true);	
		PArmor = ArmorType.amount;
		PMaxArmor = ArmorType.MaxAmount;
		PArmorPercent = basicarmor(ArmorType).SavePercent * 100;
		PArmorOverMax = (PArmor - HX_PMaxArmor);
		PMaxArmorOverMax = (HX_POverMaxArmor - HX_PMaxArmor);
		
		LabOffset = (6 * w_HXGENERALFONTM);
		ValOffset = (3 * w_HXCONSOLEFONT);
		Bar_Width = TexSize("HXHABROK");
		x_HealthBox = ((2 * TexOffset + Offset) + LabOffset + Bar_Width  + ValOffset);
		y_HealthBox = (2 * (TexOffset + (h_HXGENERALFONTM - 1)) + Offset);
		PAirSupply = CPlayer.air_finished - level.maptime;
		PAirSupplyMax = level.airSupply;
		
		switch (HX_PMaxHealthType.GetInt())
		{
			default:
				HX_PMaxHealth = PMaxHealth; break;
			case 0:
				HX_PMaxHealth = PMaxHealth; break;
			case 1:
				HX_PMaxHealth = 100; break;
			case 2:
				HX_PMaxHealth = 200; break;
			case 3:
				HX_PMaxHealth = 999; break;
			case 4:
				HX_PMaxHealth = 9999; break;
		}
		
		switch (HX_OverMaxHealthType.GetInt())
		{
			default:
				HX_POverMaxHealth = PMaxHealth; break;
			case 0:
				HX_POverMaxHealth = PMaxHealth; break;
			case 1:
				HX_POverMaxHealth = 100; break;
			case 2:
				HX_POverMaxHealth = 200; break;
			case 3:
				HX_POverMaxHealth = 999; break;
			case 4:
				HX_POverMaxHealth = 9999; break;
		}
		
		switch (HX_PMaxArmorType.GetInt())
		{
			default:
				HX_PMaxArmor = PMaxArmor; break;
			case 0:
				HX_PMaxArmor = PMaxArmor; break;
			case 1:
				HX_PMaxArmor = 100; break;
			case 2:
				HX_PMaxArmor = 200; break;
			case 3:
				HX_PMaxArmor = 999; break;
			case 4:
				HX_PMaxArmor = 9999; break;
		}

		switch (HX_OverMaxArmorType.GetInt())
		{
			default:
				HX_POverMaxArmor = 200; break;
			case 0:
				HX_POverMaxArmor = PMaxArmor; break;
			case 1:
				HX_POverMaxArmor = 100; break;
			case 2:
				HX_POverMaxArmor = 200; break;
			case 3:
				HX_POverMaxArmor = 999; break;
			case 4:
				HX_POverMaxArmor = 9999; break;
		}
	
	// Mugshot Vars
		MugBox = 46;
		y_MugBoxOffset = (y + (y_HealthBox + MugBox));
		x_Mugshot = (x + (MugBox / 2));
		y_Mugshot = ((y + y_HealthBox) + (MugBox / 2));
	// Player Stats & Inventory Vars
		SmallBox = 24;
		x_BerserkBoxOffset = (x + MugBox);
		x_ArmorBoxOffset = (x_BerserkBoxOffset + SmallBox);
		y_SmallBoxOffset = (y + (y_HealthBox + SmallBox));
		h_ArmPercBox = (h_HXGENERALFONTS + (2 * TexOffset2));
		
	// AmmoBox
		w_AllAmmoBox = 76;
		h_AllAmmoBox = 31;
		w_AmmoBox = (3 * w_HXSTATUSFONT + (2 * TexOffset));
		h_AmmoBox = h_AllAmmoBox;
		
	// Ammo
		let PWeapon = p.ReadyWeapon;
		PAmmo1 = PWeapon.Ammo1 ? PWeapon.Ammo1.Amount : 0;
		PAmmo2 = PWeapon.Ammo2 ? PWeapon.Ammo2.Amount : 0;
		
	}
	
}