module Exetel end

%w(
exetel/api
exetel/response
).each do |lib|
  require File.join(File.dirname(__FILE__), lib)
end