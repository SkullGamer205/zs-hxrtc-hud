extend class zsHXRTC_HUD
{
	// General HUD Vars
	int x;
	int y;
	int Offset;
	int TexOffset;
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
	int SmallBox;
	int x_BerserkBoxOffset;
	int x_ArmorBoxOffset;
	int y_SmallBoxOffset;
	
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
	ui void CacheCvars()
	{	
	// Font width & height values.
		w_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		h_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		w_HXGENERALFONTM = HXGENERALFONTM.mFont.GetHeight();
		h_HXGENERALFONTM = HXGENERALFONTM.mFont.GetHeight();
		w_HXINDEXFONTS 	 = HXINDEXFONTS.mFont.GetHeight();
		h_HXINDEXFONTS   = HXINDEXFONTS.mFont.GetHeight();
		w_HXCONSOLEFONT	 = HXCONSOLEFONT.mFont.GetHeight();
		h_HXCONSOLEFONT  = HXCONSOLEFONT.mFont.GetHeight();
	// CValues (From CVARINFO)
		if (!p)
			p = players[consoleplayer]; 
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
	
	// General HUD Vars
		x = w_deathzone.GetInt();
		y = h_deathzone.GetInt();
		
		Offset = 2;
		TexOffset = TexSize("HXBOX11");
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
		LabOffset = (6 * w_HXGENERALFONTM);
		ValOffset = (3 * w_HXCONSOLEFONT);
		Bar_Width = TexSize("HXHABROK");
		x_HealthBox = ((2 * TexOffset + Offset) + LabOffset + Bar_Width  + ValOffset);
		y_HealthBox = (2 * (TexOffset + (h_HXGENERALFONTM - 1)) + Offset);
	
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
	}
	
}