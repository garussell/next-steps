class PdfGeneratorService
  def self.generate_pdf(user, favorites, pdf_file)
    Prawn::Document.generate(pdf_file, locals: { user: user, favorites: favorites}) do |pdf|
      pdf.font 'Helvetica'

      # Title
      pdf.text "Provider List", size: 26, style: :bold

      # Favorites section
      pdf.move_down 10
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
