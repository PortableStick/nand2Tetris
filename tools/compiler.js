#! /usr/bin/env node

const fs = require('fs')
const cCommandRegex = /([DMA]*)\=?([\+\-\&\|\!DMA\d]+[\+\-\&\|\!DMA10]*);?([JMPGTLTEQNE]*)/
const symbolTable = {
    'SP': 0,
    'LCL': 1,
    'ARG': 2,
    'THIS': 3,
    'THAT': 4,
    'SCREEN': 16384,
    'KBD': 24576,
    'R0': 0,
    'R1': 1,
    'R2': 2,
    'R3': 3,
    'R4': 4,
    'R5': 5,
    'R6': 6,
    'R7': 7,
    'R8': 8,
    'R9': 9,
    'R10': 10,
    'R11': 11,
    'R12': 12,
    'R13': 13,
    'R14': 14,
    'R15': 15
}

const destTable = {
    'M': '001',
    'D': '010',
    'MD': '011',
    'A': '100',
    'AM': '101',
    'AD': '110',
    'AMD': '111'
}
const jmpTable = {
    'JGT': '001',
    'JEQ': '010',
    'JGE': '011',
    'JLT': '100',
    'JNE': '101',
    'JLE': '110',
    'JMP': '111'
}
const cTable = {
    '0': '0101010',
    '1': '0111111',
    '-1': '0111010',
    'D': '0001100',
    'A': '0110000',
    '!D': '0001101',
    '!A': '0110001',
    '-D': '0001111',
    '-A': '0110011',
    'D+1': '0011111',
    'A+1': '0110111',
    'D-1': '0001110',
    'A-1': '0110010',
    'D+A': '0000010',
    'D-A': '0010011',
    'A-D': '0000111',
    'D&A': '0000000',
    'D|A': '0010101',
    'M': '1110000',
    '!M': '1110001',
    'M+1': '1110111',
    'M-1': '1110010',
    'D+M': '1000010',
    'D-M': '1010011',
    'M-D': '1000111',
    'D&M': '1000000',
    'D|M': '1010101'
}

let memspace = 16

const filename = process.argv[2]
const outputName = process.argv[3] || filename.replace('.asm', '.hack')

fs.readFile(filename, 'utf8', (err, file) => {
    if (err) throw err
    let contents = file.toString()
        .replace(/\/\/.*/gi, '')
        .split('\n')
        .filter(s => s.length > 0)
        .filter(s => s != '\r')
        .map(s => s.replace('\r', '').trim())

    let i = 0
    while (contents[i]) {
        const s = contents[i]
        if (s === undefined) {}
        const match = s.match(/\(([\w\.\$\_]*)\)/)
        if (match && !symbolTable[match[1]]) {
            symbolTable[match[1]] = i
            contents.splice(i, 1)
            continue
        }
        i++
    }

    contents.forEach(s => {
        const match = s.match(/@([\w\_\.]*)/)
        if (match && symbolTable[match[1]] === undefined) {
            let sym = match[1]
            if (sym.match(/^\d/)) {
                symbolTable[sym] = sym
            } else {
                symbolTable[sym] = memspace
                memspace++
            }
        }
    })

    contents = contents.map((s, i, arr) => {
            if (i === 406) {
                console.log(contents[i - 1])
                console.log(s)
            }
            if (s.startsWith('@')) {
                let s2 = s.slice(1)
                let final = binaryConverter(symbolTable[s2], i, arr)
                return final + '\n'
            } else if (s.match(/\((\w*)\)/)) {
                return ''
            } else {
                let cCommand = s.match(cCommandRegex)
                let dest = destTable[cCommand[1]] || '000'
                let c = cTable[cCommand[2]]
                if (c === "-1") {
                    console.log(cCommand)
                }
                let jmp = jmpTable[cCommand[3]] || '000'
                if (i === 406) {
                    console.log(`${cCommand}`)
                    process.exit(1)
                }
                return `111${c}${dest}${jmp}\n`;
            }
        }).filter(s => s.length > 0).join('')
        // console.log(symbolTable)
    fs.writeFile(outputName, contents, () => console.log(`Wrote file ${outputName}`))
})

function binaryConverter(str, i, arr) {
    let num = +(str)
    num = num.toString(2)
    while (num.length < 16) {
        num = `0${num}`
    }
    return num
}