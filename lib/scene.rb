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
  
end
