module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'Password confirmation', with: password
      within(".form-actions") do
        click_on 'Sign up'
      end
    end

    def sign_in(capybara: false)
      user = create(:user)
      if capybara
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      else
        session[:user_id] = user.id
      end
    end

    def logout
      click_on 'Logout'
    end
  end
end
