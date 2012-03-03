require 'opengl'
include Gl, Glu, Glut

class Scene
  
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
  end
  
  def self.display(*args)
    initialize
    
    glutDisplayFunc(Proc.new { display_callback(*args) })
    glutKeyboardFunc(Proc.new { |key, x, y| keyboard_proxy(key, x, y) })
    glutMouseFunc(Proc.new { |button, state, x, y| mouse(button, state, x, y) })
    glutReshapeFunc(Proc.new { reshape })
    
    glutMainLoop
  end
  
  def self.display_callback(*args)
    glClear(GL_COLOR_BUFFER_BIT)
    instance.display(*args)
    glutSwapBuffers
    sleep(0.01)
  end
  
  def self.keyboard_proxy(key, x, y)
    instance.keyboard(key.chr, x, y)
  end
  
  def self.reshape_callback
  end
  
  def display
  end
  
  def keyboard(key, x, y)
    exit(0) if key == '\e' or key == 'q'
  end
  
  def mouse(button, state, x, y)
  end
  
  def reshape
  end
  
end
