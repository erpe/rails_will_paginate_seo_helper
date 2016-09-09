module RailsWillPaginateSeoHelper
  module ViewHelpers
    def will_paginate_seo_links(collection)
      return unless collection.respond_to?(:current_page)
      @collection = collection
      build_tags.html_safe 
    end

    private


    def build_tags
      if next_link_tag && previous_link_tag
        return previous_link_tag << next_link_tag
      end
      return next_link_tag if next_link_tag
      return previous_link_tag if previous_link_tag
    end

    def next_link_tag
      next_page = @collection.next_page
      if next_page
        next_page_url = request.original_url.gsub(/page\=\d{1,}/, "page=#{next_page}")
        return tag(:link, href: next_page_url, rel: :next)
      end
    end

    def previous_link_tag
      previous_page = @collection.previous_page
      if previous_page
        prev_page_url = request.original_url.gsub(/page\=\d{1,}/, "page=#{previous_page}")
        return tag(:link, href: prev_page_url, rel: :prev)
      end
    end
  end
end
