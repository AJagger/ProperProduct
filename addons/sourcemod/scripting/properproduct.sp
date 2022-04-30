#pragma semicolon 1

#define DEBUG

#define PLUGIN_NAME "Proper Product"
#define PLUGIN_AUTHOR "Fishage"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <tf2>
#include <tf2_stocks>
#include <sdkhooks>

public Plugin:myinfo = 
{
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = "Make Product fun again",
	version = PLUGIN_VERSION,
	url = "https://github.com/AJagger/ProperProduct"
};

new bool:active = false;

public OnPluginStart()
{
	CreateConVar("pproduct", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_REPLICATED);
	
	active = CheckMapIsProduct();
	
	//Hook players already in the game. Used on plugin reload.
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && !IsFakeClient(i))
		{
			SDKHook(i, SDKHook_OnTakeDamage, HandleDamage);
		}
	}
	
	RegAdminCmd("pproduct_active", ReportActive, ADMFLAG_GENERIC, "Display whether plugin is currently active (i.e. is the map product?)");
}

public OnMapStart()
{
	active = CheckMapIsProduct();
}

public OnClientPutInServer(client)
{
    SDKHook(client, SDKHook_OnTakeDamage, HandleDamage);
}

public bool CheckMapIsProduct()
{
	new String:mapName[128];
	GetCurrentMap(mapName, sizeof(mapName));
	
	return (StrContains(mapName, "koth_product", false) > -1);
}

public Action HandleDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype, &weapon, Float:damageForce[3], Float:damagePosition[3], damagecustom)
{	
	if(active)
	{
		int weaponId = -1;
		if (IsValidEntity(weapon))
		{
			weaponId = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
		}
		else
		{ 
			//Invalid weapon, ignore
			return Plugin_Continue;			
		}
		
		if(DamageDealtBySniperRifle(weaponId))
		{
			ForcePlayerSuicide(attacker);
			
			//Continue without dealing damage to original target
			return Plugin_Handled;
		}
	}
	
	return Plugin_Continue;
}

public bool DamageDealtBySniperRifle(weaponId)
{
	if(weaponId == 14 ||		//Sniper Rifle
		weaponId == 201 ||		//Sniper Rifle (Renamed/Strange)
		weaponId == 230 ||		//The Sydney Sleeper
		weaponId == 402 ||		//The Bazaar Bargain
		weaponId == 526 ||		//The Machina
		weaponId == 664 ||		//Festive Sniper Rifle
		weaponId == 752 ||		//The Hitman's Heatmaker
		weaponId == 792 ||		//Silver Botkiller Sniper Rifle Mk.I
		weaponId == 801 ||		//Gold Botkiller Sniper Rifle Mk.I
		weaponId == 851 ||		//The AWPer Hand
		weaponId == 881 ||		//Rust Botkiller Sniper Rifle Mk.I
		weaponId == 890 ||		//Blood Botkiller Sniper Rifle Mk.I
		weaponId == 899 ||		//Carbonado Botkiller Sniper Rifle Mk.I
		weaponId == 908 ||		//Diamond Botkiller Sniper Rifle Mk.I
		weaponId == 957 ||		//Silver Botkiller Sniper Rifle Mk.II
		weaponId == 966 ||		//Gold Botkiller Sniper Rifle Mk.II
		weaponId == 1098 ||		//The Classic
		weaponId == 15000 ||	//Night Owl
		weaponId == 15007 ||	//Purple Range
		weaponId == 15019 ||	//Lumber From Down Under
		weaponId == 15023 ||	//Shot in the Dark
		weaponId == 15033 ||	//Bogtrotter
		weaponId == 15059 ||	//Thunderbolt
		weaponId == 15070 ||	//Pumpkin Patch
		weaponId == 15071 ||	//Boneyard
		weaponId == 15072 ||	//Wildwood
		weaponId == 15111 ||	//Balloonicorn
		weaponId == 15112 ||	//Rainbow
		weaponId == 15135 ||	//Coffin Nail
		weaponId == 15136 ||	//Dressed to Kill
		weaponId == 15154 ||	//Airwolf
		weaponId == 30665)		//Shooting Star
	{
		return true;
	}
	
	return false;
}

public Action:ReportActive(client, args)
{
	ReplyToCommand(client, "ProperProduct active: %b", active);
	return Plugin_Handled;
}