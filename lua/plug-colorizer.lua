--  ________                ___ ___               .__
--  \______ \   _______  __/   |   \   ___________|  |   ____   ______
--   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
--   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
--  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
--          \/     \/            \/       \/                \/     \/
-- | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

--  COLORIZER {{{

require'colorizer'.setup(
  {'*';},
  {
    RGB      = true;         -- #RGB hex codes
    RRGGBB   = true;         -- #RRGGBB hex codes
    names    = true;         -- "Name" codes like Blue
    RRGGBBAA = true;         -- #RRGGBBAA hex codes
    rgb_fn   = true;         -- CSS rgb() and rgba() functions
    hsl_fn   = true;         -- CSS hsl() and hsla() functions
    css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
  })

-- }}}
