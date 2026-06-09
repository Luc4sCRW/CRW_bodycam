Config = {}

Config.ItemName = "bodycam" -- OX_INV
Config.BodycamTitle = "COIL BODYCAM"
Config.DateFormat = "ISO" -- EU (DD.MM.YYYY), US (MM/DD/YYYY), ISO (YYYY-MM-DD)
Config.IncludeSeconds = true -- true/false

-- Erlaubte Jobs
Config.AllowedJobs = {
    ["police"] = true,
    ["ambulance"] = true,
    ["lsfd"] = true,
    ["noose"] = true,
}

-- Logo (Entweder ein Link oder lokal im html Ordner z.B. "logo.png")
Config.LogoPath = "https://static.wikia.nocookie.net/gtawiki/images/3/3f/Coil-GTAO-Logo.png"


Config.Locale = 'en'

Locales = {}
function i18n(str, ...)
    local args = {...}
    if not str then return 'Key nil' end
    local localeCfg = Locales[Config.Locale]
    local translation = localeCfg and localeCfg[str] or (Locales['en'] and Locales['en'][str])
    if translation then
        local _, count = translation:gsub("%%s", "")
        if count > 0 and #args == 0 then
            return translation
        end
        return string.format(translation, ...)
    end
    return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
end
function _U(str, ...)
    return i18n(str, ...)
end
