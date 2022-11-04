onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic :tx_tb:clk
add wave -noupdate -format Logic :tx_tb:pclear_b
add wave -noupdate -format Literal :tx_tb:tx_data
add wave -noupdate -format Literal :tx_tb:rx_data
add wave -noupdate -format Logic :tx_tb:txd
add wave -noupdate -format Logic :tx_tb:sout
add wave -noupdate -format Logic :tx_tb:tx_done
add wave -noupdate -format Logic :tx_tb:clk
add wave -noupdate -format Logic :tx_tb:pclear_b
add wave -noupdate -format Literal :tx_tb:tx_data
add wave -noupdate -format Literal :tx_tb:rx_data
add wave -noupdate -format Logic :tx_tb:txd
add wave -noupdate -format Logic :tx_tb:sout
add wave -noupdate -format Logic :tx_tb:tx_done
add wave -noupdate -format Logic :tx_tb:tx:pclear_b
add wave -noupdate -format Logic :tx_tb:tx:SSPCLKOUT
add wave -noupdate -format Logic :tx_tb:tx:tx_empty
add wave -noupdate -format Literal :tx_tb:tx:tx_data
add wave -noupdate -format Logic :tx_tb:tx:SSPTXD
add wave -noupdate -format Logic :tx_tb:tx:SSPFSSOUT
add wave -noupdate -format Logic :tx_tb:tx:tx_done
add wave -noupdate -format Literal :tx_tb:tx:state
add wave -noupdate -format Literal :tx_tb:tx:next_state
add wave -noupdate -format Literal :tx_tb:tx:cycle_counter
add wave -noupdate -format Literal :tx_tb:tx:send_data
add wave -noupdate -format Logic :tx_tb:tx:send_bit
add wave -noupdate -format Logic :tx_tb:tx:tx_has_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5 fs} 0}
configure wave -namecolwidth 305
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
WaveRestoreZoom {0 fs} {144 fs}
