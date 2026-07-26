hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "dvp",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",
        numlock_by_default = true,
        repeat_rate  = 40,
        repeat_delay = 170,
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
            scroll_factor  = 1.0,
        },
    },
})

hl.device({
    name          = "input-remapper-kensington-expert-wireless-tb-mouse-forwarded",
    sensitivity   = 0.40,
    accel_profile = "flat",
})

hl.device({
    name           = "elan0672:00-04f3:3187-touchpad",
    sensitivity    = 0.40,
    accel_profile  = "flat",
    natural_scroll = true,
})
