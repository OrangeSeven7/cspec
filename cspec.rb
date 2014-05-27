x = ""
puts ARGV.inspect
file_path = ARGV[0]
funct = ARGV[1]
parameters = ARGV[2]
k = 0
File.open(file_path).each do |line|
	f = line.strip unless line.nil?
	unless f.nil?
		unless f[4..-1].nil?
			stripped = f[4..-1].strip.first(funct.length)
		else
			stripped = ""
		end
		if f[0..3] == "def " and stripped == funct
			puts "here"
  		x += line.strip+"\n"
			k = 1
		elsif k == 1
			if (f+" ")[0..3] == "end "
				x += line.strip+"\n"
				k = 0
			else
				x += line.strip+"\n"
			end
		end
	end
end

ints = x.scan(/\b\d+\b/).map{|t| t.to_i}
ints += ints.map{|t| -t}
ints.map!{|t| t.to_s}
floats = x.scan(/\b\d+\.\d+\b/).map{|t| t.to_f}
floats += floats.map{|t| -t}
floats.map!{|t| t.to_s}
strs = x.scan(/\".+\"|\'.+\'/).map{|t| t[1..-2]}
arrs = x.scan(/\[.+\]/)
hashes = x.scan(/\{.+\}/)

eval(x)
g = 0
y = Array.new()
ARGV[2].each do |t|
	if t == "int"
		y.push((["nil", "-1", "0", "1", "1634719261491461971234623469249231246823912391441249"] + ints).uniq)
	elsif t == "float"
		y.push((["nil","-1.0","0.0","-1.0", "1634719261491461971234623469249231246823912391441249.0"] + floats).uniq)
	elsif t == "string"
		y.push((["nil","", [*(1..255)].map{|t| t.chr}.shuffle.join, ([*(1..255)]*30).map{|t| t.chr}.shuffle.join]+strs).uniq)
	elsif t == "array"
		y.push((["nil","[]","[*(1..10)]","[*(1..1000000)]",[*(1..1000)].map{|t| t.to_f}.to_s,(["asdf"]*100).to_s]+arrs).uniq)
	else
		y.push((["nil","{}","{1=>2}",[*(1..100)].shuffle.zip([*(1..100)].shuffle).to_h.to_s, [*(1..255)].map{|t| t.chr}.shuffle.zip([*(1..255)].map{|t| t.chr}.shuffle).to_h.to_s]+hashes).uniq)
	end
	g+=1
end

char_to_int = {0 => "a", 1 => "b", 2 => "c", 3 => "d", 4 => "e", 5 => "f", 6 => "g", 7 => "h", 8 => "i", 9 => "j", 10 => "k", 11 => "l", 12 => "m", 13 => "n", 14 => "o", 15 => "p", 16 => "q", 17 => "r", 18 => "s", 19 => "t", 20 => "u", 21 => "v", 22 => "w", 23 => "x", 24 => "y", 25 => "z"}

runnable = ""

m = [*(0..g-1)].map{|t| char_to_int[t]}
while (g-=1)>=0
	runnable += "y[#{g}].each do |#{m[g]}|\n"
end
runnable += "begin\n #{funct}(#{m.join(",")})\n rescue\n puts \"succeeded on:\" + m.map{|t| eval(t)}.inspect.to_s\n end \n" + ("end\n"*m.length)

eval(runnable)
