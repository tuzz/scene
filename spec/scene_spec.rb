require 'spec_helper'

describe Scene do
  
  describe '.instance' do
    it 'creates a new instance if one does not already exist' do
      instance = Scene.instance
      instance.class.should == Scene
      Scene.instance.should == instance
    end
  end
  
  describe '.initialize' do
    it 'initiailizes the window' do
      Object.should_receive(:glutInit)
      Scene.initialize
    end
    
    it 'uses rgb display mode with double buffering' do
      bitwise_argument = GLUT_DOUBLE | GLUT_RGB
      Object.should_receive(:glutInitDisplayMode).with(bitwise_argument)
      Scene.initialize
    end
    
    it 'sets the window size to 800x800' do
      Object.should_receive(:glutInitWindowSize).with(800, 800)
      Scene.initialize
    end
    
    it "creates a window with the title 'Super Simple Scene'" do
      Object.should_receive(:glutCreateWindow).with('Super Simple Scene')
      Scene.initialize
    end
    
    it 'sets the clear color to black' do
      Object.should_receive(:glClearColor).with(0, 0, 0, 0)
      Scene.initialize
    end
    
    it 'uses orthographic viewing in a unit cube' do
      Object.should_receive(:glMatrixMode).with(GL_PROJECTION)
      Object.should_receive(:glLoadIdentity)
      Object.should_receive(:glOrtho).with(0, 1, 0, 1, -1, 1)
      Scene.initialize
    end
  end
  
  describe '.display' do
    it 'sets up the peripheral and reshape callbacks' do
      Object.should_receive(:glutDisplayFunc)
      Object.should_receive(:glutKeyboardFunc)
      Object.should_receive(:glutMouseFunc)
      Object.should_receive(:glutReshapeFunc)
      Scene.display
    end
    
    it 'starts the graphics rendering loop' do
      Object.should_receive(:glutMainLoop)
      Scene.display
    end
  end
  
  describe '.display_callback' do
    it 'clears the display buffer' do
      Object.should_receive(:glClear).with(GL_COLOR_BUFFER_BIT)
      Scene.display_callback
    end
    
    it 'calls display on the instance' do
      Scene.instance.should_receive(:display)
      Scene.display_callback
    end
    
    it 'swaps out the display buffers' do
      Object.should_receive(:glutSwapBuffers)
      Scene.display_callback
    end
    
    it 'sleeps for 10 milliseconds to prevent 100% CPU usage' do
      Object.should_receive(:sleep).with(0.01)
      Scene.display_callback
    end
  end
  
  describe '.keyboard_proxy' do
    it 'calls keybaord after casting the key to a character' do
      Scene.instance.should_receive(:keyboard).with('A', 1, 2)
      Scene.keyboard_proxy(65, 1, 2)
    end
  end
  
end
