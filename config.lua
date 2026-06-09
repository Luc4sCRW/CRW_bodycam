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
