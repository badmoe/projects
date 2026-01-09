--- Filter Title: badman basic
--- Filter Type: (Basic)
--- Filter Description: freestyling this as we go
--- Filter Link: https://raw.githubusercontent.com/badmoe/projects/refs/heads/master/server-utilities/d2/badfilter.lua
return {
    reload = "{purple}Badfilter {grey}(v1.1.1.1)",
    language = "enUS",
    allowOverrides = true,
    filter_level = 2,
    filter_titles = { "1", "2" },
    rules = (function()

        ----------------
        -- Toggles    --
        ----------------
        local opt_class_tags        = 1 -- class item tags (ex: (B) for barb items)
        local opt_ethereal_tag      = 1 -- ethereal tag (e)
        local opt_ilvl_tags         = 1 -- ilvl tags
        local opt_socket_count      = 1 -- socket count tags
        local opt_charm_ring_amu    = 1 -- charm/ring/amulet tags
        local opt_hide_junk         = 1 -- hide junk / consumables
        local opt_hide_low_pots     = 1 -- hide low tier health/mana potions by level
        local opt_pal_shield_res    = 1 -- paladin shields all res tag
        local opt_runes             = 1 -- rune value tags for storage bag
        local opt_skill_stars       = 1 -- stars for all/class/tab skills
        local opt_single_skill_star = 1 -- stars for individual skills

        local r = { }

        local function add(rule)
            table.insert(r, rule)
        end

        local function add_many(list)
            for _, rule in ipairs(list) do
                table.insert(r, rule)
            end
        end

        ---------------------
        -- Class item tags --
        ---------------------
        if opt_class_tags == 1 then

            add({ -- Barbarian
                codes = { "ba1","ba2","ba3","ba4","ba5","ba6","ba7","ba8","ba9","baa","bab","bac","bad","bae","baf" },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}B{grey})"
            })

            add({ -- Paladin
                codes = {
                          "pa1","pa2","pa3","pa4","pa5","pa6","pa7","pa8","pa9","paa","pab","pac","pad","pae","paf",
                          "scp","gsc","wsp","rsc","hws","dsc","msc","srr","cad"
                        },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}P{grey})"
            })

            add({ -- Sorceress
                codes = {
                          "ob1","ob2","ob3","ob4","ob5","ob6","ob7","ob8","ob9","oba","obb","obc","obd","obe","obf",
                          "sst","lst","cst","8ss","8ls","8cs","7ss","7ls","7cs"
                        },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}S{grey})"
            })

            add({ -- Amazon
                codes = { "am1","am2","am3","am4","am5","am6","am7","am8","am9","ama","amb","amc","amd","ame","amf" },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}Z{grey})"
            })

            add({ -- Assassin
                codes = { "ktr","wrb","axf","ces","clw","btl","skr",
                          "9ar","9wb","9xf","9cs","9lw","9tw","9qr",
                          "7ar","7wb","7xf","7cs","7lw","7tw","7qr" },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}A{grey})"
            })

            add({ -- Necromancer
                codes = {
                          "ne1","ne2","ne3","ne4","ne5","ne6","ne7","ne8","ne9","nea","neb","nec","ned","nee","nef",
                          "wnd","ywn","bwn","gwn","9wn","9yw","9bw","9gw","7wn","7yw","7bw","7gw"
                        },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}N{grey})"
            })

            add({ -- Druid
                codes = { "dr1","dr2","dr3","dr4","dr5","dr6","dr7","dr8","dr9","dra","drb","drc","drd","dre","drf" },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                suffix = "{grey}({turquoise}D{grey})"
            })

        end

        ------------------
        -- Ethereal tag --
        ------------------

        if opt_ethereal_tag == 1 then

            add({ -- mark ethereal items with (e)
                codes = "allitems",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                ethereal = true,
                suffix = "{grey}(e)"
            })

        end

        ------------------
        -- ilvl tagging --
        ------------------

        if opt_ilvl_tags == 1 then

            add({ -- ilvl suffixed with L (x)
                codes = "allitems",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 5, 6, 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}({blue}L{ilvl}{grey})",
            })

        end

        -----------------------
        -- Socket count tags --
        -----------------------

        if opt_socket_count == 1 then

            add({ -- 6 sockets shows up in green [x]
                codes = "allitems",
                sockets = "6",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}[{green}{sockets}{grey}]"
            })

            add({ -- 5 sockets shows up in green [x]
                codes = "allitems",
                sockets = "5",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}[{green}{sockets}{grey}]"
            })

            add({ -- 4 sockets shows up in green [x]
                codes = "allitems",
                sockets = "4",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}[{green}{sockets}{grey}]"
            })

            add({ -- 3 sockets shows up in green [x]
                codes = "allitems",
                sockets = "3",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}[{green}{sockets}{grey}]"
            })

            add({ -- 2 sockets shows up in green [x]
                codes = "allitems",
                sockets = "2",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}[{green}{sockets}{grey}]"
            })

            add({ -- 1 socket shows up in red [x]
                codes = "allitems",
                sockets = "1",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
                suffix = "{grey}[{red}{sockets}{grey}]"
            })

        end

        -----------------------
        -- Ring/Amulet/Charm --
        -----------------------

        if opt_charm_ring_amu == 1 then

            add({ -- Charms suffixed Chm
                codes = { "cm1", "cm2", "cm3" },
                location = { "onground" },
                suffix = "{grey}({pink}Chm{grey})"
            })

            add({ -- Rings suffixed Rng
                codes = { "rin" },
                location = { "onground" },
                suffix = "{grey}({pink}Rng{grey})"
            })

            add({ -- Amulets suffixed Amu
                codes = { "amu" },
                location = { "onground" },
                suffix = "{grey}({pink}Amu{grey})"
            })

        end

        ---------------------------
        -- Hide junk / consumables
        ---------------------------

        if opt_hide_junk == 1 then
            add({ -- Hide throwable potions + scrolls + misc junk
                codes = { "gpl", "gpm", "gps", "opl", "opm", "ops", "isc", "tsc", "vps", "wms", "yps", "key" },
                hide = true
            })
        end

        --------------------------
        -- Hide low pots by area level
        --------------------------

        if opt_hide_low_pots == 1 then

            add({ -- Hide tier 1–2 pots in midgame zones (area level 25+)
                codes  = { "hp1", "hp2", "mp1", "mp2" },
                alvl   = { min = 25 },
                hide   = true
            })

            add({ -- Hide tier 3 pots in late-game zones (area level 40+)
                codes  = { "hp3", "mp3" },
                alvl   = { min = 40 },
                hide   = true
            })

            add({ -- Hide tier 4 pots once you're in high-level zones (area level 65+)
                codes  = { "hp4", "mp4" },
                alvl   = { min = 65 },
                hide   = true
            })

        end

        -------------------------------
        -- Paladin shields all res tag
        -------------------------------

        if opt_pal_shield_res == 1 then
            add({ -- Paladin shields all resist values
                codes = {
                    -- Normal
                    "pa1","pa2","pa3","pa4","pa5","pa6",

                    -- Exceptional
                    "xpa","xpb","xpc","xpd","xpe","xpf",

                    -- Elite
                    "pab","pac","pad","pae","paf"
                },
                location = { "onground", "onplayer", "equipped", "atvendor" },
                quality = { 0, 1, 2, 3 },
                stat = { index = 39, op = ">", value = 0 },
                stat = { index = 41, op = ">", value = 0 },
                stat = { index = 43, op = ">", value = 0 },
                stat = { index = 45, op = ">", value = 0 },
                suffix = "{grey}({gold}{stat=(39)}{grey})"
            })
        end

        -----------
        -- Runes --
        -----------

        if opt_runes == 1 then

            local runes = {
                { code = "r01", tag = "{grey}({yellow}L1{grey})"    }, -- El
                { code = "r02", tag = "{grey}({yellow}L2{grey})"    }, -- Eld
                { code = "r03", tag = "{grey}({yellow}L4{grey})"    }, -- Tir
                { code = "r04", tag = "{grey}({yellow}L8{grey})"    }, -- Nef
                { code = "r05", tag = "{grey}({yellow}L16{grey})"   }, -- Eth
                { code = "r06", tag = "{grey}({yellow}L32{grey})"   }, -- Ith
                { code = "r07", tag = "{grey}({yellow}L64{grey})"   }, -- Tal
                { code = "r08", tag = "{grey}({yellow}L128{grey})"  }, -- Ral
                { code = "r09", tag = "{grey}({yellow}L256{grey})"  }, -- Ort
                { code = "r10", tag = "{grey}({yellow}L512{grey})"  }, -- Thul
                { code = "r11", tag = "{grey}({yellow}L1024{grey})" }, -- Amn

                { code = "r12", tag = "{grey}({gold}M1{grey})"      }, -- Sol
                { code = "r13", tag = "{grey}({gold}M2{grey})"      }, -- Shael
                { code = "r14", tag = "{grey}({gold}M4{grey})"      }, -- Dol
                { code = "r15", tag = "{grey}({gold}M8{grey})"      }, -- Hel
                { code = "r16", tag = "{grey}({gold}M16{grey})"     }, -- Io
                { code = "r17", tag = "{grey}({gold}M32{grey})"     }, -- Lum
                { code = "r18", tag = "{grey}({gold}M64{grey})"     }, -- Ko
                { code = "r19", tag = "{grey}({gold}M128{grey})"    }, -- Fal
                { code = "r20", tag = "{grey}({gold}M256{grey})"    }, -- Lem
                { code = "r21", tag = "{grey}({gold}M512{grey})"    }, -- Pul
                { code = "r22", tag = "{grey}({gold}M1024{grey})"   }, -- Um

                { code = "r23", tag = "{grey}({green}H1{grey})"     }, -- Mal
                { code = "r24", tag = "{grey}({green}H2{grey})"     }, -- Ist
                { code = "r25", tag = "{grey}({green}H4{grey})"     }, -- Gul
                { code = "r26", tag = "{grey}({green}H8{grey})"     }, -- Vex
                { code = "r27", tag = "{grey}({green}H16{grey})"    }, -- Ohm
                { code = "r28", tag = "{grey}({green}H32{grey})"    }, -- Lo
                { code = "r29", tag = "{grey}({green}H64{grey})"    }, -- Sur
                { code = "r30", tag = "{grey}({green}H128{grey})"   }, -- Ber
                { code = "r31", tag = "{grey}({green}H256{grey})"   }, -- Jah
                { code = "r32", tag = "{grey}({green}H512{grey})"   }, -- Cham
                { code = "r33", tag = "{grey}({green}H1024{grey})"  }, -- Zod
            }

            for _, rr in ipairs(runes) do
                add({ -- Rune tag
                    codes = { rr.code },
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    suffix = rr.tag
                })
            end

        end

        -----------------
        -- Skill stars --
        -----------------

        if opt_skill_stars == 1 then

            add({ -- +ALL SKILLS
                codes = "allitems",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                stat = { index = 127, op = "==", value = 3 },
                suffix = "{gold}!!!"
            })
            add({
                codes = "allitems",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                stat = { index = 127, op = "==", value = 2 },
                suffix = "{gold}**"
            })
            add({
                codes = "allitems",
                location = { "onground", "onplayer", "equipped", "atvendor" },
                stat = { index = 127, op = "==", value = 1 },
                suffix = "{gold}*"
            })

            for class = 0, 6 do
                add({ -- +CLASS SKILLS
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 83, param = class, op = "==", value = 3 },
                    suffix = "{turquoise}!!!"
                })
                add({
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 83, param = class, op = "==", value = 2 },
                    suffix = "{turquoise}**"
                })
                add({
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 83, param = class, op = "==", value = 1 },
                    suffix = "{turquoise}*"
                })
            end

            local tab_params = {
                0,1,2,
                8,9,10,
                16,17,18,
                24,25,26,
                32,33,34,
                40,41,42,
                48,49,50
            }

            for _, tab in ipairs(tab_params) do
                add({ -- +SKILL TAB
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 188, param = tab, op = "==", value = 3 },
                    suffix = " {white}!!!"
                })
                add({
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 188, param = tab, op = "==", value = 2 },
                    suffix = "{white}**"
                })
                add({
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 188, param = tab, op = "==", value = 1 },
                    suffix = "{white}*"
                })
            end

        end

        -------------------------
        -- Single-skill stars  --
        -------------------------

        if opt_single_skill_star == 1 then

            for sid = 0, 374 do
                add({ -- * if item has +3 to any specific skill
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 107, param = sid, op = "==", value = 3 },
                    suffix = "{orange}*"
                })
            end

            for sid = 0, 374 do
                add({ -- * if item has +2 to any specific skill
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 107, param = sid, op = "==", value = 2 },
                    suffix = "{yellow}*"
                })
            end

            for sid = 0, 374 do
                add({ -- * if item has +1 to any specific skill
                    codes = "allitems",
                    location = { "onground", "onplayer", "equipped", "atvendor" },
                    stat = { index = 107, param = sid, op = "==", value = 1 },
                    suffix = "{blue}*"
                })
            end

        end

        return r
    end)()
}
