onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic :tb:adder:clk
add wave -noupdate -format Logic :tb:adder:clear
add wave -noupdate -format Logic :tb:adder:a
add wave -noupdate -format Logic :tb:adder:b
add wave -noupdate -format Logic :tb:adder:result
add wave -noupdate -format Logic :tb:adder:cout
add wave -noupdate -format Logic :tb:adder:fa_a
add wave -noupdate -format Logic :tb:adder:fa_b
add wave -noupdate -format Logic :tb:adder:fa_c
add wave -noupdate -format Logic :tb:adder:fa_cout
add wave -noupdate -format Logic :tb:adder:fa_s
add wave -noupdate -format Logic :tb:adder:sr_b:clk
add wave -noupdate -format Logic :tb:adder:sr_b:shift_in
add wave -noupdate -format Logic :tb:adder:sr_b:shift_out
add wave -noupdate -format Literal :tb:adder:sr_b:internal_reg
add wave -noupdate -format Logic :tb:clk
add wave -noupdate -format Literal :tb:a
add wave -noupdate -format Literal :tb:b
add wave -noupdate -format Logic :tb:clear
add wave -noupdate -format Literal :tb:result
add wave -noupdate -format Logic :tb:res_out
add wave -noupdate -format Logic :tb:cout
add wave -noupdate -format Logic :tb:adder:sr_c:clk
add wave -noupdate -format Logic :tb:adder:sr_c:shift_in
add wave -noupdate -format Logic :tb:adder:sr_c:shift_out
add wave -noupdate -format Literal :tb:adder:sr_c:internal_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 fs} 0}
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
WaveRestoreZoom {0 fs} {127 fs}
