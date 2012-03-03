Gem::Specification.new do |s|
  s.name        = 'scene'
  s.version     = '0.0.2'
  s.date        = '2012-03-03'
  s.summary     = 'Super simple scenes using OpenGL'
  s.description = 'Super simple scenes using OpenGL'
  s.author      = 'Christopher Patuzzo'
  s.email       = 'chris.patuzzo@gmail.com'
  s.files       =  ['README.md'] + Dir['lib/**/*.*']
  s.homepage    = 'https://github.com/cpatuzzo/scene'
  
  s.add_dependency 'opengl', '>= 0.7.0.pre1'
  s.add_development_dependency 'rspec'
end
