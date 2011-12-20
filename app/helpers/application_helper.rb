module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Candidate Forum"
    if @title.nil?
      base_title
    else
      "#{@title}"
    end
  end
  
  # Format text for display.                                                                    
  def format(text)
    sanitize(markdown(text))
  end

  # Process text with Markdown.                                                                 
  def markdown(text)
    BlueCloth::new(text).to_html
  end
  
  def post_user_link(user)
    if user.user_type == 2
      link_to user.name, user_path(user), :style => "color: #" + user.color + ";"
    else
      user.name
    end
  end
end
