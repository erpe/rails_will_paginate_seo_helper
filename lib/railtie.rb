require_relative './view_helpers'

module RailsWillPaginateSeoHelper
  class Railtie < Rails::Railtie
    initializer 'rails_will_paginate_seo_helpers' do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
