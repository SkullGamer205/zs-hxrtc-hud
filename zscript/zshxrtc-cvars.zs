extend class zsHXRTC_HUD
{
	// Player
	
	
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
	
	// Death Zone
	CVar w_deathzone;
	CVar h_deathzone;	
	void CacheCvars()
	{
	// Font width & height values.
		w_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		h_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		w_HXGENERALFONTM = HXGENERALFONTM.mFont.GetHeight();
		h_HXGENERALFONTM = HXGENERALFONTM.mFont.GetHeight();
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
		if (!HUD_alpha)
			HUD_alpha = CVar.GetCVar('hxrtc_alpha', p);
		if (!w_deathzone)
			w_deathzone = CVar.GetCVar('hxrtc_death_zone_x', p);
		if (!h_deathzone)
			h_deathzone = CVar.GetCVar('hxrtc_death_zone_y', p);
			
	}
}