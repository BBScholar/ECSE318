onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic :soc:cpu:clk
add wave -noupdate -format Logic :soc:cpu:mem_write
add wave -noupdate -format Literal :soc:cpu:to_mem
add wave -noupdate -format Literal :soc:cpu:mem_addr
add wave -noupdate -format Literal :soc:cpu:from_mem
add wave -noupdate -format Literal :soc:cpu:pc
add wave -noupdate -format Literal :soc:cpu:PSR
add wave -noupdate -format Logic :soc:cpu:halt
add wave -noupdate -format Literal :soc:cpu:instruction
add wave -noupdate -format Literal :soc:cpu:branch_destination
add wave -noupdate -format Logic :soc:cpu:selected_branch_vector
add wave -noupdate -format Literal :soc:cpu:PSR_branch_vector
add wave -noupdate -format Literal :soc:cpu:opcode
add wave -noupdate -format Literal :soc:cpu:CC
add wave -noupdate -format Logic :soc:cpu:src_type
add wave -noupdate -format Logic :soc:cpu:dest_type
add wave -noupdate -format Literal :soc:cpu:src_addr
add wave -noupdate -format Literal :soc:cpu:dest_addr
add wave -noupdate -format Logic :soc:cpu:alu_use_imm
add wave -noupdate -format Logic :soc:cpu:rf_write
add wave -noupdate -format Literal :soc:cpu:writeback_sel
add wave -noupdate -format Logic :soc:cpu:set_psr
add wave -noupdate -format Logic :soc:cpu:clear_psr
add wave -noupdate -format Logic :soc:cpu:clear_psr_carry
add wave -noupdate -format Logic :soc:cpu:load_imm
add wave -noupdate -format Logic :soc:cpu:branch_op
add wave -noupdate -format Logic :soc:cpu:shift_rotate
add wave -noupdate -format Literal :soc:cpu:alu_op
add wave -noupdate -format Logic :soc:cpu:branch_vector_sel
add wave -noupdate -format Literal :soc:cpu:immediate
add wave -noupdate -format Literal :soc:cpu:immediate_ext
add wave -noupdate -format Literal :soc:cpu:alu_b_selected
add wave -noupdate -format Logic :soc:cpu:store_op
add wave -noupdate -format Literal :soc:cpu:src_out
add wave -noupdate -format Literal :soc:cpu:dest_out
add wave -noupdate -format Literal :soc:cpu:writeback_selected
add wave -noupdate -format Literal :soc:cpu:alu_out
add wave -noupdate -format Literal :soc:cpu:shift_out
add wave -noupdate -format Logic :soc:cpu:alu_cout
add wave -noupdate -format Logic :soc:cpu:shift_right
add wave -noupdate -format Literal :soc:cpu:shamt
add wave -noupdate -format Literal -expand :soc:cpu:rf:registers
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {536 fs} 0}
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
configure wave -timelineunits fs
update
WaveRestoreZoom {0 fs} {1 ps}
