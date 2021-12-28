Config = {}


Config["ESX_Event"] = {
    ["getSharedObject"] = 'esx:getSharedObject',
    ["playerLoaded"] = 'esx:playerLoaded'
}

Config["ESX_Version"] = true    --  new Verion 1.2 + หรือ weight เปิด true

Config["vMenuSyncWeather"] = true   -- เมื่อใช้ Vmenu ให้เปิดเป็น true

Config["MaxPos"]        =   10 -- Limit จำนวน ที่สามารถ ซ่อม ได้
Config["BlackoutPer"]   =   70 -- % ในการไฟดับเมื่อ ซ่อม fail
Config["PressKey"]      =   38 -- ปุ่มที่กด E
Config["DisplayShake"]  =   0.5 -- ความสั่นของหน้าจอเมื่อ เกิดการระเบิด


Config["DistanceShow"] = {  -- ระยะในการมองเห็น
    show_text3d = 10.0, -- ระยะในการมองเห็น Text3d
    show_press  = 2.5   -- ระยะที่สามารถกด ปุ่มที่กำหนดเพื่อทำงานได้
}

Config["CustomBlip"] = {
    Enable  = true,     -- เปิด / ปิด
    Sprite  = 354,      -- รูปแบบ Vlip
    Scale   = 0.85,     -- ขนาด Blip
    Colour  = 5,        -- สี Blip
    Text    = "Breaker", -- ชื่อ Blip
}

Config["ItemWork"] = {
    Enable = true,      -- เปิด / ปิด อุปกรฯ์ในการทำงาน
    item = {name = "bread", label = "ขนมปัง"}, -- ชื่อ Item
    IsRemove = true    -- ให้ลบ item มือทำการซ่อมไฟ
}

Config["PlayGame"] = {
    ["Enable"] = true,  -- เปิด / ปิด Miniganme
    ["Minigame"] = function()
        local Result = exports['xzero_skillcheck']:startGameSync({
            textTitle           = "ซ่อมตู้ไฟ", -- ข้อความที่แสดง
            speedMin            = 15,         -- ความเร็วสุ่มตั้งแต่เท่าไหร่  (ยิ่งน้อยยิ่งเร็ว)
            speedMax            = 20,         -- ความเร็วสุ่มถึงเท่าไหร่    (ยิ่งน้อยยิ่งเร็ว)
            countSuccessMax     = 1,          -- กำหนดจำนวนครั้งที่สำเร็จ (เมื่อถึงเป้าจะ success)
            countFailedMax      = 3,          -- กำหนดจำนวนครั้งที่ล้มเหลว (เมื่อถึงเป้าจะ failed)
        })
        if Result.status then
            return true
        else
            return false
        end
    end
}
Config["DrawText3D"] = function(coords)
    DrawText3D(coords.x, coords.y, coords.z + 0.8, "กด [~o~E~s~] เพื่อซ่อมตู้ไฟฟ้า")
end


Config["setTingonSuccess"] = {
    ["Timeduration"] = 5000, -- เวลาในการขโมยสาบไฟ
    ["TextLable"] = "กำลังตัดสายไฟ",
    ["processbar"] = function(time, text)
        exports['mythic_progbar']:Progress({
            name = "unique_action_name",
            duration = time,
            label = text,
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }
        })
        RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do Citizen.Wait(0) end
        Wait(100)
        TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 49, 0, false, false, false)
    end,
}

Config["GetItem"] = {
    {
        Item = "water",
        Amount = 1,
        Percent = 100,
    },
    {
        Money = 1000,
        Percent = 100,
    },
    {
        BlackMoney = 1000,
        Percent = 100,
    },
}


Config["GetItemBonus"] = {   ---ไอเทมพิเศษ หากซ่อมเวลาไฟดับ
    ["Enable"] = true,
    ["List"] = {
        {
            Item = "phone",
            Amount = 1,
            Percent = 100,
        },
        {
            Money = 10000,
            Percent = 100,
        },
        {
            BlackMoney = 10000,
            Percent = 100,
        },
    } 
}