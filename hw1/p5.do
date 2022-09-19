onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Struct
add wave -noupdate -format Logic :p5_tb:s1:clk
add wave -noupdate -format Logic :p5_tb:s1:out
add wave -noupdate -format Logic :p5_tb:s1:a
add wave -noupdate -format Logic :p5_tb:s1:b
add wave -noupdate -format Logic :p5_tb:s1:t1
add wave -noupdate -format Logic :p5_tb:s1:t2
add wave -noupdate -divider Behave
add wave -noupdate -format Logic :p5_tb:s2:clk
add wave -noupdate -format Logic :p5_tb:s2:out
add wave -noupdate -format Logic :p5_tb:s2:A
add wave -noupdate -format Logic :p5_tb:s2:B
add wave -noupdate -divider Overall
add wave -noupdate -format Logic :p5_tb:clk
add wave -noupdate -format Logic :p5_tb:w
add wave -noupdate -format Logic :p5_tb:e
add wave -noupdate -format Logic :p5_tb:out1
add wave -noupdate -format Logic :p5_tb:out2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7 ns} 0}
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {84 ns}
