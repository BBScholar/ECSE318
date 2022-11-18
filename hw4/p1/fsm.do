onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic :tb:clk
add wave -noupdate -format Logic :tb:R
add wave -noupdate -format Logic :tb:A
add wave -noupdate -format Logic :tb:reset
add wave -noupdate -format Logic :tb:E_b
add wave -noupdate -format Logic :tb:E_s
add wave -noupdate -format Logic :tb:E_diff
add wave -noupdate -divider Behav
add wave -noupdate -format Literal :tb:both:behav_fsm:current_state
add wave -noupdate -format Literal :tb:both:behav_fsm:next_state
add wave -noupdate -divider Struct
add wave -noupdate -format Literal :tb:both:struct_fsm:state
add wave -noupdate -format Literal :tb:both:struct_fsm:next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {116 fs} 0}
configure wave -namecolwidth 246
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits fs
update
WaveRestoreZoom {0 fs} {529 fs}
