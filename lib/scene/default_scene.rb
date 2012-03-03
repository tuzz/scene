module DefaultScene
  
  def display
  end
  
  def keyboard(key, x, y)
    exit(0) if key == '\e' or key == 'q'
  end
  
  def mouse(button, state, x, y)
  end
  
  def reshape(width, height)
  end
  
end
