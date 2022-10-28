onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic :tb:clk
add wave -noupdate -format Literal :tb:a
add wave -noupdate -format Literal :tb:b
add wave -noupdate -format Logic :tb:clear
add wave -noupdate -format Literal :tb:result
add wave -noupdate -format Logic :tb:res_out
add wave -noupdate -divider {A reg}
add wave -noupdate -format Logic :tb:adder:sr_a:clk
add wave -noupdate -format Logic :tb:adder:sr_a:shift_in
add wave -noupdate -format Logic :tb:adder:sr_a:shift_out
add wave -noupdate -format Literal :tb:adder:sr_a:internal_reg
add wave -noupdate -divider {B Reg}
add wave -noupdate -format Logic :tb:adder:sr_b:clk
add wave -noupdate -format Logic :tb:adder:sr_b:shift_in
add wave -noupdate -format Logic :tb:adder:sr_b:shift_out
add wave -noupdate -format Literal :tb:adder:sr_b:internal_reg
add wave -noupdate -divider {C Reg}
add wave -noupdate -format Logic :tb:adder:sr_c:clk
add wave -noupdate -format Logic :tb:adder:sr_c:shift_in
add wave -noupdate -format Logic :tb:adder:sr_c:shift_out
add wave -noupdate -format Literal :tb:adder:sr_c:internal_reg
add wave -noupdate -divider {Carry Reg}
add wave -noupdate -format Logic :tb:adder:carry_reg:clk
add wave -noupdate -format Logic :tb:adder:carry_reg:clear
add wave -noupdate -format Logic :tb:adder:carry_reg:d
add wave -noupdate -format Logic :tb:adder:carry_reg:q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {114 fs} 0}
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
WaveRestoreZoom {0 fs} {558 fs}
