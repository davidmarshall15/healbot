local TempMaxH=0;
local HealBot_TrackNames={};
local HealBot_TrackPrivateNames={}
local i={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local order = {};
local units = {};
local suborder = {};
local subunits = {};
local MyGroup={["GROUP"]=0,["FRAME"]=1}
local HeaderPos={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_ActiveHeaders={[0]=1}
local HealBot_AutoCloseFrame={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local HealBot_TrackUnit={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={},[11]={}}
local HealBot_SpecialUnit={}
local HealBot_TrackPrivateUnit={}
local HealBot_Panel_BlackList={};
local backBarsSize={[1]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [2]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [3]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [4]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [5]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [6]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [7]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [8]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                    [9]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},
                   [10]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0},}
local HealBot_MyHealTargets={}
local HealBot_MyPrivateTanks={}
local HealBot_MyPrivateHealers={}
local HealBot_MyPrivateDamagers={}
local HealBot_MainTanks={};
local HealBot_MainHealers={};
local HealBot_UnitGroups={}
local HealBot_TestBarsActive={}
local hbBarsPerFrame={}
local hbCurrentFrame=1
local HealBot_unitRole={}
local _
local nraid=0
local hbOptionOn=0
local hbMoveMe=0
local hbFocusOn=0
local HealBot_Header_Frames={}
local HealBot_Track_Headers={}
local HealBot_PanelVars={}
local hbPanel_dataUnits={}
local hbPanel_dataNames={}
local hbPanel_dataGUIDs={}
local hbPanel_dataRoles={}
local hbPanel_dataRanks={}
local hbPanel_dataPlayerRoles={}
local hbPanel_dataPetUnits={}
local hbPanel_dataPetNames={}
local hbPanel_dataPetGUIDs={}
local hbPanel_dataExtraGUIDs={}
local hbPanel_enemyUnits={}
local hbPanel_enemyUnits={}
local grpNo=1
local tHeader={}
local erButton=nil
local xUnit=""
local xGUID=""
local hbRole={ [HEALBOT_MAINTANK]=3,
               [HEALBOT_WORD_HEALER]=5,
               [HEALBOT_WORD_DPS]=7,
               [HEALBOT_WORDS_UNKNOWN]=9,
      }
local HealBot_randomN=random(11)
local prevCol=0
local HealBot_randomClCol = {}
local HealBot_randomClNames={}
local HealBot_Action_HealGroup = {
    "player",
    "party1",
    "party2",
    "party3",
    "party4",
};
local HealBot_colIndex= {}
local HealBot_Action_HealButtons = {};
local hbPanelShowhbFocus=nil
local hbPanelNoCols={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local hbPanelNoRows={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local HealBot_noBars=100
local HealBot_setTestCols={}
local HealBot_setTestBars=false
local HealBot_RoleIDs={[HEALBOT_MAINTANK]=1, [HEALBOT_WORD_HEALER]=2, [HEALBOT_WORD_DPS]=3}
local HealBot_Panel_luVars={}
HealBot_Panel_luVars["SelfPets"]=false
HealBot_Panel_luVars["OptionsShown"]=false
HealBot_Panel_luVars["TestBarsDelAll"]=true
HealBot_Panel_luVars["MAPID"]=0
HealBot_Panel_luVars["NumPrivate"]=0
HealBot_Panel_luVars["NumPets"]=0
HealBot_Panel_luVars["TankHealth"]=0
HealBot_Panel_luVars["cpGroup"]=false
HealBot_Panel_luVars["cpRaid"]=false
HealBot_Panel_luVars["FocusGroups"]=1
HealBot_Panel_luVars["cpMacro"]="HealBot-CrashProt"
HealBot_Panel_luVars["cpCrash"]=false
HealBot_Panel_luVars["resetAuxText"]=false

local hbRoleOnes={}
local hbTANK=1
local hbHEALER=2
local hbDPS=3
local hbDPSC=4
local hbRoleRef={[hbTANK]="TankUnit",[hbHEALER]="HealerUnit",[hbDPS]="DPSUnit",[hbDPSC]="DPSUnitCaster"}
for x=1,4 do
    hbRoleOnes[x]={}
    hbRoleOnes[x].guid=""
    hbRoleOnes[x].prevguid="x"
    hbRoleOnes[x].unit=""
    hbRoleOnes[x].health=0
end
--local hbClassOnes={}

local tClass={["WARR"]=true,["PALA"]=true,["DRUI"]=true,["DEAT"]=true}
function HealBot_Panel_retLuVars(vName)
      --HealBot_setCall("HealBot_Panel_retLuVars - "..vName)
    return HealBot_Panel_luVars[vName]
end

function HealBot_Panel_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Panel_setLuVars - "..vName)
    HealBot_Panel_luVars[vName]=vValue
end

function HealBot_Panel_retNoCols(frame)
      --HealBot_setCall("HealBot_Panel_retNoCols")
    return hbPanelNoCols[frame]
end

function HealBot_Panel_retHeadersCols(frame)
      --HealBot_setCall("HealBot_Panel_retHeadersCols")
    return ceil(hbPanelNoRows[frame]/5)
end

function HealBot_Panel_setAutoClose(frame)
      --HealBot_setCall("HealBot_Panel_setAutoClose")
    HealBot_AutoCloseFrame[frame]=Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]
end

function HealBot_Panel_setCP(cpType, useCP)
      --HealBot_setCall("HealBot_Panel_setCP")
    if cpType=="GROUP" then
        HealBot_Panel_luVars["cpGroup"]=useCP
    elseif cpType=="RAID" then
        HealBot_Panel_luVars["cpRaid"]=useCP
    end
end

function HealBot_Panel_isSpecialUnit(unit)
      --HealBot_setCall("HealBot_Panel_isSpecialUnit")
    return HealBot_SpecialUnit[unit] or 0
end

function HealBot_Panel_TankRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_TankRole")
    HealBot_unitRole[unit]=hbRole[HEALBOT_MAINTANK]
    HealBot_MainTanks[guid]=unit
    if isPlayer and UnitHealthMax(unit)>hbRoleOnes[hbTANK].health then
        hbRoleOnes[hbTANK].health=UnitHealthMax(unit)
        hbRoleOnes[hbTANK].guid=guid
        hbRoleOnes[hbTANK].unit=unit
    end
    if hbPanel_dataPlayerRoles[guid]==0 or hbPanel_dataPlayerRoles[guid]>5 then hbPanel_dataPlayerRoles[guid]=2 end
end
 
function HealBot_Panel_HealerRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_HealerRole")
    HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_HEALER]
    HealBot_MainHealers[guid]=unit
    if isPlayer and UnitHealthMax(unit)>hbRoleOnes[hbHEALER].health then
        hbRoleOnes[hbHEALER].health=UnitHealthMax(unit)
        hbRoleOnes[hbHEALER].guid=guid
        hbRoleOnes[hbHEALER].unit=unit
    end
    if hbPanel_dataPlayerRoles[guid]==0 or hbPanel_dataPlayerRoles[guid]>5 then hbPanel_dataPlayerRoles[guid]=3 end
end

function HealBot_Panel_DamagerRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_DamagerRole")
    HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_DPS]
    if isPlayer then
        if UnitHealthMax(unit)>hbRoleOnes[hbDPS].health then
            hbRoleOnes[hbDPS].health=UnitHealthMax(unit)
            hbRoleOnes[hbDPS].guid=guid
            hbRoleOnes[hbDPS].unit=unit
        end
        if (UnitPowerType(unit) or 1)==0 and UnitHealthMax(unit)>hbRoleOnes[hbDPSC].health then
            hbRoleOnes[hbDPSC].health=UnitHealthMax(unit)
            hbRoleOnes[hbDPSC].guid=guid
            hbRoleOnes[hbDPSC].unit=unit
        end
    end
end

local aRole = nil
function HealBot_Panel_SetRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_SetRole")
    aRole = HealBot_Panel_UnitRole(unit, guid, isPlayer)
    if aRole=="TANK" then
        HealBot_Panel_TankRole(unit, guid, isPlayer)
    elseif aRole=="HEALER" then
        HealBot_Panel_HealerRole(unit, guid, isPlayer)
    elseif aRole=="DAMAGER" then
        HealBot_Panel_DamagerRole(unit, guid, isPlayer)
    else
        HealBot_unitRole[unit]=hbRole[HEALBOT_WORDS_UNKNOWN]
    end
end

function HealBot_Panel_updDataStore(button)
      --HealBot_setCall("HealBot_Panel_updDataStore")
    button.reset=true
    if hbPanel_dataUnits[button.unit] then
        hbPanel_dataNames[button.name]=button.unit
        hbPanel_dataGUIDs[button.guid]=button.unit
        hbPanel_dataUnits[button.unit]=button.guid
        button.roletxt=HealBot_Panel_UnitRoleDefault(button.guid)
        button.rank=hbPanel_dataRanks[button.guid] or 0
        if button.role~=hbPanel_dataPlayerRoles[button.guid] then
            button.role=hbPanel_dataPlayerRoles[button.guid]
            HealBot_setLuVars("pluginClearDown", 1)
        end
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",1)
    elseif hbPanel_dataPetUnits[button.unit] then
        hbPanel_dataPetNames[button.name]=button.unit
        hbPanel_dataPetGUIDs[button.guid]=button.unit
        hbPanel_dataPetUnits[button.unit]=button.guid
        if button.status.unittype==7 then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcVehicle",1)
        elseif button.status.unittype==8 then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets",1)
        end
    elseif button.status.unittype>8 then
        hbPanel_dataExtraGUIDs[button.guid]=button.unit
    end
end

local hbPrevPlayerGUID={}
for x=1,40 do
    hbPrevPlayerGUID[x]=""
end
function HealBot_Panel_addDataStore(unit, nRaidID, isPlayer, nPartyID)
      --HealBot_setCall("HealBot_Panel_addDataStore")
    if UnitExists(unit) then
        local dsGUID=UnitGUID(unit)
        local dsName=UnitName(unit)
        if dsGUID then
            hbPanel_dataRanks[dsGUID]=0
            hbPanel_dataPlayerRoles[dsGUID]=0
            if isPlayer then
                --if UnitIsUnit(unit, "player") then unit="player" end
                hbPanel_dataNames[dsName]=unit
                hbPanel_dataGUIDs[dsGUID]=unit
                hbPanel_dataUnits[unit]=dsGUID
            else
                --if UnitIsUnit(unit, "pet") then unit="pet" end
                hbPanel_dataPetNames[dsName]=unit
                hbPanel_dataPetGUIDs[dsGUID]=unit
                hbPanel_dataPetUnits[unit]=dsGUID
            end
            hbPanel_dataRoles[dsGUID]=HEALBOT_WORDS_UNKNOWN
            if HealBot_MyPrivateTanks[dsGUID] or HealBot_Globals.HealBot_PermPrivateTanks[dsGUID] then
                hbPanel_dataRoles[dsGUID]="TANK"
                hbPanel_dataPlayerRoles[dsGUID]=4
            elseif HealBot_MyPrivateHealers[dsGUID] or HealBot_Globals.HealBot_PermPrivateHealers[dsGUID] then
                hbPanel_dataRoles[dsGUID]="HEALER"
                hbPanel_dataPlayerRoles[dsGUID]=5
            elseif HealBot_MyPrivateDamagers[dsGUID] or  HealBot_Globals.HealBot_PermPrivateDamagers[dsGUID] then
                hbPanel_dataRoles[dsGUID]="DAMAGER"
            end
            if nRaidID>0 then
                if hbPrevPlayerGUID[nRaidID]~=dsGUID then
                    hbPrevPlayerGUID[nRaidID]=dsGUID
                    HealBot_setLuVars("pluginClearDown", 1)
                end
                local hbFRole=false
                local _, rank, hbSubgroup, _, _, _, _, _, _, hbRRole, isML, hbCombatRole = GetRaidRosterInfo(nRaidID);
                HealBot_UnitGroups[unit]=hbSubgroup
                if isPlayer then
                    if hbPanel_dataPlayerRoles[dsGUID]==0 then hbPanel_dataPlayerRoles[dsGUID]=7 end
                    if hbPanel_dataRoles[dsGUID]==HEALBOT_WORDS_UNKNOWN then
                        if hbRRole and (string.lower(hbRRole)=="maintank" or (HealBot_Globals.IncMainAssist and string.lower(hbRRole)=="mainassist")) then
                            hbFRole="TANK"
                            if string.lower(hbRRole)=="maintank" then hbPanel_dataPlayerRoles[dsGUID]=1 end
                        elseif hbCombatRole and (hbCombatRole=="HEALER" or hbCombatRole=="TANK") then
                            if HEALBOT_GAME_VERSION>3 then
                                hbFRole = hbCombatRole
                            else
                                if HealBot_Globals.AllowPlayerRoles then
                                    if hbCombatRole=="HEALER" then
                                        hbFRole = "HEALER"
                                    else
                                        hbFRole=HealBot_Panel_CheckRole(unit)
                                    end
                                else
                                    hbFRole=HealBot_Panel_UnitRoleOnSpec(dsGUID, hbFRole)
                                end
                            end
                        end
                    end
                    if HEALBOT_GAME_VERSION>3 and rank>0 and GetLFGMode(LE_LFG_CATEGORY_LFR) then
                        if UnitIsGroupLeader(unit) then
                            hbPanel_dataRanks[dsGUID]=2
                        end
                    elseif isML then
                        hbPanel_dataRanks[dsGUID]=3
                    elseif rank>0 then
                        hbPanel_dataRanks[dsGUID]=rank
                    end
                end
                if not hbFRole then
                    HealBot_Panel_SetRole(unit, dsGUID, isPlayer)
                else
                    hbPanel_dataRoles[dsGUID]=hbFRole
                    if hbFRole=="TANK" then
                        HealBot_Panel_TankRole(unit, dsGUID, isPlayer)
                    elseif hbFRole=="HEALER" then 
                        HealBot_Panel_HealerRole(unit, dsGUID, isPlayer)
                    end
                end
            else
                if nPartyID and hbPrevPlayerGUID[nPartyID]~=dsGUID then
                    hbPrevPlayerGUID[nPartyID]=dsGUID
                    HealBot_setLuVars("pluginClearDown", 1)
                end
                HealBot_UnitGroups[unit]=1
                HealBot_Panel_SetRole(unit, dsGUID, isPlayer)
                if IsInGroup() then
                    if UnitIsGroupLeader(unit) then hbPanel_dataRanks[dsGUID]=4 end
                    if hbPanel_dataPlayerRoles[dsGUID]==0 then hbPanel_dataPlayerRoles[dsGUID]=6 end
                end
            end
        end
    end
end

local hbPlayerRaidID=0
function HealBot_Panel_buildDataStore(doPlayers, doPets)
      --HealBot_setCall("HealBot_Panel_buildDataStore")
    if doPlayers then
        for x,_ in pairs(hbPanel_dataNames) do
            hbPanel_dataNames[x]=nil
        end
        for x,_ in pairs(hbPanel_dataGUIDs) do
            HealBot_MainTanks[x]=nil
            HealBot_MainHealers[x]=nil
            hbPanel_dataGUIDs[x]=nil
        end
        for x,_ in pairs(hbPanel_dataUnits) do
            HealBot_unitRole[x]=9
            hbPanel_dataUnits[x]=false
        end
        hbPlayerRaidID=0
        for x=1,4 do
            hbRoleOnes[x].health=0
            hbRoleOnes[x].guid=""
        end
        if HealBot_Config.DisabledNow==0 then
            local nGroupMembers=GetNumGroupMembers()
            if nGroupMembers>0 then
                if IsInRaid() then
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("raid"..j, j, true)
                        if UnitIsUnit("raid"..j,"player") then
                            hbPlayerRaidID=j
                        end
                    end
                else
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("party"..j, 0, true, j)
                    end
                end
            end
        end
        HealBot_Panel_addDataStore("player", hbPlayerRaidID, true)
        for x=1,4 do
            if hbRoleOnes[x].prevguid~=hbRoleOnes[x].guid then
                hbRoleOnes[x].prevguid=hbRoleOnes[x].guid
                if hbRoleOnes[x].guid=="" then
                    HealBot_setLuVars(hbRoleRef[x], "x")
                    HealBot_Aura_setLuVars(hbRoleRef[x], "x")
                    HealBot_ActionIcons_setLuVars(hbRoleRef[x], "x")
                    --HealBot_AddDebug(hbRoleRef[x].." is x","One Unit Role",true)
                else
                    HealBot_setLuVars(hbRoleRef[x], hbRoleOnes[x].unit)
                    HealBot_Aura_setLuVars(hbRoleRef[x], hbRoleOnes[x].unit)
                    HealBot_ActionIcons_setLuVars(hbRoleRef[x], hbRoleOnes[x].unit)
                    --HealBot_AddDebug(hbRoleRef[x].." is "..UnitName(hbRoleOnes[x].unit),"One Unit Role",true)
                end
                HealBot_setLuVars("pluginClearDown", 1)
            end
        end
    end
    if doPets then
        HealBot_Panel_luVars["NumPets"]=0
        for x,_ in pairs(hbPanel_dataPetNames) do
            hbPanel_dataPetNames[x]=nil;
        end
        for x,_ in pairs(hbPanel_dataPetGUIDs) do
            HealBot_MainTanks[x]=nil
            HealBot_MainHealers[x]=nil
            hbPanel_dataPetGUIDs[x]=nil
        end
        for x,_ in pairs(hbPanel_dataPetUnits) do
            HealBot_unitRole[x]=9
            hbPanel_dataPetUnits[x]=false
        end
        if HealBot_Config.DisabledNow==0 then
            HealBot_Panel_addDataStore("pet", 0, false)
            local nGroupMembers=GetNumGroupMembers()
            if nGroupMembers>0 then
                if IsInRaid() then
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("raidpet"..j, j, false)
                    end
                else
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("partypet"..j, 0, false)
                    end
                end
            end
        end
    end
