#!/usr/bin/env ruby

def create_mux_4_way_16
  preamble = "// This file is part of www.nand2tetris.org
// and the book \"The Elements of Computing Systems\"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Mux4Way16.hdl

/**
 * 4-way 16-bit multiplexor:
 * out = a if sel == 00
 *       b if sel == 01
 *       c if sel == 10
 *       d if sel == 11
 */

CHIP Mux4Way16 {
  IN a[16], b[16], c[16], d[16], sel[2];
  OUT out[16];

  PARTS:
  // Put your code here:\n\n"
  footer = "}"

  output = (0..15).map do |i|
    "\tMux(a=a[#{i}], b=c[#{i}], sel=sel[1], out=out#{i}1);
    Mux(a=b[#{i}], b=d[#{i}], sel=sel[1], out=out#{i}2);
    Mux(a=out#{i}1, b=out#{i}2, sel=sel[0], out=out[#{i}]);\n\n"
  end
  open("Mux4Way16.hdl", 'w') do |f|
    f.puts preamble + output.join + footer
  end
end

create_mux_4_way_16
