require 'prawn'

class PdfGeneratorService
  def self.generate_pdf(user, favorites, providers, pdf_file)
    Prawn::Document.generate(pdf_file, locals: { user: user, favorites: favorites, providers: providers }) do |pdf|
      pdf.font 'Helvetica'

      # Title
      pdf.text "User: #{user.username}", size: 16, style: :bold

      # Favorites section
      pdf.move_down 10
      pdf.text "Favorites:", size: 18, style: :bold
      favorites.each do |favorite|
        truncated_descriptions = truncate_description(strip_tag(favorite.description), 100)
        pdf.text "Name: #{favorite.name}", size: 12, style: :bold, color: '0066cc'
        pdf.text "Category: #{favorite.category}", size: 12, style: :bold
        pdf.text "Description: #{truncated_descriptions}"
        pdf.text "Address: #{favorite.address}"
        pdf.text "Phone: #{favorite.phone}", style: :underline
        pdf.text "Fees: #{strip_tag(favorite.fees)}"
        pdf.text "Schedule: #{favorite.schedule}"
        pdf.move_down 10
      end

      # My Service section
      pdf.text "My Service:", size: 14, style: :bold, color: 'cc6600'
      providers.each do |provider|
        pdf.text "Name: #{provider.name}", size: 12, style: :bold
        pdf.text "Description: #{provider.description}"
        pdf.text "Fees: #{provider.fees}"
        pdf.text "Location: #{provider.street} #{provider.city.upcase}, #{provider.state.upcase} #{provider.zipcode}"
        pdf.text "Phone: #{provider.phone}"
        pdf.text "Schedule: #{provider.schedule}"
        pdf.move_down 10
      end
    end

    pdf_file
  end

  private

  def self.truncate_description(description, length)
    if description.length > length
      description[0..length] + '...'
    else
      description
    end
  end

  def self.strip_tag(html)
    ActionView::Base.full_sanitizer.sanitize(html)
  end
end
