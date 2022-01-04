Approved_Vehicles = {
    'fpiu4',
    'cvpi1',
    'fpis1',
    'charger3',
    'tahoe2',
    'charger2',
    'ram1',
    'fpiu2',
    'cvpi2',
    'charger4',
    'tahoe1',
    'fpiu1',
    'charger1',
    'fpis2',
    'ram2',
    'camp16',
    'polar1',
    'um20silv',
    'um18durango',
    'um18chrg',
    'PD8',
    'PD1',
    'PD3',
    'PD2',
    'PD5',
    'PD4',
    'PD7',
    'PD6',
    'so1',
    'so2',
    'so3',
    'so4',
    'so5',
    'so6',
    'so7',
    'um17raptor',
    'um20fpiu',
    'um14chrg',
    'lcso1',
    'lcso2',
    'lcso3',
    'lcso4',
    'lcso5',
    'tru2',
    'sru1',
    'dps14charger',
    'dpsfpis',
    'dps3',
    'dpsfpiu',
    'tahoedps',
    'dps18charg',
    'dps6',
    'dps14chargerst',
    'dps4',
    'dps2',
    'dps5',
    'dpsfpiust',
    'dps18chargerst',
    'dpsfpisst',
    'dps1',
    'so20',
    'so21',
    'um19tundra',
    'um18stang',
    'um16fpiu',
    'um20tahoe',
    'chpvic',
    'chp1',
    'chp2',
    'chp3',
    'chp4',
    'chp5',
    'chp6',
    'hpun',
    '',
}

RegisterCommand('ptimer', function()
    if isTimerActive then
        TriggerEvent('chatMessage', "Pit Timer is on");

    else
        TriggerEvent('pit_timer')
    end
end)

RegisterNetEvent('pit_timer')
AddEventHandler('pit_timer', function()
    isTimerActive = true
    if isTimerActive then
        if isTimerOn then
            TriggerEvent('chatMessage', "Pit Timer is on");
        else
            isTimerOn = true
            TriggerEvent('chatMessage', "Pit Timer started");
            Citizen.Wait(180000)
            TriggerEvent('chatMessage', "Pit Timer ended | Proced with Pit");
            isTimerOn = false
            s = 00
            m = 3
        end
    end
    isTimerActive = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local vehicle = GetPlayersLastVehicle(PlayerPedId)
        local carModel = GetEntityModel(vehicle)
        local carName = GetDisplayNameFromVehicleModel(carModel)
        local isVehicleAllowed 
        for _, allowed_car in pairs(Approved_Vehicles) do
            if carModel == GetHashKey(allowed_car) then
                isVehicleAllowed = true
            end
        end
        if isTimerActive then
            if IsPedInVehicle(PlayerPedId(-1), vehicle, true) then
                if isVehicleAllowed then
                    DrawText2("Pit Timer: ".. m .. ":" .. s )
                end
            end
        end
    end
end)

s = 00
m = 3

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isTimerActive then
            Citizen.Wait(1000)
            if s == 00 then
                s = 60 
                m = m - 1 
            end
            s = s - 1 
        end
    end
end)

function DrawText2(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.3)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.935, 0.05)
end