end

function HealBot_Panel_clickToFocus(status)
      --HealBot_setCall("HealBot_Panel_clickToFocus")
    if status=="Show" then
        hbPanelShowhbFocus=true
    else
        hbPanelShowhbFocus=false
    end
end

function HealBot_Panel_IsMyTarget(guid)
      --HealBot_setCall("HealBot_Panel_IsMyTarget", nil, guid)
    return HealBot_MyHealTargets[guid] or HealBot_Globals.HealBot_PermMyTargets[guid]
end

function HealBot_Panel_IsTank(guid)
      --HealBot_setCall("HealBot_Panel_IsTank", nil, guid)
    return HealBot_MainTanks[guid]
end

function HealBot_Panel_IsHealer(guid)
      --HealBot_setCall("HealBot_Panel_IsHealer", nil, guid)
    return HealBot_MainHealers[guid]
end

function HealBot_Panel_SethbTopRole(Role)
      --HealBot_setCall("HealBot_Panel_SethbTopRole")
    if not Role then return end
    Role=strupper(strtrim(Role))
    if Role=="TANK" then
        hbRole[HEALBOT_MAINTANK]=2
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=7
    elseif Role=="DPS" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=2
    elseif Role=="HEALER" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=2
        hbRole[HEALBOT_WORD_DPS]=7
    else
        HealBot_AddChat(Role..HEALBOT_CHAT_TOPROLEERR)
        return
    end
    if HealBot_Globals.TopRole~=Role then
        HealBot_Globals.TopRole=Role
        HealBot_AddChat(HEALBOT_CHAT_NEWTOPROLE..Role)
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    end
end

function HealBot_Panel_ClearBlackList()
      --HealBot_setCall("HealBot_Panel_ClearBlackList")
    for x,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_Panel_BlackList[x]=nil
    end 
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_AddBlackList(unit)
      --HealBot_setCall("HealBot_Panel_AddBlackList", nil, nil, unit)
    xGUID=UnitGUID(unit)
    if xGUID then
        HealBot_Panel_BlackList[xGUID]=true;
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    end
end

function HealBot_Panel_ClearHealTargets()
      --HealBot_setCall("HealBot_Panel_ClearHealTargets")
    HealBot_MyHealTargets = {}
end

function HealBot_Panel_PrivateListUpdate()
      --HealBot_setCall("HealBot_Panel_PrivateListUpdate")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets")
    HealBot_Timers_Set("AURA","CheckUnits")
end

function HealBot_Panel_ToggelHealTarget(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelHealTarget", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermMyTargets[xGUID] then
            HealBot_Globals.HealBot_PermMyTargets[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermMyTargets[xGUID]=UnitName(unit) or "unKnown"
        end
    else
        if HealBot_MyHealTargets[xGUID] then
            HealBot_MyHealTargets[xGUID]=nil
        else
            HealBot_MyHealTargets[xGUID]=true
        end
    end
    HealBot_Panel_PrivateListUpdate()
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_ToggelPrivateTanks(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelPrivateTanks", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermPrivateTanks[xGUID] then
            HealBot_Globals.HealBot_PermPrivateTanks[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermPrivateTanks[xGUID]=UnitName(unit) or "unKnown"
        end
    else
        if HealBot_MyPrivateTanks[xGUID] then
            HealBot_MyPrivateTanks[xGUID]=nil
        else
            HealBot_MyPrivateTanks[xGUID]=true
        end
    end
    HealBot_Panel_PrivateListUpdate()
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_ToggelPrivateHealers(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelPrivateHealers", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermPrivateHealers[xGUID] then
            HealBot_Globals.HealBot_PermPrivateHealers[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermPrivateHealers[xGUID]=UnitName(unit) or "unKnown"
        end
    else
        if HealBot_MyPrivateHealers[xGUID] then
            HealBot_MyPrivateHealers[xGUID]=nil
        else
            HealBot_MyPrivateHealers[xGUID]=true
        end
    end
    HealBot_Panel_PrivateListUpdate()
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_ToggelPrivateDamagers(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelPrivateDamagers", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermPrivateDamagers[xGUID] then
            HealBot_Globals.HealBot_PermPrivateDamagers[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermPrivateDamagers[xGUID]=UnitName(unit) or "unKnown"
        end
    else
        if HealBot_MyPrivateDamagers[xGUID] then
            HealBot_MyPrivateDamagers[xGUID]=nil
        else
            HealBot_MyPrivateDamagers[xGUID]=true
        end
    end
    HealBot_Panel_PrivateListUpdate()
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_RetMyHealTarget(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetMyHealTarget", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.HealBot_PermMyTargets[xGUID]
    else
        return HealBot_MyHealTargets[xGUID]
    end
end

function HealBot_Panel_RetPrivateTanks(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetPrivateTanks", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.HealBot_PermPrivateTanks[xGUID]
    else
        return HealBot_MyPrivateTanks[xGUID]
    end
end

function HealBot_Panel_RetPrivateHealers(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetPrivateHealers", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.HealBot_PermPrivateHealers[xGUID]
    else
        return HealBot_MyPrivateHealers[xGUID]
    end
end

function HealBot_Panel_RetPrivateDamagers(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetPrivateDamagers", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.HealBot_PermPrivateDamagers[xGUID]
    else
        return HealBot_MyPrivateDamagers[xGUID]
    end
end

local role_tex_file = "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp"
local role_t = "\124T"..role_tex_file..":%d:%d:"
local role_tex = {
   DAMAGER = role_t.."0:0:64:64:20:39:22:41\124t",
   HEALER  = role_t.."0:0:64:64:20:39:1:20\124t",
   TANK    = role_t.."0:0:64:64:0:19:22:41\124t",
   LEADER  = role_t.."0:0:64:64:0:19:1:20\124t",
   NONE    = ""
}

local roleTextures={
    ["DAMAGER"]="Interface\\Addons\\HealBot\\Images\\dps.tga",
    ["TANK"]="Interface\\Addons\\HealBot\\Images\\tank.tga",
    ["HEALER"]="Interface\\Addons\\HealBot\\Images\\healer.tga",
    }
    
local classTextures={
    ["DEAT"]="Interface\\Addons\\HealBot\\Images\\Deathknight-round",
    ["DEMO"]="Interface\\Addons\\HealBot\\Images\\Demonhunter-round",
    ["DRUI"]="Interface\\Addons\\HealBot\\Images\\Druid-round",
    ["HUNT"]="Interface\\Addons\\HealBot\\Images\\Hunter-round",
    ["MAGE"]="Interface\\Addons\\HealBot\\Images\\Mage-round",
    ["MONK"]="Interface\\Addons\\HealBot\\Images\\Monk-round",
    ["PALA"]="Interface\\Addons\\HealBot\\Images\\Paladin-round",
    ["PRIE"]="Interface\\Addons\\HealBot\\Images\\Priest-round",
    ["ROGU"]="Interface\\Addons\\HealBot\\Images\\Rogue-round",
    ["SHAM"]="Interface\\Addons\\HealBot\\Images\\Shaman-round",
    ["WARL"]="Interface\\Addons\\HealBot\\Images\\Warlock-round",
    ["WARR"]="Interface\\Addons\\HealBot\\Images\\Warrior-round",
    ["EVOK"]="Interface\\Addons\\HealBot\\Images\\Warrior-round",
    }

function HealBot_Panel_retClassRoleIcon(id)
      --HealBot_setCall("HealBot_Panel_retClassRoleIcon")
    return classTextures[id] or roleTextures[id]
end

function HealBot_Panel_classEN(unit)
      --HealBot_setCall("HealBot_Panel_classEN", nil, nil, unit)
    local classEN = HealBot_EnClass(unit)
    if classEN then 
        return strsub(classEN,1,4)
    else
        return HealBot_Class_En[HEALBOT_WARRIOR]
    end
end

function HealBot_Panel_CheckRole(unit)
      --HealBot_setCall("HealBot_Panel_CheckRole", nil, nil, unit)
    local classEN = HealBot_EnClass(unit)
    if classEN and not tClass[strsub(classEN,1,4)] then
        return "DAMAGER"
    end
    return "TANK"
end

function HealBot_Panel_UnitRoleOnSpec(guid, role)
      --HealBot_setCall("HealBot_Panel_UnitRoleOnSpec", nil, guid)
    if HealBot_Panel_RaidUnitGUID(guid) then
        local s=HealBot_Action_getGuidData(guid, "SPEC")
        if s==" "..HEALBOT_RESTORATION.." " or s==" "..HEALBOT_DISCIPLINE.." " or s==" "..HEALBOT_HOLY.." " or s==" "..HEALBOT_SHAMAN_RESTORATION.." " then
            return "HEALER"
        elseif s==" "..HEALBOT_PROTECTION.." " or (role=="TANK" and s==" "..HEALBOT_FERAL.." ") or (role=="TANK" and s==" "..HEALBOT_BLOOD.." ") then
            return "TANK"
        else
            return "DAMAGER"
        end
    else
        return role
    end
end

function HealBot_Panel_UnitRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_UnitRole", nil, guid)
    local role = hbPanel_dataRoles[guid]
    if role==HEALBOT_WORDS_UNKNOWN then 
        if HEALBOT_GAME_VERSION>2 then
            role=UnitGroupRolesAssigned(unit) or HEALBOT_WORDS_UNKNOWN
            if HEALBOT_GAME_VERSION==3 then
                if HealBot_Globals.AllowPlayerRoles then
                    if GetPartyAssignment('MAINTANK', unit) or role=="TANK" then 
                        role=HealBot_Panel_CheckRole(unit)
                    end
                else
                    role=HealBot_Panel_UnitRoleOnSpec(guid, role)
                end
            end
        end
        hbPanel_dataRoles[guid]=role
    end
    if role==HEALBOT_WORDS_UNKNOWN and isPlayer then
        role="DAMAGER"
    end
    return role
end

function HealBot_Panel_UnitRoleDefault(guid)
      --HealBot_setCall("HealBot_Panel_UnitRoleDefault", nil, guid)
    if hbPanel_dataRoles[guid] and (hbPanel_dataRoles[guid]=="TANK" or hbPanel_dataRoles[guid]=="HEALER") then
        return hbPanel_dataRoles[guid]
    else
        return "DAMAGER"
    end
end

function HealBot_Action_SetClassIconTexture(button)
      --HealBot_setCall("HealBot_Action_SetClassIconTexture", button)
    if UnitExists(button.unit) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWCLASS"] then
        local setRole=false
        local unitRole=HEALBOT_WORDS_UNKNOWN
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWROLE"] then
            unitRole=HealBot_Panel_UnitRole(button.unit, button.guid, button.isplayer)
        end
        if roleTextures[unitRole] then
            HealBot_Aura_ClassUpdate(button, roleTextures[unitRole])
        else
            HealBot_Aura_ClassUpdate(button, classTextures[HealBot_Panel_classEN(button.unit)])
        end
    else
        HealBot_Aura_ClassUpdate(button, false)
    end
end

HealBot_Panel_luVars["HealerHWM"]=1
function HealBot_Panel_CreateHeader(hbCurFrame)
      --HealBot_setCall("HealBot_Panel_CreateHeader")
    if HealBot_ActiveHeaders[0]>99 then HealBot_ActiveHeaders[0]=1 end
    local tryId,freeId=HealBot_ActiveHeaders[0],nil
    if not HealBot_ActiveHeaders[tryId] then
        freeId=tryId
    else
        for j=1,99 do
            if not HealBot_ActiveHeaders[j] then
                freeId=j
                break
            end
        end
    end
    if freeId then 
        HealBot_ActiveHeaders[freeId]=true 
        local hn="HealBot_Action_Header"..freeId
        local hhb=_G[hn]
        if not hhb then 
            local hp=_G["f"..hbCurFrame.."_HealBot_Action"]
            hhb=CreateFrame("Button", hn, hp, "HealingButtonTemplate3") 
            hhb.id=freeId
        end
        if freeId>HealBot_Panel_luVars["HealerHWM"] then
            HealBot_Panel_luVars["HealerHWM"]=freeId
        end
        hhb.frame=0
        HealBot_ActiveHeaders[0]=freeId+1
        return hhb
    else
        return nil
    end
end

function HealBot_Panel_ResetHeaders()
      --HealBot_setCall("HealBot_Panel_ResetHeaders")
    for i=1,HealBot_Panel_luVars["HealerHWM"] do
        local hhb=_G["HealBot_Action_Header"..i]
        if hhb then hhb.frame=0 end
    end
end

function HealBot_Panel_DeleteHeader(hdrID, xHeader)
      --HealBot_setCall("HealBot_Panel_DeleteHeader")
    local hg=_G["HealBot_Action_Header"..hdrID]
    if hdrID<HealBot_ActiveHeaders[0] then HealBot_ActiveHeaders[0]=hdrID end
    hg:Hide();
    HealBot_ActiveHeaders[hdrID]=nil
    HealBot_Header_Frames[xHeader]=nil
end

function HealBot_Panel_retHealBot_Header_Frames(hbCurFrame)
      --HealBot_setCall("HealBot_Panel_retHealBot_Header_Frames")
    return HealBot_Options_copyTable(HealBot_Header_Frames)
end

local vPostFrameBF={}
function HealBot_Panel_ParentFrameID(frame)
      --HealBot_setCall("HealBot_Panel_ParentFrameID")
    vPostFrameBF[frame]=_G["f"..frame.."_HealBot_Action"]
end

function HealBot_Panel_Anchor2ParentFrame(button, backFrame)
      --HealBot_setCall("HealBot_Panel_Anchor2ParentFrame", button)
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 then
        backFrame:SetPoint("TOPLEFT",vPostFrameBF[button.frame],"TOPLEFT",5+backBarsSize[button.frame]["PAD"],-5+(0-backBarsSize[button.frame]["PAD"]));
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==2 then
        backFrame:SetPoint("BOTTOMLEFT",vPostFrameBF[button.frame],"BOTTOMLEFT",5+backBarsSize[button.frame]["PAD"],5+backBarsSize[button.frame]["PAD"]);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
        backFrame:SetPoint("TOPRIGHT",vPostFrameBF[button.frame],"TOPRIGHT",-5+(0-backBarsSize[button.frame]["PAD"]),-5+(0-backBarsSize[button.frame]["PAD"]));
    else
        backFrame:SetPoint("BOTTOMRIGHT",vPostFrameBF[button.frame],"BOTTOMRIGHT",-5+(0-backBarsSize[button.frame]["PAD"]),5+backBarsSize[button.frame]["PAD"]);
    end
end

function HealBot_Panel_AnchorSpecialFrame(button, backFrame, relButton, newColumn, child)
      --HealBot_setCall("HealBot_Panel_AnchorSpecialFrame", button)
    if child then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-backBarsSize[button.frame]["CMARGIN"],0)
        end
    elseif newColumn==2 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==2 then
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
            backFrame:SetPoint("TOPRIGHT",relButton,"BOTTOMRIGHT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMRIGHT",relButton,"TOPRIGHT",0,backBarsSize[button.frame]["RMARGIN"])
        end
    else
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["S2WIDTH"]+backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-(backBarsSize[button.frame]["S2WIDTH"]+backBarsSize[button.frame]["CMARGIN"]),0)
        end
    end
end

function HealBot_Panel_AnchorFrame(button, backFrame, relButton, newColumn)
      --HealBot_setCall("HealBot_Panel_AnchorFrame")
    if newColumn==2 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 or
           Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
        end
    else
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-backBarsSize[button.frame]["CMARGIN"],0)
        end
    end
end

function HealBot_Panel_AnchorButton(button, backFrame, relButton, newColumn, child)
      --HealBot_setCall("HealBot_Panel_AnchorButton", button)
    if not relButton then
        HealBot_Panel_Anchor2ParentFrame(button, backFrame)
    elseif backFrame~=relButton then
        if button.frame==10 and HealBot_SpecialUnit[button.unit] then
            HealBot_Panel_AnchorSpecialFrame(button, backFrame, relButton, newColumn, child)
        else
            HealBot_Panel_AnchorFrame(button, backFrame, relButton, newColumn)
        end
    else
        HealBot_Panel_Anchor2ParentFrame(button, backFrame)
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll",1)
    end
end

function HealBot_Panel_UpdateHeadersOpacity()
      --HealBot_setCall("HealBot_Panel_UpdateHeadersOpacity")
    for _,header in pairs(HealBot_Header_Frames) do
        HealBot_Action_UpdateHeaderOpacity(header)
    end
end

local vSpecialAnchor={}
function HealBot_Panel_PositionButton(button,xHeader,relButton,newColumn,preCombat)
      --HealBot_setCall("HealBot_Panel_PositionButton", button)
    if xHeader then
        local vPosParentHF=HealBot_Header_Frames[xHeader]
        if not vPosParentHF then
            vPosParentHF=HealBot_Panel_CreateHeader(button.frame)
            HealBot_Header_Frames[xHeader]=vPosParentHF
            vPosParentHF.back=_G[vPosParentHF:GetName().."Bar5"]
            vPosParentHF.bar=_G[vPosParentHF:GetName().."Bar"]
            vPosParentHF.bar.txt=_G[vPosParentHF.bar:GetName().."_text"]
            vPosParentHF.bar.txt2=_G[vPosParentHF.bar:GetName().."_text2"]
        end
        if vPosParentHF.frame~=button.frame then
            vPosParentHF.parent=_G["f"..button.frame.."_HealBot_Action"]
            vPosParentHF:ClearAllPoints()
            vPosParentHF:SetParent(vPosParentHF.parent)
            vPosParentHF.frame=button.frame
            HealBot_Skins_ResetSkin("header",vPosParentHF)
        elseif HealBot_setTestBars then
            HealBot_Skins_ResetSkin("header",vPosParentHF)
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["GROW"]==1 then
            vPosParentHF.back:SetHeight(backBarsSize[button.frame]["HEIGHT"])
        else
            vPosParentHF.back:SetWidth(backBarsSize[button.frame]["WIDTH"])
        end
        HealBot_Track_Headers[xHeader]=true
        vPosParentHF.back:ClearAllPoints()
        HealBot_Panel_AnchorButton(button, vPosParentHF.back, relButton, newColumn)
        vPosParentHF.bar.txt:SetText(xHeader);
        vPosParentHF:Show();
        return vPosParentHF.back
    else
        HealBot_Panel_AnchorButton(button, button.gref["Back"], relButton, newColumn)
        
        if button.frame==10 and HealBot_SpecialUnit[button.unit] then
            local eGUID=UnitGUID(button.unit.."target") or button.unit.."target"
            local eButton=HealBot_Action_SetHealButton(button.unit.."target",eGUID,10,11,false,3,preCombat) 
            if eButton then
                HealBot_TrackUnit[eButton.status.unittype][eButton.unit]=true
                HealBot_Panel_AnchorButton(eButton, eButton.gref["Back"], button.gref["Back"], 1, true)        
                eButton:ClearAllPoints()
                eButton:SetPoint("CENTER",eButton.gref["Bar"],"CENTER",0,0)
                eButton:Show()
            end
        end

        button:ClearAllPoints()
        button:SetPoint("CENTER",button.gref["Bar"],"CENTER",0,0)
        return button.gref["Back"]
    end
end

function HealBot_Action_SetBackBarHeightWidth(frame, height, width, pad)
      --HealBot_setCall("HealBot_Action_SetBackBarHeightWidth")
    local vSetAddHWScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["SCALE"]
    if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][frame]["BORDER"]>1 then
        backBarsSize[frame]["RMARGIN"]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["RMARGIN"] * vSetAddHWScale)
        backBarsSize[frame]["CMARGIN"]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["CMARGIN"] * vSetAddHWScale)
    else
        backBarsSize[frame]["RMARGIN"]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["RMARGIN"]*vSetAddHWScale)
        backBarsSize[frame]["CMARGIN"]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["CMARGIN"]*vSetAddHWScale)
    end
    if backBarsSize[frame]["HEIGHT"]~=height or backBarsSize[frame]["WIDTH"]~=width or backBarsSize[frame]["PAD"]~=pad then
        backBarsSize[frame]["HEIGHT"]=height
        backBarsSize[frame]["WIDTH"]=width
        backBarsSize[frame]["PAD"]=pad
        return true
    else
        return false
    end
end

function HealBot_Action_SetBackSpecialWidth(frame, width)
      --HealBot_setCall("HealBot_Action_SetBackSpecialWidth")
    backBarsSize[frame]["S2WIDTH"]=width
end

function HealBot_Action_SetBackHeaderHeightWidth(frame, height, width)
      --HealBot_setCall("HealBot_Action_SetBackHeaderHeightWidth")
    backBarsSize[frame]["HEADHEIGHT"]=height
    backBarsSize[frame]["HEADWIDTH"]=width
end

local HealBot_Panel_initFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Panel_resetInitFrames()
      --HealBot_setCall("HealBot_Panel_resetInitFrames")
    for j=1,10 do
        HealBot_Panel_initFrame[j]=true
    end
end

local vSetHWFrame,vSetHWextraHeight,vSetHWextraWidth="",0,0
function HealBot_Action_SetHeightWidth(numRows,numCols,numHeaders,hbCurFrame)
      --HealBot_setCall("HealBot_Action_SetHeightWidth")
    vSetHWFrame = _G["f"..hbCurFrame.."_HealBot_Action"]
    vSetHWextraHeight=10
    vSetHWextraWidth=10
    if hbOptionOn==hbCurFrame then
        vSetHWextraHeight=vSetHWextraHeight+30
    end
    if hbMoveMe==hbCurFrame then
        vSetHWextraHeight=vSetHWextraHeight+20
    end
    if hbFocusOn==hbCurFrame then
        vSetHWextraHeight=vSetHWextraHeight+10+ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SCALE"])
    end
    if numHeaders>0 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
            vSetHWextraWidth=vSetHWextraWidth+(backBarsSize[hbCurFrame]["HEADWIDTH"]*numHeaders)
        else
            vSetHWextraHeight=vSetHWextraHeight+(backBarsSize[hbCurFrame]["HEADHEIGHT"]*numHeaders)
        end
    end
    vSetHWextraHeight=vSetHWextraHeight+(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["PADDING"]*2)
    vSetHWextraWidth=vSetHWextraWidth+(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["PADDING"]*2)
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
        vSetHWFrame:SetHeight(vSetHWextraHeight+(backBarsSize[hbCurFrame]["HEIGHT"]*numCols)+(backBarsSize[hbCurFrame]["RMARGIN"]*(numCols-1)))
        vSetHWFrame:SetWidth(vSetHWextraWidth+(backBarsSize[hbCurFrame]["WIDTH"]*numRows)+(backBarsSize[hbCurFrame]["CMARGIN"]*((numHeaders+numRows-1))))
    else
        vSetHWFrame:SetHeight(vSetHWextraHeight+(backBarsSize[hbCurFrame]["HEIGHT"]*numRows)+(backBarsSize[hbCurFrame]["RMARGIN"]*((numHeaders+numRows-1))))
        vSetHWFrame:SetWidth(vSetHWextraWidth+(backBarsSize[hbCurFrame]["WIDTH"]*numCols)+(backBarsSize[hbCurFrame]["CMARGIN"]*(numCols-1)))
    end
    if HealBot_Panel_initFrame[hbCurFrame] then
        HealBot_Panel_initFrame[hbCurFrame]=false
        HealBot_Action_FrameSetPoint(hbCurFrame, vSetHWFrame)
    end
    HealBot_Action_setPoint(hbCurFrame)
end

function HealBot_Panel_TestBarsOff()
      --HealBot_setCall("HealBot_Panel_TestBarsOff")
    for x,b in pairs(HealBot_TestBarsActive) do
        for id=1,12 do
            HealBot_Action_ClearTestIcon(b, id)
        end
        for id=51,60 do
            HealBot_Action_ClearTestIcon(b, id)
        end
        b:Hide()
        HealBot_Emerg_Button[b.id]:Hide()
        HealBot_TestBarsActive[x]=nil
    end
end

function HealBot_Panel_ToggleTestBars()
      --HealBot_setCall("HealBot_Panel_ToggleTestBars")
    if HealBot_setTestBars then
        HealBot_setTestBars=false
        HealBot_Panel_TestBarsOff()
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSON)
        for j=1,10 do
            HealBot_Action_HidePanel(j)
        end
        HealBot_Action_setLuVars("TestBarsOn", false)
        HealBot_Text_setLuVars("TestBarsOn", false)
        HealBot_Aux_setLuVars("TestBarsOn", false)
        HealBot_TestBarsState(false)
        HealBot_Options_setLuVars("TestBarsOn", false)
        HealBot_Skins_isTestBars(false)
        HealBot_Timers_Set("AURA","ClearAllBuffs")
        HealBot_Timers_Set("AURA","ClearAllDebuffs")
        --HealBot_setTestCols={}
    else
        HealBot_Action_setLuVars("TestBarsOn", true)
        HealBot_Text_setLuVars("TestBarsOn", true)
        HealBot_Aux_setLuVars("TestBarsOn", true)
        HealBot_TestBarsState(true)
        HealBot_Options_setLuVars("TestBarsOn", true)
        HealBot_Skins_isTestBars(true)
        HealBot_setTestBars=true
        HealBot_Panel_luVars["TestBarsDelAll"]=true
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSOFF)
    end
    HealBot_Timers_Set("AUX","UpdateAllAuxByType")
end

local vBar={[1]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [2]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [3]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [4]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [5]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [6]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [7]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [8]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [9]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
           [10]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},}
local vPosButton,vFrame="",0
local maxRows={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local maxCols={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local maxHeaders={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local rowNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local barNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local headerNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local hbAnchoredButtons={}
function HealBot_Panel_PositionBars(preCombat)
      --HealBot_setCall("HealBot_Panel_PositionBars")
    local newCol=1
    local sameCol=2
    local emtarPrev=false
    for x,_ in pairs(hbAnchoredButtons) do
        hbAnchoredButtons[x]=nil
    end 
    table.foreach(HealBot_Action_HealButtons, function (x,xUnitData)
        local xUnit,xUnitType=string.split("~", xUnitData)
        xUnitType=tonumber(xUnitType)
        if HealBot_setTestBars then
            vPosButton=HealBot_Test_Button[xUnit] or "nil"
        elseif xUnitType<5 then
            vPosButton=HealBot_Private_Button[xUnit] or "nil"
        elseif xUnitType>10 then
            vPosButton=HealBot_Enemy_Button[xUnit] or "nil"
        elseif xUnitType==8 then
            vPosButton=HealBot_Pet_Button[xUnit] or "nil"
        elseif xUnitType==7 then
            vPosButton=HealBot_Vehicle_Button[xUnit] or "nil"
        elseif xUnitType>8 then
            vPosButton=HealBot_Extra_Button[xUnit] or "nil"
        else
            vPosButton=HealBot_Unit_Button[xUnit] or "nil"
        end
        if vPosButton~="nil" and hbBarsPerFrame[vPosButton.frame] and not hbAnchoredButtons[vPosButton.id] then
            hbAnchoredButtons[vPosButton.id]=true
            vFrame=vPosButton.frame
            rowNo[vFrame]=rowNo[vFrame]+1
            barNo[vFrame]=barNo[vFrame]+1
            vBar[vFrame]["BUTTON"]=vPosButton
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vFrame]["GROW"]==1 then
                newCol=2
                sameCol=1
            else
                newCol=1
                sameCol=2
            end
            if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][vFrame]["SHOW"] then 
                if HeaderPos[vFrame][barNo[vFrame]] then
                    headerNo[vFrame]=headerNo[vFrame]+1
                    if barNo[vFrame]==1 then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],false,sameCol,preCombat)
                        vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    elseif headerNo[vFrame]>Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["NUMCOLS"] then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVCOL"],newCol,preCombat)
                        maxCols[vFrame]=maxCols[vFrame]+1
                        vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                        headerNo[vFrame]=1
                        rowNo[vFrame]=1
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVROW"],sameCol,preCombat)
                    end
                end
                if rowNo[vFrame]>maxRows[vFrame][1] then
                    maxRows[vFrame][1]=rowNo[vFrame]
                end
                if headerNo[vFrame]>maxHeaders[vFrame] then
                    maxHeaders[vFrame]=headerNo[vFrame]
                end
                vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol,preCombat)
            elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["GRPCOLS"] then
                if HeaderPos[vFrame][barNo[vFrame]] then
                    headerNo[vFrame]=headerNo[vFrame]+1
                end
                if barNo[vFrame]==1 then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,false,sameCol,preCombat)
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                elseif headerNo[vFrame]>Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["NUMCOLS"] then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVCOL"],newCol,preCombat)
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    headerNo[vFrame]=1
                    maxCols[vFrame]=maxCols[vFrame]+1
                    rowNo[vFrame]=1
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol,preCombat)
                end
                if rowNo[vFrame]>maxRows[vFrame][1] then
                    maxRows[vFrame][1]=rowNo[vFrame]
                end
            else
                if barNo[vFrame]==1 or rowNo[vFrame]>(maxRows[vFrame][maxCols[vFrame]] or rowNo[vFrame]) then
                    if barNo[vFrame]==1 then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,false,sameCol,preCombat)
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVCOL"],newCol,preCombat)
                        maxCols[vFrame]=maxCols[vFrame]+1
                    end
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    rowNo[vFrame]=1
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol,preCombat)
                end
            end
        elseif vPosButton.id and hbAnchoredButtons[vPosButton.id] then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll", 0.2)
            HealBot_AddDebug("AnchorButton button and relButton as the same - unit="..(xUnit or "nil"), "Panel", true)
        end
    end)
