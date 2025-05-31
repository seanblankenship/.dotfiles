return {
  "sphamba/smear-cursor.nvim",
  enabled = function()
    return os.getenv("NVIM_SSHFS") ~= "1"
  end,
  opts = {
    cursor_color = "none",
    normal_bg = nil,
    transparent_bg_fallback_color = "#181825", -- catppuccin.base

    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    min_horizontal_distance_smear = 0,
    min_vertical_distance_smear = 0,

    smear_horizontally = true,
    smear_vertically = true,
    smear_diagonally = true,
    smear_to_cmd = true,
    scroll_buffer_space = false,

    legacy_computing_symbols_support = false,
    legacy_computing_symbols_support_vertical_bars = false,
    vertical_bar_cursor = false,

    smear_insert_mode = true,
    vertical_bar_cursor_insert_mode = true,
    smear_replace_mode = false,
    smear_terminal_mode = false,
    horizontal_bar_cursor_replace_mode = false,

    never_draw_over_target = true,
    hide_target_hack = false,

    max_kept_windows = 30,
    windows_zindex = 300,
    filetypes_disabled = {},

    time_interval = 17,
    delay_event_to_smear = 2,
    delay_after_key = 6,

    stiffness = 0.65,
    trailing_stiffness = 0.45,
    trailing_exponent = 1.8,
    slowdown_exponent = 0.05,
    distance_stop_animating = 0.15,

    stiffness_insert_mode = 0.45,
    trailing_stiffness_insert_mode = 0.4,
    trailing_exponent_insert_mode = 1.3,
    distance_stop_animating_vertical_bar = 0.3,

    max_slope_horizontal = 0.5,
    min_slope_vertical = 2,

    color_levels = 16,
    gamma = 2.2,
    max_shade_no_matrix = 0.6,
    matrix_pixel_threshold = 0.7,
    matrix_pixel_threshold_vertical_bar = 0.3,
    matrix_pixel_min_factor = 0.5,
    volume_reduction_exponent = 0.25,
    minimum_volume_factor = 0.7,

    max_length = 20,
    max_length_insert_mode = 3,

    logging_level = vim.log.levels.WARN
  }
}