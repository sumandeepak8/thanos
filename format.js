const { readFileSync } = require('fs');
var Table = require('cli-table');
var table = new Table({
  chars: { 'top': '═' , 'top-mid': '╤' , 'top-left': '╔' , 'top-right': '╗'
         , 'bottom': '═' , 'bottom-mid': '╧' , 'bottom-left': '╚' , 'bottom-right': '╝'
         , 'left': '║' , 'left-mid': '╟' , 'mid': '─' , 'mid-mid': '┼'
         , 'right': '║' , 'right-mid': '╢' , 'middle': '│' }
,
 head: ["serial no.","Name", "Total Commits", "Last Commit Time", "coverage", "Failing tests", "Passing Tests"] 
});

let data = readFileSync('log','utf-8');
data = data.split('\n');
data.pop();
data=data.map((x)=>x.split(","));
data.map((x)=>table.push(x))

console.log(table.toString());
