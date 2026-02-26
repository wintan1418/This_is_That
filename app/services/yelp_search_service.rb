# SerpAPI Yelp Search Service
# Uses SerpAPI to search Yelp for businesses
class YelpSearchService
  BASE_URL = "https://serpapi.com/search.json"

  def initialize
    @api_key = ENV["SERPAPI_KEY"]
  end

  # Search for businesses on Yelp via SerpAPI
  # @param query [String] What to search for (e.g., "coffee shop")
  # @param location [String] City/location (e.g., "New York, NY")
  # @param options [Hash] Additional options like category, limit
  def search(query:, location:, **options)
    params = {
      engine: "yelp",
      find_desc: query,
      find_loc: location,
      api_key: @api_key
    }

    # Add optional parameters - must use www.yelp.com format
    params[:yelp_domain] = options[:domain] || "www.yelp.com"

    response = Faraday.get(BASE_URL, params)
    result = JSON.parse(response.body)

    if result["error"]
      Rails.logger.error "SerpAPI Error: #{result['error']}"
      return { success: false, error: result["error"], results: [] }
    end

    {
      success: true,
      results: parse_results(result["organic_results"] || [], location),
      total: result["search_information"]&.dig("total_results") || 0
    }
  rescue Faraday::Error => e
    Rails.logger.error "SerpAPI Request Failed: #{e.message}"
    { success: false, error: e.message, results: [] }
  rescue JSON::ParserError => e
    Rails.logger.error "SerpAPI JSON Parse Failed: #{e.message}"
    { success: false, error: "Invalid response", results: [] }
  end

  # Find matching places in a new city based on a home place
  # @param home_place [Place] The place from home city
  # @param new_city [String] The city to find matches in
  def find_matches(home_place:, new_city:)
    # Use the category and name as search query
    query = home_place.category&.yelp_alias || home_place.name

    search(query: query, location: new_city)
  end

  private

  def parse_results(results, default_location = nil)
    # Extract city from default location if provided (e.g. "Austin, TX" -> "Austin")
    default_city = default_location&.split(",")&.first&.strip

    results.map do |result|
      {
        yelp_id: extract_yelp_id(result["link"]),
        name: result["title"],
        address: result["address"],
        city: extract_city(result["neighborhoods"]) || default_city,
        rating: result["rating"],
        reviews_count: result["reviews"],
        price: result["price"],
        phone: result["phone"],
        image_url: result["thumbnail"],
        url: result["link"],
        categories: result["categories"] || [],
        snippet: result["snippet"]
      }
    end
  end

  def extract_yelp_id(url)
    return nil unless url
    # Extract business ID from Yelp URL
    url.match(/biz\/([^?]+)/)&.captures&.first
  end

  def extract_city(neighborhoods)
    return nil unless neighborhoods.is_a?(Array)
    neighborhoods.first
  end
end
