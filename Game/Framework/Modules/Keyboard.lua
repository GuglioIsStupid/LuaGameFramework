local ffi = require("ffi")
local SDL2 = require("Game.Framework.Backend.SDL2")
local function s_lower(str)
    return string.lower(str)
end
local function s_upper(str)
    return string.upper(str)
end
local function s_capitalize(str)
    return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end
Game.Keyboard = {}
Game.Keyboard._keys = {}

--https://www.freepascal-meets-sdl.net/sdl-2-0-key-code-lookup-table/

local keycodes = {
    [0] = "Unknown",
    [8] = "Backspace",
    [9] = "Tab",
    [13] = "Return",
    [27] = "Escape",
    [32] = "Space",
    [33] = "Exclaim",
    [34] = "Quotedbl",
    [35] = "Hash",
    [36] = "Dollar",
    [37] = "Percent",
    [38] = "Ampersand",
    [39] = "Quote",
    [40] = "LeftParen",
    [41] = "RightParen",
    [42] = "Asterisk",
    [43] = "Plus",
    [44] = "Comma",
    [45] = "Minus",
    [46] = "Period",
    [47] = "Slash",
    [48] = "0",
    [49] = "1",
    [50] = "2",
    [51] = "3",
    [52] = "4",
    [53] = "5",
    [54] = "6",
    [55] = "7",
    [56] = "8",
    [57] = "9",
    [58] = "Colon",
    [59] = "Semicolon",
    [60] = "Less",
    [61] = "Equals",
    [62] = "Greater",
    [63] = "Question",
    [64] = "At",
    [91] = "LeftBracket",
    [92] = "Backslash",
    [93] = "RightBracket",
    [94] = "Caret",
    [95] = "Underscore",
    [96] = "Backquote",
    [97] = "A",
    [98] = "B",
    [99] = "C",
    [100] = "D",
    [101] = "E",
    [102] = "F",
    [103] = "G",
    [104] = "H",
    [105] = "I",
    [106] = "J",
    [107] = "K",
    [108] = "L",
    [109] = "M",
    [110] = "N",
    [111] = "O",
    [112] = "P",
    [113] = "Q",
    [114] = "R",
    [115] = "S",
    [116] = "T",
    [117] = "U",
    [118] = "V",
    [119] = "W",
    [120] = "X",
    [121] = "Y",
    [122] = "Z",
    [127] = "Delete",
    [1073741881] = "CapsLock",
    [1073741882] = "F1",
    [1073741883] = "F2",
    [1073741884] = "F3",
    [1073741885] = "F4",
    [1073741886] = "F5",
    [1073741887] = "F6",
    [1073741888] = "F7",
    [1073741889] = "F8",
    [1073741890] = "F9",
    [1073741891] = "F10",
    [1073741892] = "F11",
    [1073741893] = "F12",
    [1073741894] = "PrintScreen",
    [1073741895] = "ScrollLock",
    [1073741896] = "Pause",
    [1073741897] = "Insert",
    [1073741898] = "Home",
    [1073741899] = "PageUp",
    [1073741901] = "End",
    [1073741902] = "PageDown",
    [1073741903] = "Right",
    [1073741904] = "Left",
    [1073741905] = "Down",
    [1073741906] = "Up",
    [1073741907] = "NumLockClear",
    [1073741908] = "KPDivide",
    [1073741909] = "KPMultiply",
    [1073741910] = "KPMinus",
    [1073741911] = "KPPlus",
    [1073741912] = "KPEnter",
    [1073741913] = "KP1",
    [1073741914] = "KP2",
    [1073741915] = "KP3",
    [1073741916] = "KP4",
    [1073741917] = "KP5",
    [1073741918] = "KP6",
    [1073741919] = "KP7",
    [1073741920] = "KP8",
    [1073741921] = "KP9",
    [1073741922] = "KP0",
    [1073741923] = "KPPeriod",
    [1073741925] = "Application",
    [1073741926] = "Power",
    [1073741927] = "KPEquals",
    [1073741928] = "F13",
    [1073741929] = "F14",
    [1073741930] = "F15",
    [1073741931] = "F16",
    [1073741932] = "F17",
    [1073741933] = "F18",
    [1073741934] = "F19",
    [1073741935] = "F20",
    [1073741936] = "F21",
    [1073741937] = "F22",
    [1073741938] = "F23",
    [1073741939] = "F24",
    [1073741940] = "Execute",
    [1073741941] = "Help",
    [1073741942] = "Menu",
    [1073741943] = "Select",
    [1073741944] = "Stop",
    [1073741945] = "Again",
    [1073741946] = "Undo",
    [1073741947] = "Cut",
    [1073741948] = "Copy",
    [1073741949] = "Paste",
    [1073741950] = "Find",
    [1073741951] = "Mute",
    [1073741952] = "VolumeUp",
    [1073741953] = "VolumeDown",
    [1073741957] = "KPComma",
    [1073741958] = "KPEqualsAS400",
    [1073741977] = "Alterase",
    [1073741978] = "Sysreq",
    [1073741979] = "Cancel",
    [1073741980] = "Clear",
    [1073741981] = "Prior",
    [1073741982] = "Return2",
    [1073741983] = "Separator",
    [1073741984] = "Out",
    [1073741985] = "Oper",
    [1073741986] = "Clearagain",
    [1073741987] = "CrSel",
    [1073741988] = "ExSel",
    [1073742000] = "KP00",
    [1073742001] = "KP000",
    [1073742002] = "ThousandsSeparator",
    [1073742003] = "DecimalSeparator",
    [1073742004] = "CurrencyUnit",
    [1073742005] = "CurrencySubUnit",
    [1073742006] = "KPLeftParen",
    [1073742007] = "KPRightParen",
    [1073742008] = "KPLeftBrace",
    [1073742009] = "KPRightBrace",
    [1073742010] = "KPTab",
    [1073742011] = "KPBackspace",
    [1073742012] = "KPA",
    [1073742013] = "KPB",
    [1073742014] = "KPC",
    [1073742015] = "KPD",
    [1073742016] = "KPE",
    [1073742017] = "KPF",
    [1073742018] = "KPXOR",
    [1073742019] = "KPPower",
    [1073742020] = "KPPercent",
    [1073742021] = "KPLess",
    [1073742022] = "KPGreater",
    [1073742023] = "KPAmpersand",
    [1073742024] = "KPDblAmpersand",
    [1073742025] = "KPVerticalBar",
    [1073742026] = "KPDblVerticalBar",
    [1073742027] = "KPColon",
    [1073742028] = "KPHash",
    [1073742029] = "KPSpace",
    [1073742030] = "KPAt",
    [1073742031] = "KPExclam",
    [1073742032] = "KPMemStore",
    [1073742033] = "KPMemRecall",
    [1073742034] = "KPMemClear",
    [1073742035] = "KPMemAdd",
    [1073742036] = "KPMemSubtract",
    [1073742037] = "KPMemMultiply",
    [1073742038] = "KPMemDivide",
    [1073742039] = "KPPlusMinus",
    [1073742040] = "KPClear",
    [1073742041] = "KPClearEntry",
    [1073742042] = "KPBinary",
    [1073742043] = "KPOctal",
    [1073742044] = "KPDecimal",
    [1073742045] = "KPHexadecimal",
    [1073742048] = "LCtrl",
    [1073742049] = "LShift",
    [1073742050] = "LAlt",
    [1073742051] = "LGui",
    [1073742052] = "RCtrl",
    [1073742053] = "RShift",
    [1073742054] = "RAlt",
    [1073742055] = "RGui",
    [1073742081] = "Mode",
    [1073742082] = "AudioNext",
    [1073742083] = "AudioPrev",
    [1073742084] = "AudioStop",
    [1073742085] = "AudioPlay",
    [1073742086] = "AudioMute",
    [1073742087] = "MediaSelect",
    [1073742088] = "WWW",
    [1073742089] = "Mail",
    [1073742090] = "Calculator",
    [1073742091] = "Computer",
    [1073742092] = "ACSearch",
    [1073742093] = "ACHome",
    [1073742094] = "ACBack",
    [1073742095] = "ACForward",
    [1073742096] = "ACStop",
    [1073742097] = "ACRefresh",
    [1073742098] = "ACBookmarks",
    [1073742099] = "BrightnessDown",
    [1073742100] = "BrightnessUp",
    [1073742101] = "DisplaySwitch",
    [1073742102] = "KBDIllumToggle",
    [1073742103] = "KBDIllumDown",
    [1073742104] = "KBDIllumUp",
    [1073742105] = "Eject",
    [1073742106] = "Sleep",
    [1073742107] = "App1",
    [1073742108] = "App2",
    [1073742109] = "AudioRewind",
    [1073742110] = "AudioFastForward",
    [1073742111] = "Max"
}

for k, v in pairs(keycodes) do
    Game.Keyboard._keys[v] = {
        pressed = false,
        released = false,
        held = false
    }
end

function Game.Keyboard.IsKeyDown(key)
    local key = Game.Keyboard.GetKeyCode(key)
    return Game.Keyboard._keys[key].held
end

function Game.Keyboard.IsKeyPressed(key)
    local key = Game.Keyboard.GetKeyCode(key)
    return Game.Keyboard._keys[key].pressed
end

function Game.Keyboard.IsKeyReleased(key)
    local key = Game.Keyboard.GetKeyCode(key)
    return Game.Keyboard._keys[key].released
end

function Game.Keyboard.Update()
    for k, v in pairs(keycodes) do
        Game.Keyboard._keys[v].pressed = false
        Game.Keyboard._keys[v].released = false
    end
end

function Game.Keyboard.GetKeyName(key)
    return keycodes[key]
end

function Game.Keyboard.GetKeyCode(key)
    local keycode = 0
    for k, v in pairs(keycodes) do
        if v == key then
            keycode = k
            break
        end
    end
    return keycodes[keycode]
end