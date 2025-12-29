--- Filter Title: badman basic
--- Filter Type: (Basic)
--- Filter Description: freestyling this as we go
--- Filter Link: https://raw.githubusercontent.com/badmoe/projects/refs/heads/master/server-utilities/d2/badfilter.lua
return {
    reload = "{turquoise}Badfilter {gray}(v1 or w/e) {green}",
    language = "enUS",
    allowOverrides = true,
    filter_level = 2,
    filter_titles = { "1", "2" },
    rules = {
    { -- ilvl suffixed with L (x)
            codes = "allitems",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            itype = { 5, 6, 10, 12, 45, 50, 58, 82, 83, 84 },
            suffix = " {grey}({blue}L{ilvl}{grey})",
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
	{ -- Hide throwable potions
            codes = { "exp", "gpm", "ops", "ful" },
            hide = true
	},
	{ -- Hide hp/mp pots below tier 3 after level 25
            codes  = { "hp1", "hp2", "mp1", "mp2" },
            pstat  = { stat = "level", min = 25 },
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
	{ -- White base
            codes = { "wnd","ywn","bwn","gwn",  "9wn","9yw","9bw","9gw",  "7wn","7yw","7bw","7gw" },
            sockets = "2",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            prefix = "{gold}(White Base) "
	},
	{ -- Spirit Sword base
            codes = { "crs" },
            sockets = "4",
            location = { "onground", "onplayer", "equipped", "atvendor" },
            prefix = "{gold}(Spirit Base) "
	},
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