end

local vSetupFrameTag, vSetupBarsOptionsParent, vSetupBarsMaxRows, vSetupBarsOverflow=nil, nil, 1, 0
function HealBot_Panel_SetupExtraBars(frame, preCombat)
      --HealBot_setCall("HealBot_Panel_SetupExtraBars")
    if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][frame]["SHOW"] or
       Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["GRPCOLS"] then
        maxRows[frame][1]=1
    else
        vSetupBarsMaxRows=floor(hbBarsPerFrame[frame]/Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["NUMCOLS"])
        vSetupBarsOverflow=hbBarsPerFrame[frame]-(vSetupBarsMaxRows*Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["NUMCOLS"])
        for x=1,Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["NUMCOLS"] do
            if x<=vSetupBarsOverflow then
                maxRows[frame][x]=vSetupBarsMaxRows+1
            else
                maxRows[frame][x]=vSetupBarsMaxRows
            end
        end
    end
    barNo[frame]=0
    rowNo[frame]=0
    headerNo[frame]=0
    maxHeaders[frame]=0
    maxCols[frame]=1
    vBar[frame]["BUTTON"]=nil
    vBar[frame]["PREVROW"]=nil
    vBar[frame]["PREVCOL"]=nil
    HealBot_Panel_PositionBars(preCombat)
    
    hbPanelNoCols[frame]=maxCols[frame]
    hbPanelNoRows[frame]=maxRows[frame][1]

    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame==frame and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    if hbBarsPerFrame[frame]>0 then
        HealBot_Text_setTextLen(frame)
        hbMoveMe=0
        vSetupBarsOptionsParent=_G["f"..frame.."_HealBot_Action"]
        vSetupFrameTag=_G[vSetupBarsOptionsParent:GetName().."_UnlockTxt"]
        if not preCombat and HealBot_Action_CanMove(frame) then
            hbMoveMe=frame
            vSetupFrameTag:ClearAllPoints()
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["BARS"]==4 then
                vSetupFrameTag:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-8)
            else
                vSetupFrameTag:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,8)
            end
            vSetupFrameTag:SetText(HEALBOT_ACTION_UNLOCKED)
        else
            vSetupFrameTag:SetText("")
        end
        if HealBot_Config.DisabledNow==0 then
            HealBot_Action_SetHeightWidth(maxRows[frame][1],maxCols[frame],maxHeaders[frame],frame)
            if HealBot_setTestBars or (HealBot_AutoCloseFrame[frame]==1 or preCombat) then
                HealBot_Action_ShowPanel(frame)
            end
            HealBot_Action_setFrameHeader(frame)
        else
            HealBot_Action_HidePanel(frame)
        end
        if not HealBot_setTestBars then 
            if HealBot_AutoCloseFrame[frame]>1 then
                HealBot_CheckActiveFrames(frame, true)
            else
                HealBot_CheckActiveFrames(frame, false)
            end
        end
    else
        HealBot_Action_HidePanel(frame)
        if not HealBot_setTestBars then 
            HealBot_CheckActiveFrames(frame, false)
        end
    end
end

