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
end
