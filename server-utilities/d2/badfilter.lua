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
            location = { "onground", "onplayer", "equipped", "atvendor" },
            suffix = "{grey}({purple}Chrm{grey})"
	},
	{ -- Rings, Amulets, Jewelry suffixed Jwlr
            codes = { "rin","amu","jew" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
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
	{ -- Rondache shows innate All Res roll (only when it has one)
            codes = { "pa1","pa2","pa3","pa4","pa5",  "xpa","xpb","xpc","xpd","xpe",  "upa","upb","upc","upd","upe" },
            location = { "onground", "onplayer", "equipped", "atvendor" },
            stat = { index = 31, op = ">", value = 0 },
            suffix = "{grey}({gold}{stat=(31)}{grey})"
	},
    }
}