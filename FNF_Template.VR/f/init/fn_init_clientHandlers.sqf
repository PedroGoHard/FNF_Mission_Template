//Save player inventory when inventory is opened. Vars used in clutter EH.
playerInventoryEH = player addEventHandler ["InventoryOpened", {
  uniformPlayer = uniform player;
  vestPlayer = vest player;
  backpackPlayer = backpack player;

  uniformInventory = uniformItems player;
  vestInventory = vestItems player;
  backpackInventory = backpackItems player;

  primaryWeaponPlayer = primaryWeapon player;
  secondaryWeaponPlayer = secondaryWeapon player;
  handgunWeaponPlayer = handgunWeapon player;

  primaryWeaponAttachments = primaryWeaponItems player;
  secondaryWeaponAttachments = secondaryWeaponItems player;
  handgunWeaponAttachments = handgunItems player;

  weaponMags = primaryWeaponMagazine player;
  weaponMagsSecondary = secondaryWeaponMagazine player;
  handgunMags = handgunMagazine player;

  itemsPlayer = assignedItems player;
  headPlayer = headgear player;
}];

//Stop players from cluttering the ground and sharing weapons.
deleteGroundClutterEH = player addEventHandler ["Put", {
	params ["_unit", "_container", "_item"];
  _weaponsArray = [primaryWeaponPlayer,secondaryWeaponPlayer,handgunWeaponPlayer];
  _ammoArray = weaponMags + weaponMagsSecondary + handgunMags;
  _itemsArray = [primaryWeaponPlayer,secondaryWeaponPlayer,handgunWeaponPlayer,uniformPlayer,vestPlayer,backpackPlayer,headPlayer];
  _itemsArray = _itemsArray + _weaponsArray + _ammoArray;
  if ((_container isKindOf "GroundWeaponHolder" || _item in _itemsArray) && (!(_container isEqualTo _unit) || _item in _itemsArray)) then {
    [_container, _item, 1, false] call CBA_fnc_removeItemCargo;
    [_container, _item, 1, false] call CBA_fnc_removeWeaponCargo;
    [_container, _item, 1, false] call CBA_fnc_removeBackpackCargo;
    [_container, _item, 1, -1] call CBA_fnc_removeMagazineCargo;

    _itemAdded = false;

    _clearAndAddInventory_Weapon = {
      params["_unit","_item"];
      if (!(_item == primaryWeaponPlayer) && !(_item == secondaryWeaponPlayer) && !(_item == handgunWeaponPlayer)) exitWith {};
      {_unit unassignItem _x;} forEach itemsPlayer;
      {_unit removeItem _x;} forEach itemsPlayer;
      _binoculars = itemsPlayer select (count itemsPlayer) - 1;
      _unit removeWeapon _binoculars;
      removeUniform _unit;
      removeVest  _unit;
      removeBackpack _unit;
      _unit addUniform uniformPlayer;
      _unit addVest vestPlayer;
      _unit addBackpack backpackPlayer;
      _unit addWeapon _item;
      switch (_item) do {
        case primaryWeaponPlayer: {
          {_unit addPrimaryWeaponItem _x;} forEach primaryWeaponAttachments;
          {_unit addPrimaryWeaponItem _x;} forEach weaponMags;
        };
        case secondaryWeaponPlayer: {
          {_unit addSecondaryWeaponItem _x;} forEach secondaryWeaponAttachments;
          {_unit addSecondaryWeaponItem _x;} forEach weaponMagsSecondary;
        };
        case handgunWeaponPlayer: {
          {_unit addHandgunItem _x;} forEach handgunWeaponAttachments;
          {_unit addHandgunItem _x;} forEach handgunMags;
        };
      };

      {_unit addItemToUniform _x;} forEach uniformInventory;
      {_unit addItemToVest _x;} forEach vestInventory;
      {_unit addItemToBackpack _x;} forEach backpackInventory;
      {_unit addItem _x;} forEach itemsPlayer;
      _unit removeItem _binoculars;
      {_unit assignItem _x;} forEach itemsPlayer;
      _unit addWeapon _binoculars;
      _itemAdded = true;
    };
    _clearAndAddInventory = {
      params["_unit","_item"];
      if (_itemAdded) exitWith {};
      if (!(_item == uniformPlayer) && !(_item == vestPlayer) && !(_item == backpackPlayer)) exitWith {};
      switch (_item) do {
        case uniformPlayer: {
          _unit addUniform uniformPlayer;
          {_unit addItemToUniform _x;} forEach uniformInventory;
        };
        case vestPlayer: {
          _unit addVest vestPlayer;
          {_unit addItemToVest _x;} forEach vestInventory;
        };
        case backpackPlayer: {
          _unit addBackpack backpackPlayer;
          {_unit addItemToBackpack _x;} forEach backpackInventory;
        };
      };
      _itemAdded = true;
    };

    _handleGearItem = {
      params["_unit","_item"];
      if (_itemAdded) exitWith {};
      if (_item in primaryWeaponAttachments && !(primaryWeaponAttachments isEqualTo primaryWeaponItems _unit)) then {
        _unit addPrimaryWeaponItem _item;
        _itemAdded = true;
      };
      if (_item in secondaryWeaponAttachments && !(secondaryWeaponAttachments isEqualTo secondaryWeaponItems _unit) && !_itemAdded) then {
        _unit addSecondaryWeaponItem _item;
        _itemAdded = true;
      };
      if (_item in handgunWeaponAttachments && !(handgunWeaponAttachments isEqualTo handgunItems _unit) && !_itemAdded) then {
        _unit addHandgunItem _item;
        _itemAdded = true;
      };
      if (_item in weaponMags && !(weaponMags isEqualTo primaryWeaponMagazine _unit) && !_itemAdded) then {
        _unit addPrimaryWeaponItem _item;
        _itemAdded = true;
      };
      if (_item in weaponMagsSecondary && !(weaponMagsSecondary isEqualTo secondaryWeaponMagazine _unit) && !_itemAdded) then {
        _unit addSecondaryWeaponItem _item;
        _itemAdded = true;
      };
      if (_item in handgunMags && !(handgunMags isEqualTo handgunMagazine _unit) && !_itemAdded) then {
        _unit addHandgunItem _item;
        _itemAdded = true;
      };
      if (_item in uniformInventory && !_itemAdded) then {
        _unit addItemToUniform _item;
        _itemAdded = true;
      };
      if (_item in vestInventory && !_itemAdded) then {
        _unit addItemToVest _item;
        _itemAdded = true;
      };
      if (_item in backpackInventory && !_itemAdded) then {
        _unit addItemToBackpack _item;
        _itemAdded = true;
      };
      if (!_itemAdded) then {
        _unit addWeapon _item;
      };
    };

    [player, _item]  call _clearAndAddInventory_Weapon;
    [player, _item] call _clearAndAddInventory;
    [player, _item] call _handleGearItem;

    if (!isNull findDisplay 602)then {closeDialog 602};
    "phx_safeStartTextLayer" cutText ["No littering, please", "PLAIN", 0];
    "phx_safeStartTextLayer" cutFadeOut 5;
  };
}];

