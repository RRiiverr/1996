local pitch = ui.reference("AA", "Anti-aimbot angles", "pitch")
local base = ui.reference("AA", "Anti-aimbot angles", "yaw base")
local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "yaw")
local jitter, jitter_slider = ui.reference("AA", "Anti-aimbot angles", "yaw jitter")
local body, body_slider = ui.reference("AA", "Anti-aimbot angles", "body yaw")
local body_fr = ui.reference("AA", "Anti-aimbot angles", "freestanding body yaw")
local lby = ui.reference("AA", "Anti-aimbot angles", "lower body yaw target")
local fake = ui.reference("AA", "Anti-aimbot angles", "fake yaw limit")
local legss = ui.reference("AA", "Other", "leg movement")
local mindmg = ui.reference("Rage", "Aimbot", "minimum damage")
local fl_sl = ui.reference("AA", "fake lag", "limit")
local fl_var = ui.reference("AA", "fake lag", "Variance")
local fd = ui.reference("Rage", "Other", "Duck peek assist")
local screen1, screen2 = client.screen_size()
local center1, center2 = screen1 / 2, screen2 / 2
local last = 0
local last1 = 0
local last2 = 0
local last3 = 0
local last4 = 0
local last5 = 0

local label1 = ui.new_label("AA", "Anti-aimbot angles", "-------------------------------------------------")
local label2 = ui.new_label("AA", "Anti-aimbot angles", " ")
local label3 = ui.new_label("AA", "Anti-aimbot angles", "  [Spooky]  ")
local spooeky = ui.new_checkbox("AA", "Anti-aimbot angles", "Lets get spooky!")

local preset = ui.new_checkbox("AA", "Anti-aimbot angles", "-- presets --")
local combo = ui.new_combobox("AA", "Anti-aimbot angles", "preset anti-aims", {"nothing", "spooky", "frightening", "anxious"})
local label4 = ui.new_label("AA", "Anti-aimbot angles", " ")
local label5 = ui.new_label("AA", "Anti-aimbot angles", " [Spooky others] ")
local fake_c = ui.new_checkbox("AA", "Anti-aimbot angles", "fake jitter")
local jitter_c = ui.new_checkbox("AA", "Anti-aimbot angles", "jittering of thy jitter")
local lby_c = ui.new_checkbox("AA", "Anti-aimbot angles", "lby jitter")
local legs = ui.new_checkbox("AA", "Anti-aimbot angles", "leg jitter")
local boddy = ui.new_checkbox("AA", "Anti-aimbot angles", "body yaw switcher")
local yaw_c = ui.new_checkbox("AA", "Anti-aimbot angles", "yaw jitter")


local label6 = ui.new_label("Rage", "Aimbot", " ")
local dmg_c = ui.new_checkbox("Rage", "Aimbot", "Overide")
local hot_dmg = ui.new_hotkey("Rage", "Aimbot", "Overide key")
local rs_dmg = ui.new_slider("Rage", "Aimbot", "Reset min dmg", 1, 101, 20)
local new_dmg = ui.new_slider("Rage", "Aimbot", "Overide min dmg", 1, 101, 20)

local dmg = ui.new_checkbox("AA", "Anti-aimbot angles", "damage indicator")
local label_text = ui.new_checkbox("AA", "Anti-aimbot angles", "indicators")
local color = ui.new_color_picker("AA", "Anti-aimbot angles", 255, 255, 255)
local r, g, b, a = 255, 255, 255, 255
local r1, g1, b1, a1 = 0, 0, 0, 100
local r2, g2, b2, a2 = 225, 225, 225, 225
local r3, g3, b3, a3 = 150, 200, 60, 225


local function setTableVisibility(table, state)
  for i=1, #table do
      ui.set_visible(table[i], state)
  end
end

local function handleGUI() 
  local enabled = ui.get(spooeky) 
  setTableVisibility({preset, combo, label4, label5, fake_c, jitter_c, lby_c, legs, boddy, yaw_c, label6, dmg_c, hot_dmg, rs_dmg, new_dmg, dmg, label_text, color}, enabled)
end


client.set_event_callback("paint", function(presets)
    if ui.get(spooeky and preset) then
      if ui.get(combo) == "spooky" then
        ui.set(pitch, "default")
        ui.set(base, "local view")
        ui.set(yaw_slider, -4)
      elseif ui.get(combo) == "frightening" then
        ui.set(pitch, "default")
        ui.set(base, "at targets")
        ui.set(yaw_slider, 6)
      elseif ui.get(combo) == "anxious" then
        ui.set(pitch, "minimal")
        ui.set(base, "at targets")
        ui.set(yaw_slider, -8)
      end
    end
end)


