SLOT_CODES =
{
    chapter_clears =
    {
        code = "Chapter_Clears",
        mapping =
        {
        [0] = 1, --  0 Chapters
        [1] = 2, --  1 Chapters
        [2] = 3, --  2 Chapters
        [3] = 4, --  3 Chapters
        [4] = 5, --  4 Chapters
        [5] = 6, --  5 Chapters
        [6] = 7, --  6 Chapters
        [7] = 8, --  7 Chapters
        }
    },
    palace_stars =
    {
        code = "Palace_Stars",
        mapping =
        {
        [0] = 1, --  0 Chapters
        [1] = 2, --  1 Chapters
        [2] = 3, --  2 Chapters
        [3] = 4, --  3 Chapters
        [4] = 5, --  4 Chapters
        [5] = 6, --  5 Chapters
        [6] = 7, --  6 Chapters
        [7] = 8, --  7 Chapters
        }
    },
  pit_items =
    {
        code = "Pit_Items",
        mapping =
        {
        [0] = 0, -- Vanilla Pit
        [1] = 0, -- Filler Pit
        [2] = 1,  -- Any item in Pit
        }
    },
  limit_chapter_logic =
    {
        code = "limit_chapter_logic",
        mapping =
        {
        [0] = 0, -- False
        [1] = 1, -- True
        }
    },
  limit_chapter_eight =
    {
        code = "limit_chapter_eight", -- All chapter 8 keys will be vanilla, all other locations will have non-progression items.
        mapping =
        {
        [0] = 1, --False
        [1] = 0  -- True
        }
    },
  palace_skip =
    {
        code = "palace_skip", -- Entering the Thousand-Year door will take you straight to Grodus.
        mapping =
        {
        [0] = 0, -- False
        [1] = 1  -- True
        }
    },
  yoshi_color =
    {
        code = "yoshi",
        mapping =
        {
        [0] = "0", -- Green
        [1] = "1", -- Red
        [2] = "2", -- Blue
        [3] = "3", -- Orange
        [4] = "4", -- Pink
        [5] = "5", -- Black
        [6] = "6", -- White
        [7] = "7" -- White but bugged in 0.4.0
        }
    },
  westside =
    {
        code = "open_westside",
        mapping =
        {
        [0] = "0", -- False
        [1] = "1", -- True
        }
    },
  tattlesanity =
    {
        code = "tattlesanity",
        mapping =
        {
        [0] = "0", -- False
        [1] = "1", -- True
        }
    },
  disable_intermissions =
    {
        code = "disable_intermissions",
        mapping =
        {
        [0] = "0", -- False
        [1] = "1", -- True
        }
    },
  goal =
    {
        code = "goal",
        mapping =
        {
        [0] = "0", -- Defeat Shadow Queen
        [1] = "1", -- Crystal Star Hunt
        [2] = "2" -- Defeat Bonetail
        }
    }
}