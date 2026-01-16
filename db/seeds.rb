# Seed categories for Yelp search
# These match Yelp's category aliases

categories = [
  { name: "Restaurants", yelp_alias: "restaurants", icon: "🍽️" },
  { name: "Coffee & Tea", yelp_alias: "coffee", icon: "☕" },
  { name: "Bars", yelp_alias: "bars", icon: "🍺" },
  { name: "Nightlife", yelp_alias: "nightlife", icon: "🌙" },
  { name: "Breakfast & Brunch", yelp_alias: "breakfast_brunch", icon: "🥞" },
  { name: "Pizza", yelp_alias: "pizza", icon: "🍕" },
  { name: "Fast Food", yelp_alias: "hotdogs", icon: "🍔" },
  { name: "Bakeries", yelp_alias: "bakeries", icon: "🥐" },
  { name: "Desserts", yelp_alias: "desserts", icon: "🍰" },
  { name: "Parks", yelp_alias: "parks", icon: "🌳" },
  { name: "Gyms", yelp_alias: "gyms", icon: "💪" },
  { name: "Spas", yelp_alias: "spas", icon: "💆" },
  { name: "Shopping", yelp_alias: "shopping", icon: "🛍️" },
  { name: "Grocery", yelp_alias: "grocery", icon: "🛒" },
  { name: "Hair Salons", yelp_alias: "hair", icon: "💇" },
  { name: "Auto Repair", yelp_alias: "autorepair", icon: "🔧" },
  { name: "Hotels", yelp_alias: "hotels", icon: "🏨" },
  { name: "Museums", yelp_alias: "museums", icon: "🏛️" },
  { name: "Movie Theaters", yelp_alias: "movietheaters", icon: "🎬" },
  { name: "Bookstores", yelp_alias: "bookstores", icon: "📚" }
]

puts "Seeding #{categories.length} categories..."

categories.each do |cat|
  Category.find_or_create_by!(yelp_alias: cat[:yelp_alias]) do |category|
    category.name = cat[:name]
    category.icon = cat[:icon]
  end
end

puts "Done! Created #{Category.count} categories."
