# coding: utf-8

require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "About page" do
    before { visit about_path }

    it { should have_content('Загиров Рустам') }
    it { should have_content('Сертифицированный специалист') }
    it { should have_selector('title', text: full_title("О Загирове Рустаме")) }
    it { should have_selector('h1', text: 'Загиров Рустам — веб-программист') }
    it { should have_content('rustam@zagirov.name') }

  end

end