local vSetupBarsOptionsFrame=nil
function HealBot_Panel_SetupBars(preCombat)
      --HealBot_setCall("HealBot_Panel_SetupBars")
    for j=1,5 do
        if hbBarsPerFrame[j] and hbBarsPerFrame[j]>0 then
            if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][j]["SHOW"] or
               Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["GRPCOLS"] then
                maxRows[j][1]=1
            else
                vSetupBarsMaxRows=floor(hbBarsPerFrame[j]/Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["NUMCOLS"])
                vSetupBarsOverflow=hbBarsPerFrame[j]-(vSetupBarsMaxRows*Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["NUMCOLS"])
                for x=1,Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["NUMCOLS"] do
                    if x<=vSetupBarsOverflow then
                        maxRows[j][x]=vSetupBarsMaxRows+1
                    else
                        maxRows[j][x]=vSetupBarsMaxRows
                    end
                end
            end
        end
    end
    for j=1,5 do
        barNo[j]=0
        rowNo[j]=0
        headerNo[j]=0
        maxHeaders[j]=0
        maxCols[j]=1
        vBar[j]["BUTTON"]=nil
        vBar[j]["PREVROW"]=nil
        vBar[j]["PREVCOL"]=nil
    end 

    HealBot_Panel_PositionBars(preCombat)

    for j=1,5 do
        hbPanelNoCols[j]=maxCols[j]
        hbPanelNoRows[j]=maxRows[j][1]
    end 
    
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame<6 and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end

    local vSetupBarsFrame=0
    hbMoveMe=0
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then
            vSetupBarsOptionsParent=_G["f"..j.."_HealBot_Action"]
            vSetupFrameTag=_G[vSetupBarsOptionsParent:GetName().."_UnlockTxt"]
            if not preCombat and HealBot_Action_CanMove(j) then
                hbMoveMe=j
                vSetupFrameTag:ClearAllPoints()
                if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==4 then
                    vSetupFrameTag:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-8)
                else
                    vSetupFrameTag:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,8)
                end
                vSetupFrameTag:SetText(HEALBOT_ACTION_UNLOCKED)
            else
                vSetupFrameTag:SetText("")
            end
            if vSetupBarsFrame==0 then 
                vSetupBarsFrame=j
            end
            if not HealBot_setTestBars then 
                if HealBot_AutoCloseFrame[j]>1 then
                    HealBot_CheckActiveFrames(j, true)
                else
                    HealBot_CheckActiveFrames(j, false)
                end
            end
        elseif not HealBot_setTestBars then 
            HealBot_CheckActiveFrames(j, false)
        end
    end

    if HealBot_Globals.HideOptions then
        if vSetupBarsOptionsFrame and hbOptionOn>0 then
            vSetupBarsOptionsFrame:Hide()
            hbOptionOn=0
        end
    elseif vSetupBarsFrame>0 and vSetupBarsOptionsFrame then
        vSetupBarsOptionsParent=_G["f"..vSetupBarsFrame.."_HealBot_Action"]
        vSetupBarsOptionsFrame:ClearAllPoints()
        if vSetupBarsOptionsFrame.frame~=vSetupBarsFrame then
            vSetupBarsOptionsFrame:Hide()
            vSetupBarsOptionsFrame:SetParent(vSetupBarsOptionsParent)
            vSetupBarsOptionsFrame.frame=vSetupBarsFrame
            local oWidth=ceil(backBarsSize[vSetupBarsFrame]["WIDTH"]*0.95)
            if oWidth>70 then oWidth=70 end
            vSetupBarsOptionsFrame:SetWidth(oWidth)
            vSetupBarsOptionsFrame:SetHeight(25)
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==4 then
            if hbMoveMe==vSetupBarsFrame then
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-22);
            else
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-2);
            end
        else
            if hbMoveMe==vSetupBarsFrame then
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,27);
            else
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,7);
            end
        end
        vSetupBarsOptionsFrame:Show();
        hbOptionOn=vSetupBarsFrame
    elseif hbOptionOn>0 and vSetupBarsOptionsFrame then
        vSetupBarsOptionsFrame:Hide()
        hbOptionOn=0
    end
    
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then
            if HealBot_Config.DisabledNow==0 then
                HealBot_Text_setTextLen(j)
                if HealBot_setTestBars or (HealBot_AutoCloseFrame[j]==1 or preCombat) then
                    HealBot_Action_ShowPanel(j)
                end
                HealBot_Action_SetHeightWidth(maxRows[j][1],maxCols[j],maxHeaders[j],j)
                HealBot_Action_setFrameHeader(j)
            else
                HealBot_Action_HidePanel(j)
            end
        else
            HealBot_Action_HidePanel(j)
        end
    end
end

function HealBot_Panel_InitOptBars()
      --HealBot_setCall("HealBot_Panel_InitOptBars")
    vSetupBarsOptionsFrame=_G["HealBot_Action_OptionsButton"]
    if not vSetupBarsOptionsFrame then
        vSetupBarsOptionsParent=_G["f1_HealBot_Action"]
        vSetupBarsOptionsFrame=CreateFrame("Button", "HealBot_Action_OptionsButton", vSetupBarsOptionsParent, "HealBotOptionsButtonTemplate")
        local bar = _G[vSetupBarsOptionsFrame:GetName().."Bar"]
        bar:SetStatusBarColor(0.1,0.1,0.4,0);
        bar:SetMinMaxValues(0,100);
        bar:SetValue(0);
        bar:UnregisterAllEvents()
        vSetupBarsOptionsFrame.frame=0
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(HealBot_Default_Fonts[15].file, 12)
        bar.txt:SetPoint("CENTER",0,-2)
        bar.txt:SetTextColor(0.8,0.8,0.2,0.85);
        bar.txt:SetText(HEALBOT_ACTION_OPTIONS);
        bar = _G[vSetupBarsOptionsFrame:GetName().."Bar5"]
        bar:SetStatusBarColor(0.1,0.1,0.4,0);
        bar:SetMinMaxValues(0,100);
        bar:SetValue(0);
        bar:UnregisterAllEvents()
        vSetupBarsOptionsFrame:Hide()
    end
end
 
function HealBot_Panel_RandomClassColour(tRole,bClass)
      --HealBot_setCall("HealBot_Panel_RandomClassColour")
    if bClass then
        HealBot_randomN=bClass
    else
        local newCol=1
        while newCol>0 do
            if not tRole then
                HealBot_randomN=random(HealBot_randomClCol[0]["MAX"])
            elseif tRole==HEALBOT_WORD_HEALER then
                HealBot_randomN=random(HealBot_randomClCol[0]["HS"],HealBot_randomClCol[0]["HE"])
            else
                HealBot_randomN=random(1,HealBot_randomClCol[0]["TE"])
            end
            if HealBot_randomN~=prevCol then
                prevCol=HealBot_randomN
                newCol=0
            end
        end
    end
    return HealBot_randomClCol[HealBot_randomN][1],
           HealBot_randomClCol[HealBot_randomN][2],
           HealBot_randomClCol[HealBot_randomN][3],
           HealBot_randomClCol[HealBot_randomN][4],
           HealBot_randomClCol[HealBot_randomN][5],
           HealBot_randomClCol[HealBot_randomN][6],
           HealBot_randomClCol[HealBot_randomN][7]
end

local RandomClassesAdj={}
local rndClasses={}
local curClass,tRnd=1,0
local numNotSet=0
function HealBot_Panel_RandomClassesRun()
      --HealBot_setCall("HealBot_Panel_RandomClassesRun")
    for z=1,numNotSet do
        if numNotSet>0 then
            tRnd=random(5)
            local tClass=random(HealBot_randomClCol[0]["MAX"])
            if tRnd>RandomClassesAdj[tClass] then
                rndClasses[tClass]=rndClasses[tClass]+1
                numNotSet=numNotSet-1
                if RandomClassesAdj[tClass]<4 then 
                    RandomClassesAdj[tClass]=RandomClassesAdj[tClass]+2
                else
                    RandomClassesAdj[tClass]=5
                end
            elseif RandomClassesAdj[tClass]>1 then
                RandomClassesAdj[tClass]=RandomClassesAdj[tClass]-1
            end
        else
            break
        end
    end
end

function HealBot_Panel_RandomClasses(nUnits)
      --HealBot_setCall("HealBot_Panel_RandomClasses")
    for z=1,HealBot_randomClCol[0]["MAX"] do
        RandomClassesAdj[z]=3
        rndClasses[z]=0
    end
    curClass=1
    numNotSet=nUnits
    for x=1,20 do
        if numNotSet>0 then
            HealBot_Panel_RandomClassesRun()
        else
            break
        end
    end
    return rndClasses
end

function HealBot_Panel_TestBarColUpdate(button)
      --HealBot_setCall("HealBot_Panel_TestBarColUpdate")
    --for _,xButton in pairs(HealBot_Test_Button) do
        button.gref["Bar"]:SetStatusBarColor(HealBot_colIndex["hcr"..button.id],HealBot_colIndex["hcg"..button.id],HealBot_colIndex["hcb"..button.id],1);
        button.gref.txt["text"]:SetTextColor(HealBot_colIndex["hctr"..button.id],HealBot_colIndex["hctg"..button.id],HealBot_colIndex["hctb"..button.id],1);
        button.gref.txt["text2"]:SetTextColor(HealBot_colIndex["hctr2"..button.id],HealBot_colIndex["hctg2"..button.id],HealBot_colIndex["hctb2"..button.id],1);
        button.gref.txt["text3"]:SetTextColor(HealBot_colIndex["hctr3"..button.id],HealBot_colIndex["hctg3"..button.id],HealBot_colIndex["hctb3"..button.id],1)
        button.gref.txt["text4"]:SetTextColor(HealBot_colIndex["hctr4"..button.id],HealBot_colIndex["hctg4"..button.id],HealBot_colIndex["hctb4"..button.id],1)
        button.gref.txt["text5"]:SetTextColor(HealBot_colIndex["hctr2"..button.id],HealBot_colIndex["hctg2"..button.id],HealBot_colIndex["hctb2"..button.id],1);
    --end
end

local hbCustomRoleCols={}
function HealBot_Panel_SetCustomRoleCols()
      --HealBot_setCall("HealBot_Panel_SetCustomRoleCols")
    if HealBot_Globals.OverrideColours["USEROLE"]==1 then
        hbCustomRoleCols["TANK"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["TANK"])
        hbCustomRoleCols["HEALER"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["HEALER"])
        hbCustomRoleCols["DAMAGER"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["DAMAGER"])
    else
        hbCustomRoleCols["TANK"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["TANK"])
        hbCustomRoleCols["HEALER"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["HEALER"])
        hbCustomRoleCols["DAMAGER"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["DAMAGER"])
    end
end

