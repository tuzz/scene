require 'scene/default_scene'
require 'opengl'
include Gl, Glu, Glut

class Scene
  
  include DefaultScene
  
  def self.display(*args)
    initialize
    
    glutDisplayFunc(Proc.new { display_proxy(*args) })
    glutKeyboardFunc(Proc.new { |key, x, y| keyboard_proxy(key, x, y) })
    glutMouseFunc(Proc.new { |button, state, x, y| mouse(button, state, x, y) })
    glutReshapeFunc(Proc.new { reshape(width, height) })
    
    glutMainLoop
  end
  
private
  
  def self.instance
    @instance ||= new
  end
  
  def self.initialize
    glutInit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
    glutInitWindowSize(800, 800)
    glutCreateWindow('Super Simple Scene')
    
    glClearColor(0, 0, 0, 0)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    glOrtho(0, 1, 0, 1, -1, 1)
    instance # Allow initializer overrides
  end
  
  def self.display_proxy(*args)
    glClear(GL_COLOR_BUFFER_BIT)
    instance.display(*args)
    glutSwapBuffers
    sleep(0.01)
  end
  
  def self.keyboard_proxy(key, x, y)
    instance.keyboard(key.chr, x, y)
  end
  
end
