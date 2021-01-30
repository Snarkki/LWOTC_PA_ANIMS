//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_ViperAnims.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_ViperAnims extends X2DownloadableContentInfo config (PAAnims);;

var config array<name> IncludeClassTemplates;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{}

static event OnPostTemplatesCreated()
{
//Disable first line and undisable other lines for LWOTC playable aliens - first is for regular playable aliens.
	Modify_Viper_Template('PA_VIPER',"PA_VIPER_ANIM.ARC_GameUnit_PAViper");
//	Modify_Viper_Template('PA_VIPER2',"PA_VIPER_ANIM.ARC_GameUnit_PAViper");
//	Modify_Viper_Template('PA_Sidewinder',"PA_SIDEWINDER.Archetypes_ARC_GameUnit_Sidewinder_F");
//	Modify_Viper_Template('PA_Sidewinder',"PA_SIDEWINDER.Archetypes_ARC_GameUnit_Sidewinder_M");
//	Modify_Viper_Template('PA_Naja',PA_NAJA.Archetypes_ARC_GameUnit_Naja_F");
//	Modify_Viper_Template('PA_Naja',PA_NAJA.Archetypes_ARC_GameUnit_Naja_M");
}

static function Modify_Viper_Template(name TemplateName, string ArchetypeName)
{
	local X2DataTemplate				DataTemplate;
	local array<X2DataTemplate>			DataTemplates;
    local X2CharacterTemplateManager        CharMgr;
	local X2CharacterTemplate			CharacterTemplate;

	`LOG("Modify viper templates",,'LWR_Viper');

	CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	//  Access a specific ability template by name.
		CharMgr.FindDataTemplateAllDifficulties(TemplateName, DataTemplates);
		foreach DataTemplates(DataTemplate)
			{
				// check it's an ability template
				CharacterTemplate = X2CharacterTemplate(DataTemplate);

				if(CharacterTemplate != None)
				{
					`LOG("Character modified",,'LWR_Viper');
					CharacterTemplate.strPawnArchetypes.AddItem(ArchetypeName);
				}
			}
}

static function UpdateAnimations(out array<AnimSet> CustomAnimSets, XComGameState_Unit UnitState, XComUnitPawn Pawn)
{
//	local X2WeaponTemplate PrimaryWeaponTemplate;
	local int TemplateCheck;

	if (UnitState == none || !UnitState.IsSoldier())
	{
		return;
	}
	TemplateCheck = default.IncludeClassTemplates.FIND(UnitState.GetSoldierClassTemplateName());
	if (TemplateCheck != INDEX_NONE)
	{
			CustomAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("PA_VIPER_ANIM.Anims.AS_Grenade")));

	}
}

