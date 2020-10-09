require "../yaml_merger"

folders = ARGV[0].split("|")

contents = [] of String

folders.each do |folder|
  dir = Dir.new(folder)
  dir.each do |filename|
    if filename =~ /.+\.yml$/
      contents << File.read(folder + "/" + filename)
    end
  end
end

final_content = Glassy::I18n::YamlMerger.new(contents).merge

File.write("/tmp/test", final_content)

puts "<<-LOCALEFILE"
puts final_content
puts "LOCALEFILE"
