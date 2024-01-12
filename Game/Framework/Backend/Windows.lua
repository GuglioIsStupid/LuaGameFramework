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

    // get command line arguments
    int GetCommandLineA(void);
    int GetCommandLineW(void);
    int CommandLineToArgvA(void);
    int CommandLineToArgvW(void);
    int LocalFree(void);
]]

local win32api = ffi.load("user32.dll")

local Windows = {}

function Windows.GetDesktopDimensions()
    local width = win32api.GetSystemMetrics(0)
    local height = win32api.GetSystemMetrics(1)
    return width, height
end

function Windows.GetClientDimensions()
    local rect = ffi.new("RECT")
    win32api.GetClientRect(nil, rect)
    local width = rect.right - rect.left
    local height = rect.bottom - rect.top
    return width, height
end

function Windows.GetCommandLine()
    local command_line = ffi.string(win32api.GetCommandLineW())
    return command_line
end

return Windows