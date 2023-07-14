# general utils
vsim work.eight_bit_tristate_buffer_test
run -all

vsim work.one_bit_tristate_buffer_test
run -all

# ALU Components
vsim work.add_component_test
run -all

vsim work.and_component_test
run -all

vsim work.not_component_test
run -all

vsim work.or_component_test
run -all

vsim work.shl_component_test
run -all

vsim work.shr_component_test
run -all

vsim work.sub_component_test
run -all

vsim work.xor_component_test
run -all

# ALU

vsim work.alu_test
run -all

quit -sim

