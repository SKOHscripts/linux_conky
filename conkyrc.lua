conky.config = {

	lua_load = "~/CloudStation/Documents/scripts/linux_conky/draw_bg.lua",
    -- lua_startup_hook = "draw_bg",
    lua_draw_hook_pre = "draw_bg",
    -- lua_draw_hook_post = "conky_update",


	
	update_interval = 1,
	cpu_avg_samples = 1,
	net_avg_samples = 1,
	out_to_console = false,
	on_bottom = true,

	override_utf8_locale = true,
	double_buffer = true,
	no_buffers = true,
	text_buffer_size = 2048,
	imlib_cache_size = 0,


	own_window = true,
	own_window_transparent = true,
    own_window_class = 'conky',
    own_window_type = 'dock',
	own_window_argb_visual = true,
	own_window_argb_value = 500,
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

	border_inner_margin = 5,
	border_outer_margin = 0,
	xinerama_head = 1,
	alignment = 'top_right',
	gap_x = 20,
	gap_y = 72,


	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,
	use_xft = true,
	font = 'Ubuntu Mono:size=10',
	xftalpha = 0,
	uppercase = false,
	default_color = 'darkgray',
	default_shade_color = '#1d1d1d',

	own_window_colour = '#000000',
	minimum_width = 300, minimum_height = 0,
	alignment = 'top_right',


	template5 = [[
${if_mounted \2}#
${font Ubuntu:pixelsize=11:bold}${color0}· \1 · $alignc${color1}${font Ubuntu:pixelsize=10}${fs_used \2}  /  ${fs_size \2}#
${if_match ${fs_used_perc \2}>=75}${color b54}$else$color$endif#
${template8}${fs_used_perc \2}%$font$color
${if_match ${fs_used_perc \2}>=75}${color b54}$else$color$endif#
${fs_bar 7 \2}
$endif$color]],


	
	color1 = 'b9b9b7', -- secondary text color
	color2 = '2e7629',
	template7 = '${alignc}',
    template8 = '${alignr 10}',

};
conky.text = [[
${font}${voffset -15}
${color darkred}${font Ubuntu:pixelsize=20:bold}SYSTEM  ${hr 3 }$color
${font Ubuntu:pixelsize=13:bold}${exec lsb_release -d | cut -f2 }
#${template8}${font Ubuntu:pixelsize=17:bold}${execi 1000 date "+%d %B"}  ${exec date "+%H:%M"}
${font Ubuntu:pixelsize=13:bold}Host: $alignr$nodename
${font Ubuntu:pixelsize=13:bold}Uptime: ${font Ubuntu:pixelsize=13:normal}$uptime_short

${font Ubuntu:pixelsize=11:bold}${color0}· BATTERY · $alignc${color1}${font Ubuntu:pixelsize=10}${battery_time}#
${if_match ${battery_percent BAT0}<=20}${color b54}\
${else}${if_match ${battery_percent BAT0} ==100}${color2}${endif}\
${endif}#
${template8}${battery_percent}%$font$color
${if_match ${battery_percent BAT0}<=20}${color b54}${battery_bar 7}\
${else}${if_match ${battery_percent BAT0} ==100}${color2}${battery_bar 7}${endif}\
${battery_bar 7}
${endif}#

${color darkred}${font Ubuntu:pixelsize=20:bold}CPU  ${hr 3}$color
${font Ubuntu:pixelsize=13:bold}${execi 1000 grep model /proc/cpuinfo | cut -d : -f2 | tail -1 | sed 's/\s//'}
${font Ubuntu:pixelsize=13:bold}${cpugraph 50,300 000000 ffffff cpu}
${font Ubuntu:pixelsize=11:bold}${cpu cpu0}%${goto 50}${cpubar cpu0 7,80} $alignr${cpu cpu1}%   ${cpubar cpu1 7,80}
${font Ubuntu:pixelsize=11:bold}${cpu cpu2}%${goto 50}${cpubar cpu2 7,80} $alignr${cpu cpu3}%   ${cpubar cpu3 7,80}
${freq_g}GHz ${if_match ${exec sensors | grep 'Core 0' | cut -c17-18}>=80}${color b54}$else$color$endif#
${template8}${exec sensors | grep 'Core 0' | cut -c17-18}°C

${color darkred}${font Ubuntu:pixelsize=20:bold}MEMORY  ${hr 3}$color
${font Ubuntu:pixelsize=11:bold}${color0}· RAM · $alignc${color1}${font Ubuntu:pixelsize=10}$mem / $memmax#
${if_match ${memperc}>=75}${color b54}$else$color$endif#
${template8}${memperc}%$font$color
${if_match ${memperc}>=75}${color b54}$else$color$endif#
${membar 7}

${font Ubuntu:pixelsize=11:bold}${color0}· SWAP · $alignc${color1}${font Ubuntu:pixelsize=10}$swap / $swapmax#
${if_match ${swapperc}>=75}${color b54}$else$color$endif#
${template8}${swapperc}%$font$color
${if_match ${swapperc}>=75}${color b54}$else$color$endif#
${swapbar 7}

${color darkred}${font Ubuntu:pixelsize=20:bold}DISK USAGE  ${hr 3}$color
${template5 / /}#
${template5 BACKUP_DISK /media/corentin/BACKUP_DISK}#
${template5 USB_MICHELC /media/corentin/USB_MICHELC}#
${font Ubuntu:pixelsize=11:bold}Temperature: ${if_match ${execi 10 sudo nvme smart-log /dev/nvme0 | grep 'Temperature Sensor' | cut -c39-40}>=50}${color b54}$else$color$endif#
${template8}${execi 10 sudo nvme smart-log /dev/nvme0 | grep 'Temperature Sensor' | cut -c39-40}°C

${color darkred}${font Ubuntu:bold:size=14}NETWORK  ${hr 3}$color
${font Ubuntu:pixelsize=13:bold}Local IPs:${font Ubuntu:pixelsize=13:normal}$alignr ${execi 120 ip a | grep inet | grep -vw lo | grep -v inet6 | cut -d \/ -f1 | sed 's/[^0-9\.]*//g'}
${font Ubuntu:pixelsize=13:bold}External IP:${font Ubuntu:pixelsize=13:normal}${alignr}${execi 1000  wget -q -O- http://ipecho.net/plain; echo}
${font Ubuntu:pixelsize=13:bold}WIFI : Down: ${font Ubuntu:pixelsize=13:normal}${downspeed wlo1}  ${font Ubuntu:pixelsize=13:bold}${alignr}Up: ${font Ubuntu:pixelsize=13:normal}${upspeed wlo1}
${font Ubuntu:pixelsize=13:normal}${execi 60  protonvpn s | head -n 1 | cut -f2 -d ':' | tr -d ' '} ${execi 60 protonvpn s | awk '/#/{print}' | cut -f2 -d ':' | tr -d ' '}
#${font sans-serif:normal:size=7}${execi 1200  sudo protonvpn -f c | tail -n2}

${downspeedgraph wlo1 60,150 000000 ffffff} ${alignr}${upspeedgraph wlo1 60,150 000000 ffffff}
${color darkred}${font Ubuntu:pixelsize=20:bold}TOP PROCESSES  ${hr 3}$color
${font Ubuntu:pixelsize=16:bold}NAME $alignr PID    CPU    MEM ${font Ubuntu:pixelsize=13:normal}
${top name 1} $alignr ${top pid 1} ${top cpu 1}% ${top mem 1}%
${top name 2} $alignr ${top pid 2} ${top cpu 2}% ${top mem 2}%
${top name 3} $alignr ${top pid 3} ${top cpu 3}% ${top mem 3}%
${top name 4} $alignr ${top pid 4} ${top cpu 4}% ${top mem 4}%
${top name 5} $alignr ${top pid 5} ${top cpu 5}% ${top mem 5}%
${top name 6} $alignr ${top pid 6} ${top cpu 6}% ${top mem 6}%
${top name 7} $alignr ${top pid 7} ${top cpu 7}% ${top mem 7}%
${top name 8} $alignr ${top pid 8} ${top cpu 8}% ${top mem 8}%
${top name 9} $alignr ${top pid 9} ${top cpu 9}% ${top mem 9}%
${top name 10} $alignr ${top pid 10} ${top cpu 10}% ${top mem 10}%

]];
