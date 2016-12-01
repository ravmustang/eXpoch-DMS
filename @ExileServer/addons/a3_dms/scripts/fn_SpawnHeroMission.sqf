/*
	DMS_fnc_SpawnHeroMission
	Created by eraser1
	Upgraded by DonkeyPunch.INFO
	eXpoch and DirtySanchez

	Usage:
	[
		_missionType,
		_parameters
	] call DMS_fnc_SpawnHeroMission;

	Simply spawns a mission with the given mission type and passes parameters to it. Returns nothing
*/

private _mission =
[
	missionNamespace getVariable format
	[
		"DMS_Mission_%1",
		_this param [0,selectRandom DMS_HeroMissionTypesArray, [""]]
	]
] param [0, "no",[{}]];

if (_mission isEqualTo "no") then
{
	diag_log format ["DMS ERROR :: Calling DMS_fnc_SpawnHeroMission for a mission that isn't in DMS_HeroMissionTypesArray! Parameters: %1",_this];
}
else
{
	private _parameters = if ((count _this)>1) then {_this select 1} else {[]};

	DMS_MissionCount 			= DMS_MissionCount + 1;
	DMS_RunningHMissionCount 	= DMS_RunningHMissionCount + 1;
	DMS_HMissionDelay 			= DMS_TimeBetweenMissions call DMS_fnc_SelectRandomVal;

	_parameters call _mission;

	DMS_HMissionLastStart 		= diag_tickTime;


	if (DMS_DEBUG) then
	{
		(format ["SpawnHeroMission :: Spawned mission %1 with parameters (%2) | DMS_HMissionDelay set to %3 seconds", _mission, _parameters, DMS_HMissionDelay]) call DMS_fnc_DebugLog;
	};
};
