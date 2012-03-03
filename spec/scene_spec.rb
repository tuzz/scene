require 'spec_helper'

describe Scene do
  
  before do
    [:display, :timer, :keyboard, :mouse, :reshape].each do |method|
      Scene.any_instance.stub(method)
    end
  end
  
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
      Scene.send(:initialize)
    end
    
    it 'uses double buffering, rgb display mode and depth mode' do
      bitwise_argument = GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH
      Object.should_receive(:glutInitDisplayMode).with(bitwise_argument)
      Scene.send(:initialize)
    end
    
    it 'sets the window size to 800x800' do
      Object.should_receive(:glutInitWindowSize).with(800, 800)
      Scene.send(:initialize)
    end
    
    it "creates a window with the title 'Super Simple Scene'" do
      Object.should_receive(:glutCreateWindow).with('Super Simple Scene')
      Scene.send(:initialize)
    end
    
    it 'sets the clear color to black' do
      Object.should_receive(:glClearColor).with(0, 0, 0, 0)
      Scene.send(:initialize)
    end
    
    it 'enables depth tests' do
      Object.should_receive(:glEnable).with(GL_DEPTH_TEST)
      Scene.send(:initialize)
    end
    
    it 'uses perspective viewing with FOV=60, scale=1, zNear=1 and zFar=10' do
      Object.should_receive(:glMatrixMode).with(GL_PROJECTION)
      Object.should_receive(:gluPerspective).with(60, 1, 1, 10)
      Scene.send(:initialize)
    end
    
    it "positions the camera at 0, 0, -4, focussing on the origin with 'y' representing 'up'" do
      Object.should_receive(:glMatrixMode).with(GL_MODELVIEW)
      position = [0, 0, -4]; focus = [0, 0, 1]; up = [0, 1, 0]
      Object.should_receive(:gluLookAt).with(*(position + focus + up))
      Scene.send(:initialize)
    end
    
    it 'allows settings to be overriden by the instance initializer' do
      Scene.should_receive(:instance)
      Scene.send(:initialize)
    end
  end
  
  describe '.display' do
    it 'sets up the peripheral and reshape callbacks' do
      Object.should_receive(:glutDisplayFunc)
      Object.should_receive(:glutTimerFunc)
      Object.should_receive(:glutKeyboardFunc)
      Object.should_receive(:glutMouseFunc)
      Object.should_receive(:glutReshapeFunc)
      Scene.send(:display)
    end
    
    it 'starts the graphics rendering loop' do
      Object.should_receive(:glutMainLoop)
      Scene.send(:display)
    end
  end
  
  describe '.display_proxy' do
    it 'clears the display buffer' do
      bitwise_argument = GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
      Object.should_receive(:glClear).with(bitwise_argument)
      Scene.send(:display_proxy)
    end
    
    it 'calls display on the instance' do
      Scene.instance.should_receive(:display)
      Scene.send(:display_proxy)
    end
    
    it 'swaps out the display buffers' do
      Object.should_receive(:glutSwapBuffers)
      Scene.send(:display_proxy)
    end
  end
  
  describe '.timer_proxy' do
    it 'passes the elapsed time between calls into the timer instance method' do
      Scene.instance_variable_set(:@time, 50)
      Time.stub(:now).and_return(60)
      Scene.instance.should_receive(:timer).with(10)
      Scene.timer_proxy
    end
    
    it 'sends a message requesting a redisplay' do
      Object.should_receive(:glutPostRedisplay)
      Scene.timer_proxy
    end
    
    it 'sets a new timer' do
      Object.should_receive(:glutTimerFunc)
      Scene.timer_proxy
    end
  end
  
  describe '.keyboard_proxy' do
    it 'calls keybaord after casting the key to a character' do
      Scene.instance.should_receive(:keyboard).with('A', 1, 2)
      Scene.send(:keyboard_proxy, 65, 1, 2)
    end
  end
  
end
