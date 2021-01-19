#include <sourcemod>
#include <sdktools>

new Handle:g_hMenuOne = INVALID_HANDLE;
new Handle:g_hMenuTwo = INVALID_HANDLE;
new Handle:g_hMenuThree = INVALID_HANDLE;
new Handle:g_hMenuFour = INVALID_HANDLE;
new Handle:g_hMenuFive = INVALID_HANDLE;
new Handle:g_hMenuSix = INVALID_HANDLE;
new Handle:g_hMenuSeven = INVALID_HANDLE;

int i_cvEnabled;
int g_OnClientPutInServer[MAXPLAYERS+1] = {false, ... };
public Plugin:myinfo = 
{
	name = "Switch Weapon",
	author = "misiu29",
	description = "Switch knifes,guns for csso",
	version = "1.1",
	url = "misiu29.github.io"
}
public void OnPluginStart()
{
    
    g_hMenuOne = CreateMenu(MenuOneHandler);
    SetMenuTitle(g_hMenuOne, "请选择你要切换武器的类型");
    AddMenuItem(g_hMenuOne, "knife", "匕首");
    AddMenuItem(g_hMenuOne, "gun", "枪械");
    
    g_hMenuTwo = CreateMenu(MenuTwoHandler);
    SetMenuTitle(g_hMenuTwo, "请选择阵营");
    AddMenuItem(g_hMenuTwo, "ct", "CT");
    AddMenuItem(g_hMenuTwo, "t", "T");
    SetMenuExitBackButton(g_hMenuTwo, true);
    
    g_hMenuThree = CreateMenu(MenuThreeHandler);
    SetMenuTitle(g_hMenuThree, "请选择匕首样式");
    AddMenuItem(g_hMenuThree, "ctknife0", "原版匕首");
    AddMenuItem(g_hMenuThree, "ctknife1", "海豹短刀");
    AddMenuItem(g_hMenuThree, "ctknife2", "爪子刀");
    AddMenuItem(g_hMenuThree, "ctknife3", "折叠刀");
    AddMenuItem(g_hMenuThree, "ctknife4", "刺刀");
    AddMenuItem(g_hMenuThree, "ctknife5", "m9刺刀");
    AddMenuItem(g_hMenuThree, "ctknife6", "蝴蝶刀");
    AddMenuItem(g_hMenuThree, "ctknife7", "穿肠刀");
    SetMenuExitBackButton(g_hMenuThree, true);

    g_hMenuFour = CreateMenu(MenuFourHandler);
    SetMenuTitle(g_hMenuFour, "请选择匕首样式");
    AddMenuItem(g_hMenuFour, "tknife0", "原版匕首");
    AddMenuItem(g_hMenuFour, "tknife1", "海豹短刀");
    AddMenuItem(g_hMenuFour, "tknife2", "爪子刀");
    AddMenuItem(g_hMenuFour, "tknife3", "折叠刀");
    AddMenuItem(g_hMenuFour, "tknife4", "刺刀");
    AddMenuItem(g_hMenuFour, "tknife5", "m9刺刀");
    AddMenuItem(g_hMenuFour, "tknife6", "蝴蝶刀");
    AddMenuItem(g_hMenuFour, "tknife7", "穿肠刀");
    SetMenuExitBackButton(g_hMenuFour, true);

    g_hMenuFive = CreateMenu(MenuFiveHandler);
    SetMenuTitle(g_hMenuFive, "请选择枪械种类");
    AddMenuItem(g_hMenuFive, "pist", "手枪");
    AddMenuItem(g_hMenuFive, "rif", "步枪/冲锋枪");
    SetMenuExitBackButton(g_hMenuFive, true);   

    g_hMenuSix = CreateMenu(MenuSixHandler);
    SetMenuTitle(g_hMenuSix, "请选择手枪");
    AddMenuItem(g_hMenuSix, "pist0", "usp");
    AddMenuItem(g_hMenuSix, "pist1", "p2000");
    AddMenuItem(g_hMenuSix, "pist2", "fn57");
    AddMenuItem(g_hMenuSix, "pist3", "tec9");
    AddMenuItem(g_hMenuSix, "pist4", "ct方cz75");
    AddMenuItem(g_hMenuSix, "pist5", "t方cz75");
    AddMenuItem(g_hMenuSix, "pist6", "全部更换cz75");    
    SetMenuExitBackButton(g_hMenuSix, true);  

    g_hMenuSeven = CreateMenu(MenuSevenHandler);
    SetMenuTitle(g_hMenuSeven, "请选择步枪/冲锋枪");
    AddMenuItem(g_hMenuSeven, "rif0", "m4a1-s");
    AddMenuItem(g_hMenuSeven, "rif1", "m4a4");
    AddMenuItem(g_hMenuSeven, "rif2", "ct方mp7");
    AddMenuItem(g_hMenuSeven, "rif3", "t方mp7");
    AddMenuItem(g_hMenuSeven, "rif4", "ct方mp5");
    AddMenuItem(g_hMenuSeven, "rif5", "t方mp5");
    AddMenuItem(g_hMenuSeven, "rif6", "全部更换mp7");
    AddMenuItem(g_hMenuSeven, "rif7", "全部更换mp5");
    SetMenuExitBackButton(g_hMenuSeven, true); 

    RegConsoleCmd("nt", Menu_Test1);
    HookEventEx("player_team",	Event_PlayerTeam);
}
public void OnClientPutInServer(int client)
{
	g_OnClientPutInServer[client] = true;
}


