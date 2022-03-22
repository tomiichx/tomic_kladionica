Config = {}

-- Kladionica zahtjeva zf_context i zf_dialog. // Sports Betting Script Requires: zf_context, zf_dialog.

Config.Kladionica = {
    Lokacija = vec3(308.9934, -906.9758, 29.27991), -- Kordinate Kladionice. // Coordinates.
    VlasnikPosao = 'kladionica', -- posao koji ima pristup gazda meni-u. // job that manages the matches.
    Society = 'kladionica', -- stavite false ukoliko ne zelite da se ulozi i isplate odvijaju preko sefa organizacije (ukoliko netko dobije, isplatit' ce ga sef, isto tako ulozi idu u sef), a ukoliko zelite da novac ide/dolazi u sef, stavite npr 'kladionica' 
    -- Society > Set it to 'JobName' if you want all income and expenses to be handled by a society, false if you don't. 
    MinUlog = 100, -- Minimalni ulog // Min. Deposit
    MaxUlog = 50000, -- Maksimalni ulog // Max. Deposit
}