client.set_event_callback("paint", function(randomizers)
    if ui.get(spooeky) then
        local cur = globals.curtime()
        if ui.get(fake_c) then
            if (cur > last) then
                local frick = math.random(10, 50)
                if frick <= 40 then
                    ui.set(fake, (frick * 1.2))
                    last = cur + 0.3
                elseif (frick <= 20) and (frick >= 39) then
                    ui.set(fake, ((frick * 1.3) / 2))
                    last = cur + 0.25
                elseif frick <= 19 then
                    ui.set(fake, (frick * 2.2))
                    last = cur + 0.2
                end
            end
        end

        if ui.get(jitter_c) then
            if (cur > last1) then
                local frick = math.random(1, 2)
                local frick1 = math.random(-3, 3)
                if frick == 1 then
                    ui.set(jitter, "offset")
                    ui.set(jitter_slider, (frick1 * 2))
                    last1 = cur + 0.3
                else
                    ui.set(jitter, "center")
                    ui.set(jitter_slider, (frick1 * 1.5))
                end
            end
        end

        if ui.get(lby_c) then
            if (cur > last2) then
                frick = math.random(1, 3)
                if frick == 1 then
                    ui.set(lby, "off")
                    last2 = cur + 0.6
                else
                    ui.set(lby, "eye yaw")
                    last2 = cur + 0.6
                end
            end
        end

        if ui.get(boddy) then
            ui.set(body_fr, true)
            if (cur > last3) then
                local frick = math.random(-100, 100)
                local frick1 = math.random(1, 3)
                if (frick <= 54)  and (frick >= -54)then
                    ui.set(body_slider, (frick * (frick1 * 0.5)))
                else
                    ui.set(body_slider, (frick / frick1))
                end
                if frick1 == 1 then
                    ui.set(body, "jitter")
                    last3 = cur + 0.1
                else
                    ui.set(body, "static")
                    last3 = cur + 0.4
                end
            end
        end

        if ui.get(legs) then
            if (cur > last4) then
              local fricker = math.random(0, 3)
              if fricker <= 2 then
                ui.set(legss, "never slide")
                last4 = cur + 0.01
              end
              if fricker == 1 then
                ui.set(legss, "always slide")
                last4 = cur + 0.01
              end
            end
        end

        if ui.get(yaw_c) then
            local frick = math.random(1, 3)
            local frick1 = math.random(-4, -4)
            if (cur > last5) then
                if frick == 1 then 
                    ui.set(yaw, "180 Z")
                    ui.set(yaw_slider, frick1)
                    last5 = cur + 0.3
                else
                    ui.set(yaw, "180")
                    ui.set(yaw_slider, frick1)
                    last5 = cur + 0.5
                end
            end
        end
    end
end)



client.set_event_callback("paint", function(damage)
    if ui.get(dmg_c) then
        if ui.get(hot_dmg) == true then
            ui.set(mindmg, (ui.get(new_dmg)))
        else
            ui.set(mindmg, (ui.get(rs_dmg)))
        end
    else
        return
    end
end)

client.set_event_callback("paint", function (indicator)
    if ui.get(spooeky) then
      if ui.get(label_text) then
        renderer.text(center1 + 2, center2 + 20, r, g, b, 255, "cb", 0, "Spooky v2")
      else
        renderer.text(center1 + 2, center2 + 20, r1, g1, b1, a1, "cb", 0, "Spooky v2")
      end
      if ui.get(boddy) then
        renderer.text(center1 + 2, center2 + 32, r, g, b, 255, "c", 0, "switcher")
      else
        renderer.text(center1 + 2, center2 + 32, r1, g1, b1, a1, "c", 0, "switcher")
      end
      if ui.get(jitter_c) then
        renderer.text(center1 + 2, center2 + 44, r, g, b, 255, "c", 0, "jitter")
      else
        renderer.text(center1 + 2, center2 + 44, r1, g1, b1, a1, "c", 0, "jitter")
      end
      if ui.get(fake_c) then
        renderer.text(center1 + 2, center2 + 56, r, g, b, 255, "c", 0, "fake")
      else
        renderer.text(center1 + 2, center2 + 56, r1, g1, b1, a1, "c", 0, "fake")
      end
      if ui.get(yaw_c) then
        renderer.text(center1 + 2, center2 + 68, r, g, b, 255, "c", 0, "yaw")
      else
        renderer.text(center1 + 2, center2 + 68, r1, g1, b1, a1, "c", 0, "yaw")
      end
      if ui.get(lby_c) then
        renderer.text(center1 + 2, center2 + 80, r, g, b, 255, "c", 0, "lby")
      else
        renderer.text(center1 + 2, center2 + 80, r1, g1, b1, a1, "c", 0, "lby")
      end
      if ui.get(dmg) then
        if ui.get(hot_dmg) == true then
          renderer.text(center1 - 925, center2 + 240, r3, g3, b3, a3, "cb+", 0, "DMG")
          renderer.text(center1 - 925, center2 + 260, r3, g3, b3, a3, "cb+", 0, (ui.get(mindmg)))
        else
          renderer.text(center1 - 925, center2 + 240, r2, g2, b2, a2, "cb+", 0, "DMG")
          renderer.text(center1 - 925, center2 + 260, r2, g2, b2, a2, "cb+", 0, (ui.get(mindmg)))
        end
      else
        return
      end
    else
      return
    end
end)
client.set_event_callback("paint_ui", handleGUI)