onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic :p2_tb:mult:clk
add wave -noupdate -format Logic :p2_tb:mult:load
add wave -noupdate -format Literal :p2_tb:mult:a
add wave -noupdate -format Literal :p2_tb:mult:b
add wave -noupdate -format Literal :p2_tb:mult:p
add wave -noupdate -format Logic :p2_tb:mult:valid
add wave -noupdate -format Logic :p2_tb:mult:adder_co
add wave -noupdate -format Logic :p2_tb:mult:and_bit
add wave -noupdate -format Logic :p2_tb:mult:p_reg_so
add wave -noupdate -format Literal :p2_tb:mult:p_reg_q
add wave -noupdate -format Literal :p2_tb:mult:a_reg_q
add wave -noupdate -format Literal :p2_tb:mult:b_reg_q
add wave -noupdate -format Literal :p2_tb:mult:anded_b
add wave -noupdate -format Literal :p2_tb:mult:adder_sout
add wave -noupdate -format Literal :p2_tb:mult:p_reg_in
add wave -noupdate -format Logic :p2_tb:mult:state_load
add wave -noupdate -format Logic :p2_tb:mult:state_valid
add wave -noupdate -format Logic :p2_tb:mult:state_calc
add wave -noupdate -format Logic :p2_tb:mult:done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {362 ns} 0}
configure wave -namecolwidth 194
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
WaveRestoreZoom {0 ns} {3697 ns}
