Config = {}

Config.Locale = 'en' -- 'de', 'en', 'es', 'fr'
Config.ItemName = "bodycam" -- ox_inventory Item
Config.BodycamTitle = "COIL BODYCAM"
Config.DateFormat = "ISO" -- EU (DD.MM.YYYY), US (MM/DD/YYYY), ISO (YYYY-MM-DD)
Config.IncludeSeconds = true

Config.AllowedJobs = {
    ["police"] = true,
    ["ambulance"] = true,
    ["lsfd"] = true,
    ["noose"] = true,
}

-- Logo
Config.LogoPath = "https://static.wikia.nocookie.net/gtawiki/images/3/3f/Coil-GTAO-Logo.png" -- if you want to use a picture local, then html/YOUR-IMAGE.png
