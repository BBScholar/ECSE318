onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal :p3_tb:mult:a
add wave -noupdate -format Literal :p3_tb:mult:b
add wave -noupdate -format Literal :p3_tb:mult:p
add wave -noupdate -format Logic :p3_tb:mult:negate
add wave -noupdate -format Literal :p3_tb:mult:a_comp
add wave -noupdate -format Literal :p3_tb:mult:b_comp
add wave -noupdate -format Literal :p3_tb:mult:a_ext
add wave -noupdate -format Literal :p3_tb:mult:carry
add wave -noupdate -format Literal :p3_tb:mult:sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18 ns} 0}
configure wave -namecolwidth 279
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {884 ns}
