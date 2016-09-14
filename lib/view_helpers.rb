module RailsWillPaginateSeoHelper
  module ViewHelpers
    def will_paginate_seo_links(collection)
      return unless collection.respond_to?(:current_page)
      @collection = collection
      build_tags
    end

    private

    def build_tags
      if next_link_tag && previous_link_tag
        return (previous_link_tag << next_link_tag).html_safe
      end
      return previous_link_tag.html_safe if previous_link_tag
      next_link_tag.html_safe if next_link_tag
    end

    def previous_link_tag
      previous_page = @collection.previous_page
      original_url = request.original_url

      if previous_page
        if previous_page == 1
          prev_page_url = original_url.gsub(/(&|\?)page\=\d{1,}/, '')
        else
          prev_page_url = original_url.gsub(/page\=\d{1,}/, "page=#{previous_page}")
        end
        return tag(:link, href: prev_page_url, rel: :prev)
      end
    end

    def next_link_tag
      next_page = @collection.next_page
      return nil if next_page.nil?
      
      original_url = request.original_url

      match = original_url.match(/(&|\?)page\=\d{1,}/)

      if match          # has :page url-parameter
        next_page_url = original_url.gsub(/page\=\d{1,}/, "page=#{next_page}")
      else              # no :page url-parameter page
        sign_match = original_url.match(/\?/)
        if sign_match   # url has parameter attached
          next_page_url = original_url.concat("&page=#{next_page}")
        else            # url has no parameter attached
          next_page_url = original_url.concat("?page=#{next_page}")
        end
      end
      tag(:link, href: next_page_url, rel: :next) if next_page_url
    end
  end
end
