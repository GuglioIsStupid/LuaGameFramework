local ffi = require("ffi")

-- win32api
ffi.cdef[[
    // get desktop dimensions
    typedef struct tagRECT {
        long left;
        long top;
        long right;
        long bottom;
    } RECT, *PRECT, *NPRECT, *LPRECT;

    int GetSystemMetrics(int nIndex);
    int GetClientRect(void* hWnd, RECT* lpRect);
]]

local win32api = ffi.load("user32.dll")

local Windows = {}

function Windows.GetDesktopDimensions()
    local width = win32api.GetSystemMetrics(0)
    local height = win32api.GetSystemMetrics(1)
    return width, height
end

return Windows