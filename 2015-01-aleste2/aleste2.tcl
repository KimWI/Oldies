set throttle off
set readdict [dict create]
set writedict [dict create]

debug set_bp 0xc01f {} {
  debug set_watchpoint read_mem {0xF197 0xFFFE} {[pc_in_slot 3 0]} {
    set addr [format "%04X" $::wp_last_address]
    if {![dict exists $readdict $addr]} {
      dict append readdict $addr 0
      puts stderr [format "read %s" $addr]
    }
  }
  debug set_watchpoint write_mem {0xF197 0xFFFE} {[pc_in_slot 3 0]} {
    set addr [format "%04X" $::wp_last_address]
    if {![dict exists $writedict $addr]} {
      dict append writedict $addr 0
      puts stderr [format "write %s" $addr]
    }
  }
  debug break
}