local hbHealButtonsConcat={[1]="", [2]="~", [3]="1"}
function HealBot_Panel_TestBarShow(index,button,tRole,r,g,b,tpR,tpG,tpB)
      --HealBot_setCall("HealBot_Panel_TestBarShow")
    hbHealButtonsConcat[1]=button.unit
    hbHealButtonsConcat[3]="5"
    table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
    --HealBot_TrackUnit[5][button.unit]=true
    HealBot_TestBarsActive[index]=button
    if not HealBot_setTestCols[index] or button.reset then
        HealBot_setTestCols[index]=true
        if button.reset then
            button.text.r,button.text.g,button.text.b=r,g,b
            HealBot_colIndex["hctr5"..index],HealBot_colIndex["hctg5"..index],HealBot_colIndex["hctb5"..index]=tpR,tpG,tpB
        else
            r,g,b=button.text.r,button.text.g,button.text.b
            HealBot_colIndex["hctr5"..index]=HealBot_colIndex["hctr5"..index] or tpR
            HealBot_colIndex["hctg5"..index]=HealBot_colIndex["hctg5"..index] or tpG
            HealBot_colIndex["hctb5"..index]=HealBot_colIndex["hctb5"..index] or tpB
        end
        button.reset=false
        if not hbCustomRoleCols[button.roletxt] then button.roletxt="DAMAGER" end

        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==2 or
           Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==5 then
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = r,g,b
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==1 then
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = 0,1,0
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==4 then
            HealBot_colIndex["hcr"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
            HealBot_colIndex["hcg"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
            HealBot_colIndex["hcb"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
        else
            HealBot_colIndex["hcr"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hcg"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hcb"..index]=hbCustomRoleCols[button.roletxt].b
        end

        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==2 or 
           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==5 then
            HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = r,g,b
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 then
            HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = 0,1,0
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==4 then
            HealBot_colIndex["hctr"..index]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCR"]
            HealBot_colIndex["hctg"..index]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCG"]
            HealBot_colIndex["hctb"..index]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCB"]
        else
            HealBot_colIndex["hctr"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb"..index]=hbCustomRoleCols[button.roletxt].b
        end
        button.text.r,button.text.g,button.text.b=r,g,b

        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==2 or 
           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==5 then
            HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index] = r,g,b
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==1 then
            HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index] = 0,1,0
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==4 then
            HealBot_colIndex["hctr2"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCR"]
            HealBot_colIndex["hctg2"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCG"]
            HealBot_colIndex["hctb2"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCB"]
        else
            HealBot_colIndex["hctr2"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg2"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb2"..index]=hbCustomRoleCols[button.roletxt].b
        end

        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]==2 or 
           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]==5 then
            HealBot_colIndex["hctr3"..index],HealBot_colIndex["hctg3"..index],HealBot_colIndex["hctb3"..index] = r,g,b
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]==1 then
            HealBot_colIndex["hctr3"..index],HealBot_colIndex["hctg3"..index],HealBot_colIndex["hctb3"..index] = 0,1,0
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]==4 then
            HealBot_colIndex["hctr3"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCR"]
            HealBot_colIndex["hctg3"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCG"]
            HealBot_colIndex["hctb3"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCB"]
        else
            HealBot_colIndex["hctr3"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg3"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb3"..index]=hbCustomRoleCols[button.roletxt].b
        end
        
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]==2 or 
           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]==5 then
            HealBot_colIndex["hctr4"..index],HealBot_colIndex["hctg4"..index],HealBot_colIndex["hctb4"..index] = r,g,b
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]==1 then
            HealBot_colIndex["hctr4"..index],HealBot_colIndex["hctg4"..index],HealBot_colIndex["hctb4"..index] = 0,1,0
        elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]==4 then
            HealBot_colIndex["hctr4"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACR"]
            HealBot_colIndex["hctg4"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACG"]
            HealBot_colIndex["hctb4"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACB"]
        else
            HealBot_colIndex["hctr4"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg4"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb4"..index]=hbCustomRoleCols[button.roletxt].b
        end
        
        button.gref["Bar"]:SetValue(1000)
        button.health.mixcolr,button.health.mixcolg,button.health.mixcolb=button.text.r,button.text.g,button.text.b
        button.mana.r,button.mana.g,button.mana.b=HealBot_colIndex["hctr5"..index],HealBot_colIndex["hctg5"..index],HealBot_colIndex["hctb5"..index]
        button.health.rcol,button.health.gcol=0,1
        button.health.pct=1000
        HealBot_Panel_TestBarColUpdate(button)
    end
    button:Show()
    HealBot_Action_UpdateBackground(button)
    if button.frame<10 and Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["USE"] then
        if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARCOL"]==2 or
           Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARCOL"]==5 then
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(button.text.r,button.text.g,button.text.b,1)
        elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARCOL"]==3 or
           Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARCOL"]==6 then
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(hbCustomRoleCols[button.roletxt].r,hbCustomRoleCols[button.roletxt].g,hbCustomRoleCols[button.roletxt].b,1)
        elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARCOL"]==4 then
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HR"],
                                                                  Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HG"],
                                                                  Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HB"],1)
        else
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(0,1,0,1)
        end
        HealBot_Emerg_Button[button.id]:Show()
    else
        HealBot_Emerg_Button[button.id]:Hide()
    end
end

local noBars=100
function HealBot_Panel_testAddButton(gName,bName,minBar,maxBar,tRole,bClass)
      --HealBot_setCall("HealBot_Panel_testAddButton")
    local k=i[hbCurrentFrame]
    for j=minBar,maxBar do
        if noBars>0 then
            if not tRole then tRole="DAMAGER" end
            local tcR,tcG,tcB,tcC,tpR,tpG,tpB=HealBot_Panel_RandomClassColour(tRole, bClass)
            local tstb=HealBot_Action_SetTestButton(hbCurrentFrame, bName..j,tRole,tcC)
            if tstb then 
                local bIndex=tstb.id
                HealBot_Panel_TestBarShow(bIndex,tstb,tRole,tcR,tcG,tcB,tpR,tpG,tpB)
                noBars=noBars-1
                i[hbCurrentFrame]=i[hbCurrentFrame]+1
                hbBarsPerFrame[tstb.frame]=hbBarsPerFrame[tstb.frame]+1
            end
        end
    end
    if i[hbCurrentFrame]>k and not tHeader[gName] then
        HeaderPos[hbCurrentFrame][k+1] = gName
        tHeader[gName]=true
        if not bClass and (bName==HEALBOT_OPTIONS_EMERGENCYHEALS or bName==HEALBOT_OPTIONS_GROUPHEALS) then
            grpNo=grpNo+1
        end
    end
end

function HealBot_Panel_TestBarsOn()
      --HealBot_setCall("HealBot_Panel_TestBarsOn")
    HealBot_Action_resetTestBarsCounters()
    if HealBot_Panel_luVars["TestBarsDelAll"] then
        HealBot_Panel_luVars["TestBarsDelAll"]=false
        for xHeader,xButton in pairs(HealBot_Header_Frames) do
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for x,_ in pairs(HealBot_Action_HealButtons) do
        HealBot_Action_HealButtons[x]=nil;
    end 
    for x,b in pairs(HealBot_TestBarsActive) do
        HealBot_TestBarsActive[x]=nil
    end
    for xHeader in pairs(HealBot_Track_Headers) do
        HealBot_Track_Headers[xHeader]=false
    end
    for x,_ in pairs(tHeader) do
        tHeader[x]=nil
    end
    for gl=1,10 do
        HeaderPos[gl]={};
        hbBarsPerFrame[gl]=0
        i[gl]=0
    end
    noBars=tonumber(HealBot_noBars)
    grpNo=1
    local gNo=5
    local healGroups=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin]
    local xRaidBars=40
    if HealBot_Globals.TestBars["PROFILE"]==3 then 
        xRaidBars=25
    elseif HealBot_Globals.TestBars["PROFILE"]==2 then 
        xRaidBars=10
    elseif HealBot_Globals.TestBars["PROFILE"]==1 then 
        xRaidBars=5 
    end
    local vRaidBars=xRaidBars
    for gl=1,11 do
        hbCurrentFrame=healGroups[gl]["FRAME"]
        if HealBot_Action_hasPowerCounter(gl)>0 then
            HealBot_Action_setLuVars("showTestPowerIndicator", HealBot_Action_hasPowerCounter(gl))
        end
        if healGroups[gl]["NAME"]==HEALBOT_OPTIONS_SELFHEALS_en then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_SELFHEALS,HEALBOT_OPTIONS_SELFHEALS,1,1,"HEALER")
                gNo=4
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-1
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_TANKHEALS_en then
            local nTanks=HealBot_Globals.TestBars["TANKS"]
            if HealBot_Globals.TestBars["PROFILE"]==1 then nTanks=1 end
            if nTanks>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TANKHEALS,HEALBOT_WORD_TANK,1,nTanks,"TANK")
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-nTanks
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_CLASSES_HEALERS_en then
            local nHealers=HealBot_Globals.TestBars["HEALERS"]
            if HealBot_Globals.TestBars["PROFILE"]==1 then nHealers=1 end
            if nHealers>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_CLASSES_HEALERS,HEALBOT_WORD_HEALER,1,nHealers,"HEALER")
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-nHealers
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_GROUPHEALS_en then
            if gNo>xRaidBars then gNo=xRaidBars end
            if healGroups[gl]["STATE"] and gNo>0 then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_GROUPHEALS,1,gNo)
                xRaidBars=xRaidBars-gNo
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_MYTARGET_en then
            if HealBot_Globals.TestBars["TARGETS"]>0 and healGroups[gl]["STATE"] then
                --HealBot_Panel_testAddButton(HEALBOT_OPTIONS_MYTARGET,HEALBOT_DISABLED_TARGET,1,HealBot_Globals.TestBars["TARGETS"])
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_MYTARGET,HEALBOT_OPTIONS_MYTARGET,1,HealBot_Globals.TestBars["TARGETS"])
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-HealBot_Globals.TestBars["TARGETS"]
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
            if HealBot_Globals.TestBars["PETS"]>0 and healGroups[gl]["STATE"] then
                if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] and HealBot_Globals.TestBars["PETS"]>5 then
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 1",HEALBOT_WORD_PET,1,5)
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 2",HEALBOT_WORD_PET,6,HealBot_Globals.TestBars["PETS"])
                else
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_WORD_PET,1,HealBot_Globals.TestBars["PETS"])
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en and hbCurrentFrame<6 then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETHEALS,HEALBOT_OPTIONS_TARGETHEALS,1,1)
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_FOCUS_en and hbCurrentFrame<6 then
            if healGroups[gl]["STATE"] and HEALBOT_GAME_VERSION>1 then
                HealBot_Panel_testAddButton(HEALBOT_FOCUS,HEALBOT_FOCUS,1,1)
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_EMERGENCYHEALS_en then
            if healGroups[gl]["STATE"] and xRaidBars>0 then
                if HealBot_Globals.TestBars["PROFILE"]>1 then
                    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 then
                        for x=1,8 do
                            if xRaidBars>(5*(x-1)) then
                                if xRaidBars<(5*x) then
                                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,(5*x)-4,xRaidBars)
                                else
                                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,(5*x)-4,(5*x))
                                end
                            end
                        end
                    elseif Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==2 then
                        local rndClass=HealBot_Panel_RandomClasses(xRaidBars)
                        local curBar=1
                        for x=1,HealBot_randomClCol[0]["MAX"] do
                            if rndClass[x]>0 then
                                HealBot_Panel_testAddButton(HealBot_randomClNames[x],HEALBOT_OPTIONS_EMERGENCYHEALS,curBar,curBar+(rndClass[x]-1),nil,x)
                                curBar=curBar+rndClass[x]
                            end
                        end
                    else
                        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,xRaidBars)
                    end
                else
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_GROUPHEALS,1,xRaidBars)
                end
                xRaidBars=0
            end
        end
        HealBot_Action_setLuVars("showTestPowerIndicator", 0)
    end
    
    HealBot_Panel_SetupBars(true)
    
    if healGroups[10]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9 and HEALBOT_GAME_VERSION>1 then
        hbCurrentFrame=9
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_FOCUS,HEALBOT_FOCUS,1,1)
        HealBot_Panel_SetupExtraBars(9, true)
    else
        HealBot_Action_HidePanel(9)
    end
    
    if healGroups[9]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8 then
        hbCurrentFrame=8
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETHEALS,HEALBOT_OPTIONS_TARGETHEALS,1,1)
        HealBot_Panel_SetupExtraBars(8, true)
    else
        HealBot_Action_HidePanel(8)
    end
    
    if HealBot_Globals.TestBars["PETS"]>0 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        hbCurrentFrame=7
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] and HealBot_Globals.TestBars["PETS"]>5 then
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 1",HEALBOT_WORD_PET,1,5)
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 2",HEALBOT_WORD_PET,6,HealBot_Globals.TestBars["PETS"])
        else
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_WORD_PET,1,HealBot_Globals.TestBars["PETS"])
        end
        HealBot_Panel_SetupExtraBars(7, true)
    else
        HealBot_Action_HidePanel(7)
    end
    
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        hbCurrentFrame=6
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_VEHICLE,HEALBOT_VEHICLE,1,vRaidBars)
        HealBot_Panel_SetupExtraBars(6, true)
    else
        HealBot_Action_HidePanel(6)
    end
    
    if healGroups[11]["STATE"] then
        hbCurrentFrame=10
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_CUSTOM_CASTBY_ENEMY,HEALBOT_CUSTOM_CASTBY_ENEMY,1,HealBot_Globals.TestBars["ENEMY"],HEALBOT_CUSTOM_CASTBY_ENEMY)
        HealBot_Panel_SetupExtraBars(10, true)
    else
        HealBot_Action_HidePanel(10)
    end
    for _,xButton in pairs(HealBot_Test_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
           -- HealBot_setTestCols[xButton.id]=false
            xButton:Hide()
            HealBot_Emerg_Button[xButton.id]:Hide()
        end
    end
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    --HealBot_Timers_Set("SKINS","TextUpdateHealth")
end

function HealBot_Panel_resetTestCols(force)
      --HealBot_setCall("HealBot_Panel_resetTestCols")
    if HealBot_setTestBars then
        if force then HealBot_setTestCols={} end
        HealBot_Timers_nextRecalcAll()
    end
end

function HealBot_Panel_resetTestColsButton(index)
      --HealBot_setCall("HealBot_Panel_resetTestColsButton")
    if HealBot_setTestCols[index] then HealBot_setTestCols[index]=false end
end


function HealBot_Panel_enemyBar(eUnit, pUnit)
      --HealBot_setCall("HealBot_Panel_enemyBar")
    i[hbCurrentFrame]=i[hbCurrentFrame]+1
    table.insert(units,eUnit)
    hbPanel_enemyUnits[pUnit]=true
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGET"] then
        HealBot_SpecialUnit[eUnit]=1
        HealBot_SpecialUnit[eUnit.."target"]=2
    else
        HealBot_SpecialUnit[eUnit]=nil
        HealBot_SpecialUnit[eUnit.."target"]=nil
    end
end

function HealBot_Panel_checkEnemyBar(eUnit, pUnit, preCombat, existsShow, preCombatShow)
      --HealBot_setCall("HealBot_Panel_checkEnemyBar")
    if UnitExists(pUnit) then
        if preCombat then
            if preCombatShow==2 then
                if UnitExists(eUnit) then
                    HealBot_Panel_enemyBar(eUnit, pUnit)
                end
            elseif preCombatShow==1 or not UnitExists("boss1") then
                HealBot_Panel_enemyBar(eUnit, pUnit)
            end
        elseif existsShow>1 then
            if existsShow==2 then
                if HealBot_ValidLivingEnemy(pUnit, eUnit) then
                    HealBot_Panel_enemyBar(eUnit, pUnit)
                end
            else
                HealBot_Panel_enemyBar(eUnit, pUnit)
            end
        end
    end
end

local vSubSortUnit,vSubSortGUID,vExists,vDup,vRole="","",false,false,3
function HealBot_Panel_SubSort(doSubSort,unitType, preCombat)
      --HealBot_setCall("HealBot_Panel_SubSort")
    if doSubSort then --and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBORDER"]<6 then
        table.sort(subunits,function (a,b)
            if not suborder[a] or not suborder[b] then
                return false
            else
                if suborder[a]<suborder[b] then return true end
                if suborder[a]>suborder[b] then return false end
                return a<b
            end
        end)
    end
    for j=1,#subunits do
        vSubSortUnit=subunits[j]
        if vSubSortUnit then
            vSubSortGUID=UnitGUID(vSubSortUnit) or vSubSortUnit
            vExists=false
            vDup=false
            if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                if unitType<5 then
                    if HealBot_TrackPrivateUnit[vSubSortUnit] then vExists=true end
                    if HealBot_TrackUnit[unitType][vSubSortUnit] then vDup=true end
                else
                    if HealBot_TrackUnit[unitType][vSubSortUnit] then vExists=true end
                    if HealBot_TrackPrivateUnit[vSubSortUnit] then vDup=true end
                end
            elseif HealBot_TrackUnit[unitType][vSubSortUnit] or HealBot_TrackPrivateUnit[vSubSortUnit] then
                vExists=true
            end
            if not vExists and not HealBot_Panel_BlackList[vSubSortGUID] then
                vRole=3
                if HealBot_MainTanks[vSubSortGUID] then 
                    vRole=1 
                elseif HealBot_MainHealers[vSubSortGUID] then 
                    vRole=2
                end
                if HealBot_Action_SetHealButton(vSubSortUnit,vSubSortGUID,hbCurrentFrame,unitType,vDup,vRole,preCombat) then
                    if unitType<5 then
                        HealBot_TrackPrivateUnit[vSubSortUnit]=true
                    else
                        HealBot_TrackUnit[unitType][vSubSortUnit]=true
                    end
                    hbHealButtonsConcat[1]=vSubSortUnit
                    hbHealButtonsConcat[3]=unitType
                    table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
                    --if (not HealBot_SpecialUnit[vSubSortUnit] or HealBot_SpecialUnit[vSubSortUnit]==1) then
                        hbBarsPerFrame[hbCurrentFrame]=hbBarsPerFrame[hbCurrentFrame]+1
                    --end
                end
            end
        else
            HealBot_Timers_Set("LAST","ResetAllButtonsRecalcAll",1)
        end
    end
    for x,_ in pairs(suborder) do
        suborder[x]=nil;
    end
    for x,_ in pairs(subunits) do
        subunits[x]=nil;
    end
end

local vSubOrderKey,allowOOR=99,true
function HealBot_Panel_sortOrder(unit, barOrder, mainSort)
      --HealBot_setCall("HealBot_Panel_sortOrder")
    vSubOrderKey=99
    if mainSort and Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SHOW"] then
        allowOOR=false
    else
        allowOOR=true
    end
    if barOrder==1 then
        if UnitIsUnit(unit, "player") then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = "!";
            else
                vSubOrderKey = UnitName(unit) or unit
            end
        elseif UnitExists(unit) then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = "ÿÿÿþ"..(UnitName(unit) or unit)
            else
                vSubOrderKey = UnitName(unit) or unit
            end
        else
            vSubOrderKey = "ÿÿÿÿ"..unit
        end
    elseif barOrder==2 then
        if UnitIsUnit(unit, "player") then
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = "!";
            else
                vSubOrderKey = HealBot_Panel_classEN(unit)
            end
        elseif UnitExists(unit) then
            if allowOOR and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = "ÿÿÿþ"..HealBot_Panel_classEN(unit)
            else
                vSubOrderKey = HealBot_Panel_classEN(unit)
            end
        else
            vSubOrderKey = "ÿÿÿÿ"..unit
        end
    elseif barOrder==3 then
        if UnitIsUnit(unit, "player") then 
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -1
            else
                vSubOrderKey = HealBot_UnitGroups[unit] or 1
            end 
        elseif UnitExists(unit) then
            if allowOOR and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 9+(HealBot_UnitGroups[unit] or 1)
            else
                vSubOrderKey = HealBot_UnitGroups[unit] or 1
            end
        else
            vSubOrderKey = (HealBot_UnitGroups[unit] or 1)
        end
    elseif barOrder==4 then
        if UnitIsUnit(unit, "player") then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -99999999
            else
                vSubOrderKey = 0-UnitHealthMax(unit)
            end
        elseif UnitExists(unit) then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 9999999-UnitHealthMax(unit)
            else
                vSubOrderKey = 0-UnitHealthMax(unit)
            end
        else
            vSubOrderKey = 99999999
        end
        if UnitIsPlayer(unit) and UnitHealthMax(unit)>TempMaxH then TempMaxH=UnitHealthMax(unit); end
    elseif barOrder==5 then
        if UnitIsUnit(unit, "player") then 
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -1
            else 
                vSubOrderKey = HealBot_unitRole[unit] or 9
            end
        elseif UnitExists(unit) then
            if allowOOR and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 59+(HealBot_unitRole[unit] or 9)
            else
                vSubOrderKey = HealBot_unitRole[unit] or 9
            end
        else
            vSubOrderKey = 99+(HealBot_unitRole[unit] or 9)
        end
    end
    return vSubOrderKey
end

function HealBot_Panel_insSort(unit, mainSort)
      --HealBot_setCall("HealBot_Panel_insSort")
    if unit then
        if mainSort then 
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
                order[unit] = HealBot_Panel_sortOrder(unit, Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"], mainSort)
            else
                if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] and UnitIsUnit(unit, "player") then
                    order[unit] = "!"
                else
                    order[unit] = unit
                end
            end
            table.insert(units,unit)
        else
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBORDER"]<6 then
                suborder[unit] = HealBot_Panel_sortOrder(unit, Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBORDER"], mainSort)
            else
                if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] and UnitIsUnit(unit, "player") then
                    suborder[unit] = "!"
                else
                    suborder[unit] = unit
                end
            end
            table.insert(subunits,unit)
        end
    end
end

function HealBot_Panel_SetFocusGroups()
      --HealBot_setCall("HealBot_Panel_SetFocusGroups")
    if HealBot_Globals.OverrideEffects["USE"]==2 then
        HealBot_Panel_luVars["FocusGroups"]=HealBot_Globals.OverrideEffects["FOCUSGROUPS"]
        HealBot_Panel_luVars["FGroups"]=HealBot_Globals.OverrideFocusGroups
    else
        HealBot_Panel_luVars["FocusGroups"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FOCUSGROUPS"]
        HealBot_Panel_luVars["FGroups"]=Healbot_Config_Skins.FocusGroups[Healbot_Config_Skins.Current_Skin]
    end
end

function HealBot_Panel_addUnit(unit, unitType, hbGUID, isRaidGroup)
      --HealBot_setCall("HealBot_Panel_addUnit")
    if HealBot_Panel_luVars["FocusGroups"]<3 or unitType>5 or HealBot_Panel_luVars["FGroups"][HealBot_UnitGroups[unit]] then
        local uExists=false
        if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
            if unitType<5 then
                if HealBot_TrackPrivateNames[hbGUID] then uExists=true end
            else
                if HealBot_TrackNames[hbGUID] then uExists=true end
            end
        elseif HealBot_TrackNames[hbGUID] or HealBot_TrackPrivateNames[hbGUID] then
            uExists=true
        end
        if not uExists then
            if UnitIsVisible(unit) or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
                if not isRaidGroup then i[hbCurrentFrame] = i[hbCurrentFrame]+1; end
                if unitType<5 then
                    HealBot_TrackPrivateNames[hbGUID]=true
                else
                    HealBot_TrackNames[hbGUID]=true;
                end
                HealBot_Panel_insSort(unit, true)
            elseif isRaidGroup then
                HealBot_setNotVisible(unit,6)
            else
                HealBot_setNotVisible(unit,0)
            end
        end
    end
end

--local vMainSortIndex,vMainSortKey=0,""
local vMainSortKey=""
function HealBot_Panel_MainSort(doMainSort,unitType, preCombat)
      --HealBot_setCall("HealBot_Panel_MainSort")
    if #units>0 then
        if doMainSort then --and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
            --vMainSortIndex=0
            table.sort(units,function (a,b)
                if order[a]<order[b] then return true end
                if order[a]>order[b] then return false end
                return a<b
            end)
            vMainSortKey=order[units[1]]
            for j=1,#units do
                if vMainSortKey~=order[units[j]] then
                    HealBot_Panel_SubSort(true, unitType, preCombat)
                    --vMainSortIndex=j
                    vMainSortKey=order[units[j]]
                end
                HealBot_Panel_insSort(units[j], false)
            end
            --if vMainSortIndex<#units then
                HealBot_Panel_SubSort(true, unitType, preCombat)
            --end
        else
            for j=1,#units do
                HealBot_Panel_insSort(units[j], false)
            end
            HealBot_Panel_SubSort(true, unitType, preCombat)
        end
    end
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(units) do
        units[x]=nil;
    end
end

function HealBot_Panel_addUnits(doMainSort,unitType,hText,k, preCombat)
      --HealBot_setCall("HealBot_Panel_addUnits")
    HealBot_Panel_MainSort(doMainSort,unitType, preCombat)
    HeaderPos[hbCurrentFrame][k+1] = hText 
end

local vEnemyIndex,vEnemyLocation,vEnemyBossNum,vEnemyBossExist=0,"",0,1
function HealBot_Panel_enemyTargets(preCombat)
        --HealBot_setCall("HealBot_Panel_enemyTargets")
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_TARGETHEALS
    vEnemyIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"] then
        if HEALBOT_GAME_VERSION>9 then
            HealBot_Panel_checkEnemyBar("anyenemy", "player", preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWSELF"])
        else
            HealBot_Panel_checkEnemyBar("playertarget", "player", preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWSELF"])
        end
    end
    if HEALBOT_GAME_VERSION>1 and Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCFOCUS"] then
        HealBot_Panel_checkEnemyBar("focus", "player", preCombat, 
                                    Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWFOCUS"],
                                    Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWFOCUS"])
    end
    
    _,vEnemyLocation = IsInInstance()
    if vEnemyLocation == "arena" then
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"] then
            for j=1,GetNumGroupMembers() do
                xUnit="arena"..j;
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, 
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"],
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWARENA"])
            end
        end
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"] then
            for j=1,GetNumGroupMembers() do
                xUnit="arenapet"..j;
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, 
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"],
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWARENA"])
            end
        end
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"] then
        for _,xUnit in pairs(HealBot_MainTanks) do
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWTANK"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWTANK"])
        end
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"] then
        for xGUID,_ in pairs(HealBot_MyHealTargets) do
            xUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWMYTAR"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWLIST"])
        end
        for xGUID,_ in pairs(HealBot_Globals.HealBot_PermMyTargets) do
            xUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWMYTAR"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWLIST"])
        end
    end
    
    if HEALBOT_GAME_VERSION>2 then
        vEnemyBossNum=Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["NUMBOSS"]
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWBOSS"] then
            vEnemyBossExist=2
        else
            vEnemyBossExist=1
        end
        if HealBot_Panel_luVars["MAPID"]==953 then
            if UnitExists("boss1") then
                if vEnemyBossNum<3 then vEnemyBossNum=3 end
                vEnemyBossExist=1
            end
        end
        
        if vEnemyBossNum>0 then
            for bi=1,vEnemyBossNum do
                xUnit="boss"..bi
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, vEnemyBossExist, vEnemyBossExist)
            end
        end
    end

    if i[hbCurrentFrame]>vEnemyIndex then 
        HealBot_Panel_addUnits(false,11,HEALBOT_CUSTOM_CASTBY_ENEMY,vEnemyIndex, preCombat)
    end
