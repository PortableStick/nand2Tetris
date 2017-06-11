#! /usr/bin/ruby

def createInc16
    preamble = '// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/02/Inc16.hdl

/**
 * 16-bit incrementer:
 * out = in + 1 (arithmetic addition)
 */

CHIP Inc16 {
    IN in[16];
    OUT out[16];

    PARTS:
   // Put you code here:'

    footer = "}"

    output = (1..15).map do |i|
        "\tFullAdder(a=in[#{i}], b=false, c=carry#{i - 1}, carry=carry#{i}, sum=out[#{i}]);\n"
    end

    File.open('Inc16.hdl', 'w') do |f|
        f.puts preamble + "\n\tFullAdder(a=in[0], b=true, c=false, carry=carry0, sum=out[0]);\n" + output.join + footer
    end
end

createInc16