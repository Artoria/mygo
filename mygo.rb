# vim: ft=ruby
filename = ARGV[1]
raise "Extension can't be go" if File.extname(filename) == ".go"
open((out = File.dirname(filename) + '/' + File.basename(filename, ".mygo") + ".go"), "w") do |f|
    a = IO.binread filename
    a.gsub!(/\(([^A-Za-z0-9()_\s][^)]*)\)/){
  	  "__mygo__" + [$1].pack("m0").tr("+/=","_")
    }
    a.gsub!(/`([^A-Za-z0-9()_\s][^)]*)`/){
  	  ".__mygo__" + [$1].pack("m0").tr("+/=","_")
    }
    f.write a
end

system "cmd /c env go " + ARGV[0] + " " +  out
