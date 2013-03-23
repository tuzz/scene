Gem::Specification.new do |s|
  s.name        = 'scene'
  s.version     = '0.0.3'
  s.date        = '2012-03-03'
  s.summary     = 'Super Simple Scene'
  s.description = 'Render OpenGL animations with sensible defaults'
  s.author      = 'Chris Patuzzo'
  s.email       = 'chris@patuzzo.co.uk'
  s.files       =  ['README.md'] + Dir['lib/**/*.*']
  s.homepage    = 'https://github.com/tuzz/scene'
  
  s.add_dependency 'opengl', '>= 0.7.0.pre1'
  s.add_development_dependency 'rspec'
end
