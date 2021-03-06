-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
	In game macro to change Instrument Mode:
	/console gs c cycle InstrumentMode
--]]

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	include('organizer-lib')

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	--state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}
	state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

	-- For tracking current recast timers via the Timers plugin.
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT')
	state.useMidcastGear    = M(false, 'Equip midcast gear on precast')

	--state.InstrumentMode:options('Gjallarhorn', 'Daurdabla')
	state.InstrumentMode = M{['description']='Instrument Mode', 'Normal', 'Gjallarhorn', 'Daurdabla'}

	brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
	pick_tp_weapon()
	
	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2
	
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main="Oranyan",sub="Clerisy Strap",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +1",hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet=""}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.BardSong = set_combine(sets.precast.FC,
		{main="Oranyan",range="Daurdabla",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Anhur Robe",hands="Gendewitha Gages +1",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Doyen Pants",feet="Bihu Slippers"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range="Daurdabla"})
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {range="Gjallarhorn",
		head="Nahtirah Hat",
		body="Gendewitha Bliaut",hands="Buremte Gloves",
		back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range="Gjallarhorn",
		head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bihu Justaucorps +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS)

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)

	sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
	
	
	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {range="Angel Lyre",
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Perimede Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
		
	-- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
	sets.midcast.Ballad = {legs="Aoidos' Rhing. +2"}
	sets.midcast.Lullaby = {hands="Brioso Cuffs"}
	sets.midcast.Madrigal = {head="Aoidos' Calot +2"}
	sets.midcast.March = {hands="Aoidos' Manchettes +2"}
	sets.midcast.Minuet = {body="Aoidos' Hongreline +2"}
	sets.midcast.Minne = {}
	sets.midcast.Paeon = {head="Brioso Roundlet"}
	sets.midcast.Carol = {head="Aoidos'' Calot +2",
		body="Aoidos' Hongreline +2",hands="Aoidos' Manchettes +2",
		legs="Aoidos' Rhing. +2",feet="Aoidos' Cothrn. +2"}
	sets.midcast["Sentinel's Scherzo"] = {feet="Aoidos' Cothrn. +2"}
	sets.midcast['Magic Finale'] = {neck="Incanter's torque",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

	sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
	sets.midcast.HonorMarch = {range="Marsyas",hands="Aoidos' Manchettes +1"}
	sets.Marsyas = {range="Marsyas",ammo=empty}
	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {range="Daurdabla",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear1="Etiolation earring",ear2="Loquacious Earring",
		body="Aoidos' Hongreline +2",hands="Aoidos' Manchettes +2",ring1="Prolix Ring",ring2="Weatherspoon Ring",
		back="Swith Cape +1",waist="Porous Rope",legs="Inyanga Shalwar +1",feet="Brioso Slippers"}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main="Carnwenhan",sub="Clerisy Strap",range="Gjallarhorn",
		head="Brioso Roundlet +1",neck="Aoidos' Matinee",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
		back="Kumbira Cape",waist="Goading Belt",legs="Inyanga Shalwar +1",feet="Brioso Slippers +1"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = {main="Carnwenhan",sub="Clerisy Strap",range="Gjallarhorn",
		head="Brioso Roundlet +1",neck="Wind Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Brioso Justaucorps +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
		back="Kumbira Cape",waist="Demonry Sash",legs="Brioso Cannions +1",feet="Bokwus Boots"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Harmony Cape",waist="Corvax Sash",legs="Fil Rhing. +1"}

	--sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range="Daurdabla"}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = {main="Carnwenhan",range="Daurdabla",
		head="Nahtirah Hat",neck="Wind Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Brioso Justaucorps +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
		back="Swith Cape +1",waist="Goading Belt",legs="Gendewitha Spats",feet="Bokwus Boots"}

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Arka IV",sub='Achaq Grip',
		head="Gendewitha Caubeen",
		body="Gendewitha Bliaut",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Haoma's Ring",
		legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.midcast.Stoneskin = {
		head="Nahtirah Hat",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",
		legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
		
	sets.midcast.Cursna = {
		neck="Malison Medallion",
		hands="Hieros Mittens",ring1="Ephedra Ring"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP, 
		body="Gendewitha Bliaut",
		legs="Nares Trews",feet="Chelona Boots +1"}
	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Oranyan", sub="Irenic Strap",range="Daurdabla",
		head="Inyanga Tiara +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
		body="Inyanga Jubbah +1",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Inyanga crackows +1"}

	sets.idle.PDT = {main="Oranyan", sub="Irenic Strap",range="Daurdabla",
		head="Inyanga Tiara +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
		body="Inyanga Jubbah +1",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Inyanga crackows +1"}

	sets.idle.Town = {main="Oranyan", sub="Irenic Strap",range="Daurdabla",
		head="Inyanga Tiara +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
		body="Inyanga Jubbah +1",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Inyanga crackows +1"}
	
	sets.idle.Weak = {main="Oranyan", sub="Irenic Strap",range="Daurdabla",
		head="Inyanga Tiara +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
		body="Inyanga Jubbah +1",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Inyanga crackows +1"}
	
	
	-- Defense sets
	sets.defense.PDT = {main="Mafic Cudgel", sub="Genmei Shield",range="Daurdabla",
		head="Inyanga Tiara +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
		body="Vrikodara Jupon",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Inyanga crackows +1"}

	sets.defense.MDT = {main="Oranyan", sub="Irenic Strap",range="Daurdabla",
		head="Inyanga Tiara +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
		body="Inyanga Jubbah +1",hands="Inyanga Dastanas +1",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Inyanga crackows +1"}

	sets.Kiting = {feet="Fili Cothurnes +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {range="Angel Lyre",
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bihu Justaucorps +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}

	-- Sets with weapons defined.
	sets.engaged.Dagger = {range="Angel Lyre",
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bihu Justaucorps +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}

	-- Set if dual-wielding
	sets.engaged.DW = {range="Angel Lyre",
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Bihu Justaucorps +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		if spell.english == 'Honor March' then
			equip(sets.Marsyas)
			eventArgs.handled = true
		end
		if buffactive['Nightingale'] or buffactive['Troubadour'] then
			state.useMidcastGear:set('true')
		end
	end
	if not buffactive['Nightingale'] and not buffactive['Troubadour'] then
		state.useMidcastGear:reset()
	end
end

function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		if spell.english == 'Honor March' then
			equip(sets.precast.FC.BardSong,sets.Marsyas)
			eventArgs.handled = true  
        end      
		-- Auto-Pianissimo
		if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
			not state.Buff['Pianissimo'] then
			
			local spell_recasts = windower.ffxi.get_spell_recasts()
			if spell_recasts[spell.recast_id] < 2 then
				send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			end
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if spell.type == 'BardSong' then
			-- layer general gear on first, then let default handler add song-specific gear.
			local generalClass = get_song_class(spell)
			if generalClass and sets.midcast[generalClass] then
				equip(sets.midcast[generalClass])
			end
		end
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.english == 'Honor March' then
		equip(sets.Marsyas)
	end
end


-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
-- function job_aftercast(spell, action, spellMap, eventArgs)
--     if spell.type == 'BardSong' and not spell.interrupted then
--         if spell.target and spell.target.type == 'SELF' then
--             adjust_timers(spell, spellMap)
--         end
--     end
-- end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Offense Mode' then
		if newValue == 'Normal' then
			disable('main','sub','ammo')
		else
			enable('main','sub','ammo')
		end
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- function job_buff_change(buff, gain)
-- 	if (buff == 'Nightingale' or buff == 'Troubadour') and not gain then
-- 		if not (buffactive['Nightingale'] or buffactive['Troubadour']) then
-- 			state.useMidcastGear:set('false')
-- 		end
-- 	end
-- end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	pick_tp_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	
	return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
	-- Can't use spell.targets:contains() because this is being pulled from resources
	if set.contains(spell.targets, 'Enemy') then
		if state.CastingMode.value == 'Resistant' then
			return 'ResistantSongDebuff'
		else
			return 'SongDebuff'
		end
	elseif state.InstrumentMode.value == 'Daurdabla' then
		return 'DaurdablaDummy'
	else
		return 'SongEffect'
	end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
-- function adjust_timers(spell, spellMap)
--     if state.UseCustomTimers.value == false then
--         return
--     end
	
--     local current_time = os.time()
	
--     -- custom_timers contains a table of song names, with the os time when they
--     -- will expire.
	
--     -- Eliminate songs that have already expired from our local list.
--     local temp_timer_list = {}
--     for song_name,expires in pairs(custom_timers) do
--         if expires < current_time then
--             temp_timer_list[song_name] = true
--         end
--     end
--     for song_name,expires in pairs(temp_timer_list) do
--         custom_timers[song_name] = nil
--     end
	
--     local dur = calculate_duration(spell.name, spellMap)
--     if custom_timers[spell.name] then
--         -- Songs always overwrite themselves now, unless the new song has
--         -- less duration than the old one (ie: old one was NT version, new
--         -- one has less duration than what's remaining).
		
--         -- If new song will outlast the one in our list, replace it.
--         if custom_timers[spell.name] < (current_time + dur) then
--             send_command('timers delete "'..spell.name..'"')
--             custom_timers[spell.name] = current_time + dur
--             send_command('timers create "'..spell.name..'" '..dur..' down')
--         end
--     else
--         -- Figure out how many songs we can maintain.
--         local maxsongs = 2
--         if player.equipment.range == "Daurdabla" then
--             maxsongs = maxsongs + info.ExtraSongs
--         end
--         if buffactive['Clarion Call'] then
--             maxsongs = maxsongs + 1
--         end
--         -- If we have more songs active than is currently apparent, we can still overwrite
--         -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
--         if maxsongs < table.length(custom_timers) then
--             maxsongs = table.length(custom_timers)
--         end
		
--         -- Create or update new song timers.
--         if table.length(custom_timers) < maxsongs then
--             custom_timers[spell.name] = current_time + dur
--             send_command('timers create "'..spell.name..'" '..dur..' down')
--         else
--             local rep,repsong
--             for song_name,expires in pairs(custom_timers) do
--                 if current_time + dur > expires then
--                     if not rep or rep > expires then
--                         rep = expires
--                         repsong = song_name
--                     end
--                 end
--             end
--             if repsong then
--                 custom_timers[repsong] = nil
--                 send_command('timers delete "'..repsong..'"')
--                 custom_timers[spell.name] = current_time + dur
--                 send_command('timers create "'..spell.name..'" '..dur..' down')
--             end
--         end
--     end
-- end

-- -- Function to calculate the duration of a song based on the equipment used to cast it.
-- -- Called from adjust_timers(), which is only called on aftercast().
-- function calculate_duration(spellName, spellMap)
--     local mult = 1
--     if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
--     if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
	
--     if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
--     if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
--     if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
--     if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
--     if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
--     if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
--     if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
--     if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	
--     if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
--     if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
--     if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
--     if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
--     if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
--     if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
--     if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
	
--     if buffactive.Troubadour then
--         mult = mult*2
--     end
--     if spellName == "Sentinel's Scherzo" then
--         if buffactive['Soul Voice'] then
--             mult = mult*2
--         elseif buffactive['Marcato'] then
--             mult = mult*1.5
--         end
--     end
	
--     local totalDuration = math.floor(mult*120)

--     return totalDuration
-- end

-- Function to reset timers.
-- function reset_timers()
--     for i,v in pairs(custom_timers) do
--         send_command('timers delete "'..i..'"')
--     end
--     custom_timers = {}
-- end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
	if brd_daggers:contains(player.equipment.main) then
		state.CombatWeapon:set('Dagger')
		
		if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
			state.CombatForm:set('DW')
		else
			state.CombatForm:reset()
		end
	else
		state.CombatWeapon:reset()
		state.CombatForm:reset()
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(2, 18)
end


-- windower.raw_register_event('zone change',reset_timers)
-- windower.raw_register_event('logout',reset_timers)

