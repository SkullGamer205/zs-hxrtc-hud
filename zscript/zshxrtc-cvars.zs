extend class zsHXRTC_HUD
{

	// Font
	HUDFont TimeFont;
	
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
	int x_NamePos, y_NamePos, x_BarPos, y_BarPos, x_ValuePos, y_ValuePos;
	float x_HealthBox, y_HealthBox;
	float w_HealthBox, h_HealthBox;
	Vector2 HealthBoxPos;
	Vector2 HealthBoxSize;
	Vector2 HealthNamePos;
	Vector2 HealthBarPos;
	Vector2 HealthValuePos;
	
	// Mugshot	
	int SmallBox, MugBox;
	float x_MugBox, y_MugBox;
	float x_Mugshot, y_Mugshot;
	Vector2 MugPos, MugSize, MugPos2;
	
	// Ammo
	Array<Ammo> ownedAmmo;
	int curAmmoIndex;
	float x_AllAmmoBox, y_AllAmmoBox, x_AllAmmoBoxLabel, y_AllAmmoBoxLabel;
	float w_AllAmmoBox, h_AllAmmoBox;
	Vector2 AllAmmoBoxPos;
	Vector2 AllAmmoBoxSize;
	
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
		col_kills = GetColor(level.killed_monsters, level.total_monsters,	1, StatCol);
		col_items = GetColor(level.found_items, level.total_items,			1, StatCol);
		col_scrts = GetColor(level.found_secrets, level.total_secrets,		1, StatCol);
		col_par	= GetColor(TicsConvert(level.Time), level.ParTime,		1, ParCol);
		
		col_hp = GetColor(PHealth, PMaxHealth,		4, HPCol);
		col_ap = GetColor(PArmor, PMaxArmor,		4, HPCol);
		
		// Fonts
		TimeFont = HXCONSOLEFONT;
		
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
		
		w_TimeBox = 8 * FontGetWidth(TimeFont) + 2 * TexBox1;
		h_TimeBox = FontGetWidth(TimeFont) + 1.5 * TexBox1;
		x_TimeBox = x;	
		TimeBoxPos = (x_TimeBox, y_TimeBox);
		TimeBoxSize = (w_TimeBox, h_TimeBox);
		TimePos = (x_TimeBox + (w_TimeBox / 2), y_TimeBox + (h_TimeBox / 2) - (FontGetWidth(TimeFont) / 2));
		
		x_LinfoBox = x_TimeBox;
		y_LinfoBox = y_TimeBox + h_TimeBox;
		w_LinfoBox = w_TimeBox; h_LinfoBox = ((2 * TexBox1) + (3 * FontGetWidth(HXGENERALFONTS)) + 1);
		LinfoBoxPos = (x_LinfoBox, y_LinfoBox);
		LinfoBoxSize = (w_LinfoBox, h_LinfoBox);
		
		// HP AP Vars
		PHealth = pwm.Health;
		PMaxHealth = pwm.GetMaxHealth(true);
		let ArmorType = pwm.FindInventory("BasicArmor", true);	
		PArmor = ArmorType.amount;
		PMaxArmor = ArmorType.MaxAmount;
		PArmorPercent = basicarmor(ArmorType).SavePercent * 100;
		
		BarWidth = TexSize("HXHABROK");
		w_HealthBox = ((6 * (FontGetWidth(HXGENERALFONTM) + 1) + 2) + BarWidth + (3 * (FontGetWidth(HXGENERALFONTS) + 1)) + (2 * TexBox1));
		h_HealthBox = (2 * TexBox1 + (2 * FontGetWidth(HXGENERALFONTM)) + 1);
		x_HealthBox = x; y_HealthBox = -(y + h_HealthBox);
		HealthBoxPos = (x_HealthBox, y_HealthBox);
		HealthBoxSize = (w_HealthBox, h_HealthBox);
		
		// Mugshot
		SmallBox = 24;
		MugBox = 46;
		x_MugBox = x_HealthBox;
		y_MugBox = y_HealthBox - mugBox;
		MugPos = (x_MugBox, y_MugBox);
		MugSize = (MugBox, MugBox);
		
		x_Mugshot = x_MugBox + (MugBox / 2);
		y_Mugshot = y_MugBox + (mugBox / 2);
		MugPos2 = (x_Mugshot, y_Mugshot);
		// All Ammo
		
		x_AllAmmoBox = -(x + w_AllAmmoBox); y_AllAmmoBox = -(y + h_AllAmmoBox);
		x_AllAmmoBoxLabel = -(x + TexBox1); y_AllAmmoBoxLabel = -(y + TexBox1); 
		w_AllAmmoBox = (FontGetWidth(HXGENERALFONTS) + 1) * 8; h_AllAmmoBox = ((FontGetWidth(HXGENERALFONTS) + 1) * (ownedAmmo.Size() + 1) + TexBox1);
		AllAmmoBoxSize = (w_AllAmmoBox, h_AllAmmoBox);
		AllAmmoBoxPos = (x_AllAmmoBox, y_AllAmmoBox);
		
	}
}