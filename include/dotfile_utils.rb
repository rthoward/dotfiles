# Richard Howard, 2013

# file targets -----------------------------------------------

def strip_unwanted_files(file_list)
   file_list.delete_if {|filename| filename == "." || filename == ".."}
   return file_list
end

def get_copy_details(source, target)
   return "#{source.ljust(50)} -> #{target.ljust(30)}"
end

# linking --------------------------------------------------

# makes symlink in directory
# retuns 0 on success, > 0 on failure
def make_link(source, target, shouldForce)

   begin
      if shouldForce
         FileUtils.ln_sf(source, target)
      else
         FileUtils.symlink(source, target)
      end
   rescue
      return 1
   end

   return 0
end

# user confirmation / error processing -------------------------

def confirm_dirs(repo_dir, home_dir)
   puts "please confirm the following two directories"
   puts "   repo: #{repo_dir}"
   puts "   home: #{home_dir}"
   STDOUT.print "correct? [y/n] "
   input = gets.chomp
   unless input == "y" || input == "Y" || input.downcase == "yes"
      puts "ERROR: incorrect directories"
      exit 1
   end

   puts "ok, thanks"
   puts
end

# return true on success, false on failure
def confirm_overwrite(source, target)
   decided = false
   while true do
      STDOUT.print red("WARNING: overwrite file #{target}? [(y)es/(n)o/(d)iff] ")
      STDOUT.flush
      input = gets.chomp
      if input == "y"
         return true
      elsif input == "n"
         return false
      elsif input == "d"
         # TODO: diff 
         puts "DIFF"
      end
   end 
end

def abort(reason)
   puts "ERROR: #{reason}"
   exit 1
end
