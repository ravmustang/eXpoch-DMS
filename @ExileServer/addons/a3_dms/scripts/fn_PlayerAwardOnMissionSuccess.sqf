/*
	DMS_fnc_PlayerAwardOnMissionSuccess
	Created by eraser1
	Upgraded by DirtySanchez

*/
_params = _this;
_array = _params select 0;
_completionType = _array select 0;
_completionArray = _array select 1;
_missionPos = _completionArray select 0;
_distance = _completionArray select 1;
_playersNear = nearestObjects[_missionPos,["Exile_Unit_Player","eXpoch_Female_Prisoner_F"],_distance];
_player = _playersNear select 0;
if(isPlayer _player)then
{
	if (DMS_Add_MissionCompletion2DB) then
	{
		_newWeinerCaptures = _player getVariable ["ExileDMS", 0];
		_newWeinerCaptures = _newWeinerCaptures + 1;
		_player setVariable ["ExileDMS", _newWeinerCaptures];
		format["addAccountDMS:%1", getPlayerUID _player] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerDMS = _newWeinerCaptures;
		(owner _player) publicVariableClient "ExileClientPlayerDMS";
		ExileClientPlayerDMS = nil;
	};
	if (DMS_Show_Party_Capture_Notification) then
	{
		private _group = group _player;
		private _members = units _group;
			if ((count _members)>1) then
		{
			private _msg = format
			[
				"%1 just captured that mission! That's %2 DMS completions so far",
				name _player,
				_newWeinerCaptures
			];
				{
				_msg remoteExecCall ["systemChat", _player];
			} forEach _members;
		};
	};
};