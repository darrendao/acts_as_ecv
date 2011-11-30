module ActsAsEcv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_ecv(attr={})
      up_txt = attr[:up_txt] || "SYSTEM UP"
      down_txt = attr[:down_txt] || "SYSTEM DOWN"
      down_file = attr[:down_file] || File.join("public", "system", "down")
      define_method('index') do
        # Check if app has been marked as down
        if File.exists?(down_file)
          render :text => down_txt
        else
          render :text => up_txt
        end
      end
    end
  end
end

ActionController::Base.send(:include, ActsAsEcv)
