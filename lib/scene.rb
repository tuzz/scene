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
    glutKeyboardFunc(Proc.new { keyboard_callback })
    glutMouseFunc(Proc.new { mouse_callback })
    glutReshapeFunc(Proc.new { reshape_callback })
    
    glutMainLoop
  end
  
  def self.display_callback
  end
  
  def self.keyboard_callback
  end
  
  def self.mouse_callback
  end
  
  def self.reshape_callback
  end
  
  # 
  # def self.display_callback(*args)
  #   glClear(GL_COLOR_BUFFER_BIT)
  #   instance.display(*args)
  #   glutSwapBuffers
  #   sleep(0.1)
  # end
  # 
  # def self.keyboard_callback(key, x, y)
  #   instance.defined? keyboard(key.chr, x, y)
  # end
  # 
  # def self.mouse_callback
  # end
  # 
  # def keyboard(key, x, y)
  #   exit(0) if key == '\e'
  # end
  # 
  # def mouse
  # end
  
end
