if [file exists "work"] {vdel -all}
vlog -f rtl/dut.f
vlog intf.sv my_pkg.svh
vlog tb_top.sv +cover
vsim -debugDB work.tb_top -coverage +UVM_TESTNAME=my_test
add wave -position insertpoint  \
sim:/tb_top/ifc/*
run -all;
coverage report -codeAll -cvg -verbose