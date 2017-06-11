#! /usr/bin/ruby

def createNot16
  preamble = "// This file is part of www.nand2tetris.org
// and the book \"The Elements of Computing Systems\"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Not16.hdl

/**
 * 16-bit Not:
 * for i=0..15: out[i] = not in[i]
 */

CHIP Not16 {
  IN in[16];
  OUT out[16];

  PARTS:
  // Put your code here:\n"

  footer = "}"

  output = (0..15).map do |i|
    "\tNot(in=in[#{i}], out=out[#{i}]);\n"
  end

  File.open("Not16.hdl", 'w') do |f|
    f.puts preamble + output.join + footer
  end
end

createNot16