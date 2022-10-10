onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -format Logic :testFreecell:fc:clock
add wave -noupdate -format Literal :testFreecell:fc:source
add wave -noupdate -format Literal :testFreecell:fc:dest
add wave -noupdate -divider Outputs
add wave -noupdate -format Logic :testFreecell:fc:win
add wave -noupdate -divider Decode
add wave -noupdate -format Logic :testFreecell:fc:src_tab
add wave -noupdate -format Logic :testFreecell:fc:src_free
add wave -noupdate -format Logic :testFreecell:fc:src_home
add wave -noupdate -format Logic :testFreecell:fc:dest_tab
add wave -noupdate -format Logic :testFreecell:fc:dest_free
add wave -noupdate -format Logic :testFreecell:fc:dest_home
add wave -noupdate -divider {Decode Decode}
add wave -noupdate -format Literal :testFreecell:fc:tab_src_decoded
add wave -noupdate -format Literal :testFreecell:fc:tab_dest_decoded
add wave -noupdate -format Literal :testFreecell:fc:free_src_decoded
add wave -noupdate -format Literal :testFreecell:fc:free_dest_decoded
add wave -noupdate -format Literal :testFreecell:fc:home_dest_decoded
add wave -noupdate -divider {Tableau Data}
add wave -noupdate -format Literal :testFreecell:fc:tab_top_cards
add wave -noupdate -format Literal :testFreecell:fc:tab_num_cards
add wave -noupdate -format Literal :testFreecell:fc:tab_full
add wave -noupdate -format Literal :testFreecell:fc:tab_empty
add wave -noupdate -divider {Free Data}
add wave -noupdate -format Literal :testFreecell:fc:free_top_cards
add wave -noupdate -format Literal :testFreecell:fc:free_num_cards
add wave -noupdate -format Literal :testFreecell:fc:free_full
add wave -noupdate -format Literal :testFreecell:fc:free_empty
add wave -noupdate -divider {Home Data}
add wave -noupdate -format Literal :testFreecell:fc:home_top_cards
add wave -noupdate -format Literal :testFreecell:fc:home_num_cards
add wave -noupdate -format Literal :testFreecell:fc:home_full
add wave -noupdate -format Literal :testFreecell:fc:home_empty
add wave -noupdate -divider {Selected Cards}
add wave -noupdate -format Literal :testFreecell:fc:src_card
add wave -noupdate -format Logic :testFreecell:fc:src_empty
add wave -noupdate -format Literal :testFreecell:fc:dest_card
add wave -noupdate -format Logic :testFreecell:fc:dest_full
add wave -noupdate -format Literal :testFreecell:fc:tab_src_card
add wave -noupdate -format Logic :testFreecell:fc:tab_src_empty
add wave -noupdate -format Literal :testFreecell:fc:tab_dest_card
add wave -noupdate -format Logic :testFreecell:fc:tab_dest_full
add wave -noupdate -format Literal :testFreecell:fc:free_src_card
add wave -noupdate -format Logic :testFreecell:fc:free_src_empty
add wave -noupdate -format Literal :testFreecell:fc:free_dest_card
add wave -noupdate -format Logic :testFreecell:fc:free_dest_full
add wave -noupdate -format Literal :testFreecell:fc:home_dest_card
add wave -noupdate -format Logic :testFreecell:fc:home_dest_full
add wave -noupdate -divider Control
add wave -noupdate -format Literal :testFreecell:fc:tab_push
add wave -noupdate -format Literal :testFreecell:fc:tab_pop
add wave -noupdate -format Literal :testFreecell:fc:home_push
add wave -noupdate -format Literal :testFreecell:fc:free_pop
add wave -noupdate -format Literal :testFreecell:fc:free_push
add wave -noupdate -divider {External Validate}
add wave -noupdate -format Logic :testFreecell:fc:valid
add wave -noupdate -format Logic :testFreecell:fc:invalid
add wave -noupdate -divider {Internal Validate}
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:source
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:dest
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:src_empty
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:dest_full
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:src_card
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:dest_card
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:valid
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:invalid
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:illegal_source
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:order_valid
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:order_invalid
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:src_dest_eq
add wave -noupdate -divider {Order Validation}
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:ord:dest_home
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:ord:dest_empty
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:top
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:future_top
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:ord:valid
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:top_suite
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:future_suite
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:top_value
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:future_value
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:ord:opposite_color
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:ord:same_color
add wave -noupdate -format Logic :testFreecell:fc:invalid_detect:ord:same_suite
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:home_valid_value
add wave -noupdate -format Literal :testFreecell:fc:invalid_detect:ord:tab_valid_value
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 fs} 0}
configure wave -namecolwidth 386
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
WaveRestoreZoom {0 fs} {61 fs}
