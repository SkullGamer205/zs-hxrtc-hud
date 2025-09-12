extend class zsHXRTC_HUD
{

	// Fonts
	HUDFont TimeFont, LinfoFont, 
				HPFont1, HPFont2, HPFont3, ArmFont, 
				InvFont, AmmoFont1, AmmoFont2;
	CVar HX_StatusFont, HX_ConsoleFont, HX_MediumFont, HX_SmallFont;
	
	// Colors
	int col_kills, col_items, col_scrts;
	int col_hp, col_ap, col_par;
	
	// Box
	CVar HX_Box0, HX_Box1, HX_Box2;
	
	// Death Zone
	int x, y;
	CVar w_deathzone, h_deathzone;	
	
	// Toggles
	CVar HX_ShowTime, HX_ShowLInfo;
	
	// Alpha
	float alpha;
	CVar HUD_alpha;
	
	// TexBoxes
	string TexBox0, TexBox1, TexBox2;
	int TexBox0_size, TexBox1_size, TexBox2_size;
	
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
	CVar HX_HPAPStyle;

	int BarWidth;
	int HealthStringID;
	int x_NamePos, 		y_NamePos,
		x_BarPos, 		y_BarPos,
		x_ValuePos, 	y_ValuePos;
		
	float x_HealthBox,		y_HealthBox;
	float w_HealthBox, 		h_HealthBox;
	Vector2 HealthBoxPos,	HealthBoxSize;
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
	
	Vector2 InvCurPos, InvCurSize;
	
	Vector2 InvCBordPos, InvCBordSize;
	
	Vector2 InvCountPos, CurIconPos;
	
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
	
	Vector2 ArmIcoBoxPos, ArmIcoBoxSize;
	Vector2 ArmPercBoxPos, ArmPercBoxSize;
	Vector2 ArmPercNumPos;
	Vector2 ArmPercentPos;
	Vector2 ArmIconPos;
	
	// Berserk Icon
	float x_BskIcoBox, y_BskIcoBox;
	float w_BskIcoBox, h_BskIcoBox;
	
	float x_BskIcon, y_BskIcon;
	
	Vector2 BskIcoBoxPos, BskIcoBoxSize;
	Vector2 BskIconPos;
	
	// Ammo	
	CVar HX_AmmoStyle;
	
	// List Ammo
	int AmmoBarWidth;
	Array<Ammo> ownedAmmo;
	int curAmmoIndex;
	
	float x_AllAmmoBox, y_AllAmmoBox;
	float x_AllAmmoBoxLabel, y_AllAmmoBoxLabel;
	float w_AllAmmoBox, h_AllAmmoBox;
	Vector2 AllAmmoBoxPos, AllAmmoBoxSize;
	
	float x_AmmoBox, y_AmmoBox;
	float w_AmmoBox, h_AmmoBox;
	Vector2 AmmoBoxPos, AmmoBoxSize;
	
	// Current Ammo
	Ammo PAmmo1, PAmmo2;
	int PAmmo1_Amount, PAmmo2_Amount;
	int CurAmmoBarWidth;
	float x_PAmmo1, y_PAmmo1;
	float x_PAmmo2, y_PAmmo2;
	float x_PAmmo1Label, y_PAmmo1Label;
	float x_PAmmo2Label, y_PAmmo2Label;
	float x_PAmmo1Bar, y_PAmmo1Bar;
	float x_PAmmo2Bar, y_PAmmo2Bar;
	
	float w_PAmmo1, h_PAmmo1;
	float w_PAmmo2, h_PAmmo2;
	
	Vector2 PAmmo1Pos, PAmmo1Size;
	Vector2 PAmmo2Pos, PAmmo2Size;
	Vector2 PAmmo1LabelPos, PAmmo2LabelPos;
	Vector2 PAmmo1BarPos, PAmmo2BarPos;
	
	// Weapon Icon
	//w44h20
	float x_WeapIconBox, y_WeapIconBox;
	float w_WeapIconBox, h_WeapIconBox;
	float x_WeapIcon, y_WeapIcon;
	
	Vector2 WeapIconBoxPos, WeapIconBoxSize;
	Vector2 WeapIconPos;
	
    ui void CacheCvars()
    {
        p = CPlayer; 
        pwm = p.mo;
        
        if (!p || !pwm) return;
            
        // Cache CVars
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
        if (!HX_HPAPStyle)
            HX_HPAPStyle = CVar.GetCVar('hxrtc_hpap_style', p);
        if (!HX_AmmoStyle)
            HX_AmmoStyle = CVar.GetCVar('hxrtc_ammo_style', p);
        if (!HX_Box0)
            HX_Box0 = CVar.GetCVar('hxrtc_box0', p);
        if (!HX_Box1)
            HX_Box1 = CVar.GetCVar('hxrtc_box1', p);
        if (!HX_Box2)
            HX_Box2 = CVar.GetCVar('hxrtc_box2', p);
        if (!HX_StatusFont)
            HX_StatusFont = CVar.GetCVar('hxrtc_font0', p);
        if (!HX_ConsoleFont)
            HX_ConsoleFont = CVar.GetCVar('hxrtc_font1', p);
        if (!HX_MediumFont)
            HX_MediumFont = CVar.GetCVar('hxrtc_font2', p);
        if (!HX_SmallFont)
            HX_SmallFont = CVar.GetCVar('hxrtc_font3', p);
            
        // Box textures
        TexBox0 = HX_Box0.GetString();
        TexBox1 = HX_Box1.GetString();
        TexBox2 = HX_Box2.GetString();
        
        // General HUD variables
        x = w_deathzone.GetInt();
        y = h_deathzone.GetInt();
        alpha = HUD_alpha.GetFloat() / 100;
        
        TexBox0_size = TexSize(TexBox0.."1");
        TexBox1_size = TexSize(TexBox1.."1");
        TexBox2_size = TexSize(TexBox2.."1");
        
        // Colors
        array<int> StatCol = {11, 11, 10};
        array<int> ParCol = {10, 10, 11};
        array<int> HPCol = {11, 6, 8, 10, 3, 7};
        
        col_kills = GetColor(level.killed_monsters, level.total_monsters, 1, StatCol);
        col_items = GetColor(level.found_items, level.total_items, 1, StatCol);
        col_scrts = GetColor(level.found_secrets, level.total_secrets, 1, StatCol);
        col_par = GetColor(TicsConvert(level.Time), level.ParTime, 1, ParCol);
        
        // Fonts
        TimeFont = HXCONSOLEFONT;
        LinfoFont = HXGENERALFONTS;
        HPFont1 = HXGENERALFONTM;
        HPFont2 = HXCONSOLEFONT;
		HPFont3 = HXSTATUSFONT;
        ArmFont = LinfoFont;
        InvFont = LinfoFont;
        AmmoFont1 = HXGENERALFONTS;
        AmmoFont2 = HXSTATUSFONT;
        
        // Level info variables
        show_time = HX_ShowTime.GetBool();
        show_linfo = HX_ShowLInfo.GetBool();
        
        w_TimeBox = FontStringWidth(level.TimeFormatted(), TimeFont) + (2 * TexBox1_size);
        h_TimeBox = FontGetWidth(TimeFont) + 1.5 * TexBox1_size;
        x_TimeBox = x;
        
        if (show_time == true) {
            y_TimeBox = y;
        } else {
            y_TimeBox = y - h_TimeBox;
        }
        
        TimeBoxPos = (x_TimeBox, y_TimeBox);
        TimeBoxSize = (w_TimeBox, h_TimeBox);
        TimePos = (x_TimeBox + (w_TimeBox / 2), y_TimeBox + (h_TimeBox / 2) - (FontGetWidth(TimeFont) / 2));
        
        x_LinfoBox = x_TimeBox;
        y_LinfoBox = y_TimeBox + h_TimeBox;
        w_LinfoBox = w_TimeBox;
        h_LinfoBox = ((2 * TexBox1_size) + (3 * (FontGetWidth(LinfoFont) + 1) - 1));
        LinfoBoxPos = (x_LinfoBox, y_LinfoBox);
        LinfoBoxSize = (w_LinfoBox, h_LinfoBox);
        
        // Player health/armor
        PHealth = pwm.Health;
        PMaxHealth = pwm.GetMaxHealth(true);
        
        let ArmorType = BasicArmor(pwm.FindInventory("BasicArmor"));
        if (ArmorType) {
            PArmor = ArmorType.amount;
            PMaxArmor = ArmorType.MaxAmount;
            PArmorPercent = ArmorType.SavePercent * 100;
        } else {
            PArmor = 0;
            PMaxArmor = 0;
            PArmorPercent = 0;
        }
        
        col_hp = GetColor(PHealth, PMaxHealth, 4, HPCol);
        col_ap = GetColor(PArmor, PMaxArmor, 4, HPCol);
        
        BarWidth = TexSize("HXHABROK");
		
		switch (HX_HPAPStyle.GetInt())
		{
		default:
			w_HealthBox = ((FontStringWidth("HEALTH", HPFont1) + 2) + BarWidth + (FontStringWidth("999", HPFont2)) + (2 * TexBox1_size));
			h_HealthBox = (2 * TexBox1_size + (2 * FontGetWidth(HPFont1)) + 1);
			break;
		case 1:
			w_HealthBox = FontStringWidth("9999", HPFont3) + (2 * TexBox1_size);
			h_HealthBox = (FontGetWidth(HPFont3) + 1) + (2 * TexBox1_size) + 2;
			break;
        }
		
		x_HealthBox = x;
		y_HealthBox = -(y + h_HealthBox);
		HealthBoxPos = (x_HealthBox, y_HealthBox);
        HealthBoxSize = (w_HealthBox, h_HealthBox);
		
        // Mugshot
        MugBox = 46;
        x_MugBox = x_HealthBox;
        y_MugBox = y_HealthBox - MugBox;
        MugPos = (x_MugBox, y_MugBox);
        MugSize = (MugBox, MugBox);
        
        x_Mugshot = x_MugBox + (MugBox / 2);
        y_Mugshot = y_MugBox + (MugBox / 2);
        MugPos2 = (x_Mugshot, y_Mugshot);
        
        // Current inventory
        w_InvCur = MugBox;
        h_InvCur = 32 + (2 * TexBox2_size);
        x_InvCur = x_MugBox;
        y_InvCur = y_MugBox - h_InvCur;
        x_InvCount = x_InvCur + w_InvCur - (TexBox2_size * 2);
        y_InvCount = y_InvCur + (h_InvCur - ((2 * TexBox2_size) + FontGetWidth(InvFont)));
        
        InvCurPos = (x_InvCur, y_InvCur);
        InvCurSize = (w_InvCur, h_InvCur);
        InvCBordPos = (x_InvCur + TexBox2_size, y_InvCur + TexBox2_size);
        InvCBordSize = (w_InvCur - (2 * TexBox2_size), h_InvCur - (2 * TexBox2_size));
        InvCountPos = (x_InvCount, y_InvCount);
        CurIconPos = (x_InvCur + (w_InvCur / 2), y_InvCur + (h_InvCur - TexBox2_size - 2));
        CurIconSize = (h_InvCur - (2 * TexBox2_size) - 2);
        
        // Inventory bar
        x_InvBar = 0;
        y_InvBar = -y;
        InvBarPos = (x_InvBar, y_InvBar);
        
        // Armor icon
        SmallBox = 24;
        x_ArmIcoBox = x_MugBox + MugBox;
        y_ArmIcoBox = y_HealthBox - SmallBox;
        w_ArmIcoBox = SmallBox;
        h_ArmIcoBox = SmallBox;
        
        w_ArmPercBox = w_ArmIcoBox;
        h_ArmPercBox = FontGetWidth(ArmFont) + (2 * TexBox2_size);
        x_ArmPercBox = x_ArmIcoBox;
        y_ArmPercBox = y_ArmIcoBox - h_ArmPercBox;
        x_ArmPercNum = x_ArmPercBox + TexBox2_size + FontStringWidth("100", ArmFont);
        y_ArmPercNum = y_ArmPercBox + TexBox2_size;
        x_ArmPercent = x_ArmPercBox + w_ArmPercBox - TexBox2_size;
        y_ArmPercent = y_ArmPercNum;
        
        x_ArmIcon = x_ArmIcoBox + (SmallBox / 2);
        y_ArmIcon = y_ArmIcoBox + (SmallBox / 2);
        
        ArmIcoBoxPos = (x_ArmIcoBox, y_ArmIcoBox);
        ArmIcoBoxSize = (w_ArmIcoBox, h_ArmIcoBox);
        ArmPercBoxPos = (x_ArmPercBox, y_ArmPercBox);
        ArmPercBoxSize = (w_ArmPercBox, h_ArmPercBox);
        ArmPercNumPos = (x_ArmPercNum, y_ArmPercNum);
        ArmPercentPos = (x_ArmPercent, y_ArmPercent);
        ArmIconPos = (x_ArmIcon, y_ArmIcon);
        
        // Berserk icon
        x_BskIcoBox = x_ArmIcoBox + SmallBox;
        y_BskIcoBox = y_ArmIcoBox;
        w_BskIcoBox = SmallBox;
        h_BskIcoBox = SmallBox;
        
        x_BskIcon = x_BskIcoBox + (SmallBox / 2);
        y_BskIcon = y_BskIcoBox + (SmallBox / 2);
        
        BskIcoBoxPos = (x_BskIcoBox, y_BskIcoBox);
        BskIcoBoxSize = (w_BskIcoBox, h_BskIcoBox);
        BskIconPos = (x_BskIcon, y_BskIcon);
        
        // All ammo
        AmmoBarWidth = TexSize("HXHAMMOK");
        
		switch (HX_AmmoStyle.GetInt())
		{
		default: 
			w_AllAmmoBox = (FontStringWidth("999", AmmoFont1) + 2) + AmmoBarWidth + (2 + 8) + (2 * TexBox1_size);
			break;
		case 1:
			w_AllAmmoBox = (FontStringWidth("999-999", AmmoFont1) + 2) + (8) + (2 * TexBox1_size);
			break;
		}
		
        h_AllAmmoBox = ((FontGetWidth(AmmoFont1) + 1) * max(ownedAmmo.Size(), 1) + (TexBox1_size * 2) - 1);
        x_AllAmmoBox = -(x + w_AllAmmoBox);
        y_AllAmmoBox = -(y + h_AllAmmoBox);
        x_AllAmmoBoxLabel = -(x + TexBox1_size);
        y_AllAmmoBoxLabel = -(y + TexBox1_size);
        AllAmmoBoxSize = (w_AllAmmoBox, h_AllAmmoBox);
        AllAmmoBoxPos = (x_AllAmmoBox, y_AllAmmoBox);
		
        // Current ammo
        CurAmmoBarWidth = TexSize("HXAMBRBG");
        [PAmmo1, PAmmo2] = GetCurrentAmmo();
        
        if (!PAmmo1 && !PAmmo2) {
            Ammo PAmmo = PAmmo1 ? PAmmo1 : PAmmo2;
            w_PAmmo1 = 0;
            h_PAmmo1 = 0;
            
            x_PAmmo1 = x_AllAmmoBox - w_PAmmo1;
            y_PAmmo1 = -y - h_PAmmo1;
            
            x_PAmmo1Bar = x_PAmmo1 + TexBox1_size - 2;
            y_PAmmo1Bar = y_PAmmo1 + TexBox1_size - 2;
            
            x_PAmmo1Label = x_PAmmo1 + (w_PAmmo1 - (TexBox1_size - 1));
            y_PAmmo1Label = y_PAmmo1 + TexBox1_size - 2;
        } else if ((PAmmo1 && !PAmmo2) || (!PAmmo1 && PAmmo2) || (PAmmo1 == PAmmo2)) {
            Ammo PAmmo = PAmmo1 ? PAmmo1 : PAmmo2;
            w_PAmmo1 = FontStringWidth(String.Format("%d", (PAmmo.maxamount ? PAmmo.maxamount : 0)), AmmoFont2) + (2 * TexBox1_size);
            h_PAmmo1 = (FontGetWidth(AmmoFont2) + 1) + (2 * TexBox1_size) + 2;
            
            x_PAmmo1 = x_AllAmmoBox - w_PAmmo1;
            y_PAmmo1 = -y - h_PAmmo1;
            
            x_PAmmo1Bar = x_PAmmo1 + TexBox1_size - 2;
            y_PAmmo1Bar = y_PAmmo1 + TexBox1_size - 2;
            
            x_PAmmo1Label = x_PAmmo1 + (w_PAmmo1 - (TexBox1_size - 1));
            y_PAmmo1Label = y_PAmmo1 + TexBox1_size - 2;
        } else {
            w_PAmmo1 = FontStringWidth(String.Format("%d", (PAmmo1.maxamount ? PAmmo1.maxamount : 0)), AmmoFont2) + (2 * TexBox1_size);
            h_PAmmo1 = (FontGetWidth(AmmoFont2) + 1) + (2 * TexBox1_size) + 2;
            
            w_PAmmo2 = FontStringWidth(String.Format("%d", (PAmmo2.maxamount ? PAmmo2.maxamount : 0)), AmmoFont2) + (2 * TexBox1_size);
            h_PAmmo2 = h_PAmmo1;
            
            x_PAmmo1 = x_AllAmmoBox - w_PAmmo1;
            y_PAmmo1 = -y - h_PAmmo1;
            x_PAmmo2 = x_PAmmo1 - w_PAmmo2;
            y_PAmmo2 = -y - h_PAmmo2;
            
            x_PAmmo1Bar = x_PAmmo1 + TexBox1_size - 2;
            y_PAmmo1Bar = y_PAmmo1 + TexBox1_size - 2;
            x_PAmmo2Bar = x_PAmmo2 + TexBox1_size - 2;
            y_PAmmo2Bar = y_PAmmo2 + TexBox1_size - 2;
            
            x_PAmmo1Label = x_PAmmo1 + (w_PAmmo1 - (TexBox1_size - 1));
            y_PAmmo1Label = y_PAmmo1 + TexBox1_size - 2;
            x_PAmmo2Label = x_PAmmo2 + (w_PAmmo2 - (TexBox1_size - 1));
            y_PAmmo2Label = y_PAmmo2 + TexBox1_size - 2;
        }

        PAmmo1Pos = (x_PAmmo1, y_PAmmo1);
        PAmmo2Pos = (x_PAmmo2, y_PAmmo2);
        PAmmo1Size = (w_PAmmo1, h_PAmmo1);
        PAmmo2Size = (w_PAmmo2, h_PAmmo2);
        PAmmo1BarPos = (x_PAmmo1Bar, y_PAmmo1Bar);
        PAmmo2BarPos = (x_PAmmo2Bar, y_PAmmo2Bar);
        PAmmo1LabelPos = (x_PAmmo1Label, y_PAmmo1Label);
        PAmmo2LabelPos = (x_PAmmo2Label, y_PAmmo2Label);
		
		// Weapon Icon
		w_WeapIconBox = (44);
		h_WeapIconBox = (20);
		
		x_WeapIconBox = (x_AllAmmoBox - w_WeapIconBox);
		y_WeapIconBox = (y_PAmmo1 - h_WeapIconBox);
		
		x_WeapIcon = (x_AllAmmoBox - (w_WeapIconBox / 2));
		y_WeapIcon = (y_PAmmo1 - (h_WeapIconBox / 2));
		
		WeapIconBoxPos = (x_WeapIconBox, y_WeapIconBox);
		WeapIconBoxSize = (w_WeapIconBox, h_WeapIconBox);
		WeapIconPos = (x_WeapIcon, y_WeapIcon);
		
    }
}