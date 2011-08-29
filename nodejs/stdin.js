var stdin = process.stdin
var stdout = process.stdout
stdin.resume()

stdin.on('data', function(c){
	stdout.write(c)
})

stdin.on('end', function(){
	stdout.write('end')
})
