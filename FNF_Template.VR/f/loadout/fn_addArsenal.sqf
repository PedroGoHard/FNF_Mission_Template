_arsenalAction = ["Arsenal","Enter Arsenal","",{call arsenal;},{true}] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment"],_arsenalAction] call ace_interact_menu_fnc_addActionToClass;

_arsenalReset = ["Arsenal Reset","Reset Loadout to Default","",{
  phx_loadoutAssigned = nil;
  call phx_fnc_loadout_set;
  _null = [] spawn {
    sleep 10;
    phx_radHandle1 = [phx_fnc_radio_waitGear, 0.1, []] call CBA_fnc_addPerFrameHandler;
  };
  },{true}] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment"],_arsenalReset] call ace_interact_menu_fnc_addActionToClass;

//BLU base classes
_bluBaseWeaponClasses = ["rhs_weap_hk416d10","rhs_weap_hk416d145","rhs_weap_m16a4","rhs_weap_m4","rhs_weap_m4a1_blockII","rhs_weap_m4a1","rhs_weap_m4a1_carryhandle","rhs_weap_mk18",
"rhsusf_weap_glock17g4","rhsusf_weap_m1911a1","hgun_Pistol_heavy_01_F","hgun_ACPC2_F","rhsusf_weap_m9"
];
_bluBaseItemClasses = ["ACE_fieldDressing","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_CableTie","ACE_epinephrine","ACE_Flashlight_XL50","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_tourniquet","ACE_Flashlight_MX991","ItemGPS","tf_microdagr","ItemWatch","ACE_Altimeter","tf_anprc152","ItemCompass","ItemMap","G_Tactical_Black","G_Tactical_Clear",
"G_Squares_Tinted","G_Sport_Greenblack","G_Sport_Blackred","G_Sport_Checkered","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Red","rhsusf_oakley_goggles_blk","rhsusf_oakley_goggles_clr","rhsusf_oakley_goggles_ylw","rhsusf_shemagh2_gogg_white","rhsusf_shemagh_gogg_white","rhsusf_shemagh2_gogg_tan","rhsusf_shemagh_gogg_tan","rhsusf_shemagh2_gogg_od","rhsusf_shemagh_gogg_od","rhsusf_shemagh2_gogg_grn",
"rhsusf_shemagh_gogg_grn","rhsusf_shemagh2_white","rhsusf_shemagh_white","rhsusf_shemagh2_tan","rhsusf_shemagh_tan","rhsusf_shemagh2_od","rhsusf_shemagh_od","rhsusf_shemagh2_grn","rhsusf_shemagh_grn","G_Shades_Black","G_Shades_Blue","G_Shades_Green","G_Shades_Red","G_Lowprofile","G_Combat_Goggles_tna_F","G_Combat","rhs_ess_black","rhs_googles_clear","rhs_googles_yellow","rhs_googles_orange","G_Aviator",
"rhsusf_acc_anpeq15side","rhsusf_acc_anpeq15_top","rhsusf_acc_anpeq15_wmx","rhsusf_acc_anpeq15_wmx_light","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15_bk_top","rhsusf_acc_anpeq15","rhsusf_acc_anpeq15_light","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15_bk_light","rhsusf_acc_anpeq15A","rhsusf_acc_anpeq16a","rhsusf_acc_anpeq16a_light","rhsusf_acc_anpeq16a_top","rhsusf_acc_anpeq16a_light_top","acc_flashlight_smg_01",
"acc_flashlight","rhsusf_acc_wmx","rhsusf_acc_wmx_bk","rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_T1_low_fwd","optic_Yorris","optic_ACO_grn","optic_Aco","optic_Holosight_blk_F","optic_Holosight_khk_F","optic_Holosight","rhsusf_acc_EOTECH","rhsusf_acc_eotech_552","rhsusf_acc_eotech_552_d","rhsusf_acc_eotech_552_wd","rhsusf_acc_compm4","rhsusf_acc_eotech_xps3"
];
_bluBaseMagazineClasses = ["rhs_mag_30Rnd_556x45_M855A1_Stanag","rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red","rhs_mag_an_m14_th3","HandGrenade","ACE_M84",
"rhsusf_mag_17Rnd_9x19_FMJ","rhsusf_mag_7x45acp_MHP","11Rnd_45ACP_Mag","rhsusf_mag_15Rnd_9x19_FMJ","9Rnd_45ACP_Mag",
"SmokeShellBlue","SmokeShellPurple","SmokeShellOrange","SmokeShellGreen","SmokeShellRed","SmokeShellYellow","ACE_HandFlare_Green","ACE_HandFlare_Red","ACE_HandFlare_White",
"ACE_HandFlare_Yellow","ACE_Chemlight_HiOrange","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite","ACE_Chemlight_HiYellow"
];
//BLU Lead
_bluLeadWeaponClasses = ["rhs_weap_hk416d10_m320","rhs_weap_hk416d145_m320","rhs_weap_m16a4_carryhandle_M203","rhs_weap_m4_m203",
"rhs_weap_m4_m320","rhs_weap_m4a1_carryhandle_m203","rhs_weap_m4a1_blockII_M203","rhs_weap_m4a1_m203","rhs_weap_m4a1_m320","rhs_weap_mk18_m320",
"rhs_weap_rsp30_white","rhs_weap_rsp30_green","rhs_weap_rsp30_red"
];
_bluLeadItemClasses = ["ACE_VectorDay","ACE_EntrenchingTool"];
_bluLeadMagazineClasses = ["1Rnd_HE_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell",
"1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareWhite_F","UGL_FlareYellow_F"
];
//BLU AR
_bluARWeaponClasses = ["rhs_weap_m249_pip_L"];
_bluARMagazineClasses = ["rhsusf_200rnd_556x45_mixed_box"];
_bluARItemClasses = ["ACE_SpareBarrel"];
//BLU RAT
_bluRATWeaponClasses = ["rhs_weap_maaws"];
_bluRATMagazineClasses = ["rhs_mag_maaws_HEDP","rhs_mag_maaws_HEAT","rhs_mag_maaws_ILLUM","rhs_mag_maaws_SMOKE"];
//BLU CE
_bluCEMagazineClasses = ["SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag"];
_bluCEItemClasses = ["ACE_Clacker"];
//BLU MG
_bluMGWeaponClasses = ["rhs_weap_m240G"];
_bluMGMagazineClasses = ["rhsusf_100Rnd_762x51_m80a1epr"];
_bluMGItemClasses = ["ACE_SpareBarrel"];
//BLU AT
_bluATWeaponClasses = ["rhs_weap_smaw"];
_bluATMagazineClasses = ["rhs_mag_smaw_HEDP","rhs_mag_smaw_HEAA","rhs_mag_smaw_SR"];
_bluATItemClasses = ["rhs_optic_maaws"];

