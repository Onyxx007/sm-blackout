RegisterFontFile('sarabun')
fontId = RegisterFontId('sarabun')

function FailGame()
	local ragdoll = false
	ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
	RequestAnimDict("weapon@w_pi_stungun")
	while (not HasAnimDictLoaded("weapon@w_pi_stungun")) do Citizen.Wait(0) end
	Wait(100)
	TaskPlayAnim(PlayerPedId(), "weapon@w_pi_stungun", "damage", 8.0, 8.0, -1, 50, 0, false, false, false)

	local particleDictionary = "core"
	local particleName = "ent_sht_electrical_box"

	RequestNamedPtfxAsset(particleDictionary)
	while not HasNamedPtfxAssetLoaded(particleDictionary) do
	Citizen.Wait(0)
	end

	SetPtfxAssetNextCall(particleDictionary)
	effect = StartParticleFxLoopedOnEntity(particleName, PlayerPedId(), 0.0, 0.9, 0.0, 0.0, 0.0, 0.0, 1.5, 0, 0, 0)

	Citizen.Wait(1000)
	ragdoll = true

	Citizen.CreateThread(function()
		while ragdoll do
			Citizen.Wait(0)
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
		end
	end)

	TriggerEvent("pNotify:SendNotification", {
		text = Config["Translate"].this_fail,
		type = "error",
		timeout = 5000,
		layout = Config["LayoutNotify"]
	})   

	Citizen.Wait(3000)
	ClearPedTasks(PlayerPedId())
	StopGameplayCamShaking(true)
	ragdoll = false
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y= World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.45, 0.45)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 400
    DrawRect(_x,_y+0.0250, 0.015+ factor, 0.06, 0, 0, 0, 68)
end