public Action Event_PlayerTeam(Handle event, char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if(!client || !IsClientInGame(client) || IsFakeClient(client) || !g_OnClientPutInServer[client] || i_cvEnabled == 0)
	{
		return Plugin_Continue;
	}
	
	ClientCommand(client,"cl_showpluginmessages 1");
	
	return Plugin_Continue;
}


public Action Menu_Test1(int client, int args)
{
    if (client > 0)
    {
        DisplayMenu(g_hMenuOne, client, MENU_TIME_FOREVER);
    }
    PrintToChat(client,"[nt]武器切换菜单已经打开 请按ESC查看^");
    return Plugin_Handled;
}

public MenuOneHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        decl String:Item[20];
		GetMenuItem(g_hMenuOne,param2,Item,sizeof(Item));
		if(StrEqual(Item,"knife"))
		{
            DisplayMenu(g_hMenuTwo, param1, MENU_TIME_FOREVER);
		}else if(StrEqual(Item,"gun"))
		{
            DisplayMenu(g_hMenuFive, param1, MENU_TIME_FOREVER);
		}
        
    }
}

public MenuTwoHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        
        decl String:Item2[20];
		GetMenuItem(g_hMenuTwo,param2,Item2,sizeof(Item2));
		if(StrEqual(Item2,"ct"))
		{
            DisplayMenu(g_hMenuThree, param1, MENU_TIME_FOREVER);

		}else if(StrEqual(Item2,"t"))
        {
            DisplayMenu(g_hMenuFour, param1, MENU_TIME_FOREVER);

        }
        
    }
    else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack && IsClientInGame(param1))
    {
        DisplayMenu(g_hMenuOne, param1, MENU_TIME_FOREVER);
    }
}

public MenuThreeHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        decl String:Item3[20];
		GetMenuItem(g_hMenuThree,param2,Item3,sizeof(Item3));
		if(StrEqual(Item3,"ctknife0"))
		{
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 0");
            PrintToChat(param1,"[nt]CT方 原版匕首 已更换完毕 重生后生效^");

		}else if(StrEqual(Item3,"ctknife1"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 1");
            PrintToChat(param1,"[nt]CT方 海豹短刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item3,"ctknife2"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 2");
            PrintToChat(param1,"[nt]CT方 爪子刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item3,"ctknife3"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 3");
            PrintToChat(param1,"[nt]CT方 折叠刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item3,"ctknife4"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 4");
            PrintToChat(param1,"[nt]CT方 刺刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item3,"ctknife5"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 5");
            PrintToChat(param1,"[nt]CT方 M9刺刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item3,"ctknife6"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 6");
            PrintToChat(param1,"[nt]CT方 蝴蝶刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item3,"ctknife7"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_ct 7");
            PrintToChat(param1,"[nt]CT方 穿肠刀 已更换完毕 重生后生效^");
        }

    }else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack && IsClientInGame(param1))
    {
        DisplayMenu(g_hMenuTwo, param1, MENU_TIME_FOREVER);
    }
} 
public MenuFourHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        decl String:Item4[20];
		GetMenuItem(g_hMenuFour,param2,Item4,sizeof(Item4));
		if(StrEqual(Item4,"tknife0"))
		{
            ClientCommand(param1,"loadout_slot_knife_weapon_t 0");
            PrintToChat(param1,"[nt]T方 原版匕首 已更换完毕 重生后生效^");

		}else if(StrEqual(Item4,"tknife1"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 1");
            PrintToChat(param1,"[nt]T方 海豹短刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item4,"tknife2"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 2");
            PrintToChat(param1,"[nt]T方 爪子刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item4,"tknife3"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 3");
            PrintToChat(param1,"[nt]T方 折叠刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item4,"tknife4"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 4");
            PrintToChat(param1,"[nt]T方 刺刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item4,"tknife5"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 5");
            PrintToChat(param1,"[nt]T方 M9刺刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item4,"tknife6"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 6");
            PrintToChat(param1,"[nt]T方 蝴蝶刀 已更换完毕 重生后生效^");
        }else if(StrEqual(Item4,"tknife7"))
        {
            ClientCommand(param1,"loadout_slot_knife_weapon_t 7");
            PrintToChat(param1,"[nt]T方 穿肠刀 已更换完毕 重生后生效^");
        }

    }else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack && IsClientInGame(param1))
    {
        DisplayMenu(g_hMenuTwo, param1, MENU_TIME_FOREVER);
    }
} 
public MenuFiveHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        decl String:Item5[20];
		GetMenuItem(g_hMenuFive,param2,Item5,sizeof(Item5));
		if(StrEqual(Item5,"pist"))
		{
            DisplayMenu(g_hMenuSix, param1, MENU_TIME_FOREVER);

		}else if(StrEqual(Item5,"rif"))
        {
            DisplayMenu(g_hMenuSeven, param1, MENU_TIME_FOREVER);

        }
    }else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack && IsClientInGame(param1))
    {
        DisplayMenu(g_hMenuTwo, param1, MENU_TIME_FOREVER);
    }
} 
public MenuSixHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        decl String:Item6[20];
		GetMenuItem(g_hMenuSix,param2,Item6,sizeof(Item6));
		if(StrEqual(Item6,"pist0"))
		{
            ClientCommand(param1,"loadout_slot_hkp2000_weapon 1");
            PrintToChat(param1,"[nt]CT方 usp 已更换完毕 重生后生效^");

		}else if(StrEqual(Item6,"pist1"))
        {
            ClientCommand(param1,"loadout_slot_hkp2000_weapon 0");
            PrintToChat(param1,"[nt]CT方 p2000 已更换完毕 重生后生效^");
        }else if(StrEqual(Item6,"pist2"))
        {
            ClientCommand(param1,"loadout_slot_fiveseven_weapon 0");
            PrintToChat(param1,"[nt]CT方 FN57 已更换完毕 重生后生效^");
        }else if(StrEqual(Item6,"pist3"))
        {
            ClientCommand(param1,"loadout_slot_tec9_weapon 0");
            PrintToChat(param1,"[nt]T方 TEC-9 已更换完毕 重生后生效^");
        }else if(StrEqual(Item6,"pist4"))
        {
            ClientCommand(param1,"loadout_slot_fiveseven_weapon 1");
            PrintToChat(param1,"[nt]CT方 CZ75 已更换完毕 重生后生效^");
        }else if(StrEqual(Item6,"pist5"))
        {
            ClientCommand(param1,"loadout_slot_tec9_weapon 1");
            PrintToChat(param1,"[nt]T方 CZ75 已更换完毕 重生后生效^");
        }else if(StrEqual(Item6,"pist6"))
        {
            ClientCommand(param1,"loadout_slot_fiveseven_weapon 1");
            ClientCommand(param1,"loadout_slot_tec9_weapon 1");
            PrintToChat(param1,"[nt]双方阵营 CZ75 已更换完毕 重生后生效^");
        }
    }else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack && IsClientInGame(param1))
    {
        DisplayMenu(g_hMenuTwo, param1, MENU_TIME_FOREVER);
    }
} 