//OPF Classes

_opfBaseWeaponClasses = ["rhs_weap_ak105_npz","rhs_weap_ak74m_npz","rhs_weap_aks74n_npz","rhs_weap_ak74n_npz","rhs_weap_6p53","hgun_Pistol_01_F","rhs_weap_pya","rhs_weap_tt33"];
_opfBaseItemClasses = ["ACE_fieldDressing","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_CableTie","ACE_epinephrine","ACE_Flashlight_XL50","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_tourniquet","ACE_Flashlight_MX991","ItemGPS","tf_microdagr","ItemWatch","ACE_Altimeter","tf_fadak","ItemCompass","ItemMap","G_Tactical_Black","G_Tactical_Clear",
"G_Squares_Tinted","G_Sport_Greenblack","G_Sport_Blackred","G_Sport_Checkered","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Red","rhsusf_oakley_goggles_blk","rhsusf_oakley_goggles_clr","rhsusf_oakley_goggles_ylw","rhsusf_shemagh2_gogg_white","rhsusf_shemagh_gogg_white","rhsusf_shemagh2_gogg_tan","rhsusf_shemagh_gogg_tan","rhsusf_shemagh2_gogg_od","rhsusf_shemagh_gogg_od","rhsusf_shemagh2_gogg_grn",
"rhsusf_shemagh_gogg_grn","rhsusf_shemagh2_white","rhsusf_shemagh_white","rhsusf_shemagh2_tan","rhsusf_shemagh_tan","rhsusf_shemagh2_od","rhsusf_shemagh_od","rhsusf_shemagh2_grn","rhsusf_shemagh_grn","G_Shades_Black","G_Shades_Blue","G_Shades_Green","G_Shades_Red","G_Lowprofile","G_Combat_Goggles_tna_F","G_Combat","rhs_ess_black","rhs_googles_clear","rhs_googles_yellow","rhs_googles_orange","G_Aviator",
"rhs_acc_1p63","rhs_acc_rakursPM","rhs_acc_1p87","optic_Yorris","optic_ACO_grn","optic_Aco","optic_Holosight_blk_F","optic_Holosight_khk_F","optic_Holosight","rhsusf_acc_EOTECH","rhs_acc_pkas","rhsusf_acc_eotech_xps3"
];
_opfBaseMagazineClasses = ["rhs_30Rnd_545x39_AK_green","rhs_30Rnd_545x39_7N6_AK","rhs_mag_an_m14_th3","HandGrenade","ACE_M84",
"SmokeShellBlue","SmokeShellPurple","SmokeShellOrange","SmokeShellGreen","SmokeShellRed","SmokeShellYellow","ACE_HandFlare_Green","ACE_HandFlare_Red","ACE_HandFlare_White",
"ACE_HandFlare_Yellow","ACE_Chemlight_HiOrange","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite","ACE_Chemlight_HiYellow",
"rhs_mag_762x25_8","rhs_mag_9x19_17","10Rnd_9x21_Mag","rhs_18rnd_9x21mm_7N28"
];
//OPF Lead
_opfLeadWeaponClasses = ["rhs_weap_ak74m_gp25_npz","rhs_weap_ak74n_gp25_npz","rhs_weap_aks74n_gp25_npz",
"rhs_weap_rsp30_white","rhs_weap_rsp30_green","rhs_weap_rsp30_red"];
_opfLeadItemClasses = ["ACE_VectorDay","ACE_EntrenchingTool"];
_opfLeadMagazineClasses = ["rhs_VOG25","rhs_VG40OP_green","rhs_VG40OP_red","rhs_VG40OP_white","rhs_GRD40_Green","rhs_GRD40_Red","rhs_GRD40_White"];
//OPF AR
_opfARWeaponClasses = ["rhs_weap_pkm"];
_opfARMagazineClasses = ["rhs_100Rnd_762x54mmR_green"];
_opfARItemClasses = ["ACE_SpareBarrel"];
//OPF RAT
_opfRATWeaponClasses = ["rhs_weap_rpg7"];
_opfRATMagazineClasses = ["rhs_rpg7_PG7V_mag","rhs_rpg7_PG7VL_mag","rhs_rpg7_PG7VM_mag","rhs_rpg7_PG7VR_mag","rhs_rpg7_PG7VS_mag"];
//OPF CE
_opfCEMagazineClasses = ["SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag"];
_opfCEItemClasses = ["ACE_Clacker"];
//OPF MG
_opfMGWeaponClasses = ["rhs_weap_pkp"];
_opfMGMagazineClasses = ["rhs_100Rnd_762x54mmR_green"];
_opfMGItemClasses = ["ACE_SpareBarrel"];
//OPF AT
_opfATWeaponClasses = ["launch_NLAW_F"];
_opfATMagazineClasses = [];
_opfATItemClasses = ["rhs_acc_pgo7v3"];

