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
	
	// Death Zone
	CVar w_deathzone;
	CVar h_deathzone;
	
	void CacheCvars()
	{
	// Font width & height values.
		w_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		h_HXGENERALFONTS = HXGENERALFONTS.mFont.GetHeight();
		w_HXCONSOLEFONT	 = HXCONSOLEFONT.mFont.GetHeight();
		h_HXCONSOLEFONT  = HXCONSOLEFONT.mFont.GetHeight();
	// CValues (From CVARINFO)
		if (!p)
			p = players[consoleplayer]; 
		if (!pwm)
			pwm = (p).mo;
		if (!w_deathzone)
			w_deathzone = CVar.GetCVar('hxrtc_death_zone_x', p);
		if (!h_deathzone)
			h_deathzone = CVar.GetCVar('hxrtc_death_zone_y', p);
	}
}