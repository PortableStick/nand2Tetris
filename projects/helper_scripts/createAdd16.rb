#! /usr/bin/ruby

def createAdd16
    preamble = '// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/02/Adder16.hdl

/**
 * Adds two 16-bit values.
 * The most significant carry bit is ignored.
 */

CHIP Add16 {
    IN a[16], b[16];
    OUT out[16];

    PARTS:
   // Put you code here:'

    footer = "}"

    output = (1..15).map do |i|
        "\tFullAdder(a=a[#{i}], b=b[#{i}], c=carry#{i - 1}, carry=carry#{i}, sum=out[#{i}]);\n"
    end

    File.open('Add16.hdl', 'w') do |f|
        f.puts preamble + "\n\tFullAdder(a=a[0], b=b[0], c=false, carry=carry0, sum=out[0]);\n" + output.join + footer
    end
end

createAdd16