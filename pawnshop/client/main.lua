ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local sell = {
    "Acheter",
    "Vendre"
}
local box = {
    "100 $",
    "1000 $",
    "5000 $",
    "10 000 $"
}
local function OnSelected(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
	local slide = btn.slidenum
	local btn = btn.name
	local check = btn.unkCheckbox

    if slide == 1 and btn == "Ordinateur" then
        TriggerServerEvent('PawnShop:Buy', "pc", 150)
    elseif slide == 2 and btn == "Ordinateur" then
        TriggerServerEvent('PawnShop:Sell', "pc", 80)
	end
end

local MenuPawnShop = {
	Base = { Header = {"ShopUI_Title_LowEndFashion", "ShopUI_Title_LowEndFashion"}, Color = {color_black}, HeaderColor = {255, 0, 0}, Title = "Pawn Shop"},
	Data = { currentMenu = "Shop"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Shop"] = {
			b = {
                {name = "Produits", ask = ">", askX = true},
			}
        },
        ["produits"] = {
            b = {
                {name = "Ordinateur", slidemax = sell, askX = true} --Exemple
            }
        },
	}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        for k in pairs(PawnShop.Pos) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, PawnShop.Pos[k].x, PawnShop.Pos[k].y, PawnShop.Pos[k].z)

            if distance <= 2.1 then
                ESX.ShowHelpNotification(_U('help_pawnshop'))
                if IsControlJustPressed(0, 38) then
                    CreateMenu(MenuPawnShop)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(PawnShop.Blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
