 --------------------------------------------------------------------[[
--[[

remap.lua

Used to remap keys in the event Karabiner-Elements is not working.
Original code inspired from https://youtu.be/wpVNm8Ub-1s, from
https://github.com/elliotwaite.

--]]
--------------------------------------------------------------------]]
hs.hotkey.setLogLevel("warning")

local remap = {}
remap.KEYMAP = {}

remap.ORDERED_KEY_CODES = {58, 61, 55, 54, 59, 62, 56, 60}
remap.KEY_CODE_TO_KEY_STR = {
  [58] = 'leftAlt',
  [61] = 'rightAlt',
  [55] = 'leftCmd',
  [54] = 'rightCmd',
  [59] = 'leftCtrl',
  [62] = 'rightCtrl',
  [56] = 'leftShift',
  [60] = 'rightShift'
}
remap.KEY_CODE_TO_MOD_TYPE = {
  [58] = 'alt',
  [61] = 'alt',
  [55] = 'cmd',
  [54] = 'cmd',
  [59] = 'ctrl',
  [62] = 'ctrl',
  [56] = 'shift',
  [60] = 'shift'
}
remap.KEY_CODE_TO_SIBLING_KEY_CODE = {
  [58] = 61,
  [61] = 58,
  [55] = 54,
  [54] = 55,
  [59] = 62,
  [62] = 59,
  [56] = 60,
  [60] = 56
}


function remap.update_hotkey_groups()
   hotkey_groups = {}

   for _, hotkey_vals in ipairs(remap.KEYMAP) do
      local from_mods, from_key, to_mods, to_key = table.unpack(hotkey_vals)

      local to_key_stroke = function()
         hs.eventtap.keyStroke(to_mods, to_key, 0)
      end

      local hotkey = hs.hotkey.new(from_mods, from_key, to_key_stroke, nil, to_key_stroke)

      hotkey_groups[from_mods] = hotkey_groups[from_mods] or {}

      table.insert(hotkey_groups[from_mods], hotkey)
   end

   return hotkey_groups
end


function remap.update_enabled_hotkeys()
   if cur_hotkey_group ~= nil then
      for _, hotkey in ipairs(cur_hotkey_group) do
         hotkey:disable()
      end
   end

   local cur_mod_keys_str = ''
   for _, key_code in ipairs(remap.ORDERED_KEY_CODES) do
      if mod_states[key_code] then
         if cur_mod_keys_str ~= '' then
            cur_mod_keys_str = cur_mod_keys_str .. '+'
         end
         cur_mod_keys_str = cur_mod_keys_str .. remap.KEY_CODE_TO_KEY_STR[key_code]
      end
   end

   cur_hotkey_group = remap.update_hotkey_groups()[cur_mod_keys_str]
   if cur_hotkey_group ~= nil then
      for _, hotkey in ipairs(cur_hotkey_group) do
         hotkey:enable()
      end
   end
end


mod_states = {}
for _, key_code in ipairs(remap.ORDERED_KEY_CODES) do
  mod_states[key_code] = false
end


remap.mod_key_watcher = hs.eventtap.new(
   {hs.eventtap.event.types.flagsChanged},
   function(event)
      local key_code = event:getKeyCode()
      --local mod_states = remap.update_mod_states()
      if mod_states[key_code] ~= nil then
         if event:getFlags()[remap.KEY_CODE_TO_MOD_TYPE[key_code]] then
         -- If a mod key of this type is currently pressed, we can't
         -- determine if this event was a key-up or key-down event, so we
         -- just toggle the `modState` value corresponding to the event's
         -- key code.
         mod_states[key_code] = not mod_states[key_code]
      else
         -- If no mod keys of this type are pressed, we know that this was
         -- a key-up event, so we set the `modState` value corresponding to
         -- this key code to false. We also set the `modState` value
         -- corresponding to its sibling key code (e.g. the sibling of left
         -- shift is right shift) to false to ensure that the state for
         -- that key is correct as well. This code makes the `modState`
         -- self correcting. If it ever gets in an incorrect state, which
         -- could happend if some other code triggers multiple key-down
         -- events for a single modifier key, the state will self correct
         -- once all modifier keys of that type are released.
         mod_states[key_code] = false
         mod_states[remap.KEY_CODE_TO_SIBLING_KEY_CODE[key_code]] = false
      end
      remap.update_enabled_hotkeys()
   end
end)


return remap