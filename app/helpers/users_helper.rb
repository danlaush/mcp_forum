module UsersHelper
  
  def user_type_select_options
    options = []
    if current_user.user_type == 0
      options.push(['Super User',0])
    end
    if current_user.user_type <= 1
      options.push ['Administrator',1]
    end
    options.push ['Candidate',2]
    options_for_select(options, @user.user_type || 2)
  end
  
end
