class Requester
  MAGIC_API_URL = 'https://api.scryfall.com'.freeze
  CARDS_ENDPOINT = "#{MAGIC_API_URL}/cards".freeze
  SEARCH_ENDPOINT = "#{CARDS_ENDPOINT}/search".freeze
  AUTOCOMPLETE_ENDPOINT = "#{CARDS_ENDPOINT}/autocomplete".freeze
  RANDOM_ENDPOINT = "#{CARDS_ENDPOINT}/random".freeze

  SELECTED_PARAMS = %w[id name lang image_uris scryfall_uri mana_cost
                       rarity artist prices]

  class << self
    def cards(options = {})
      options[:page] ||= 1
      options = remove_params_except(options, [:page])

      JSON.parse(RestClient.get(CARDS_ENDPOINT, params: options))
    end

    def card_search(card_name, options = {})
      options[:q] = card_name
      options[:order] ||= 'name'
      options[:dir] ||= 'auto'
      options[:page] ||= 1
      options = remove_params_except(options, %i[order dir page q])

      begin
        request = RestClient.get(SEARCH_ENDPOINT, params: options)
      rescue RestClient::NotFound
        request = {}.to_json
      end

      JSON.parse(request)
    end

    # TODO: Add the result from this request as a dropdown in the search bar via AJAX
    def autocomplete_card_search(card_name)
      options = { q: card_name }
      answer = RestClient.get(AUTOCOMPLETE_ENDPOINT, params: options)

      JSON.parse(answer)['data']
    end

    def random_card
      JSON.parse(RestClient.get(RANDOM_ENDPOINT))
    end

    def formatted_request!(request)
      request.slice! *SELECTED_PARAMS
    end

    def true_da_true
      'Diogo carregadinho BR'
    end

    private

    def remove_params_except(options, keys)
      invalid_keys = options.keys - keys
      invalid_keys.each do |invalid_key|
        options.delete invalid_key
      end

      options
    end
  end
end