end

local vTargetValid, vTargetGUID=false,"target"
function HealBot_Panel_validTarget(unit)
        --HealBot_setCall("HealBot_Panel_validTarget", nil, nil, unit)
    if UnitExists("target") then
        vTargetValid=true
        vTargetGUID=UnitGUID("target") or "target"
        if HealBot_Panel_BlackList[vTargetGUID] then 
            vTargetValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] and not UnitIsFriend("player","target") then 
            vTargetValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TEXRAID"] and 
              (UnitIsUnit("target", "player") or UnitInParty("target") or UnitInRaid("target")) then
            vTargetValid=false
        end
    else
        vTargetValid=false
    end
    return vTargetValid
end

local vTargetIndex=0
function HealBot_Panel_targetHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_targetHeals")
    vTargetIndex=i[hbCurrentFrame]
    if UnitExists("target") and (not preCombat or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]>1) then
        if UnitIsVisible("target") or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
            if preCombat or HealBot_Panel_validTarget() then
                i[hbCurrentFrame] = i[hbCurrentFrame]+1;
                table.insert(subunits,"target")
            end
        end
    elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        table.insert(subunits,"target")
    end
    if i[hbCurrentFrame]>vTargetIndex then 
        HealBot_Panel_SubSort(false,9, preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = HEALBOT_OPTIONS_TARGETHEALS
    end
end

function HealBot_Panel_UnitUsingVehicle()
        --HealBot_setCall("HealBot_Panel_UnitUsingVehicle")
    return false
end

local HealBot_UnitUsingVehicle=_G["UnitUsingVehicle"] or _G["HealBot_Panel_UnitUsingVehicle"]
local vVehiclePlayerUnit,vVehicleUnit,vVehicleIndex="","",0
function HealBot_Panel_vehicleHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_vehicleHeals")
    if HEALBOT_GAME_VERSION>2 then
        vVehicleIndex=i[hbCurrentFrame]
        if nraid>0 then
            for j=1,nraid do
                vVehicleUnit="raidpet"..j;
                vVehiclePlayerUnit="raid"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and HealBot_UnitUsingVehicle(vVehiclePlayerUnit) and UnitExists(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, 7, hbPanel_dataPetUnits[vVehicleUnit], false)
                elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] and hbPanel_dataUnits[vVehiclePlayerUnit] then
                    HealBot_Panel_addUnit(vVehicleUnit, 7, vVehicleUnit, false)
                end
            end
        else
            vVehicleUnit="pet"
            vVehiclePlayerUnit="player"
            if hbPanel_dataPetUnits[vVehicleUnit] and HealBot_UnitUsingVehicle(vVehiclePlayerUnit) then
                HealBot_Panel_addUnit(vVehicleUnit, 7, hbPanel_dataPetUnits[vVehicleUnit], false)
            elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] and hbPanel_dataUnits[vVehiclePlayerUnit] then
                HealBot_Panel_addUnit(vVehicleUnit, 7, vVehicleUnit, false)
            end
            for j=1,4 do
                vVehicleUnit="partypet"..j;
                vVehiclePlayerUnit="party"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and HealBot_UnitUsingVehicle(vVehiclePlayerUnit) and UnitExists(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, 7, hbPanel_dataPetUnits[vVehicleUnit], false)
                elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] and hbPanel_dataUnits[vVehiclePlayerUnit] then
                    HealBot_Panel_addUnit(vVehicleUnit, 7, vVehicleUnit, false)
                end
            end
        end
        if i[hbCurrentFrame]>vVehicleIndex then 
            HealBot_Panel_addUnits(true, 7,HEALBOT_VEHICLE,vVehicleIndex, preCombat)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"]=false
    end
end

local vPetPlayerUnit,vPetUnit,vPetIndex,vPetGrp5ID="","",0,0
function HealBot_Panel_petHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_petHeals")
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS
    vPetGrp5ID=0
    vPetIndex=i[hbCurrentFrame]
    if nraid>0 then
        for j=1,nraid do
            vPetUnit="raidpet"..j;
            vPetPlayerUnit="raid"..j;
            if UnitExists(vPetUnit) and hbPanel_dataPetUnits[vPetUnit] and not HealBot_UnitUsingVehicle(vPetPlayerUnit) then
                HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
            elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] and hbPanel_dataUnits[vPetPlayerUnit] and HealBot_Panel_IsMyTarget(hbPanel_dataUnits[vPetPlayerUnit]) then
                HealBot_Panel_addUnit(vPetUnit, 8, vPetUnit, false)
            end
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
                if i[hbCurrentFrame]-vPetIndex == 6 then 
                    vPetGrp5ID=vPetGrp5ID+1
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]-5] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                end
                if i[hbCurrentFrame]>vPetIndex and ((i[hbCurrentFrame]-vPetIndex)%5 == 0) then                           
                    HealBot_Panel_MainSort(true,8, preCombat)        
                    vPetGrp5ID=vPetGrp5ID+1
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                end
            end
        end
        if not HeaderPos[hbCurrentFrame][vPetIndex+1] and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] and i[hbCurrentFrame]-vPetIndex == 5 then
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    else
        vPetUnit="pet"
        vPetPlayerUnit="player"
        if UnitExists(vPetUnit) and hbPanel_dataPetUnits[vPetUnit] and not HealBot_UnitUsingVehicle(vPetPlayerUnit) and not HealBot_Panel_luVars["SelfPets"] then
            HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
        elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] and hbPanel_dataUnits[vPetPlayerUnit] and HealBot_Panel_IsMyTarget(hbPanel_dataUnits[vPetPlayerUnit]) then
            HealBot_Panel_addUnit(vPetUnit, 8, vPetUnit, false)
        end
        for j=1,4 do
            vPetUnit="partypet"..j;
            vPetPlayerUnit="party"..j;
            if UnitExists(vPetUnit) and hbPanel_dataPetUnits[vPetUnit] and not HealBot_UnitUsingVehicle(vPetPlayerUnit) then 
                HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
            elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] and hbPanel_dataUnits[vPetPlayerUnit] and HealBot_Panel_IsMyTarget(hbPanel_dataUnits[vPetPlayerUnit]) then
                HealBot_Panel_addUnit(vPetUnit, 8, vPetUnit, false)
            end
        end
    end
    if i[hbCurrentFrame]>vPetIndex then
        HealBot_Panel_MainSort(true,8, preCombat)        
        if not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS
        elseif nraid==0 or (not HeaderPos[hbCurrentFrame][vPetIndex+1] and (i[hbCurrentFrame]-vPetIndex)%5>0) then 
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    end
end

local vRaidTargetNum,vRaidTargetGroup,vRaidUnit,vRaidIndex,vCrashProtData,vCrashProtTmp=0,8,"",0,"1","0"
local vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
function HealBot_Panel_raidHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_raidHeals")
    vRaidIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==1 or Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_EMERGENCYHEALS
    end
    
    vRaidTargetNum = nraid
    if preCombat and nraid>0 and HealBot_Panel_luVars["cpRaid"] then
        if vRaidTargetNum<11 then
            vRaidTargetNum=10
            vRaidTargetGroup=2
        elseif vRaidTargetNum<16 then
            vRaidTargetNum=15
            vRaidTargetGroup=3
        elseif vRaidTargetNum<26 then
            vRaidTargetNum=25
            vRaidTargetGroup=5
        else
            vRaidTargetNum=40
            vRaidTargetGroup=8
        end
    end

    if nraid>0 then
        for j=1,vRaidTargetNum do
            vRaidUnit = "raid"..j;
            if UnitIsUnit(vRaidUnit,"player") then
                HealBot_Data["PUNIT"]=vRaidUnit
                if MyGroup["GROUP"]>0 then
                    local _, _, subgroup = GetRaidRosterInfo(j);
                    HeaderPos[MyGroup["FRAME"]][MyGroup["GROUP"]] = HEALBOT_OPTIONS_GROUPHEALS.." "..subgroup
                end
            end
            if hbPanel_dataUnits[vRaidUnit] then
                HealBot_Panel_addUnit(vRaidUnit, 5, hbPanel_dataUnits[vRaidUnit], true)
            elseif preCombat and (HealBot_Panel_luVars["cpCrash"] or HealBot_Panel_luVars["cpRaid"]) then
                HealBot_UnitGroups[vRaidUnit]=vRaidTargetGroup
                HealBot_Panel_addUnit(vRaidUnit, 5, vRaidUnit, true)
            end
        end
    else
        for n,xUnit in ipairs(HealBot_Action_HealGroup) do
            if hbPanel_dataUnits[xUnit] then
                HealBot_Panel_addUnit(xUnit, 5, hbPanel_dataUnits[xUnit], true)
            elseif preCombat then
                if (IsInGroup() and HealBot_Panel_luVars["cpGroup"]) or
                   (HealBot_Panel_luVars["cpCrash"] and HealBot_Panel_luVars["cpCrashType"]=="g" and n<=HealBot_Panel_luVars["cpCrashNum"]) then
                    HealBot_UnitGroups[xUnit]=1
                    HealBot_Panel_addUnit(xUnit, 5, xUnit, true)
                end
            end
        end
    end

    --if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
        table.sort(units,function (a,b)
            if order[a]<order[b] then return true end
            if order[a]>order[b] then return false end
            return a<b
        end)
    --end
    vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==2 or
           Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 or
           Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
        vRaidShowHeader=true
    end

    for j=1,#units do
        vRaidUnit=units[j];
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
            if vRaidSubSort~=order[vRaidUnit] then
                if vRaidShowHeader then
                    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==2 then
                        vRaidHeadSort=UnitClass(vRaidUnit) or HEALBOT_WARRIOR
                    elseif Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 then
                        vRaidHeadSort=HEALBOT_OPTIONS_GROUPHEALS.." "..order[vRaidUnit]
                    elseif Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
                        vRaidHeadSort=HealBot_unitRole[vRaidUnit] or hbRole[HEALBOT_WORD_DPS]
                    end
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = vRaidHeadSort
                end
                HealBot_Panel_SubSort(true, 5, preCombat)
                vRaidSubSort=order[vRaidUnit]
                vRaidPrevSort=vRaidHeadSort
            end
        end
        HealBot_Panel_insSort(vRaidUnit, false)
    end
    if #units>0 then
        HealBot_Panel_SubSort(true, 5, preCombat)
    end
            
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(units) do
        units[x]=nil;
    end
end

local vFocusUnitValid,vFocusGUID=false,"focus"
function HealBot_Panel_validFocus()
        --HealBot_setCall("HealBot_Panel_validFocus")
    if UnitExists("focus") then
        vFocusUnitValid=true
        vFocusGUID=UnitGUID("focus") or "focus"
        if HealBot_Panel_BlackList[vFocusGUID] then 
            vFocusUnitValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] and not UnitIsFriend("player","focus") then 
            vFocusUnitValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FEXRAID"] and 
               (UnitIsUnit("focus", "player") or UnitInParty("focus") or UnitInRaid("focus")) then
            vFocusUnitValid=false
        end
    else
        vFocusUnitValid=false
    end
    return vFocusUnitValid
end

local vFocusIndex=0
function HealBot_Panel_focusHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_focusHeals")
    vFocusIndex=i[hbCurrentFrame]
    if UnitExists("focus") and (not preCombat or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]>1) then
        if preCombat then
            i[hbCurrentFrame] = i[hbCurrentFrame]+1;
            table.insert(subunits,"focus")
        elseif UnitIsVisible("focus") or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
            if HealBot_Panel_validFocus() then
                i[hbCurrentFrame] = i[hbCurrentFrame]+1;
                table.insert(subunits,"focus")
            end
        else
            HealBot_setNotVisible("focus",4)
        end
    elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then 
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        table.insert(subunits,"focus")
    end
    if i[hbCurrentFrame]>vFocusIndex then 
        HealBot_Panel_SubSort(false, 10, preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = HEALBOT_FOCUS
    end
end

local vMyTargetsIndex,vMyTargetsUnit=0,"unknown"
function HealBot_Panel_myHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_myHeals")
    vMyTargetsIndex=i[hbCurrentFrame]
    for xGUID,_ in pairs(HealBot_MyHealTargets) do
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then  
            HealBot_Panel_addUnit(vMyTargetsUnit, 4, xGUID, false)
        end
    end
    for xGUID,_ in pairs(HealBot_Globals.HealBot_PermMyTargets) do
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then  
            HealBot_Panel_addUnit(vMyTargetsUnit, 4, xGUID, false)
        end
    end
    if i[hbCurrentFrame]>vMyTargetsIndex then 
        HealBot_Panel_addUnits(true, 4,HEALBOT_OPTIONS_MYTARGET,vMyTargetsIndex, preCombat)
    end
end

local vGroupIndex=0
function HealBot_Panel_groupHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_groupHeals")
    vGroupIndex=i[hbCurrentFrame]
    for n,xUnit in ipairs(HealBot_Action_HealGroup) do
        if UnitExists(xUnit) and UnitGUID(xUnit) and hbPanel_dataGUIDs[UnitGUID(xUnit)] then
            if nraid>0 then 
                xUnit=hbPanel_dataGUIDs[UnitGUID(xUnit)] or xUnit
            end
            HealBot_Panel_addUnit(xUnit, 6, hbPanel_dataUnits[xUnit], false)
        elseif nraid==0 and preCombat then
            if (IsInGroup() and HealBot_Panel_luVars["cpGroup"]) or
               (HealBot_Panel_luVars["cpCrash"] and HealBot_Panel_luVars["cpCrashType"]=="g" and n<=HealBot_Panel_luVars["cpCrashNum"]) then
                HealBot_UnitGroups[xUnit]=1
                HealBot_Panel_addUnit(xUnit, 6, xUnit, false)
            end
        end
    end
    if i[hbCurrentFrame]>vGroupIndex then 
        HealBot_Panel_addUnits(true, 6,HEALBOT_OPTIONS_GROUPHEALS,vGroupIndex, preCombat)
        MyGroup["GROUP"]=vGroupIndex+1
        MyGroup["FRAME"]=hbCurrentFrame
    else
        MyGroup["GROUP"]=0
    end
end

local vHealIndex=0
function HealBot_Panel_healerHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_healerHeals")
    vHealIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainHealers) do
        HealBot_Panel_addUnit(xUnit, 2, xGUID, false)
    end
    if i[hbCurrentFrame]>vHealIndex then 
        HealBot_Panel_addUnits(true, 2,HEALBOT_CLASSES_HEALERS,vHealIndex, preCombat)
    end
