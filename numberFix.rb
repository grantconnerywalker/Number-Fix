# WARNING: This will affect ALL files in its directory. This script does not
# number the files itself; it simply corrects the number of leading zeros on a file for
# file sorting purposes.
#
# How to Use:
# 1. Put this script and the files you wish to change in the same directory.
# 2. Open a cmd terminal in the same directory.
# 3. Run 'ruby numberFix.rb'
# 4. Provide the number of leading zeros you would like at the end of your filename.
# 5. Examine the preview list of names, press y if you approve, otherwise press any key.
# 6. Wait for files to be changed.



# puts 1.to_s.rjust(3, "0")
# #=> 001
# puts 10.to_s.rjust(3, "0")
# #=> 010
# puts 100.to_s.rjust(3, "0")
# #=> 100

# File.rename(f, folder_path + "/" + filename.capitalize + File.extname(f))

# a.map {|x| x[/\d+/]}

# assembles new filename with substitutions
def modify_item(item, offset)
  basename = File.basename(item, ".*")
  number = basename.to_s.gsub(/^\D+[\d]*\D+/, '').gsub(/^0+/, '').rjust(offset.to_i, "0")
  text = basename.to_s.gsub(/\d+$/, '')
  return fullname = text + number + File.extname(item)
end

# prints the new file names for user review
def preview_names(offset)
  Dir.foreach('.') do |item|
    next if item == '.' or item == '..' or item == 'numberFix.rb'
    fullname = modify_item(item, offset)
    puts fullname
  end
end

# changes the file names for real
def change_names(offset)
  puts "Changing files..."
  Dir.foreach('.') do |item|
    next if item == '.' or item == '..' or item == 'numberFix.rb'
    fullname = modify_item(item, offset)
    File.rename(item, fullname)
  end
  puts "Done."
end

# main

puts "How many leading zeros would you like? (Please enter a single integer)"
offset = gets.chomp
preview_names(offset)

puts "\nDo these names look acceptable? (Y/N)"
continue = gets.chomp.downcase
if continue == 'y'
  change_names(offset)
else
  puts "Exiting program."
end
