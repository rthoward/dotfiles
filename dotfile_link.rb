# Richard Howard, 2013
require 'fileutils'
require_relative 'include/dotfile_utils.rb'
require_relative 'include/text_colors.rb'

# main ---------------------------------------------------

repo_dir = File.expand_path(File.dirname(__FILE__)) + "/files/"
home_dir = Dir.home + "/"

confirm_dirs(repo_dir, home_dir)

file_list = strip_unwanted_files(Dir.entries(repo_dir))

file_list.each do |filename|
   abs_source = repo_dir + filename
   abs_target = home_dir + filename

   STDOUT.print get_copy_details("#{repo_dir}#{filename}", "#{home_dir}#{filename}") 
   if make_link(abs_source, abs_target, false) == 0
      puts green("[ DONE ]")
   else
      puts
      if confirm_overwrite(abs_source, abs_target)
         puts green("[ DONE ]")
      else
         unless make_link(abs_source, abs_target, true)
            puts red("[FAILED]")
         else
            puts green("[ DONE ]")
         end         
      end
   end   
end