public MenuSevenHandler(Handle:menu, MenuAction:action, param1, param2)
{
    if (action == MenuAction_Select && IsClientInGame(param1))
    {
        decl String:Item7[20];
		GetMenuItem(g_hMenuSeven,param2,Item7,sizeof(Item7));
		if(StrEqual(Item7,"rif0"))
		{
            ClientCommand(param1,"loadout_slot_m4_weapon 1");
            PrintToChat(param1,"[nt]CT方 M4A1消音版 已更换完毕 重生后生效^");

		}else if(StrEqual(Item7,"rif1"))
        {
            ClientCommand(param1,"loadout_slot_m4_weapon 0");
            PrintToChat(param1,"[nt]CT方 M4A4 已更换完毕 重生后生效^");
        }else if(StrEqual(Item7,"rif2"))
        {
            ClientCommand(param1,"loadout_slot_mp7_weapon_ct 0");
            PrintToChat(param1,"[nt]CT方 MP7 已更换完毕 重生后生效^");
        }else if(StrEqual(Item7,"rif3"))
        {
            ClientCommand(param1,"loadout_slot_mp7_weapon_t 0");
            PrintToChat(param1,"[nt]T方 MP7 已更换完毕 重生后生效^");
        }else if(StrEqual(Item7,"rif4"))
        {
            ClientCommand(param1,"loadout_slot_mp7_weapon_ct 1");
            PrintToChat(param1,"[nt]CT方 MP5 已更换完毕 重生后生效^");
        }else if(StrEqual(Item7,"rif5"))
        {
            ClientCommand(param1,"loadout_slot_mp7_weapon_t 1");
            PrintToChat(param1,"[nt]T方 MP5 已更换完毕 重生后生效^");
        }else if(StrEqual(Item7,"rif6"))
        {
            ClientCommand(param1,"loadout_slot_mp7_weapon_ct 0");
            ClientCommand(param1,"loadout_slot_mp7_weapon_t 0");
            PrintToChat(param1,"[nt]双方阵营 MP7 已更换完毕 重生后生效^");
        }else if(StrEqual(Item7,"rif7"))
        {
            ClientCommand(param1,"loadout_slot_mp7_weapon_ct 1");
            ClientCommand(param1,"loadout_slot_mp7_weapon_ct 1");
            PrintToChat(param1,"[nt]双方阵营 MP5 已更换完毕 重生后生效^");
        }
    }else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack && IsClientInGame(param1))
    {
        DisplayMenu(g_hMenuTwo, param1, MENU_TIME_FOREVER);
    }
} 