end

local vTankIndex=0
function HealBot_Panel_tankHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_tankHeals")
    vTankIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainTanks) do
        HealBot_Panel_addUnit(xUnit, 1, xGUID, false)
    end
    if i[hbCurrentFrame]>vTankIndex then
        HealBot_Panel_addUnits(true, 1, HEALBOT_OPTIONS_TANKHEALS,vTankIndex, preCombat)
    end
end

local vSelfIndex,vSelfPetIndex,vSelfUnit,vSelfPetUnit=0,0,"player","pet"
function HealBot_Panel_selfHeals()
        --HealBot_setCall("HealBot_Panel_selfHeals")
    vSelfIndex=i[hbCurrentFrame]
    HealBot_Panel_luVars["SelfPets"]=false
    HealBot_Panel_addUnit(vSelfUnit, 3, UnitGUID(vSelfUnit), false)
    if i[hbCurrentFrame]>vSelfIndex then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] and hbPanel_dataPetUnits[vSelfPetUnit] and HealBot_Config.DisabledNow==0 then
            vSelfPetIndex=i[hbCurrentFrame]
            HealBot_Panel_addUnit(vSelfPetUnit, 3, hbPanel_dataPetUnits[vSelfPetUnit], false)
            if i[hbCurrentFrame]>vSelfPetIndex then HealBot_Panel_luVars["SelfPets"]=true end
        end
        HealBot_Panel_addUnits(false, 3, HEALBOT_OPTIONS_SELFHEALS,vSelfIndex, preCombat)
    end
end

function HealBot_Panel_UnitShow(button)
        --HealBot_setCall("HealBot_Panel_UnitShow", button)
    button:Show()
    if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["USE"] then
        HealBot_Emerg_Button[button.id]:Show()
    end
end

function HealBot_Panel_PetVehicleShow(button)
        --HealBot_setCall("HealBot_Panel_PetVehicleShow", button)
    HealBot_Panel_UnitShow(button)
    HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
end

function HealBot_Panel_VehicleChanged(preCombat)
        --HealBot_setCall("HealBot_Panel_VehicleChanged")
    hbCurrentFrame=6
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_vehicleHeals(preCombat)
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.status.unittype==7 then
                if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                    HealBot_Panel_PetVehicleShow(xButton)
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.status.unittype==7 then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

function HealBot_Panel_PetsChanged(preCombat)
        --HealBot_setCall("HealBot_Panel_PetsChanged")
    hbCurrentFrame=7
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_petHeals(preCombat)
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==8 then
                if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                    HealBot_Panel_PetVehicleShow(xButton)
                elseif not UnitIsUnit(xButton.unit,"pet") or not HealBot_Panel_luVars["SelfPets"] then
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
        if HealBot_Panel_luVars["NumPets"]>HealBot_retLuVars("NumPetUnits") then
            HealBot_setLuVars("NumPetUnits", HealBot_Panel_luVars["NumPets"])
        end
    else
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==8 then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

function HealBot_Panel_TargetShow(button)
        --HealBot_setCall("HealBot_Panel_TargetShow", button)
    HealBot_setLuVars("TargetNeedReset", false)
    HealBot_Panel_UnitShow(button)
    HealBot_Panel_TargetChangedCheckFocus()
end

local vTargetButton=""
function HealBot_Panel_TargetChanged(preCombat)
        --HealBot_setCall("HealBot_Panel_TargetChanged")
    hbCurrentFrame=8
    hbBarsPerFrame[hbCurrentFrame]=0
    
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_targetHeals(preCombat)
        vTargetButton = HealBot_Extra_Button["target"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.status.unittype][vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_Panel_TargetShow(vTargetButton)
            else
                HealBot_Action_MarkDeleteButton(vTargetButton)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        if HealBot_Extra_Button["target"] then
            HealBot_Action_MarkDeleteButton(HealBot_Extra_Button["target"])
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vFocusParent, vFocusFrame="",""
function HealBot_Panel_TargetChangedCheckFocus()
      --HealBot_setCall("HealBot_Panel_TargetChangedCheckFocus")
    if hbPanelShowhbFocus then
        local tButton=HealBot_Extra_Button["target"]
        if tButton then
            vFocusFrame=_G["hbExtra_HealUnit999"]
            local vFocusParent=_G["f8_HealBot_Action"]
            if not vFocusFrame then
                vFocusFrame=CreateFrame("Button", "hbExtra_HealUnit999", vFocusParent, "HealBotFocusButtonTemplate") 
                local bar = _G[vFocusFrame:GetName().."Bar"]
                bar:SetMinMaxValues(0,100);
                bar:SetValue(100);
                bar:UnregisterAllEvents()
                HealBot_Action_SethbFocusButtonAttrib(vFocusFrame)
                vFocusFrame.id=999
                vFocusFrame.name="hbExtra_HealUnit999"
                vFocusFrame.frame=8
                HealBot_Action_OnLoad(vFocusFrame) 
                vFocusFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            end
            if not HealBot_Data["UILOCK"] and UnitExists("target") and HealBot_Globals.FocusMonitor[UnitName("target")] then
                if UnitExists("focus") and HealBot_Globals.FocusMonitor[UnitName("focus")] then
                    vFocusFrame:Hide()
                else
                    HealBot_Skins_ResetSkin("hbfocus",vFocusFrame,Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][8]["NUMCOLS"])
                    vFocusFrame:ClearAllPoints()
                    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][8]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][8]["BARS"]==4 then
                        vFocusFrame:SetPoint("BOTTOM",tButton.gref["Back"],"TOP",0,9);
                    else
                        vFocusFrame:SetPoint("TOP",tButton.gref["Back"],"BOTTOM",0,-9);
                    end
                    vFocusFrame:Show();
                    hbFocusOn=vFocusFrame.frame
                end
            end
        elseif hbFocusOn>0 then
            if vFocusFrame then
                vFocusFrame:Hide();
            end
            hbFocusOn=0
        end
    elseif hbFocusOn>0 then
        if vFocusFrame then
            vFocusFrame:Hide();
        end
        hbFocusOn=0
    end
end

function HealBot_Panel_FocusShow(button)
      --HealBot_setCall("HealBot_Panel_FocusShow", button)
    HealBot_setLuVars("FocusNeedReset", false)
    HealBot_Panel_UnitShow(button)
end

