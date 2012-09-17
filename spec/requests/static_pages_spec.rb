# coding: utf-8

require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Zagirov" }

  describe "About page" do

    it "should have the content 'Загиров Рустам'" do
      visit '/static_pages/about'
      page.should have_content('Загиров Рустам')
    end

    it "should have the content 'Сертифицированный специалист'" do
      visit '/static_pages/about'
      page.should have_content('Сертифицированный специалист')
    end

    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', text: "#{base_title} | О Загирове Рустаме")
    end

    it "should have the h1" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'Загиров Рустам — веб-программист')
    end

  end

end
