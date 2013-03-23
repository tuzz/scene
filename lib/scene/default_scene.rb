module DefaultScene
  
  def display
    right, left = -1, 1
    bottom, top = -1, 1
    front, back = -1, 1
    
    lbf = [left, bottom, front]
    lbb = [left, bottom, back]
    ltf = [left, top, front]
    ltb = [left, top, back]
    rbf = [right, bottom, front]
    rbb = [right, bottom, back]
    rtf = [right, top, front]
    rtb = [right, top, back]
    
    right = [rbf, rbb, rtb, rtf]
    left = [lbf, ltf, ltb, lbb]
    bottom = [lbf, lbb, rbb, rbf]
    top = [ltf, rtf, rtb, ltb]
    front = [lbf, rbf, rtf, ltf]
    back = [lbb, ltb, rtb, rbb]
    
    glLineWidth(5)
    [right, left, bottom, top, front, back].each do |face|
      glBegin(GL_POLYGON)
      face.each do |vertex|
        color = vertex
        glColor3f(*color)
        glVertex3f(*vertex)
      end
      glEnd
      
      if @show_outline
        @outline ||= [rand, rand, rand]
        glColor3f(*@outline)
        glBegin(GL_LINE_LOOP)
        face.each { |v| glVertex3f(*v) }
        glEnd
      end
    end
  end
  
  def timer(elapsed)
    @show_outline = true if @show_outline.nil?
    @axes ||= [1, 1, 1]
    glRotatef(elapsed * 60, *@axes)
    
    @counter ||= 0
    @counter += 1
    if @counter == 100
      @outline = [rand, rand, rand]
      @counter = 0
    end
  end
  
  def keyboard(key, x, y)
    case key
    when 'q'
      exit(0)
    when 'h'
      puts
      puts 'H            : Display help'
      puts 'Q            : Quit'
      puts 'O            : Toggle outline'
      puts 'Left click   : Inverse x-rotation'
      puts 'Middle click : Inverse y-rotation'
      puts 'Right click  : Inverse z-rotation'
      puts
      puts 'Visit https://github.com/tuzz/scene for more information'
    when 'o'
      @show_outline = !@show_outline
    end
  end
  
  def mouse(button, state, x, y)
    return unless state == GLUT_DOWN
    @axes[button] *= -1
  end
  
  def reshape(width, height)
    min = [width, height].min
    x = (width - min) / 2
    y = (height - min) / 2
    glViewport(x, y, min, min)
  end
  
end
