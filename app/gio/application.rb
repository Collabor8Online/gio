module Gio
  class Application 
    def self.current 
      @current 
    end

    def initialize 
      self.class.current ||= self 
    end

    def [] collection 
      collection.to_s.classify.constantize 
    end

    protected 

    def self.current= application 
      @current = application 
    end
  end
end