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
  
end
