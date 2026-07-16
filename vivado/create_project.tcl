if {![info exists ::env(DEVICE_PART)]} {
    set ::env(DEVICE_PART) xc7z020clg400-1
}

set project_name zynq_ethernet_switch
set project_root [file normalize [file join [file dirname [info script]] .. build $project_name]]
set source_root [file normalize [file join [file dirname [info script]] .. rtl]]

create_project $project_name $project_root -part $::env(DEVICE_PART) -force
add_files [glob -nocomplain [file join $source_root *.v]]
set_property top ethernet_switch [current_fileset]
update_compile_order -fileset sources_1
puts "Created portable RTL project. Add board constraints, MAC/DMA IP, and AXI address assignment before synthesis."
