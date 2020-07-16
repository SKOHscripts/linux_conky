conky.config = {

	lua_load = "~/CloudStation/Documents/scripts/linux_conky/draw_bg.lua",
    -- lua_startup_hook = "draw_bg",
    lua_draw_hook_pre = "draw_bg",
    -- lua_draw_hook_post = "conky_update",


	
	update_interval = 0.5,
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
	own_window_argb_value = 200,
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

	border_inner_margin = 5,
	border_outer_margin = 0,
	xinerama_head = 1,
	alignment = 'top_right',
	gap_x = 20,
	gap_y = 50,


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

};
conky.text = [[
${font}${voffset -15}
${color darkred}${font sans-serif:bold:size=14}SYSTEM  ${hr 3 }$color
${font sans-serif:normal:size=10}${exec lsb_release -d | cut -f2 } 
#$alignr${font sans-serif:bold:size=13}${execi 1000 date "+%d %B"}  ${exec date "+%H:%M"}
${font sans-serif:normal:size=10}Host: $alignr$nodename
Uptime: $uptime_short
${exec acpi -b | grep "Battery 0" | awk '{ print "State : " $3 "  Capacity : "$4 "  (" $5 ")"}'}

${color darkred}${font sans-serif:bold:size=14}CPU  ${hr 3}$color
${font sans-serif:normal:size=10}${execi 1000 grep model /proc/cpuinfo | cut -d : -f2 | tail -1 | sed 's/\s//'}
${font sans-serif:normal:size=10}${cpugraph 50,300 000000 ffffff cpu}
${cpu cpu0}%${goto 50}${cpubar cpu0 7,80} $alignr${cpu cpu1}%   ${cpubar cpu1 7,80}
${cpu cpu2}%${goto 50}${cpubar cpu2 7,80} $alignr${cpu cpu3}%   ${cpubar cpu3 7,80}
${freq_g}GHz $alignr${exec sensors | grep 'Core 0' | cut -c17-18}°C

${color darkred}${font sans-serif:bold:size=14}MEMORY  ${hr 3}$color
${font sans-serif:normal:size=10}RAM $alignc $mem / $memmax $alignr $memperc%
${membar 7}
SWAP $alignc ${swap} / ${swapmax} $alignr ${swapperc}%
${swapbar 7}

${color darkred}${font sans-serif:bold:size=14}DISK USAGE  ${hr 3}$color
${font sans-serif:normal:size=10}/ $alignc ${fs_used /} / ${fs_size /} $alignr ${fs_used_perc /}%
${fs_bar 7 /}
${font sans-serif:normal:size=10}BACKUP_DISK $alignc ${fs_used /media/corentin/BACKUP_DISK} / ${fs_size /media/corentin/BACKUP_DISK} $alignr ${fs_used_perc /media/corentin/BACKUP_DISK}%
${fs_bar 7 /media/corentin/BACKUP_DISK}
${font sans-serif:normal:size=10}USB_MICHELC $alignc ${fs_used /media/corentin/USB_MICHELC} / ${fs_size /media/corentin/USB_MICHELC} $alignr ${fs_used_perc /media/corentin/USB_MICHELC}%
${fs_bar 7 /media/corentin/USB_MICHELC}
Temperature: ${execi 10 sudo nvme smart-log /dev/nvme0 | grep 'Temperature Sensor' | cut -c39-40}°C

${color darkred}${font Ubuntu:bold:size=14}NETWORK  ${hr 3}$color
${font sans-serif:normal:size=10}Local IPs:$alignr ${execi 120 ip a | grep inet | grep -vw lo | grep -v inet6 | cut -d \/ -f1 | sed 's/[^0-9\.]*//g'}
External IP:${alignr}${execi 1000  wget -q -O- http://ipecho.net/plain; echo}
${font sans-serif:normal:size=10}WIFI : Down: ${downspeed wlo1}  ${alignr}Up: ${upspeed wlo1}
${font sans-serif:normal:size=7}${execi 60  protonvpn s | head -n 1 | cut -f2 -d ':' | tr -d ' '} ${execi 60 protonvpn s | awk '/#/{print}' | cut -f2 -d ':' | tr -d ' '}
#${font sans-serif:normal:size=7}${execi 1200  sudo protonvpn -f c | tail -n2}

${downspeedgraph wlo1 60,150 000000 ffffff} ${alignr}${upspeedgraph wlo1 60,150 000000 ffffff}
${color darkred}${font sans-serif:bold:size=14}TOP PROCESSES  ${hr 3}$color
${font sans-serif:bold:size=10}NAME $alignr PID    CPU    MEM ${font sans-serif:normal:size=10}
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
