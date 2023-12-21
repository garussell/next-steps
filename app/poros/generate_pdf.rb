class GeneratePdf < Prawn::Document
  def initialize(user, favorites, providers)
    super()
    @user = user
    @favorites = format_favorites(favorites)
    @providers = format_providers(providers)
    header
    text_content
    table_content
    footer
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    # image "#{Rails.root}/app/assets/images/logo.png", width: 530, height: 150
  end

  def format_favorites(favorites)
    favorites.map do |favorite|
      [
        favorite.category,
        favorite.name,
        favorite.description,
        favorite.address,
        favorite.phone,
        favorite.fees,
        favorite.schedule
      ]
    end
  end

  def generate_pdf
    @user = current_user || User.find(params[:id])
    @favorites = @user.favorites
    @providers = Provider.where(id: @user.provider_id.to_i)
    pdf_filename = "#{@user.username}-Dashboard.pdf"
  
    pdf_file = Rails.root.join('tmp', pdf_filename)
  
    Prawn::Document.generate(pdf_file, locals: { user: @user, favorites: @favorites, providers: @providers }) do |pdf|
      pdf.text "User: #{@user.username}"
      pdf.text "Description: #{@user.description}"
      pdf.text "Favorites: "
      @favorites.each do |favorite|
        pdf.text "Category: #{favorite.category}"
        pdf.text "Name: #{favorite.name}"
        pdf.text "Description: #{favorite.description}"
        pdf.text "Address: #{favorite.address}"
        pdf.text "Phone: #{favorite.phone}"
        pdf.text "Fees: #{favorite.fees}"
        pdf.text "Schedule: #{favorite.schedule}"
      end
      pdf.text "My Service: "
      @providers.each do |provider|
        pdf.text "Name: #{provider.name}"
        pdf.text "Description: #{provider.description}"
        pdf.text "Fees: #{provider.fees}"
        pdf.text "Location: #{provider.street} #{provider.city.upcase}, #{provider.state.upcase} #{provider.zipcode}"
        pdf.text "Phone: #{provider.phone}"
        pdf.text "Schedule: #{provider.schedule}"
      end
    end
end