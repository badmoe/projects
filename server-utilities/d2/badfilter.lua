--- Filter Title: badman basic
--- Filter Type: (Basic)
--- Filter Description: freestyling this as we go
--- Filter Link: https://raw.githubusercontent.com/badmoe/projects/refs/heads/master/server-utilities/d2/badfilter.lua
return {
    reload = "{purple}Badfilter {grey}(v1 or w/e)",
    language = "enUS",
    allowOverrides = true,
    filter_level = 2,
    filter_titles = { "1", "2" },
    rules = {
    ---------------------
    -- Class item tags --
    ---------------------

	{ -- Barbarian
            codes = { "ba1","ba2","ba3","ba4","ba5","ba6","ba7","ba8","ba9","baa","bab","bac","bad","bae","baf" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}B{grey})"
	},
	{ -- Paladin
            codes = {
                      "pa1","pa2","pa3","pa4","pa5","pa6","pa7","pa8","pa9","paa","pab","pac","pad","pae","paf",
                      "scp","gsc","wsp","rsc","hws","dsc","msc","srr","cad"
                    },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}P{grey})"
	},
	{ -- Sorceress
            codes = {
                      "ob1","ob2","ob3","ob4","ob5","ob6","ob7","ob8","ob9","oba","obb","obc","obd","obe","obf",
                      "sst","lst","cst","8ss","8ls","8cs","7ss","7ls","7cs"
                    },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}S{grey})"
	},
	{ -- Amazon
            codes = { "am1","am2","am3","am4","am5","am6","am7","am8","am9","ama","amb","amc","amd","ame","amf" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}Z{grey})"
	},
	{ -- Assassin
            codes = { "ktr","wrb","axf","ces","clw","btl","skr",
                      "9ar","9wb","9xf","9cs","9lw","9tw","9qr",
                      "7ar","7wb","7xf","7cs","7lw","7tw","7qr" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}A{grey})"
	},
	{ -- Necromancer
            codes = {
                      "ne1","ne2","ne3","ne4","ne5","ne6","ne7","ne8","ne9","nea","neb","nec","ned","nee","nef",
                      "wnd","ywn","bwn","gwn","9wn","9yw","9bw","9gw","7wn","7yw","7bw","7gw"
                    },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}N{grey})"
	},
	{ -- Druid
            codes = { "dr1","dr2","dr3","dr4","dr5","dr6","dr7","dr8","dr9","dra","drb","drc","drd","dre","drf" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({turquoise}D{grey})"
	},

    -------------------
    -- General rules --
    -------------------

    { -- ilvl suffixed with L (x)
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            itype = { 5, 6, 10, 12, 45, 50, 58, 82, 83, 84 },
            suffix = "{grey}({blue}L{ilvl}{grey})",
    },
    { -- 2+ sockets shows up in green [x]
            codes = "allitems",
            sockets = "2+",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
            suffix = "{grey}[{green}{sockets}{grey}]"
    },
    { -- 1 socket shows up in red [x]
            codes = "allitems",
            sockets = "1",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            itype = { 10, 12, 45, 50, 58, 82, 83, 84 },
            suffix = "{grey}[{red}{sockets}{grey}]"
    },
	{ -- Charms suffixed Chrm
            codes = { "cm1", "cm2", "cm3" },
            location = { "onground" },
            suffix = "{grey}({purple}Chrm{grey})"
	},
	{ -- Rings, Amulets, Jewelry suffixed Jwlr
            codes = { "rin","amu","jew" },
            location = { "onground" },
            suffix = "{grey}({yellow}Jwlr{grey})"
	},
	{ -- Hide throwable potions + scrolls + misc junk
            codes = { "gpl", "gpm", "gps", "opl", "opm", "ops", "isc", "tsc", "vps", "wms", "yps", "key" },
            hide = true
	},
	{ -- Hide hp/mp pots below tier 3 after level 25
            codes  = { "hp1", "hp2", "mp1", "mp2" },
            pstat  = { stat = "level", min = 25 },
            hide   = true
	},
	{ -- Hide hp/mp pots below tier 4 after level 40
            codes  = { "hp3", "mp3" },
            pstat  = { stat = "level", min = 40 },
            hide   = true
	},
	{ -- Paladin shields all resist values
            codes = { "pa1","pa2","pa3","pa4","pa5",  "xpa","xpb","xpc","xpd","xpe",  "upa","upb","upc","upd","upe" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            quality = { 0, 1, 2, 3 },
            stat = { index = 39, op = ">", value = 0 },
            stat = { index = 41, op = ">", value = 0 },
            stat = { index = 43, op = ">", value = 0 },
            stat = { index = 45, op = ">", value = 0 },
            suffix = "{grey}({gold}{stat=(39)}{grey})"
	},

    -----------
    -- Runes --    
    -----------

	{ -- El
            codes = { "r01" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L1{grey})"
	},
    { -- Eld
            codes = { "r02" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L2{grey})"
    },
    { -- Tir
            codes = { "r03" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L4{grey})"
    },
    { -- Nef
            codes = { "r04" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L8{grey})"
    },
    { -- Eth
            codes = { "r05" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L16{grey})"
    },
    { -- Ith
            codes = { "r06" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L32{grey})"
    },
    { -- Tal
            codes = { "r07" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L64{grey})"
    },
    { -- Ral
            codes = { "r08" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L128{grey})"
    },
    { -- Ort
            codes = { "r09" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L256{grey})"
    },
    { -- Thul
            codes = { "r10" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L512{grey})"
    },
    { -- Amn
            codes = { "r11" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({yellow}L1024{grey})"
    },
    { -- Sol
            codes = { "r12" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M1{grey})"
    },
    { -- Shael
            codes = { "r13" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M2{grey})"
    },
    { -- Dol
            codes = { "r14" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M4{grey})"
    },
    { -- Hel
            codes = { "r15" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M8{grey})"
    },
    { -- Io
            codes = { "r16" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M16{grey})"
    },
    { -- Lum
            codes = { "r17" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M32{grey})"
    },
    { -- Ko
            codes = { "r18" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M64{grey})"
    },
    { -- Fal
            codes = { "r19" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M128{grey})"
    },
    { -- Lem
            codes = { "r20" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M256{grey})"
    },
    { -- Pul
            codes = { "r21" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M512{grey})"
    },
    { -- Um
            codes = { "r22" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({gold}M1024{grey})"
    },
    { -- Mal
            codes = { "r23" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H1{grey})"
    },
    { -- Ist
            codes = { "r24" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H2{grey})"
    },
    { -- Gul
            codes = { "r25" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H4{grey})"
    },
    { -- Vex
            codes = { "r26" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H8{grey})"
    },
    { -- Ohm
            codes = { "r27" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H16{grey})"
    },
    { -- Lo
            codes = { "r28" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H32{grey})"
    },
    { -- Sur
            codes = { "r29" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H64{grey})"
    },
    { -- Ber
            codes = { "r30" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H128{grey})"
    },
    { -- Jah
            codes = { "r31" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H256{grey})"
    },
    { -- Cham
            codes = { "r32" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H512{grey})"
    },
    { -- Zod
            codes = { "r33" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({green}H1024{grey})"
    },

    -----------------
    -- Skill stars --
    -----------------

	{ -- * if item has +All Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 127, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Amazon Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 0, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Sorceress Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 1, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Necromancer Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 2, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Paladin Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 3, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Barbarian Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 4, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Druid Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 5, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Assassin Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 83, param = 6, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Amazon Bow/Crossbow Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 0, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Amazon Passive/Magic Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 1, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Amazon Javelin/Spear Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 2, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Sorc Fire Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 8, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Sorc Lightning Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 9, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Sorc Cold Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 10, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Necro Curses
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 16, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Necro Poison/Bone
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 17, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Necro Summoning
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 18, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Pally Combat Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 24, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Pally Offensive Auras
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 25, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Pally Defensive Auras
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 26, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Barb Combat Skills
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 32, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Barb Masteries
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 33, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Barb Warcries
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 34, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Druid Summoning
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 40, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Druid Shape Shifting
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 41, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Druid Elemental
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 42, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Assassin Traps
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 48, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Assassin Shadow Disciplines
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 49, op = ">", value = 0 },
            suffix = "{grey}*"
	},
	{ -- * if item has +Assassin Martial Arts
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 188, param = 50, op = ">", value = 0 },
            suffix = "{grey}*"
	},
    }
}