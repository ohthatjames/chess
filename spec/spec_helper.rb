$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'chess'
require 'pry'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
