-- -*- mode: haskell -*-

Config
  { font = "xft:Fira Mono:style=bold:size=8"
  , additionalFonts = ["xft:Fira Mono:size=8:italic"]
  , textOffset = 26
  , bgColor = "#385"
  , fgColor = "#152"
  , lowerOnStart = True
  , commands =
    [ Run StdinReader

    , Run MultiCpu
      [ "-t", "(<fn=1>%CPU</fn><total0><total1><total2><total3><total4><total5><total6><total7>)"
      , "-L", "15"
      , "-H", "60"
      , "-l", "#152"
      , "-n", "#152"
      , "-h", "#152"
      , "-w", "3"
      ] 20
      
    , Run CoreTemp
      [ "-t", "(<fn=1>\176CPU</fn><core0><core1><core2><core3>)"
      , "-L", "40"
      , "-H", "60"
      , "-l", "#152"
      , "-n", "#152"
      , "-h", "#152"
      , "-w", "3"
      ] 30

    , Run Network "wlp3s0"
      [ "-t", "<rx>\8595<tx>\8593"
      , "-S", "true"
      , "-L", "0"
      , "-H", "1000"
      , "-l", "#152"
      , "-n", "#152"
      , "-h", "#152"
      , "-m", "7"
      ] 20

    , Run Wireless "wlp3s0"
      [ "-t", "<fn=1><essid></fn>"
      ] 20

    -- , Run Volume "default" "Master" [] 10
      
    , Run Battery
      [ "-t", "(<fn=1><acstatus></fn><left> +<timeleft>)"
      , "-S", "true"
      , "-L", "20"
      , "-H", "80"
      , "-l", "#152"
      , "-n", "#152"
      , "-h", "#152"
      , "-m", "4"
      , "--"
      , "-O", "A/C"
      , "-i", "---"
      , "-o", "BAT"
      ] 20
      
    , Run Date "%_m/%_d %H:%M" "date" 600
    ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " %StdinReader%}{%multicpu% %coretemp% (<fc=#152>%vpn%</fc>%wlp3s0wi% %wlp3s0%) %battery% --%date% "
  }
