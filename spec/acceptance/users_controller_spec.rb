require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "usersController" do
  before { host! "http://" + host }
  before { @user = Factory(:user) }

  #context ".index" do
    #before { @uri = "/users" }
    #before { @read_user = Factory(:user, name: "read", values: READ_user) }

    #context "when not logged in" do
      #scenario "is not authorized" do
        #visit @uri
        #current_url.should == host + "/log_in"
      #end
    #end

    #context "when logged it" do
      #before { login(@user) } 

      #scenario "view the resources" do
        #visit @uri
        #[@user, @read_user].each do |user|
          #should_visualize_user(user)
        #end
      #end

    #end
  #end


  context ".show" do
    before { @uri = "/users/" + @user.id.as_json }

    context "when not logged in" do
      scenario "is not authorized" do
        visit @uri
        current_url.should == host + "/log_in"
      end
    end

    context "when logged in" do
      before { @bob = Factory(:user_bob) }
      before { login(@user) } 

      scenario "view a resource" do
        visit @uri
        should_visualize_user(@user)
      end

      scenario "resource not found" do
        @user.destroy
        visit @uri
        current_url.should == host + "/log_in"
      end

      scenario "access other users profile" do
        visit "/users/" + @bob.id.as_json
        page.should have_content "not_found"
        page.should have_content "Resource not found" 
      end

      scenario "access with illegal id" do
        visit "/users/0"
        page.should have_content "not_found"
        page.should have_content "Resource not found"
      end
    end
  end


  #context ".create" do
    #before { @uri = "/users/new" }

    #context "when not logged in" do
      #scenario "is not authorized" do
        #visit @uri
        #current_url.should == host + "/log_in"
      #end
    #end

    #context "when logged in" do
      #before { login(@user) } 

      #context "when valid" do
        #before do
          #visit @uri
          #fill_user("pizza/read", "pizza/index pizza/show")
          #click_button 'Create user'
          #@user = user.last
        #end

        #scenario "create a resource" do
          #should_visualize_user(@user)
          #page.should have_content "was successfully created"
        #end

        #scenario "assign an URI to the resource" do
          #@user.uri.should == host + "/users/" + @user.id.as_json
        #end
      #end

      #context "when not valid" do
        #scenario "fails" do
          #visit @uri
          #fill_user("", "")
          #click_button 'Create user'
          #page.should have_content "Name can't be blank"
          #page.should have_content "Values can't be blank"
        #end
      #end
    #end
  #end

  context ".update" do
    before { @bob = Factory(:user_bob) }
    before { @uri = "/users/" + @user.id.as_json +  "/edit" }

    context "when not logged in" do
      scenario "is not authorized" do
        visit @uri
        current_url.should == host + "/log_in"
      end
    end

    context "when logged in" do
      before { login(@user) } 
      let(:name) { "Alice is my name" }

      scenario "when update fields" do
        visit @uri
        fill_in "Name", with: name
        click_button "Update User"
        page.should have_content(name)
      end

      context "when update the password" do
        let(:new_pass) { "asecurepassword"}

        context "when valid" do
          before do
            visit @uri
            fill_in "Password", with: new_pass
            click_button "Update User"
            click_link "Log out"
          end

          scenario "should log with new pass" do
            login(@user, new_pass)
            page.should have_content "Logged in"
          end

          scenario "should not log with old pass" do
            login(@user)
            page.should_not have_content "Logged in"
            save_and_open_page
          end
        end

        scenario "when empty" do
          visit @uri
          fill_in "Password", with: ""
          click_button "Update User"
          click_link "Log out"
          login(@user)
          page.should have_content "Logged in"
        end
      end

      scenario "when resource not found" do
        @user.destroy
        visit @uri
        current_url.should == host + "/log_in"
      end

      scenario "when illegal id" do
        visit "/users/0"
        page.should have_content "not_found"
        page.should have_content "Resource not found"
      end

      scenario "when edit other users profile" do
        visit "/users/" + @bob.id.as_json + "/edit"
        page.should have_content "not_found"
        page.should have_content "Resource not found" 
      end

      # No validation present on the user form
      #context "when not valid" do
        #scenario "fails" do
        #end
      #end

    end
  end

  #context ".destroy" do
  #end

end

