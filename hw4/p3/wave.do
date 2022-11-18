onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider RXTX
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:pclk
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:pclear_b
add wave -noupdate -format Literal :ssp_test2:ssp2:rxtx:tx_data
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:tx_empty
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPCLKOUT
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPTXD
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPFSSOUT
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPOE_B
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:tx_done
add wave -noupdate -format Literal :ssp_test2:ssp2:rxtx:rx_data
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPCLKIN
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPFSSIN
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:SSPRXD
add wave -noupdate -format Logic :ssp_test2:ssp2:rxtx:rx_done
add wave -noupdate -divider {RX FIFO}
add wave -noupdate -format Logic :ssp_test2:ssp2:rx_fifo:clk
add wave -noupdate -format Logic :ssp_test2:ssp2:rx_fifo:push
add wave -noupdate -format Logic :ssp_test2:ssp2:rx_fifo:pop
add wave -noupdate -format Logic :ssp_test2:ssp2:rx_fifo:clear_b
add wave -noupdate -format Literal :ssp_test2:ssp2:rx_fifo:data_in
add wave -noupdate -format Logic :ssp_test2:ssp2:rx_fifo:full
add wave -noupdate -format Logic :ssp_test2:ssp2:rx_fifo:empty
add wave -noupdate -format Literal :ssp_test2:ssp2:rx_fifo:data_out
add wave -noupdate -format Literal :ssp_test2:ssp2:rx_fifo:counter
add wave -noupdate -format Literal :ssp_test2:ssp2:rx_fifo:i
add wave -noupdate -divider {TX FIFO}
add wave -noupdate -format Logic :ssp_test2:ssp2:tx_fifo:clk
add wave -noupdate -format Logic :ssp_test2:ssp2:tx_fifo:push
add wave -noupdate -format Logic :ssp_test2:ssp2:tx_fifo:pop
add wave -noupdate -format Logic :ssp_test2:ssp2:tx_fifo:clear_b
add wave -noupdate -format Literal :ssp_test2:ssp2:tx_fifo:data_in
add wave -noupdate -format Logic :ssp_test2:ssp2:tx_fifo:full
add wave -noupdate -format Logic :ssp_test2:ssp2:tx_fifo:empty
add wave -noupdate -format Literal :ssp_test2:ssp2:tx_fifo:data_out
add wave -noupdate -format Literal :ssp_test2:ssp2:tx_fifo:counter
add wave -noupdate -format Literal :ssp_test2:ssp2:tx_fifo:i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 0}
configure wave -namecolwidth 302
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
WaveRestoreZoom {0 fs} {2485 fs}