switch (typeOf player) do {
  //BLUFOR
  case "B_officer_F": {
    [player,_bluBaseWeaponClasses + _bluLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //PL
  case "B_medic_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //CLS
  case "B_Soldier_SL_F": {
    [player,_bluBaseWeaponClasses + _bluLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //SL
  case "B_Soldier_TL_F": {
    [player,_bluBaseWeaponClasses + _bluLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //TL
  case "B_soldier_AR_F": {
    [player,_bluARWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluARItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluARMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AR
  case "B_soldier_AAR_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluARItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluARMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AAR
  case "B_soldier_LAT_F": {
    [player,_bluBaseWeaponClasses + _bluRATWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluRATMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //RAT
  case "B_soldier_exp_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluCEItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluCEMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //CE
  case "B_Soldier_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //R
  case "B_HeavyGunner_F": {
    [player,_bluMGWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluMGItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluMGMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //MG
  case "B_Soldier_unarmed_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluMGItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluMGMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AM
  case "B_soldier_PG_F": {
    [player,_bluBaseWeaponClasses + _bluLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //MGTL
  case "B_soldier_AT_F": {
    [player,_bluBaseWeaponClasses + _bluATWeaponClasses + _bluRATWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses + _bluATItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluATMagazineClasses + _bluRATMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AT
  case "B_soldier_AAT_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses + _bluATMagazineClasses + _bluRATMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AAT
  case "B_pilot_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //P
  case "B_crew_F": {
    [player,_bluBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_bluBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_bluBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
  };

  //OPFOR
  case "O_officer_F":  {
    [player,_opfBaseWeaponClasses + _opfLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//PL
  case "O_medic_F": {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //CLS
  case "O_Soldier_SL_F":  {
    [player,_opfBaseWeaponClasses + _opfLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//SL
  case "O_Soldier_TL_F":  {
    [player,_opfBaseWeaponClasses + _opfLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//TL
  case "O_Soldier_AR_F":  {
    [player,_opfARWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfARItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfARMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//AR
  case "O_Soldier_A_F":  {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfARItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfARMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//AAR
  case "O_Soldier_LAT_F":  {
    [player,_opfBaseWeaponClasses + _opfRATWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfRATMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//RAT
  case "O_soldier_exp_F":  {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfCEItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfCEMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//CE
  case "O_Soldier_F": {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //R
  case "O_HeavyGunner_F":  {
    [player,_opfMGWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfMGItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfMGMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    };//MG
  case "O_Soldier_unarmed_F": {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfMGItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfMGMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AM
  case "O_soldier_PG_F": {
    [player,_opfBaseWeaponClasses + _opfLeadWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfLeadItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfLeadMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //MGTL
  case "O_Soldier_AT_F": {
    [player,_opfBaseWeaponClasses + _opfATWeaponClasses + _opfRATWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses + _opfATItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfRATMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AT
  case "O_Soldier_AAT_F": {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses + _opfRATMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //AAT
  case "O_pilot_F": {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
    }; //P
  case "O_crew_F": {
    [player,_opfBaseWeaponClasses,false,false] call BIS_fnc_addVirtualWeaponCargo;
    [player,_opfBaseItemClasses,false,false] call BIS_fnc_addVirtualItemCargo;
    [player,_opfBaseMagazineClasses,false,false] call BIS_fnc_addVirtualMagazineCargo;
  };
};

arsenal = {
  ["Open",[nil,player]] spawn bis_fnc_arsenal;
};
