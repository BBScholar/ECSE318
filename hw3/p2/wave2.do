onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal :tb2:adder:sr_a:internal_reg
add wave -noupdate -format Literal :tb2:adder:sr_b:internal_reg
add wave -noupdate -format Literal :tb2:adder:sr_c:internal_reg
add wave -noupdate -format Logic :tb2:adder:carry_reg:q
add wave -noupdate -format Literal :tb2:i
add wave -noupdate -format Logic :tb2:clk
add wave -noupdate -format Logic :tb2:clear
add wave -noupdate -format Literal :tb2:a
add wave -noupdate -format Literal :tb2:b
add wave -noupdate -format Logic :tb2:shift_out
add wave -noupdate -format Literal :tb2:result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {517 fs} 0}
configure wave -namecolwidth 255
configure wave -valuecolwidth 140
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
WaveRestoreZoom {0 fs} {546 fs}
