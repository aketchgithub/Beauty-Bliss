puts "📃 Seeding data..."

products = [
    {
      name: "Hyaluronic Acid Serum",
      description: "This serum is packed with hyaluronic acid to hydrate and plump up your skin. It helps to reduce the appearance of fine lines and wrinkles, and leaves your skin looking and feeling smoother and more radiant.",
      price: 29.99,
      image_url: "https://example.com/images/hyaluronic_acid_serum.jpg"
    },
    {
      name: "Charcoal Face Mask",
      description: "This face mask is infused with charcoal to help purify and detoxify your skin. It helps to unclog pores and remove impurities, leaving your skin feeling refreshed and rejuvenated.",
      price: 14.99,
      image_url: "https://example.com/images/charcoal_face_mask.jpg"
    },
    {
      name: "Vitamin C Serum",
      description: "This serum is packed with vitamin C to brighten and even out your skin tone. It helps to reduce the appearance of dark spots and hyperpigmentation, and leaves your skin looking brighter and more youthful.",
      price: 39.99,
      image_url: "https://example.com/images/vitamin_c_serum.jpg"
    },
    {
      name: "Rosewater Toner",
      description: "This toner is made with rosewater to help soothe and hydrate your skin. It helps to balance your skin's pH and prepare it for the rest of your skincare routine. It can also be used throughout the day to refresh and revitalize your skin.",
      price: 19.99,
      image_url: "https://example.com/images/rosewater_toner.jpg"
    },
    {
      name: "Anti-Aging Eye Cream",
      description: "This eye cream is packed with antioxidants and peptides to help reduce the appearance of fine lines and wrinkles around your eyes. It helps to hydrate and firm up the delicate skin around your eyes, leaving it looking smoother and more youthful.",
      price: 49.99,
      image_url: "https://example.com/images/anti_aging_eye_cream.jpg"
    }
  ]
  
  # To create the products in the database
  products.each do |product|
    Product.create(product)
  end
  
  puts "✅ Done seeding"