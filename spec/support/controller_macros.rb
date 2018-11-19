module ControllerMacros
    def login_admin
      before(:each) do
        sign_in FactoryBot.create(:user, :admin)
      end
    end

    def login_level1
      before(:each) do
        sign_in FactoryBot.create(:user, :level1)
      end
    end

    def login_level2
      before(:each) do
        sign_in FactoryBot.create(:user, :level2)
      end
    end
  
  end