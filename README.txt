Examples

ARGV[0] = the path to file.
ARGV[1] = the function
ARGV[2] = parameters


Example:

If you have a file located at /home/aemon/Documents/datamine/app/controllers/emails_controller.rb with a function called thing, that accepts 3 variables, which are int, string, and int (the current possibilities are int, string, float, array, and hash), you would run the following

ARGV = ["/home/aemon/Documents/datamine/app/controllers/emails_controller.rb", "thing", ["int", "string", "int"]]
load "/<pathto>/cspec.rb"
