require 'scene/default_scene'
require 'opengl'
include Gl, Glu, Glut

class Scene
  
  include DefaultScene
  
  def self.display
    initialize
    
    glutDisplayFunc(Proc.new { display_proxy })
    glutTimerFunc(10, Proc.new { timer_proxy }, 0)
    glutKeyboardFunc(Proc.new { |key, x, y| keyboard_proxy(key, x, y) })
    glutMouseFunc(Proc.new { |button, state, x, y| instance.mouse(button, state, x, y) })
    glutReshapeFunc(Proc.new { |width, height| instance.reshape(width, height) })
    
    glutMainLoop
  end
  
private
  
  def self.instance
    @instance ||= new
  end
  
  def self.initialize
    glutInit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
    glutInitWindowSize(800, 800)
    glutCreateWindow('Super Simple Scene')
    
    glClearColor(0, 0, 0, 0)
    glEnable(GL_DEPTH_TEST)
    
    glMatrixMode(GL_PROJECTION)
    gluPerspective(60, 1, 1, 10)
    glMatrixMode(GL_MODELVIEW)
    gluLookAt(0, 0, -4, 0, 0, 1, 0, 1, 0)
    
    instance # Allow initializer overrides
  end
  
  def self.display_proxy
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    instance.display
    glutSwapBuffers
  end
  
  def self.timer_proxy
    @time ||= Time.now.to_f
    elapsed = Time.now.to_f - @time
    @time = Time.now.to_f
    instance.timer(elapsed)
    glutPostRedisplay
    glutTimerFunc(10, Proc.new { timer_proxy }, 0)
  end
  
  def self.keyboard_proxy(key, x, y)
    instance.keyboard(key.chr, x, y)
  end
  
end
