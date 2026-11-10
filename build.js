import fs from 'fs';
const root = import.meta.dirname;
const files = [
    `${root}/Global.xs`,
    `${root}/Array/IntArray.xs`,
    `${root}/Array/FloatArray.xs`,
    `${root}/Array/Records.xs`,
    `${root}/Functions/Util.xs`,
    `${root}/Functions/Messages.xs`,
    `${root}/Apis/TechState.xs`,
    `${root}/Apis/Timers.xs`,
    `${root}/Functions/Units.xs`,
    `${root}/Initialize.xs`
];

let source = '';
for(const val of files) {
    source += fs.readFileSync(val, 'utf8') + "\r\n";
}

fs.writeFileSync(`Rs.xs`, source);