script_name = GetCurrentResourceName()
Blip = {}
ESX = nil
Position = {}
RegisterNetEvent(script_name .. ":InitPos")
AddEventHandler(script_name .. ":InitPos", function(a)
  a = a
  Position = a
end)
Citizen.CreateThread(function()
  while true do
    for fj, fk in pairs(Position) do
      if GetDistanceBetweenCoords(GetEntityCoords((PlayerPedId())), fk.coords.x, fk.coords.y, fk.coords.z, true) < Config.DistanceShow.show_text3d then
        Config.DrawText3D(fk.coords)
        if GetDistanceBetweenCoords(GetEntityCoords((PlayerPedId())), fk.coords.x, fk.coords.y, fk.coords.z, true) < Config.DistanceShow.show_press and IsControlJustPressed(0, Config.PressKey) and IsPedOnFoot((PlayerPedId())) then
          if Config.ItemWork.Enable then
            if checkHasItem(Config.ItemWork.item.name) then
              if Config.ItemWork.IsRemove then
                TriggerServerEvent(script_name .. ":removeItem")
              end
              if Config.PlayGame.Enable then
                if Config.PlayGame.Minigame() then
                  Config.setTingonSuccess.processbar(Config.setTingonSuccess.Timeduration, Config.setTingonSuccess.TextLable)
                  Citizen.Wait(Config.setTingonSuccess.Timeduration)
                  TriggerServerEvent(script_name .. ":getItem", fj)
                  Citizen.Wait(3000)
                else
                  FailGame()
                  TriggerServerEvent(script_name .. ":randomBlackout", fj)
                end
              else
                TriggerServerEvent(script_name .. ":getItem", fj)
                Citizen.Wait(3000)
              end
            else
              TriggerEvent("pNotify:SendNotification", {
                text = Config.Translate.need_itemwork:format(Config.ItemWork.item.label),
                type = "error",
                timeout = 5000,
                layout = Config.LayoutNotify
              })
            end
          elseif Config.PlayGame.Enable then
            if Config.PlayGame.Minigame() then
              Config.setTingonSuccess.processbar(Config.setTingonSuccess.Timeduration, Config.setTingonSuccess.TextLable)
              Citizen.Wait(Config.setTingonSuccess.Timeduration)
              TriggerServerEvent(script_name .. ":getItem", fj)
              Citizen.Wait(3000)
            else
              FailGame()
              TriggerServerEvent(script_name .. ":randomBlackout", fj)
            end
          else
            TriggerServerEvent(script_name .. ":getItem", fj)
            Citizen.Wait(3000)
          end
        end
      end
    end
    if true then
    else
    end
    Citizen.Wait(500)
  end
end)
RegisterNetEvent(script_name .. ":SetLightState")
AddEventHandler(script_name .. ":SetLightState", function(a)
  a = a
  if not va then
    return
  end
  if Config.vMenuSyncWeather then
    if a == "off" then
      PlaySound(tonumber(-1), "Jet_Explosions", "exile_1", tonumber(0), tonumber(0), tonumber(0))
      ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", Config.DisplayShake)
      Wait(500)
      PlaySoundFrontend(tonumber(-1), "Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
      Citizen.Wait(500)
      StopGameplayCamShaking(true)
      Citizen.Wait(1500)
      TriggerServerEvent("vMenu:UpdateServerWeather", "CLEAR", true, false, false)
    elseif a == "on" then
      TriggerServerEvent("vMenu:UpdateServerWeather", "CLEAR", false, false, false)
    end
  elseif a == "off" then
    PlaySound(tonumber(-1), "Jet_Explosions", "exile_1", tonumber(0), tonumber(0), tonumber(0))
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", Config.DisplayShake)
    Wait(500)
    PlaySoundFrontend(tonumber(-1), "Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
    Citizen.Wait(500)
    StopGameplayCamShaking(true)
    Citizen.Wait(1500)
    SetArtificialLightsState(true)
  elseif a == "on" then
    SetArtificialLightsState(false)
  end
end)
RegisterNetEvent(script_name .. ":createBlip")
AddEventHandler(script_name .. ":createBlip", function(a, b)
  a = a
  if not va then
    return
  end
  Blip[a] = AddBlipForCoord(b.x, b.y, b.z)
  SetBlipSprite(Blip[a], Config.CustomBlip.Sprite)
  SetBlipDisplay(Blip[a], 4)
  SetBlipScale(Blip[a], Config.CustomBlip.Scale)
  SetBlipColour(Blip[a], Config.CustomBlip.Colour)
  SetBlipAsShortRange(Blip[a], true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(Config.CustomBlip.Text)
  EndTextCommandSetBlipName(Blip[a])
end)
RegisterNetEvent(script_name .. ":removeBlip")
AddEventHandler(script_name .. ":removeBlip", function(a)
  a = a
  if not va then
    return
  end
  Position[tonumber(a)] = nil
  Citizen.Wait(250)
  RemoveBlip(Blip[tonumber(a)])
  Citizen.Wait(250)
  Blip[tonumber(a)] = nil
end)
function tablelength(a)
  a = a
  for fg in pairs(a) do
  end
  return 0 + 1
end
function checkHasItem(a)
  a = a
  for fg = 1, #ESX.GetPlayerData().inventory do
    if a == ESX.GetPlayerData().inventory[fg].name and ESX.GetPlayerData().inventory[fg].count > 0 then
      return true
    end
  end
  return false
end
