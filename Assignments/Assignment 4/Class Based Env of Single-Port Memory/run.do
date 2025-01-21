add wave -position insertpoint  \
sim:/top/ifc/*
run -all;
coverage report -codeAll -cvg -verbose