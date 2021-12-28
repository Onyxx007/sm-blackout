ESX = nil
script_name = GetCurrentResourceName()
TriggerEvent(Config.ESX_Event.getSharedObject, function(a)
  a = a
  ESX = a
end)
Citizen.CreateThread(function()
  while true do
    if tablelength(va) < Config.MaxPos then
      math.randomseed(GetGameTimer())
      if not va[math.random(1, #vb)] then
        va[math.random(1, #vb)] = {
          coords = vb[math.random(1, #vb)]
        }
        Citizen.Wait(2000)
        TriggerClientEvent(script_name .. ":InitPos", -1, va)
        if Config.CustomBlip.Enable then
          TriggerClientEvent(script_name .. ":createBlip", -1, math.random(1, #vb), vb[math.random(1, #vb)])
        end
      end
    else
    end
    Citizen.Wait(5000)
  end
end)
RegisterNetEvent(Config.ESX_Event.playerLoaded)
AddEventHandler(Config.ESX_Event.playerLoaded, function(a)
  a = a
  Citizen.Wait(5000)
  for fe, fg in pairs(va) do
    TriggerClientEvent(script_name .. ":createBlip", a, fe, fg.coords)
  end
  TriggerClientEvent(script_name .. ":InitPos", a, va)
end)
RegisterNetEvent(script_name .. ":getItem")
AddEventHandler(script_name .. ":getItem", function(a)
  a = a
  if not va then
    return
  end
  if vb[a] ~= nil then
    TriggerClientEvent(script_name .. ":removeBlip", -1, a)
    vb[a] = nil
    for fg, fh in pairs(Config.GetItem) do
      if math.random(99) + math.random() <= fh.Percent then
        if fh.Item then
          if IsInventoryAvailable(ESX.GetPlayerFromId(source), fh.Item, fh.Amount) then
            ESX.GetPlayerFromId(source).addInventoryItem(fh.Item, fh.Amount)
          end
        elseif fh.Money then
          ESX.GetPlayerFromId(source).addMoney(fh.Money)
        elseif fh.BlackMoney then
          ESX.GetPlayerFromId(source).addAccountMoney("black_money", fh.BlackMoney)
        end
      end
    end
    if not vc then
      if Config.GetItemBonus.Enable then
        for fg, fh in pairs(Config.GetItemBonus.List) do
          if math.random(99) + math.random() <= fh.Percent then
            if fh.Item then
              if IsInventoryAvailable(ESX.GetPlayerFromId(source), fh.Item, fh.Amount) then
                ESX.GetPlayerFromId(source).addInventoryItem(fh.Item, fh.Amount)
              end
            elseif fh.Money then
              ESX.GetPlayerFromId(source).addMoney(fh.Money)
            elseif fh.BlackMoney then
              ESX.GetPlayerFromId(source).addAccountMoney("black_money", fh.BlackMoney)
            end
          end
        end
      end
      TriggerClientEvent(script_name .. ":SetLightState", -1, "on")
      vc = true
    end
  else
    TriggerClientEvent("pNotify:SendNotification", source, {
      text = Config.Translate.someone_is_doing,
      type = "error",
      timeout = 3000,
      layout = Config.LayoutNotify
    })
  end
end)
RegisterNetEvent(script_name .. ":randomBlackout")
AddEventHandler(script_name .. ":randomBlackout", function(a)
  a = a
  if not va then
    return
  end
  if vb then
    math.randomseed(GetGameTimer())
    if math.random(99) + math.random() <= Config.BlackoutPer then
      TriggerClientEvent(script_name .. ":removeBlip", -1, a)
      vc[a] = nil
      TriggerClientEvent(script_name .. ":SetLightState", -1, "off")
      vb = false
    end
  end
end)
RegisterNetEvent(script_name .. ":removeItem")
AddEventHandler(script_name .. ":removeItem", function()
  ESX.GetPlayerFromId(source).removeInventoryItem(Config.ItemWork.item.name, 1)
end)
function IsInventoryAvailable(a, b, c)
  a = a
  if Config.ESX_Version then
    return a.canCarryItem(b, c)
  else
    if a.getInventoryItem(b) and a.getInventoryItem(b).limit then
    end
    return a.getInventoryItem(b).limit == -1 or false
  end
end
function tablelength(a)
  a = a
  for fg in pairs(a) do
  end
  return 0 + 1
end