//Grenade limiter
limitHandGrenades = 4;
limitLauncherGrenades = 7;

//Cap grenade and satchel amount
grenadeAmmoCapPFH = [{
  _numberOfGrenades = 0;
  _numberOfLauncherGrenades = 0;

  _sumHandGrenades = {
    _numberOfGrenades = ({"HandGrenade" == _x} count (magazines player)) + ({"rhs_mag_an_m14_th3" == _x} count (magazines player)) + ({"ACE_M84" == _x} count (magazines player));
  };

  _sumLauncherGrenades = {
    _numberOfLauncherGrenades = ({"1Rnd_HE_Grenade_shell" == _x} count (magazines player)) + ({"rhs_VOG25" == _x} count (magazines player));
  };

  [_numberOfGrenades] call _sumHandGrenades;
  [_numberOfLauncherGrenades] call _sumLauncherGrenades;

  if (_numberOfGrenades > limitHandGrenades) then {
    for "_i" from 1 to (_numberOfGrenades - limitHandGrenades) do {
      call _sumHandGrenades;
      if (_numberOfGrenades > limitHandGrenades) then {
        player removeItem "rhs_mag_an_m14_th3";
      };
      call _sumHandGrenades;
      if (_numberOfGrenades > limitHandGrenades) then {
        player removeItem "ACE_M84";
      };
      call _sumHandGrenades;
      if (_numberOfGrenades > limitHandGrenades) then {
        player removeItem "HandGrenade";
      };
    };
    if (!isNull findDisplay 602)then {closeDialog 602};
    ["There is a maximum of 4 hand grenades allowed (smoke not included)"] call phx_fnc__hintThenClear;
  };

  if (_numberOfLauncherGrenades > limitLauncherGrenades) then {
    for "_j" from 1 to (_numberOfLauncherGrenades - limitLauncherGrenades) do {
      call _sumLauncherGrenades;
      if (_numberOfLauncherGrenades > limitLauncherGrenades) then {
        player removeItem "1Rnd_HE_Grenade_shell";
      };
      call _sumLauncherGrenades;
      if (_numberOfLauncherGrenades > limitLauncherGrenades) then {
        player removeItem "rhs_VOG25";
      };
    };
    if (!isNull findDisplay 602)then {closeDialog 602};
    ["There is a maximum of 8 HE launcher grenades allowed"] call phx_fnc__hintThenClear;
  };
}, 2, []] call CBA_fnc_addPerFrameHandler;