local vFocusButton=""
function HealBot_Panel_FocusChanged(preCombat)
      --HealBot_setCall("HealBot_Panel_FocusChanged")
    if HEALBOT_GAME_VERSION>1 then 
        hbCurrentFrame=9
        hbBarsPerFrame[hbCurrentFrame]=0
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
            i[hbCurrentFrame]=0
            HeaderPos[hbCurrentFrame]={};
            HealBot_Panel_focusHeals(preCombat)
            vFocusButton = HealBot_Extra_Button["focus"]
            if vFocusButton then
                if HealBot_TrackUnit[vFocusButton.status.unittype][vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                    HealBot_Panel_FocusShow(vFocusButton)
                else
                    HealBot_Action_MarkDeleteButton(vFocusButton)
                end
            end
            HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
        else
            vFocusButton = HealBot_Extra_Button["focus"]
            if vFocusButton then
                HealBot_Action_MarkDeleteButton(vFocusButton)
            end
            HealBot_Action_HidePanel(hbCurrentFrame)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"]=false
    end
end

function HealBot_Panel_IsTargetingEnemy(unit)
      --HealBot_setCall("HealBot_Panel_IsTargetingEnemy", nil, nil, unit)
    return hbPanel_enemyUnits[unit]
end

function HealBot_Panel_EnemyChanged(preCombat)
      --HealBot_setCall("HealBot_Panel_EnemyChanged")
    hbCurrentFrame=10
    hbBarsPerFrame[hbCurrentFrame]=0
    for x,_ in pairs(hbPanel_enemyUnits) do
        hbPanel_enemyUnits[x]=nil;
    end
    --for _,xButton in pairs(HealBot_Enemy_Button) do
    --    HealBot_Action_MarkDeleteButton(xButton)
    --end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_enemyTargets(preCombat)
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                xButton:Show()
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vPetsWithPlayers,vVehicleWithPlayers,vTargetWithPlayers,vFocusWithPlayers=false,false,false,false
local vActiveFrames={}
function HealBot_Panel_PlayersChanged(preCombat)
      --HealBot_setCall("HealBot_Panel_PlayersChanged")
    TempMaxH=9;
    HealBot_Data["PUNIT"]="player"
    if HealBot_Panel_luVars["cpCrash"] and HealBot_Panel_luVars["cpCrashType"]=="r" then
        nraid=HealBot_Panel_luVars["cpCrashNum"]
    elseif not IsInRaid() then 
        nraid=0
        HealBot_Action_setLuVars("InRaid", false)
        HealBot_Aura_setLuVars("InRaid", false)
    else
        nraid=GetNumGroupMembers();
        HealBot_Action_setLuVars("InRaid", true)
        HealBot_Aura_setLuVars("InRaid", true)
    end

    for gl=1,5 do
        HeaderPos[gl]={};
        hbBarsPerFrame[gl]=0
        i[gl]=0
        vActiveFrames[gl]=false
    end

    if HealBot_Config.DisabledNow==1 then
        hbCurrentFrame=1
        HealBot_Panel_selfHeals(preCombat)
    else
        MyGroup["GROUP"]=0
        for gl=1,10 do
            hbCurrentFrame=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"]
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["STATE"] then
                vActiveFrames[hbCurrentFrame]=true
                for x,_ in pairs(order) do
                    order[x]=nil;
                end
                for x,_ in pairs(units) do
                    units[x]=nil;
                end
                for x,_ in pairs(suborder) do
                    suborder[x]=nil;
                end
                for x,_ in pairs(subunits) do
                    subunits[x]=nil;
                end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_EMERGENCYHEALS_en then
                    HealBot_Panel_raidHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_GROUPHEALS_en then
                    HealBot_Panel_groupHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_TANKHEALS_en then
                    HealBot_Panel_tankHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_CLASSES_HEALERS_en then
                    HealBot_Panel_healerHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_SELFHEALS_en then
                    HealBot_Panel_selfHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_MYTARGET_en then
                    HealBot_Panel_myHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
                    HealBot_Panel_petHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_VEHICLE_en and hbCurrentFrame<6 then
                    HealBot_Panel_vehicleHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en and hbCurrentFrame<6 then
                    HealBot_Panel_targetHeals(preCombat)
                elseif HEALBOT_GAME_VERSION>1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_FOCUS_en and hbCurrentFrame<6 then
                    HealBot_Panel_focusHeals(preCombat)
                end
            end
        end
    end
    HealBot_Panel_SetupBars(preCombat)
    
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.unittype>4 and xButton.status.unittype<7 then
            if HealBot_TrackUnit[xButton.status.unittype][xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                HealBot_Panel_UnitShow(xButton)
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        elseif xButton.status.unittype<5 or xButton.status.unittype>8 then
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    HealBot_Panel_luVars["NumPrivate"]=0
    for xUnit,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.unittype>0 and xButton.status.unittype<5 then
            if HealBot_TrackPrivateUnit[xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                HealBot_Panel_UnitShow(xButton)
                HealBot_Panel_luVars["NumPrivate"]=HealBot_Panel_luVars["NumPrivate"]+1
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        else
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    if HealBot_Panel_luVars["NumPrivate"]>HealBot_retLuVars("NumPrivateUnits") then
        HealBot_setLuVars("NumPrivateUnits", HealBot_Panel_luVars["NumPrivate"])
    end
    if vPetsWithPlayers then
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                HealBot_Panel_PetVehicleShow(xButton)
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
    end
    if vVehicleWithPlayers then
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                HealBot_Panel_PetVehicleShow(xButton)
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
    end
    if HealBot_Panel_luVars["NumPets"]>HealBot_retLuVars("NumPetUnits") then
        HealBot_setLuVars("NumPetUnits", HealBot_Panel_luVars["NumPets"])
    end
    if vTargetWithPlayers then
        vTargetButton = HealBot_Extra_Button["target"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.status.unittype][vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_Panel_TargetShow(vTargetButton)
            else
                HealBot_Action_MarkDeleteButton(vTargetButton)
            end
        end
    end
    if vFocusWithPlayers then
        vFocusButton=HealBot_Extra_Button["focus"]
        if vFocusButton then
            if HealBot_TrackUnit[vFocusButton.status.unittype][vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                HealBot_Panel_FocusShow(vFocusButton)
            else
                HealBot_Action_MarkDeleteButton(vFocusButton)
            end
        end
    end
    for gl=1,5 do
        HealBot_ActionIcons_UpdateActiveFrame(gl, vActiveFrames[gl])
    end
end

function HealBot_Panel_RetUnitGroups(unit)
      --HealBot_setCall("HealBot_Panel_RetUnitGroups", nil, nil, unit)
    return HealBot_UnitGroups[unit] or 1
end

function HealBot_Panel_RetUnitRank(guid)
      --HealBot_setCall("HealBot_Panel_RetUnitRank", nil, guid)
    return hbPanel_dataRanks[guid] or 0
end

function HealBot_Panel_RetUnitPlayerRole(guid)
      --HealBot_setCall("HealBot_Panel_RetUnitPlayerRole", nil, guid)
    return hbPanel_dataPlayerRoles[guid] or 0
end

local focusHeal=true
function HealBot_Panel_focusHeal(isOn)
      --HealBot_setCall("HealBot_Panel_focusHeal")
    focusHeal=isOn
end

function HealBot_Panel_RaidUnitGUID(guid)
      --HealBot_setCall("HealBot_Panel_RaidUnitGUID")
    return hbPanel_dataGUIDs[guid]
end

function HealBot_Panel_PetUnitGUID(guid)
      --HealBot_setCall("HealBot_Panel_PetUnitGUID")
    return hbPanel_dataPetGUIDs[guid]
end

local ruxUnit, ruxButton, rupButton
function HealBot_Panel_RaidUnitButton(guid)
      --HealBot_setCall("HealBot_Panel_RaidUnitButton")
    ruxUnit=HealBot_Panel_RaidUnitGUID(guid)
    if ruxUnit then
        _, ruxButton, rupButton = HealBot_UnitID(ruxUnit)
        return ruxButton, rupButton
    else
        return nil
    end
end

function HealBot_Panel_RaidPetUnitGUID(guid)
      --HealBot_setCall("HealBot_Panel_RaidPetUnitGUID")
    return hbPanel_dataGUIDs[guid] or hbPanel_dataPetGUIDs[guid]
end

function HealBot_Panel_RaidPetUnitButton(guid)
      --HealBot_setCall("HealBot_Panel_RaidPetUnitButton")
    ruxUnit=HealBot_Panel_RaidPetUnitGUID(guid)
    if ruxUnit then
        _,ruxButton,rupButton = HealBot_UnitID(ruxUnit)
        return ruxButton, rupButton
    else
        return nil
    end
end

function HealBot_Panel_AllUnitGUID(guid)
      --HealBot_setCall("HealBot_Panel_AllUnitGUID")
    return hbPanel_dataGUIDs[guid] or hbPanel_dataPetGUIDs[guid] or hbPanel_dataExtraGUIDs[guid]
end

function HealBot_Panel_AllUnitButton(guid)
      --HealBot_setCall("HealBot_Panel_AllUnitButton")
    ruxUnit=HealBot_Panel_AllUnitGUID(guid)
    if ruxUnit then
        _,ruxButton,rupButton = HealBot_UnitID(ruxUnit, true)
        return ruxButton, rupButton
    else
        return nil
    end
end

function HealBot_Panel_RaidUnitName(uName)
      --HealBot_setCall("HealBot_Panel_RaidUnitName")
    return hbPanel_dataNames[uName] or hbPanel_dataPetNames[uName]
end

function HealBot_Panel_RaidUnitNameGetPlayerButton(uName)
      --HealBot_setCall("HealBot_Panel_RaidUnitNameGetPlayerButton")
    if hbPanel_dataNames[uName] then
        _, ruxButton, rupButton = HealBot_UnitID(hbPanel_dataNames[uName])
        return ruxButton, rupButton
    else
        return nil
    end
end

function HealBot_Panel_RaidUnitNameGetPlayerGUID(uName)
      --HealBot_setCall("HealBot_Panel_RaidUnitNameGetPlayerGUID")
    if hbPanel_dataNames[uName] then
        return hbPanel_dataUnits[hbPanel_dataNames[uName]]
    else
        return nil
    end
end

function HealBot_Panel_resetCrashProt()
      --HealBot_setCall("HealBot_Panel_resetCrashProt")
    vCrashProtTmp=""
end

function HealBot_Panel_DoPartyChanged(preCombat, changeType)
      --HealBot_setCall("HealBot_Panel_DoPartyChanged")
    for xHeader in pairs(HealBot_Track_Headers) do
        HealBot_Track_Headers[xHeader]=false
    end
    for x,_ in pairs(HealBot_TrackPrivateUnit) do
        HealBot_TrackPrivateUnit[x]=nil
    end 
    for x,_ in pairs(HealBot_TrackNames) do
        HealBot_TrackNames[x]=nil;
    end
    for x,_ in pairs(HealBot_TrackPrivateNames) do
        HealBot_TrackPrivateNames[x]=nil;
    end
    for xGUID,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_TrackNames[xGUID]=true
        HealBot_TrackPrivateNames[xGUID]=true
    end 
    for x,_ in pairs(HealBot_Action_HealButtons) do
        HealBot_Action_HealButtons[x]=nil;
    end
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(units) do
        units[x]=nil;
    end
    for x,_ in pairs(suborder) do
        suborder[x]=nil;
    end
    for x,_ in pairs(subunits) do
        subunits[x]=nil;
    end

    if changeType>5 then

        for z=1,6 do
            for x,_ in pairs(HealBot_TrackUnit[z]) do
                HealBot_TrackUnit[z][x]=nil
            end 
        end 
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<6 then
            vPetsWithPlayers=true
            for x,_ in pairs(HealBot_TrackUnit[8]) do
                HealBot_TrackUnit[8][x]=nil
            end 
        else
            vPetsWithPlayers=false
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6 then
            vVehicleWithPlayers=true
            for x,_ in pairs(HealBot_TrackUnit[7]) do
                HealBot_TrackUnit[7][x]=nil
            end 
        else
            vVehicleWithPlayers=false
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]<6 then
            vTargetWithPlayers=true
            for x,_ in pairs(HealBot_TrackUnit[9]) do
                HealBot_TrackUnit[9][x]=nil
            end 
        else
            vTargetWithPlayers=false
        end
        if HEALBOT_GAME_VERSION>1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]<6 then
            vFocusWithPlayers=true
            for x,_ in pairs(HealBot_TrackUnit[10]) do
                HealBot_TrackUnit[10][x]=nil
            end 
        else
            vFocusWithPlayers=false
        end
        
        if HealBot_Globals.UseCrashProt and not HealBot_retLuVars("Loaded") then
            HealBot_Panel_luVars["cpCrash"]=true
            local mbody=GetMacroBody(HealBot_Panel_luVars["cpMacro"]) or "Solo:0"
            HealBot_Panel_luVars["cpCrashType"],HealBot_Panel_luVars["cpCrashNum"] = string.split(":", mbody)
            --HealBot_Panel_luVars["cpCrashType"],HealBot_Panel_luVars["cpCrashNum"]="r","25"
            if not preCombat or HealBot_Panel_luVars["cpCrashType"]=="Solo" then
                HealBot_Panel_luVars["cpCrash"]=false
            else
                HealBot_Panel_luVars["cpCrashNum"]=tonumber(HealBot_Panel_luVars["cpCrashNum"])
            end
        end
        HealBot_Panel_PlayersChanged(preCombat)
        if not preCombat and HealBot_Globals.UseCrashProt then
            if nraid>0 then
                vCrashProtTmp="r:"..nraid
            elseif IsInGroup() then
                vCrashProtTmp="g:"..GetNumGroupMembers()
            else
                vCrashProtTmp="Solo:0"
            end
            if vCrashProtTmp~=vCrashProtData then
                vCrashProtData=vCrashProtTmp            
                local z=GetMacroIndexByName(HealBot_Panel_luVars["cpMacro"])
                if (z or 0) == 0 then
                    if GetNumMacros()<120 then
                        z = CreateMacro(HealBot_Panel_luVars["cpMacro"], "Spell_Holy_SealOfSacrifice", vCrashProtData, false)
                    end
                else
                    z = EditMacro(z, HealBot_Panel_luVars["cpMacro"], "Spell_Holy_SealOfSacrifice", vCrashProtData)
                end
            end
        end
    else
        if changeType==2 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
                for x,_ in pairs(HealBot_TrackUnit[8]) do
                    HealBot_TrackUnit[8][x]=nil
                end 
                HealBot_Panel_PetsChanged(preCombat)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
                    HealBot_ActionIcons_UpdateActiveFrame(7, true)
                else
                    HealBot_ActionIcons_UpdateActiveFrame(7, false)
                end
            else
                HealBot_ActionIcons_UpdateActiveFrame(7, false)
            end
        elseif changeType==3 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8 then
                for x,_ in pairs(HealBot_TrackUnit[9]) do
                    HealBot_TrackUnit[9][x]=nil
                end
                HealBot_Panel_TargetChanged(preCombat)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
                    HealBot_ActionIcons_UpdateActiveFrame(8, true)
                else
                    HealBot_ActionIcons_UpdateActiveFrame(8, false)
                end
            else
                HealBot_ActionIcons_UpdateActiveFrame(8, false)
            end
        elseif changeType==5 then
            for x,_ in pairs(HealBot_TrackUnit[11]) do
                HealBot_TrackUnit[11][x]=nil
            end 
            HealBot_Panel_EnemyChanged(preCombat)
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
                HealBot_ActionIcons_UpdateActiveFrame(10, true)
            else
                HealBot_ActionIcons_UpdateActiveFrame(10, false)
            end
        elseif changeType==4 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9 then
                for x,_ in pairs(HealBot_TrackUnit[10]) do
                    HealBot_TrackUnit[10][x]=nil
                end 
                HealBot_Panel_FocusChanged(preCombat)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
                    HealBot_ActionIcons_UpdateActiveFrame(9, true)
                else
                    HealBot_ActionIcons_UpdateActiveFrame(9, false)
                end
            else
                HealBot_ActionIcons_UpdateActiveFrame(9, false)
            end
        elseif changeType==1 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
                for x,_ in pairs(HealBot_TrackUnit[7]) do
                    HealBot_TrackUnit[7][x]=nil
                end 
                HealBot_Panel_VehicleChanged(preCombat)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
                    HealBot_ActionIcons_UpdateActiveFrame(6, true)
                else
                    HealBot_ActionIcons_UpdateActiveFrame(6, false)
                end
            else
                HealBot_ActionIcons_UpdateActiveFrame(6, false)
            end
        end
        if changeType>2 then
            for x,_ in pairs(hbPanel_dataExtraGUIDs) do
                hbPanel_dataExtraGUIDs[x]=nil
            end
            for xUnit,xButton in pairs(HealBot_Enemy_Button) do
                hbPanel_dataExtraGUIDs[xButton.guid]=xButton.unit
            end
            for xUnit,xButton in pairs(HealBot_Extra_Button) do
                hbPanel_dataExtraGUIDs[xButton.guid]=xButton.unit
            end
        end
    end
end

function HealBot_Panel_PrePartyChanged(preCombat, changeType)
      --HealBot_setCall("HealBot_Panel_PrePartyChanged")
    if changeType>0 then
        if changeType>5 then
            if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<6) or
               (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6) then
                HealBot_Panel_buildDataStore(true, true)
            else
                HealBot_Panel_buildDataStore(true, false)
            end
        elseif changeType==2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
            HealBot_Panel_buildDataStore(false, true)
        elseif changeType==1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
            HealBot_Panel_buildDataStore(false, true)
        end
        HealBot_Panel_DoPartyChanged(preCombat, changeType)
    else
        if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<6) or
           (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6) then
            HealBot_Panel_buildDataStore(true, true)
        else
            HealBot_Panel_buildDataStore(true, false)
        end
        if preCombat then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then 
                HealBot_Panel_buildDataStore(false, true)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then HealBot_Panel_DoPartyChanged(preCombat, 1) end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then HealBot_Panel_DoPartyChanged(preCombat, 2) end
            end
            HealBot_Panel_DoPartyChanged(preCombat, 5)
        else
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then HealBot_nextRecalcParty(1) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then HealBot_nextRecalcParty(2) end
            HealBot_nextRecalcParty(5)
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8 then HealBot_Panel_DoPartyChanged(preCombat, 3) end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9 then HealBot_Panel_DoPartyChanged(preCombat, 4) end
        HealBot_Panel_DoPartyChanged(preCombat, 6)
    end 
end

function HealBot_Panel_PartyChanged(preCombat, changeType)
      --HealBot_setCall("HealBot_Panel_PartyChanged")
    --HealBot_Action_setLuVars("CreatedButtons",0)
    --HealBot_Action_setLuVars("PartyChangedType",changeType)
    if HealBot_setTestBars then
        if not preCombat then
            HealBot_Panel_TestBarsOn()
        else
            HealBot_Panel_ToggleTestBars()
            HealBot_Action_ResetSkinAllElements()
            HealBot_Panel_PrePartyChanged(preCombat, 0)
        end
    else
        HealBot_Panel_PrePartyChanged(preCombat, changeType)
    end
end

function HealBot_Panel_Init()
      --HealBot_setCall("HealBot_Panel_Init")
    if HEALBOT_GAME_VERSION>3 then
        HealBot_randomClCol = { [0] = { ["MAX"]=11, ["TE"]=5, ["HS"]=3, ["HE"]=7}, -- Correct mana colour for 12 and 13 before setting MAX=13 - Move Evoker to 8 and set HE=8
                                [1] = { [1] = 0.77, [2] = 0.12, [3] = 0.23, [4]="DEAT", [5]=1, [6]=0, [7]=0},  
                                [2] = { [1] = 0.78, [2] = 0.61, [3] = 0.43, [4]="WARR", [5]=1, [6]=0, [7]=0},  
                                [3] = { [1] = 1,    [2] = 0.49, [3] = 0.04, [4]="DRUI", [5]=0, [6]=0, [7]=1},   
                                [4] = { [1] = 0,    [2] = 1,    [3] = 0.59, [4]="MONK", [5]=1, [6]=1, [7]=0}, 
                                [5] = { [1] = 0.96, [2] = 0.55, [3] = 0.73, [4]="PALA", [5]=0, [6]=0, [7]=1},
                                [6] = { [1] = 1,    [2] = 1,    [3] = 1,    [4]="PRIE", [5]=0, [6]=0, [7]=1},
                                [7] = { [1] = 0,    [2] = 0.44, [3] = 0.87, [4]="SHAM", [5]=0, [6]=0, [7]=1},
                                [8] = { [1] = 0.53, [2] = 0.53, [3] = 0.93, [4]="WARL", [5]=0, [6]=0, [7]=1},
                                [9] = { [1] = 0.67, [2] = 0.83, [3] = 0.45, [4]="HUNT", [5]=1, [6]=0.5, [7]=0.25},
                               [10] = { [1] = 0.25, [2] = 0.78, [3] = 0.92, [4]="MAGE", [5]=0, [6]=0, [7]=1},
                               [11] = { [1] = 1,    [2] = 0.96, [3] = 0.41, [4]="ROGU", [5]=1, [6]=1, [7]=0},
                               [12] = { [1] = 0.8,  [2] = 0.1,  [3] = 0.8,  [4]="DEMO", [5]=0, [6]=0, [7]=1},
                               [13] = { [1] = 0.22, [2] = 0.59, [3] = 0.49, [4]="EVOK", [5]=0, [6]=0, [7]=1},
                              }
        HealBot_randomClNames = { [1] = HEALBOT_DEATHKNIGHT,
                                  [2] = HEALBOT_WARRIOR,
                                  [3] = HEALBOT_DRUID,
                                  [4] = HEALBOT_MONK,
                                  [5] = HEALBOT_PALADIN,
                                  [6] = HEALBOT_PRIEST,
                                  [7] = HEALBOT_SHAMAN,
                                  [8] = HEALBOT_WARLOCK,
                                  [9] = HEALBOT_HUNTER,
                                 [10] = HEALBOT_MAGE,
                                 [11] = HEALBOT_ROGUE,
                                 [12] = HEALBOT_DEMONHUNTER,
                                 [13] = HEALBOT_EVOKER,
                                }
    elseif HEALBOT_GAME_VERSION>2 then
        HealBot_randomClCol = { [0] = { ["MAX"]=10, ["TE"]=4, ["HS"]=3, ["HE"]=6}, 
                                [1] = { [1] = 0.77, [2] = 0.12, [3] = 0.23, [4]="DEAT", [5]=1, [6]=0, [7]=0},  
                                [2] = { [1] = 0.78, [2] = 0.61, [3] = 0.43, [4]="WARR", [5]=1, [6]=0, [7]=0},  
                                [3] = { [1] = 1.0,  [2] = 0.49, [3] = 0.04, [4]="DRUI", [5]=0, [6]=0, [7]=1},   
                                [4] = { [1] = 0.96, [2] = 0.55, [3] = 0.73, [4]="PALA", [5]=0, [6]=0, [7]=1},
                                [5] = { [1] = 1.0,  [2] = 1.0,  [3] = 1.0,  [4]="PRIE", [5]=0, [6]=0, [7]=1},
                                [6] = { [1] = 0,    [2] = 0.44, [3] = 0.87, [4]="SHAM", [5]=0, [6]=0, [7]=1},
                                [7] = { [1] = 0.53, [2] = 0.53, [3] = 0.93, [4]="WARL", [5]=0, [6]=0, [7]=1},
                                [8] = { [1] = 0.67, [2] = 0.83, [3] = 0.45, [4]="HUNT", [5]=0, [6]=0, [7]=1},
                                [9] = { [1] = 0.25, [2] = 0.78, [3] = 0.92, [4]="MAGE", [5]=0, [6]=0, [7]=1},
                               [10] = { [1] = 1.0,  [2] = 0.96, [3] = 0.41, [4]="ROGU", [5]=1, [6]=1, [7]=0},
                              }
        HealBot_randomClNames = { [1] = HEALBOT_DEATHKNIGHT,
                                  [2] = HEALBOT_WARRIOR,
                                  [3] = HEALBOT_DRUID,
                                  [4] = HEALBOT_PALADIN,
                                  [5] = HEALBOT_PRIEST,
                                  [6] = HEALBOT_SHAMAN,
                                  [7] = HEALBOT_WARLOCK,
                                  [8] = HEALBOT_HUNTER,
                                  [9] = HEALBOT_MAGE,
                                 [10] = HEALBOT_ROGUE,
                                }
    else
        HealBot_randomClCol = { [0] = { ["MAX"]=9, ["TE"]=3, ["HS"]=2, ["HE"]=5}, 
                                [1] = { [1] = 0.78, [2] = 0.61, [3] = 0.43, [4]="WARR", [5]=1, [6]=0, [7]=0},  
                                [2] = { [1] = 1.0,  [2] = 0.49, [3] = 0.04, [4]="DRUI", [5]=0, [6]=0, [7]=1},   
                                [3] = { [1] = 0.96, [2] = 0.55, [3] = 0.73, [4]="PALA", [5]=0, [6]=0, [7]=1},
                                [4] = { [1] = 1.0,  [2] = 1.0,  [3] = 1.0,  [4]="PRIE", [5]=0, [6]=0, [7]=1},
                                [5] = { [1] = 0,    [2] = 0.44, [3] = 0.87, [4]="SHAM", [5]=0, [6]=0, [7]=1},
                                [6] = { [1] = 0.53, [2] = 0.53, [3] = 0.93, [4]="WARL", [5]=0, [6]=0, [7]=1},
                                [7] = { [1] = 0.67, [2] = 0.83, [3] = 0.45, [4]="HUNT", [5]=0, [6]=0, [7]=1},
                                [8] = { [1] = 0.25, [2] = 0.78, [3] = 0.92, [4]="MAGE", [5]=0, [6]=0, [7]=1},
                                [9] = { [1] = 1.0,  [2] = 0.96, [3] = 0.41, [4]="ROGU", [5]=1, [6]=1, [7]=0},
                              }
        HealBot_randomClNames = { [1] = HEALBOT_WARRIOR,
                                  [2] = HEALBOT_DRUID,
                                  [3] = HEALBOT_PALADIN,
                                  [4] = HEALBOT_PRIEST,
                                  [5] = HEALBOT_SHAMAN,
                                  [6] = HEALBOT_WARLOCK,
                                  [7] = HEALBOT_HUNTER,
                                  [8] = HEALBOT_MAGE,
                                  [9] = HEALBOT_ROGUE,
                                }
    end
end

function HealBot_Panel_ClearGUID(guid)
      --HealBot_setCall("HealBot_Panel_ClearGUID", nil, guid)
    hbPanel_dataRoles[guid]=nil
    hbPanel_dataPlayerRoles[guid]=nil
    hbPanel_dataRanks[guid]=nil
end
