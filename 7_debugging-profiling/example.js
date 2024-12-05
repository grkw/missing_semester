const fs = require("fs");

const fd = fs.openSync("foo.txt", "r+");
fs.writeSync(fd, "foo", "utf8");
const test = fs.readFileSync("foo.txt");
console.log(test);
