# coding: utf-8

require 'spec_helper'

describe "Static pages" do
  subject { page }

  it "About page" do
    visit about_path
    should have_content 'Загиров Рустам'
    should have_content 'Сертифицированный специалист'
    expect(title).to eq "Блог | О Загирове Рустаме"
      #should have_xpath "//title" , text: "Zagirov | О Загирове Рустаме"
      #should have_selector('title', text: "Zagirov | О Загирове Рустаме" )
    should have_selector 'h1', text: 'Загиров Рустам — веб-программист'
    should have_content 'rustam@zagirov.name'
  end

end
