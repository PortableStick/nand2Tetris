#! /usr/bin/ruby

def createOr16
    preamble = '// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Or16.hdl

/**
 * 16-bit bitwise Or:
 * for i = 0..15 out[i] = (a[i] or b[i])
 */

CHIP Or16 {
    IN a[16], b[16];
    OUT out[16];

    PARTS:
    // Put your code here:
'

    footer = "}\n"

    output = (0..15).map do |i|
        "\tOr(a=a[#{i}], b=b[#{i}], out=out[#{i}]);\n"
    end

    File.open("Or16.hdl", 'w') do |f|
        f.puts preamble + output.join + footer
    end
end

createOr16