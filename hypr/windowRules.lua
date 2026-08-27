-- Window Rules
hl.window_rule({ match = { class = "vlc" }, opaque = true })
hl.window_rule({ match = { class = "jetbrains-studio|jetbrains-idea-ce|jetbrains-rustrover" }, opaque = true })
hl.window_rule({ match = { class = "^(firefox)$" }, rounding = 3, center = true })
hl.window_rule({ match = { class = "^(steam)$" }, float = true, opacity = 0.90 })
hl.window_rule({ match = { class = "^(foot)$" }, opacity = 0.90 })
hl.window_rule({ match = { title = "^(.*Network Manager.*)$" }, float = true })
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true, size = { 855, 525 }, center = true })
hl.window_rule({ match = { class = "^(pinentry-)" }, stay_focused = true })
hl.window_rule({ match = { class = "^(thunar)$", title = "^[Rr]ename.*" }, float = true, opacity = 0.80, center = true })
hl.window_rule({ match = { class = "^(thunar)$", title = "File Operation Progress" }, float = true, opacity = 0.80, center = true })
hl.window_rule({ match = { class = "^(Motrix)$" }, opacity = 0.80, center = true })
hl.window_rule({ match = { class = "^(org.telegram.desktop)$" }, float = true, opacity = 0.90, center = true })

-- Opacity rules
hl.window_rule({ match = { class = "^(thunar)$" }, opacity = 0.85 })
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, opacity = 0.90 })
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$" }, opacity = 0.85 })
hl.window_rule({ match = { class = "^(discord|Vesktop|vesktop)$" }, opacity = 0.85 })
hl.window_rule({ match = { class = "^(v2rayN)$" }, opacity = 0.9 })
hl.window_rule({ match = { class = "^(ONLYOFFICE)$" }, opacity = 0.90 })
hl.window_rule({ match = { class = "^(soffice|libreoffice-writer|org.libreoffice.LibreOffice)$" }, opacity = 0.90 })


hl.layer_rule({ match = { namespace = "^(logout_dialog)$" }, blur = true })

hl.layer_rule({
  match = { namespace = "^(swaync-control-center)$" },
  blur = true,
  ignore_alpha = 0.1
})

hl.layer_rule({
  match = { namespace = "^(swaync-notification-window)$" },
  blur = true,
  ignore_alpha = 0.1
})

hl.window_rule({ 
  match = { class = ".*[Xx]dg-desktop-portal-gtk.*" }, 
  float = true, 
  size = { 1050, 1000 }, 
  center = true 
})
