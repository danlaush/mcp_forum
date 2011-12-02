require 'spec_helper'

describe UsersController do
	render_views
	
	describe "GET 'index'" do
    before(:each) do
      @admin = Factory(:user, :user_type => "1")
      second = Factory(:user, :email => Factory.next(:email))
      third = Factory(:user, :email => Factory.next(:email))
      
      @users = [@admin, second, third]
      15.times do
        @users << Factory(:user, :email => Factory.next(:email))
      end
    end
    
	  describe "for non-signed-in users" do
  	  
  	  it "should be successful" do
  	    get :index
  	    response.should be_successful
  	  end
  	  
  	  it "should have the right title" do
  	    get :index
  	    response.should have_selector("title", :content => "Candidates")
  	  end
  	  
  	  it "should list the candidates" do
  	    get :index
  	    @users[1..3].each do |user|
          response.should have_selector("li", :content => user.email)
        end
  	  end
  	  
  	  it "should not list admins" do
  	    get :index
  	    response.should_not have_selector("li", :content => @admin.email)
  	  end
    end
    
    describe "for signed in users" do
      before(:each) do
        test_sign_in(@admin)
      end
      
      it "should be successful" do
        get :index
        response.should be_successful
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Candidates")
      end
      
      it "should list the candidates" do
        get :index
        @users[1..3].each do |user|
          response.should have_selector("li", :content => user.email)
        end
      end
      
      it "should list admins" do
        get :index
        response.should have_selector("li", :content => @admin.email)
      end
    end
	end
	
	describe "GET 'show'" do
	  before(:each) do
	    @admin = Factory(:user, :user_type => 1)
	    @user = Factory(:user, :color => "#ff0000", :email => Factory.next(:email))
	  end
	  
	  describe "for non-signed-in users" do
	    it "admin pages should deny access" do
	      get :show, :id => @admin
	      response.should redirect_to(root_path)
	      flash[:notice].should =~ /logged in/i
	    end
	    
	    describe "candidate pages" do
	      it "should be successful" do
          get :show, :id => @user
          response.should be_success
        end
        
        it "should show the right user" do
          get :show, :id => @user
          assigns(:user).should == @user
        end
        
        it "should have the right user name" do
          get :show, :id => @user
          response.should have_selector("h1", :content => @user.name)
        end
        
        it "should show the user's text color" do
          get :show, :id => @user
          response.should have_selector("span", :style => "color: #" + @user.color + ";")
        end
	    end
	  end
	  
	  describe "for signed in users" do
	    before(:each) do
	      test_sign_in(@user)
	    end
	    
      it "admin pages should be successful" do
        get :show, :id => @admin
        response.should be_success
      end
      
      describe "candidate pages" do
        it "should be successful" do
          get :show, :id => @user
          response.should be_success
        end
        
        it "should show the right user" do
          get :show, :id => @user
          assigns(:user).should == @user
        end
        
        it "should have the right user name" do
          get :show, :id => @user
          response.should have_selector("h1", :content => @user.name)
        end
        
        it "should show the user's text color" do
          get :show, :id => @user
          response.should have_selector("span", :style => "color: #" + @user.color + ";")
        end
      end
	    
	    it "correct users should have an edit link" do
	      get :show, :id => @user
	      response.should have_selector("a", :href => edit_user_path(@user))
	    end
	    
	    it "incorrect users should not have an edit link" do
        get :show, :id => @admin
        response.should_not have_selector("a", :href => edit_user_path(@admin))
      end
	  end
	  
	  describe "for admin users" do
	    before(:each) do
	      test_sign_in(@admin)
	    end
      
      it "admin pages should be successful" do
        get :show, :id => @admin
        response.should be_success
      end
      
      describe "candidate pages" do
        it "should be successful" do
          get :show, :id => @user
          response.should be_success
        end
        
        it "should show the right user" do
          get :show, :id => @user
          assigns(:user).should == @user
        end
        
        it "should have the right user name" do
          get :show, :id => @user
          response.should have_selector("h1", :content => @user.name)
        end
        
        it "should show the user's text color" do
          get :show, :id => @user
          response.should have_selector("span", :style => "color: #" + @user.color + ";")
        end
      end
	    
	    it "should have an edit link for their own pages" do
        get :show, :id => @admin
        response.should have_selector("a", :href => edit_user_path(@admin))
	    end
	    
      it "should have an edit link for their own pages" do
        get :show, :id => @user
        response.should have_selector("a", :href => edit_user_path(@user))
      end
	  end
	end

	describe "GET 'new'" do
	  describe "for non-signed-in users" do
	    it "should deny access" do
	      get :new
	      response.should redirect_to(root_path)
	      flash[:notice].should =~ /allow/i
	    end
	  end
	  
	  describe "for non-admin users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should deny access" do
        get :new
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
      end
	  end
	  
	  describe "for admin users" do
      before(:each) do
        @admin = test_sign_in(Factory(:user, :user_type => "1"))
      end
      
      it "should be successful" do
        get :new
        response.should be_success
      end
      
      it "should have the correct title" do
        get :new
        response.should have_selector("title", :content => "Register")
      end
	  end
	end

	describe "POST 'create'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :new
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
      end
    end
    
    describe "for non-admin users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should deny access" do
        get :new
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
      end
    end
    
    describe "for admin users" do
      before(:each) do
        @admin = test_sign_in(Factory(:user, :user_type => "1"))
      end
      
      describe "failure" do
        before(:each) do
          @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
        end
        
        it "should not create a new user" do
          lambda do
            post :create, :user => @attr
          end.should_not change(User, :count)
        end
        
        it "should have the right title" do
          post :create, :user => @attr
          response.should have_selector("title", :content => "Register")
        end
        
        it "should render GET :new" do
          post :create, :user => @attr
          should render_template('new')
        end
        
        it "should clear the password field" do
          post :create, :user => @attr
          response.should have_selector("input[type=\"password\"]", :value => "")
        end
      end
      
      describe "success" do
        before(:each) do
          @attr = {
            :name => "Dan Laush",
            :email => "dl@ex.com",
            :password => "foobar",
            :password_confirmation => "foobar"
          }
        end
        
        it "should create a new user" do
          lambda do
            post :create, :user => @attr
          end.should change(User, :count).by(1)
        end
        
        it "should redirect to the user home page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
        end
        
        it "should display a welcome message" do
          post :create, :user => @attr
          flash[:success].should =~ /create/i
        end
      end
    end
	end
	
	describe "GET 'edit'" do
	  before(:each) do
	    @admin = Factory(:user, :user_type => "1")
	    @user1 = Factory(:user, :email => Factory.next(:email))
	    @user2 = Factory(:user, :email => Factory.next(:email))
	  end
	  
	  describe "for non-signed-in users" do
	    it "should deny access" do
	      get :edit, :id => @user1
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
      end
	  end
	  
	  describe "for incorrect users" do
	    before(:each) do
	      test_sign_in(@user2)
	    end
	    
	    it "should deny access" do
	      get :edit, :id => @user1
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
	    end
	  end
	  
	  describe "for correct users" do
	    before(:each) do
	      test_sign_in(@user1)
	    end
	    
	    it "should be successful" do
	      get :edit, :id => @user1
	      response.should be_successful
	    end
	    
	    it "should have the right title" do
	      get :edit, :id => @user1
	      response.should have_selector("title", :content => "Editing account")
	    end
	    
	    it "should have an edit_user form" do
	      get :edit, :id => @user1
	      response.should have_selector("form", :class => "edit_user")
	    end
	  end
	  
	  describe "for admins" do
	    before(:each) do
	      test_sign_in(@admin)
	    end
      
      it "should be successful" do
        get :edit, :id => @user1
        response.should be_successful
      end
      
      it "should have the right title" do
        get :edit, :id => @user1
        response.should have_selector("title", :content => "Editing account")
      end
      
      it "should have an edit_user form" do
        get :edit, :id => @user1
        response.should have_selector("form", :class => "edit_user")
      end
	  end
	end
	
	describe "POST 'update'" do
    before(:each) do
      @admin = Factory(:user, :user_type => "1")
      @user1 = Factory(:user, :email => Factory.next(:email))
      @user2 = Factory(:user, :email => Factory.next(:email))
    end
    
    describe "for non-signed-in users" do
      it "should deny access" do
        post :update, :id => @user1
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
      end
    end
    
    describe "for incorrect users" do
      before(:each) do
        test_sign_in(@user2)
      end
      
      it "should deny access" do
        put :update, :id => @user1, :attr => {}
        response.should redirect_to(root_path)
        flash[:notice].should =~ /allow/i
      end
    end
    
    describe "for correct users" do
      before(:each) do
        test_sign_in(@user1)
      end
      
      describe "failure" do
        before(:each) do
          @attr = {
            :email          => "",
            :name           => "",
            :password         => "",
            :password_confirmation  => ""
          }
        end
        
        it "should render the edit page" do
          put :update, :id => @user1, :user => @attr
          response.should render_template('edit')
        end
        
        it "should have the right title" do
          put :update, :id => @user1, :user => @attr
          response.should have_selector("title", :content => "Editing account")
        end
      end
      
      describe "success" do
        before(:each) do
          @attr = { 
            :name         => "Bar Baz", 
            :email          => "bar@baz.com",
            :password       => "barbaz", 
            :password_confirmation  => "barbaz" 
          }
        end
        
        it "should change the user's attributes" do
          put :update, :id => @user1, :user => @attr
          @user1.reload
          @user1.name.should == @attr[:name]
          @user1.email.should == @attr[:email]
        end
        
        it "should redirect to the user's show page" do
          put :update, :id => @user1, :user => @attr
          response.should redirect_to(user_path(@user))
        end
        
        it "should have a flash message" do
          put :update, :id => @user1, :user => @attr
          flash[:success].should =~ /updated/
        end
      end
    end
    
    describe "for admins" do
      before(:each) do
        test_sign_in(@admin)
        @attr = { 
          :name         => "Bar Baz", 
          :email          => "bar@baz.com",
          :password       => "barbaz", 
          :password_confirmation  => "barbaz" 
        }
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user1, :user => @attr
        @user1.reload
        @user1.name.should == @attr[:name]
        @user1.email.should == @attr[:email]
      end
      
      it "should redirect to the user's show page" do
        put :update, :id => @user1, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user1, :user => @attr
        flash[:success].should =~ /updated/
      end
    end
	end
end