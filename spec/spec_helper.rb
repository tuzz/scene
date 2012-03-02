require 'rspec'
require 'scene'

RSpec.configure do |config|
  
  config.before do
    opengl_methods = (Gl.methods | Glu.methods | Glut.methods).select { |m| m =~ /^gl/ }
    opengl_methods.each { |method_name| Object.stub(method_name) }
  end
  
end
